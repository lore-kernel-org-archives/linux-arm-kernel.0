From: jbe@pengutronix.de (Juergen Borleis)
Date: Mon, 27 Apr 2015 15:59:51 +0200
Subject: [PATCH 5/6] RTC/i.MX/DryIce: when locked, do not fail silently
In-Reply-To: <1430143192-20667-1-git-send-email-jbe@pengutronix.de>
References: <1430143192-20667-1-git-send-email-jbe@pengutronix.de>
Message-ID: <1430143192-20667-6-git-send-email-jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the DryICE unit is locked it is impossibe to set the time. Provide an
error message for this case.

Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
Signed-off-by: Robert Schwebel <rsc@pengutronix.de>
[rsc: got NDA clearance from Freescale]
---
 drivers/rtc/rtc-imxdi.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-imxdi.c b/drivers/rtc/rtc-imxdi.c
index 8890a62..46bf014 100644
--- a/drivers/rtc/rtc-imxdi.c
+++ b/drivers/rtc/rtc-imxdi.c
@@ -566,14 +566,35 @@ static int dryice_rtc_read_time(struct device *dev, struct rtc_time *tm)
 static int dryice_rtc_set_mmss(struct device *dev, unsigned long secs)
 {
 	struct imxdi_dev *imxdi = dev_get_drvdata(dev);
+	u32 dcr, dsr;
 	int rc;
 
+	dcr = readl(imxdi->ioaddr + DCR);
+	dsr = readl(imxdi->ioaddr + DSR);
+
+	if (!(dcr & DCR_TCE) || (dsr & DSR_SVF)) {
+		if (dcr & DCR_TCHL) {
+			/* we are even more out of luck */
+			di_what_is_to_be_done(imxdi, "battery");
+			return -EPERM;
+		}
+		if ((dcr & DCR_TCSL) || (dsr & DSR_SVF)) {
+			/* we are out of luck for now */
+			di_what_is_to_be_done(imxdi, "main");
+			return -EPERM;
+		}
+	}
+
 	/* zero the fractional part first */
 	rc = di_write_wait(imxdi, 0, DTCLR);
-	if (rc == 0)
-		rc = di_write_wait(imxdi, secs, DTCMR);
+	if (rc != 0)
+		return rc;
 
-	return rc;
+	rc = di_write_wait(imxdi, secs, DTCMR);
+	if (rc != 0)
+		return rc;
+
+	return di_write_wait(imxdi, readl(imxdi->ioaddr + DCR) | DCR_TCE, DCR);
 }
 
 static int dryice_rtc_alarm_irq_enable(struct device *dev,
-- 
2.1.4
