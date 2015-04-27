From: jbe@pengutronix.de (Juergen Borleis)
Date: Mon, 27 Apr 2015 15:59:49 +0200
Subject: [PATCH 3/6] RTC/i.MX/DryIce: add the unit recovery code
In-Reply-To: <1430143192-20667-1-git-send-email-jbe@pengutronix.de>
References: <1430143192-20667-1-git-send-email-jbe@pengutronix.de>
Message-ID: <1430143192-20667-4-git-send-email-jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This code is required to recover the unit from a security violation.
Hopefully this code can recover the unit from a hardware related invalid
state as well.

Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
Signed-off-by: Robert Schwebel <rsc@pengutronix.de>
[rsc: got NDA clearance from Freescale]
---
 drivers/rtc/rtc-imxdi.c | 317 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 279 insertions(+), 38 deletions(-)

diff --git a/drivers/rtc/rtc-imxdi.c b/drivers/rtc/rtc-imxdi.c
index 6db8d1c..f0c8319 100644
--- a/drivers/rtc/rtc-imxdi.c
+++ b/drivers/rtc/rtc-imxdi.c
@@ -173,6 +173,281 @@ struct imxdi_dev {
  */
 
 /*
+ * Do a write into the unit without interrupt support.
+ * We do not need to check the WEF here, because the only reason this kind of
+ * write error can happen is if we write to the unit twice within the 122 us
+ * interval. This cannot happen, since we are using this function only while
+ * setting up the unit.
+ */
+static void di_write_busy_wait(const struct imxdi_dev *imxdi, u32 val,
+			       unsigned reg)
+{
+	/* do the register write */
+	writel(val, imxdi->ioaddr + reg);
+
+	/*
+	 * now it takes four 32,768 kHz clock cycles to take
+	 * the change into effect = 122 us
+	 */
+	usleep_range(130, 200);
+}
+
+static void di_report_tamper_info(struct imxdi_dev *imxdi,  u32 dsr)
+{
+	u32 dtcr;
+
+	dtcr = readl(imxdi->ioaddr + DTCR);
+
+	dev_emerg(&imxdi->pdev->dev, "DryIce tamper event detected\n");
+	/* the following flags force a transition into the "FAILURE STATE" */
+	if (dsr & DSR_VTD)
+		dev_emerg(&imxdi->pdev->dev, "%sVoltage Tamper Event\n",
+			  dtcr & DTCR_VTE ? "" : "Spurious ");
+
+	if (dsr & DSR_CTD)
+		dev_emerg(&imxdi->pdev->dev, "%s32768 Hz Clock Tamper Event\n",
+			  dtcr & DTCR_CTE ? "" : "Spurious ");
+
+	if (dsr & DSR_TTD)
+		dev_emerg(&imxdi->pdev->dev, "%sTemperature Tamper Event\n",
+			  dtcr & DTCR_TTE ? "" : "Spurious ");
+
+	if (dsr & DSR_SAD)
+		dev_emerg(&imxdi->pdev->dev,
+			  "%sSecure Controller Alarm Event\n",
+			  dtcr & DTCR_SAIE ? "" : "Spurious ");
+
+	if (dsr & DSR_EBD)
+		dev_emerg(&imxdi->pdev->dev, "%sExternal Boot Tamper Event\n",
+			  dtcr & DTCR_EBE ? "" : "Spurious ");
+
+	if (dsr & DSR_ETAD)
+		dev_emerg(&imxdi->pdev->dev, "%sExternal Tamper A Event\n",
+			  dtcr & DTCR_ETAE ? "" : "Spurious ");
+
+	if (dsr & DSR_ETBD)
+		dev_emerg(&imxdi->pdev->dev, "%sExternal Tamper B Event\n",
+			  dtcr & DTCR_ETBE ? "" : "Spurious ");
+
+	if (dsr & DSR_WTD)
+		dev_emerg(&imxdi->pdev->dev, "%sWire-mesh Tamper Event\n",
+			  dtcr & DTCR_WTE ? "" : "Spurious ");
+
+	if (dsr & DSR_MCO)
+		dev_emerg(&imxdi->pdev->dev,
+			  "%sMonotonic-counter Overflow Event\n",
+			  dtcr & DTCR_MOE ? "" : "Spurious ");
+
+	if (dsr & DSR_TCO)
+		dev_emerg(&imxdi->pdev->dev, "%sTimer-counter Overflow Event\n",
+			  dtcr & DTCR_TOE ? "" : "Spurious ");
+}
+
+static void di_what_is_to_be_done(struct imxdi_dev *imxdi,
+				  const char *power_supply)
+{
+	dev_emerg(&imxdi->pdev->dev, "Please cycle the %s power supply in order to get the DryIce/RTC unit working again\n",
+			power_supply);
+}
+
+static int di_handle_failure_state(struct imxdi_dev *imxdi, u32 dsr)
+{
+	u32 dcr;
+
+	dev_dbg(&imxdi->pdev->dev, "DSR register reports: %08X\n", dsr);
+
+	/* report the cause */
+	di_report_tamper_info(imxdi, dsr);
+
+	dcr = readl(imxdi->ioaddr + DCR);
+
+	if (dcr & DCR_FSHL) {
+		/* we are out of luck */
+		di_what_is_to_be_done(imxdi, "battery");
+		return -ENODEV;
+	}
+	/*
+	 * with the next SYSTEM POR we will transit from the "FAILURE STATE"
+	 * into the "NON-VALID STATE" + "FAILURE STATE"
+	 */
+	di_what_is_to_be_done(imxdi, "main");
+
+	return -ENODEV;
+}
+
+static int di_handle_valid_state(struct imxdi_dev *imxdi, u32 dsr)
+{
+	/* initialize alarm */
+	di_write_busy_wait(imxdi, DCAMR_UNSET, DCAMR);
+	di_write_busy_wait(imxdi, 0, DCALR);
+
+	/* clear alarm flag */
+	if (dsr & DSR_CAF)
+		di_write_busy_wait(imxdi, DSR_CAF, DSR);
+
+	return 0;
+}
+
+static int di_handle_invalid_state(struct imxdi_dev *imxdi, u32 dsr)
+{
+	u32 dcr, sec;
+
+	/*
+	 * lets disable all sources which can force the DryIce unit into
+	 * the "FAILURE STATE" for now
+	 */
+	di_write_busy_wait(imxdi, 0x00000000, DTCR);
+	/* and lets protect them at runtime from any change */
+	di_write_busy_wait(imxdi, DCR_TDCSL, DCR);
+
+	sec = readl(imxdi->ioaddr + DTCMR);
+	if (sec != 0)
+		dev_warn(&imxdi->pdev->dev,
+			"The security violation has happend at %u seconds\n",
+			sec);
+	/*
+	 * the timer cannot be set/modified if
+	 * - the TCHL or TCSL bit is set in DCR
+	 */
+	dcr = readl(imxdi->ioaddr + DCR);
+	if (!(dcr & DCR_TCE)) {
+		if (dcr & DCR_TCHL) {
+			/* we are out of luck */
+			di_what_is_to_be_done(imxdi, "battery");
+			return -ENODEV;
+		}
+		if (dcr & DCR_TCSL) {
+			di_what_is_to_be_done(imxdi, "main");
+			return -ENODEV;
+		}
+	}
+	/*
+	 * - the timer counter stops/is stopped if
+	 *   - its overflow flag is set (TCO in DSR)
+	 *      -> clear overflow bit to make it count again
+	 *   - NVF is set in DSR
+	 *      -> clear non-valid bit to make it count again
+	 *   - its TCE (DCR) is cleared
+	 *      -> set TCE to make it count
+	 *   - it was never set before
+	 *      -> write a time into it (required again if the NVF was set)
+	 */
+	/* state handled */
+	di_write_busy_wait(imxdi, DSR_NVF, DSR);
+	/* clear overflow flag */
+	di_write_busy_wait(imxdi, DSR_TCO, DSR);
+	/* enable the counter */
+	di_write_busy_wait(imxdi, dcr | DCR_TCE, DCR);
+	/* set and trigger it to make it count */
+	di_write_busy_wait(imxdi, sec, DTCMR);
+
+	/* now prepare for the valid state */
+	return di_handle_valid_state(imxdi, __raw_readl(imxdi->ioaddr + DSR));
+}
+
+static int di_handle_invalid_and_failure_state(struct imxdi_dev *imxdi, u32 dsr)
+{
+	u32 dcr;
+
+	/*
+	 * now we must first remove the tamper sources in order to get the
+	 * device out of the "FAILURE STATE"
+	 * To disable any of the following sources we need to modify the DTCR
+	 */
+	if (dsr & (DSR_WTD | DSR_ETBD | DSR_ETAD | DSR_EBD | DSR_SAD |
+			DSR_TTD | DSR_CTD | DSR_VTD | DSR_MCO | DSR_TCO)) {
+		dcr = __raw_readl(imxdi->ioaddr + DCR);
+		if (dcr & DCR_TDCHL) {
+			/*
+			 * the tamper register is locked. We cannot disable the
+			 * tamper detection. The TDCHL can only be reset by a
+			 * DRYICE POR, but we cannot force a DRYICE POR in
+			 * softwere because we are still in "FAILURE STATE".
+			 * We need a DRYICE POR via battery power cycling....
+			 */
+			/*
+			 * out of luck!
+			 * we cannot disable them without a DRYICE POR
+			 */
+			di_what_is_to_be_done(imxdi, "battery");
+			return -ENODEV;
+		}
+		if (dcr & DCR_TDCSL) {
+			/* a soft lock can be removed by a SYSTEM POR */
+			di_what_is_to_be_done(imxdi, "main");
+			return -ENODEV;
+		}
+	}
+
+	/* disable all sources */
+	di_write_busy_wait(imxdi, 0x00000000, DTCR);
+
+	/* clear the status bits now */
+	di_write_busy_wait(imxdi, dsr & (DSR_WTD | DSR_ETBD | DSR_ETAD |
+			DSR_EBD | DSR_SAD | DSR_TTD | DSR_CTD | DSR_VTD |
+			DSR_MCO | DSR_TCO), DSR);
+
+	dsr = readl(imxdi->ioaddr + DSR);
+	if ((dsr & ~(DSR_NVF | DSR_SVF | DSR_WBF | DSR_WNF |
+			DSR_WCF | DSR_WEF)) != 0)
+		dev_warn(&imxdi->pdev->dev,
+			"There are still some sources of pain in DSR: %08x!\n",
+			dsr & ~(DSR_NVF | DSR_SVF | DSR_WBF | DSR_WNF |
+					DSR_WCF | DSR_WEF));
+
+	/*
+	 * now we are trying to clear the "Security-violation flag" to
+	 * get the DryIce out of this state
+	 */
+	di_write_busy_wait(imxdi, DSR_SVF, DSR);
+
+	/* success? */
+	dsr = readl(imxdi->ioaddr + DSR);
+	if (dsr & DSR_SVF) {
+		dev_crit(&imxdi->pdev->dev,
+			"Cannot clear the security violation flag. We are ending up in an endless loop!\n");
+		/* last resort */
+		di_what_is_to_be_done(imxdi, "battery");
+		return -ENODEV;
+	}
+
+	/*
+	 * now we have left the "FAILURE STATE" and ending up in the
+	 * "NON-VALID STATE" time to recover everything
+	 */
+	return di_handle_invalid_state(imxdi, dsr);
+}
+
+static int di_handle_state(struct imxdi_dev *imxdi)
+{
+	int rc;
+	u32 dsr;
+
+	dsr = readl(imxdi->ioaddr + DSR);
+
+	switch (dsr & (DSR_NVF | DSR_SVF)) {
+	case DSR_NVF:
+		dev_warn(&imxdi->pdev->dev, "Invalid stated unit detected\n");
+		rc = di_handle_invalid_state(imxdi, dsr);
+		break;
+	case DSR_SVF:
+		dev_warn(&imxdi->pdev->dev, "Failure stated unit detected\n");
+		rc = di_handle_failure_state(imxdi, dsr);
+		break;
+	case DSR_NVF | DSR_SVF:
+		dev_warn(&imxdi->pdev->dev,
+				"Failure+Invalid stated unit detected\n");
+		rc = di_handle_invalid_and_failure_state(imxdi, dsr);
+		break;
+	default:
+		dev_notice(&imxdi->pdev->dev, "Unlocked unit detected\n");
+		rc = di_handle_valid_state(imxdi, dsr);
+	}
+
+	return rc;
+}
+
+/*
  * enable a dryice interrupt
  */
 static void di_int_enable(struct imxdi_dev *imxdi, u32 intr)
@@ -491,6 +766,10 @@ static int __init dryice_rtc_probe(struct platform_device *pdev)
 	/* mask all interrupts */
 	writel(0, imxdi->ioaddr + DIER);
 
+	rc = di_handle_state(imxdi);
+	if (rc != 0)
+		goto err;
+
 	rc = devm_request_irq(&pdev->dev, imxdi->irq, dryice_norm_irq,
 			IRQF_SHARED, pdev->name, imxdi);
 	if (rc) {
@@ -498,44 +777,6 @@ static int __init dryice_rtc_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	/* put dryice into valid state */
-	if (readl(imxdi->ioaddr + DSR) & DSR_NVF) {
-		rc = di_write_wait(imxdi, DSR_NVF | DSR_SVF, DSR);
-		if (rc)
-			goto err;
-	}
-
-	/* initialize alarm */
-	rc = di_write_wait(imxdi, DCAMR_UNSET, DCAMR);
-	if (rc)
-		goto err;
-	rc = di_write_wait(imxdi, 0, DCALR);
-	if (rc)
-		goto err;
-
-	/* clear alarm flag */
-	if (readl(imxdi->ioaddr + DSR) & DSR_CAF) {
-		rc = di_write_wait(imxdi, DSR_CAF, DSR);
-		if (rc)
-			goto err;
-	}
-
-	/* the timer won't count if it has never been written to */
-	if (readl(imxdi->ioaddr + DTCMR) == 0) {
-		rc = di_write_wait(imxdi, 0, DTCMR);
-		if (rc)
-			goto err;
-	}
-
-	/* start keeping time */
-	if (!(readl(imxdi->ioaddr + DCR) & DCR_TCE)) {
-		rc = di_write_wait(imxdi,
-				readl(imxdi->ioaddr + DCR) | DCR_TCE,
-				DCR);
-		if (rc)
-			goto err;
-	}
-
 	platform_set_drvdata(pdev, imxdi);
 	imxdi->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
 				  &dryice_rtc_ops, THIS_MODULE);
-- 
2.1.4
