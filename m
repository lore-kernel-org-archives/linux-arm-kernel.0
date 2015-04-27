From: jbe@pengutronix.de (Juergen Borleis)
Date: Mon, 27 Apr 2015 15:59:52 +0200
Subject: [PATCH 6/6] RTC/i.MX/DryIce: prepare to force a security violation
In-Reply-To: <1430143192-20667-1-git-send-email-jbe@pengutronix.de>
References: <1430143192-20667-1-git-send-email-jbe@pengutronix.de>
Message-ID: <1430143192-20667-7-git-send-email-jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to test the new driver we need some mechanism to force a transition
into the security violation state. Two DryIce internal timers can be used
for this purpose. Both have an overflow feature which forces this transition
and can be triggered automatically (timer) or manually (monotonic via reading
the RTC time).

Note: this change is intended for development only to test the driver's
recovery capabilities. It is useless for regular use of the DryIce unit.

Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
Signed-off-by: Robert Schwebel <rsc@pengutronix.de>
[rsc: got NDA clearance from Freescale]
---
 drivers/rtc/rtc-imxdi.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-imxdi.c b/drivers/rtc/rtc-imxdi.c
index 46bf014..be4487c 100644
--- a/drivers/rtc/rtc-imxdi.c
+++ b/drivers/rtc/rtc-imxdi.c
@@ -29,6 +29,9 @@
  * not supported by the hardware.
  */
 
+#undef FORCE_VIOLATION
+# define USE_TIMER_VIOLATION
+
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
@@ -275,6 +278,69 @@ static int di_handle_failure_state(struct imxdi_dev *imxdi, u32 dsr)
 	return -ENODEV;
 }
 
+/*
+ * Two types of security violations we can force:
+ *
+ * - regular timer counter overflow:
+ *   - set it up to 0xfffffff0
+ *   - enable its counting
+ *   - set TCSL bit to prevent any further change
+ *   - let the overflow happen which forces a security violation
+ *
+ * - monotonic counter overflow:
+ *   - set it up to 0xfffffffc
+ *   - enable its counting (MCE = 1)
+ *   - set MCSL bit to prevent any further change
+ *   - write 4 times to the monotonic counter register
+ */
+static void di_prepare_security_violation(struct imxdi_dev *imxdi)
+{
+	u32 dcr = readl(imxdi->ioaddr + DCR);
+	u32 dtcr = readl(imxdi->ioaddr + DTCR);
+
+#ifndef USE_TIMER_VIOLATION /* monotonic counter variant */
+
+	/* clear the MCO flag, otherwhise it cannot be programmed again */
+	di_write_busy_wait(imxdi, DSR_MCO, DSR);
+
+	/* stop monotonic-counter to be able to set its absolute value */
+	dcr &= ~DCR_MCE;
+	di_write_busy_wait(imxdi, dcr, DCR);
+
+	/* set a new value close to its overflow */
+	di_write_busy_wait(imxdi, 0xfffffff8, DMCR);
+
+	/* enable monotonic-counter to increment on each write */
+	dcr |= DCR_MCE;
+	di_write_busy_wait(imxdi, dcr, DCR);
+
+	/* lock this setting */
+	dcr |= DCR_MCSL;
+	di_write_busy_wait(imxdi, dcr, DCR);
+
+	/* let this overflow force the transition into the failure state */
+	di_write_busy_wait(imxdi, dtcr | DTCR_MOE, DTCR);
+#else /* timer counter variant */
+	/* clear the TCO flag, otherwhise it cannot be programmed again */
+	di_write_busy_wait(imxdi, DSR_TCO, DSR);
+
+	/* set a new value close to its overflow (16 seconds) */
+	di_write_busy_wait(imxdi, 0x00000000, DTCLR);
+	di_write_busy_wait(imxdi, 0xfffffff0, DTCMR);
+
+	/* enable timer-counter to increment on each write */
+	dcr |= DCR_TCE;
+	di_write_busy_wait(imxdi, dcr, DCR);
+
+	/* lock this setting */
+	dcr |= DCR_TCSL;
+	di_write_busy_wait(imxdi, dcr, DCR);
+
+	/* let this overflow force the transition into the failure state */
+	di_write_busy_wait(imxdi, dtcr | DTCR_TOE, DTCR);
+#endif
+}
+
 static int di_handle_valid_state(struct imxdi_dev *imxdi, u32 dsr)
 {
 	/* initialize alarm */
@@ -292,6 +358,7 @@ static int di_handle_invalid_state(struct imxdi_dev *imxdi, u32 dsr)
 {
 	u32 dcr, sec;
 
+#ifndef FORCE_VIOLATION
 	/*
 	 * lets disable all sources which can force the DryIce unit into
 	 * the "FAILURE STATE" for now
@@ -299,7 +366,7 @@ static int di_handle_invalid_state(struct imxdi_dev *imxdi, u32 dsr)
 	di_write_busy_wait(imxdi, 0x00000000, DTCR);
 	/* and lets protect them at runtime from any change */
 	di_write_busy_wait(imxdi, DCR_TDCSL, DCR);
-
+#endif
 	sec = readl(imxdi->ioaddr + DTCMR);
 	if (sec != 0)
 		dev_warn(&imxdi->pdev->dev,
@@ -556,6 +623,10 @@ static int dryice_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	now = readl(imxdi->ioaddr + DTCMR);
 	rtc_time_to_tm(now, tm);
 
+#if defined(FORCE_VIOLATION) && !defined(USE_TIMER_VIOLATION)
+	/* don't use interrupts here */
+	di_write_busy_wait(imxdi, 0, DMCR);
+#endif
 	return 0;
 }
 
@@ -823,6 +894,9 @@ static int __init dryice_rtc_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+#ifdef FORCE_VIOLATION
+	di_prepare_security_violation(imxdi);
+#endif
 	return 0;
 
 err:
-- 
2.1.4
