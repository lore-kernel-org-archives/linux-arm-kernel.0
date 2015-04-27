From: jbe@pengutronix.de (Juergen Borleis)
Date: Mon, 27 Apr 2015 15:59:47 +0200
Subject: [PATCH 1/6] RTC/i.MX/DryIce: avoid the __raw* register access
 functions
In-Reply-To: <1430143192-20667-1-git-send-email-jbe@pengutronix.de>
References: <1430143192-20667-1-git-send-email-jbe@pengutronix.de>
Message-ID: <1430143192-20667-2-git-send-email-jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Be independent of the endianness of the kernel.

Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
---
 drivers/rtc/rtc-imxdi.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/rtc/rtc-imxdi.c b/drivers/rtc/rtc-imxdi.c
index c666eab..0c2a064 100644
--- a/drivers/rtc/rtc-imxdi.c
+++ b/drivers/rtc/rtc-imxdi.c
@@ -137,7 +137,7 @@ static void di_int_enable(struct imxdi_dev *imxdi, u32 intr)
 	unsigned long flags;
 
 	spin_lock_irqsave(&imxdi->irq_lock, flags);
-	__raw_writel(__raw_readl(imxdi->ioaddr + DIER) | intr,
+	writel(readl(imxdi->ioaddr + DIER) | intr,
 			imxdi->ioaddr + DIER);
 	spin_unlock_irqrestore(&imxdi->irq_lock, flags);
 }
@@ -150,7 +150,7 @@ static void di_int_disable(struct imxdi_dev *imxdi, u32 intr)
 	unsigned long flags;
 
 	spin_lock_irqsave(&imxdi->irq_lock, flags);
-	__raw_writel(__raw_readl(imxdi->ioaddr + DIER) & ~intr,
+	writel(readl(imxdi->ioaddr + DIER) & ~intr,
 			imxdi->ioaddr + DIER);
 	spin_unlock_irqrestore(&imxdi->irq_lock, flags);
 }
@@ -169,11 +169,11 @@ static void clear_write_error(struct imxdi_dev *imxdi)
 	dev_warn(&imxdi->pdev->dev, "WARNING: Register write error!\n");
 
 	/* clear the write error flag */
-	__raw_writel(DSR_WEF, imxdi->ioaddr + DSR);
+	writel(DSR_WEF, imxdi->ioaddr + DSR);
 
 	/* wait for it to take effect */
 	for (cnt = 0; cnt < 1000; cnt++) {
-		if ((__raw_readl(imxdi->ioaddr + DSR) & DSR_WEF) == 0)
+		if ((readl(imxdi->ioaddr + DSR) & DSR_WEF) == 0)
 			return;
 		udelay(10);
 	}
@@ -201,7 +201,7 @@ static int di_write_wait(struct imxdi_dev *imxdi, u32 val, int reg)
 	imxdi->dsr = 0;
 
 	/* do the register write */
