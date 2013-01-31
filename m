From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu, 31 Jan 2013 15:16:17 +0100
Subject: [RFC] ARM i.MX: rtc: change interrupt handling for DryIce
Message-ID: <1359641777-975-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

di_write_wait uses a very short timeout of 1ms for the wait_queue.
This may lead to write errors to some registers. Write errors to DCAMR and
DSR_CAF where the only one observed, though:

Tue Jan 14 15:32:23 2014  -0.985304 seconds
Tue Jan 14 15:32:24 2014  -0.985236 seconds
Tue Jan 14 15:32:25 2014  -0.986601 seconds
imxdi_rtc 53ffc000.dryice: Write-wait timeout val = 0x52d5588a reg = 0x00000008
Tue Jan 14 15:32:26 2014  -0.983772 seconds
Tue Jan 14 15:32:27 2014  -0.983594 seconds
imxdi_rtc 53ffc000.dryice: Write-wait timeout val = 0x52d5588c reg = 0x00000008
Tue Jan 14 15:32:28 2014  -0.983596 seconds
imxdi_rtc 53ffc000.dryice: Write-wait timeout val = 0x52d5588d reg = 0x00000008
Tue Jan 14 15:32:29 2014  -0.983300 seconds
Tue Jan 14 15:32:30 2014  -0.982809 seconds

Just increasing this timeout leads to a race condition in the interrupt handler.
After a couple minutes of running
	while true; do hwclock; done
the interrupt isn't handled by the driver and disabled in the process.
This seems to be because of the waitqueue check and then returning out of the
handler, as there is no other handler that takes over.

Use wait_event_interruptible without a timeout instead and do not leave the
interrupt handler in case of an empty waitqueue, but handle the actual irq case.
As before, nothing is done in that case though.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/rtc/rtc-imxdi.c |   32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/rtc/rtc-imxdi.c b/drivers/rtc/rtc-imxdi.c
index 75d307a..b3bb69f 100644
--- a/drivers/rtc/rtc-imxdi.c
+++ b/drivers/rtc/rtc-imxdi.c
@@ -66,6 +66,7 @@
 #define DIER_WCIE (1 << 8)       /* Write Complete Interrupt Enable */
 #define DIER_WEIE (1 << 7)       /* Write Error Interrupt Enable */
 #define DIER_CAIE (1 << 4)       /* Clock Alarm Interrupt Enable */
+#define DIER_SVIE (1 << 0)	 /* Security-violation interrupt */
 
 /**
  * struct imxdi_dev - private imxdi rtc data
@@ -160,7 +161,7 @@ static int di_write_wait(struct imxdi_dev *imxdi, u32 val, int reg)
 	mutex_lock(&imxdi->write_mutex);
 
 	/* enable the write-complete interrupt */
-	di_int_enable(imxdi, DIER_WCIE);
+	di_int_enable(imxdi, DIER_WCIE | DIER_WEIE);
 
 	imxdi->dsr = 0;
 
@@ -168,15 +169,18 @@ static int di_write_wait(struct imxdi_dev *imxdi, u32 val, int reg)
 	__raw_writel(val, imxdi->ioaddr + reg);
 
 	/* wait for the write to finish */
-	ret = wait_event_interruptible_timeout(imxdi->write_wait,
-			imxdi->dsr & (DSR_WCF | DSR_WEF), msecs_to_jiffies(1));
-	if (ret < 0) {
+	ret = wait_event_interruptible(imxdi->write_wait, imxdi->dsr &
+					(DSR_WCF | DSR_WEF));
+
+	if (ret <= 0) {
 		rc = ret;
 		goto out;
-	} else if (ret == 0) {
+	} else if (ret > 0) {
 		dev_warn(&imxdi->pdev->dev,
 				"Write-wait timeout "
 				"val = 0x%08x reg = 0x%08x\n", val, reg);
+		rc = -ERESTARTSYS;
+		goto out;
 	}
 
 	/* check for write error */
@@ -313,18 +317,12 @@ static irqreturn_t dryice_norm_irq(int irq, void *dev_id)
 	dier = __raw_readl(imxdi->ioaddr + DIER);
 
 	/* handle write complete and write error cases */
-	if ((dier & DIER_WCIE)) {
-		/*If the write wait queue is empty then there is no pending
-		  operations. It means the interrupt is for DryIce -Security.
-		  IRQ must be returned as none.*/
-		if (list_empty_careful(&imxdi->write_wait.task_list))
-			return rc;
-
+	if ((dier & (DIER_WCIE | DIER_WEIE))) {
 		/* DSR_WCF clears itself on DSR read */
 		dsr = __raw_readl(imxdi->ioaddr + DSR);
 		if ((dsr & (DSR_WCF | DSR_WEF))) {
 			/* mask the interrupt */
-			di_int_disable(imxdi, DIER_WCIE);
+			di_int_disable(imxdi, DIER_WCIE | DIER_WEIE);
 
 			/* save the dsr value for the wait queue */
 			imxdi->dsr |= dsr;
@@ -347,6 +345,14 @@ static irqreturn_t dryice_norm_irq(int irq, void *dev_id)
 			rc = IRQ_HANDLED;
 		}
 	}
+
+	/* handle security violations */
+	if (dier & DIER_SVIE) {
+		/* FIXME: with the current implementation, SVIE is never set */
+		/* failure states would be handled here */
+		return IRQ_HANDLED;
+	}
+
 	return rc;
 }
 
-- 
1.7.10.4
