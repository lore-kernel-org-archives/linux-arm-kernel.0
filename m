From: jbe@pengutronix.de (Juergen Borleis)
Date: Tue, 14 Apr 2015 11:08:36 +0200
Subject: [PATCH 3/5] RTC/i.MX/DryIce: monitor a security violation at runtime
In-Reply-To: <1429002518-5015-2-git-send-email-jbe@pengutronix.de>
References: <1429002518-5015-2-git-send-email-jbe@pengutronix.de>
Message-ID: <1429002518-5015-4-git-send-email-jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maybe the unit enters the hardware related state at runtime and not at
system boot time (after a power cycle).

Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
Signed-off-by: Robert Schwebel <rsc@pengutronix.de>
[rsc: got NDA clearance from Freescale]
---
 drivers/rtc/rtc-imxdi.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-imxdi.c b/drivers/rtc/rtc-imxdi.c
index f8abf2b..b04c64f 100644
--- a/drivers/rtc/rtc-imxdi.c
+++ b/drivers/rtc/rtc-imxdi.c
@@ -680,6 +680,25 @@ static irqreturn_t dryice_norm_irq(int irq, void *dev_id)
 	irqreturn_t rc = IRQ_NONE;
 
 	dier = __raw_readl(imxdi->ioaddr + DIER);
+	dsr = __raw_readl(imxdi->ioaddr + DSR);
+
+	/* handle the security violation event */
+	if (dier & DIER_SVIE) {
+		if (dsr & DSR_SVF) {
+			/*
+			 * Disable the interrupt when this kind of event has
+			 * happened.
+			 * There cannot be more than one event of this type,
+			 * because it needs a complex state change
+			 * including a main power cycle to get again out of
+			 * this state.
+			 */
+			di_int_disable(imxdi, DIER_SVIE);
+			/* report the violation */
+			di_report_tamper_info(imxdi, dsr);
+			rc = IRQ_HANDLED;
+		}
+	}
 
 	/* handle write complete and write error cases */
 	if (dier & DIER_WCIE) {
@@ -690,7 +709,6 @@ static irqreturn_t dryice_norm_irq(int irq, void *dev_id)
 			return rc;
 
 		/* DSR_WCF clears itself on DSR read */
-		dsr = __raw_readl(imxdi->ioaddr + DSR);
 		if (dsr & (DSR_WCF | DSR_WEF)) {
 			/* mask the interrupt */
 			di_int_disable(imxdi, DIER_WCIE);
@@ -706,7 +724,6 @@ static irqreturn_t dryice_norm_irq(int irq, void *dev_id)
 	/* handle the alarm case */
 	if (dier & DIER_CAIE) {
 		/* DSR_WCF clears itself on DSR read */
-		dsr = __raw_readl(imxdi->ioaddr + DSR);
 		if (dsr & DSR_CAF) {
 			/* mask the interrupt */
 			di_int_disable(imxdi, DIER_CAIE);
-- 
2.1.4