-	__raw_writel(val, imxdi->ioaddr + reg);
+	writel(val, imxdi->ioaddr + reg);
 
 	/* wait for the write to finish */
 	ret = wait_event_interruptible_timeout(imxdi->write_wait,
@@ -235,7 +235,7 @@ static int dryice_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	struct imxdi_dev *imxdi = dev_get_drvdata(dev);
 	unsigned long now;
 
-	now = __raw_readl(imxdi->ioaddr + DTCMR);
+	now = readl(imxdi->ioaddr + DTCMR);
 	rtc_time_to_tm(now, tm);
 
 	return 0;
@@ -280,17 +280,17 @@ static int dryice_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	struct imxdi_dev *imxdi = dev_get_drvdata(dev);
 	u32 dcamr;
 
-	dcamr = __raw_readl(imxdi->ioaddr + DCAMR);
+	dcamr = readl(imxdi->ioaddr + DCAMR);
 	rtc_time_to_tm(dcamr, &alarm->time);
 
 	/* alarm is enabled if the interrupt is enabled */
-	alarm->enabled = (__raw_readl(imxdi->ioaddr + DIER) & DIER_CAIE) != 0;
+	alarm->enabled = (readl(imxdi->ioaddr + DIER) & DIER_CAIE) != 0;
 
 	/* don't allow the DSR read to mess up DSR_WCF */
 	mutex_lock(&imxdi->write_mutex);
 
 	/* alarm is pending if the alarm flag is set */
-	alarm->pending = (__raw_readl(imxdi->ioaddr + DSR) & DSR_CAF) != 0;
+	alarm->pending = (readl(imxdi->ioaddr + DSR) & DSR_CAF) != 0;
 
 	mutex_unlock(&imxdi->write_mutex);
 
@@ -312,7 +312,7 @@ static int dryice_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 		return rc;
 
 	/* don't allow setting alarm in the past */
-	now = __raw_readl(imxdi->ioaddr + DTCMR);
+	now = readl(imxdi->ioaddr + DTCMR);
 	if (alarm_time < now)
 		return -EINVAL;
 
@@ -346,7 +346,7 @@ static irqreturn_t dryice_norm_irq(int irq, void *dev_id)
 	u32 dsr, dier;
 	irqreturn_t rc = IRQ_NONE;
 
-	dier = __raw_readl(imxdi->ioaddr + DIER);
+	dier = readl(imxdi->ioaddr + DIER);
 
 	/* handle write complete and write error cases */
 	if (dier & DIER_WCIE) {
@@ -357,7 +357,7 @@ static irqreturn_t dryice_norm_irq(int irq, void *dev_id)
 			return rc;
 
 		/* DSR_WCF clears itself on DSR read */
-		dsr = __raw_readl(imxdi->ioaddr + DSR);
+		dsr = readl(imxdi->ioaddr + DSR);
 		if (dsr & (DSR_WCF | DSR_WEF)) {
 			/* mask the interrupt */
 			di_int_disable(imxdi, DIER_WCIE);
@@ -373,7 +373,7 @@ static irqreturn_t dryice_norm_irq(int irq, void *dev_id)
 	/* handle the alarm case */
 	if (dier & DIER_CAIE) {
 		/* DSR_WCF clears itself on DSR read */
-		dsr = __raw_readl(imxdi->ioaddr + DSR);
+		dsr = readl(imxdi->ioaddr + DSR);
 		if (dsr & DSR_CAF) {
 			/* mask the interrupt */
 			di_int_disable(imxdi, DIER_CAIE);
@@ -446,7 +446,7 @@ static int __init dryice_rtc_probe(struct platform_device *pdev)
 	 */
 
 	/* mask all interrupts */
-	__raw_writel(0, imxdi->ioaddr + DIER);
+	writel(0, imxdi->ioaddr + DIER);
 
 	rc = devm_request_irq(&pdev->dev, imxdi->irq, dryice_norm_irq,
 			IRQF_SHARED, pdev->name, imxdi);
@@ -456,7 +456,7 @@ static int __init dryice_rtc_probe(struct platform_device *pdev)
 	}
 
 	/* put dryice into valid state */
-	if (__raw_readl(imxdi->ioaddr + DSR) & DSR_NVF) {
+	if (readl(imxdi->ioaddr + DSR) & DSR_NVF) {
 		rc = di_write_wait(imxdi, DSR_NVF | DSR_SVF, DSR);
 		if (rc)
 			goto err;
@@ -471,23 +471,23 @@ static int __init dryice_rtc_probe(struct platform_device *pdev)
 		goto err;
 
 	/* clear alarm flag */
-	if (__raw_readl(imxdi->ioaddr + DSR) & DSR_CAF) {
+	if (readl(imxdi->ioaddr + DSR) & DSR_CAF) {
 		rc = di_write_wait(imxdi, DSR_CAF, DSR);
 		if (rc)
 			goto err;
 	}
 
 	/* the timer won't count if it has never been written to */
-	if (__raw_readl(imxdi->ioaddr + DTCMR) == 0) {
+	if (readl(imxdi->ioaddr + DTCMR) == 0) {
 		rc = di_write_wait(imxdi, 0, DTCMR);
 		if (rc)
 			goto err;
 	}
 
 	/* start keeping time */
-	if (!(__raw_readl(imxdi->ioaddr + DCR) & DCR_TCE)) {
+	if (!(readl(imxdi->ioaddr + DCR) & DCR_TCE)) {
 		rc = di_write_wait(imxdi,
-				__raw_readl(imxdi->ioaddr + DCR) | DCR_TCE,
+				readl(imxdi->ioaddr + DCR) | DCR_TCE,
 				DCR);
 		if (rc)
 			goto err;
@@ -516,7 +516,7 @@ static int __exit dryice_rtc_remove(struct platform_device *pdev)
 	flush_work(&imxdi->work);
 
 	/* mask all interrupts */
-	__raw_writel(0, imxdi->ioaddr + DIER);
+	writel(0, imxdi->ioaddr + DIER);
 
 	clk_disable_unprepare(imxdi->clk);
 
-- 
2.1.4
