From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 24 Jun 2011 15:13:15 +0900
Subject: [PATCH] rtc: rtc-s3c: remove useless codes
Message-ID: <1308895995-19977-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Changhwan Youn <chaos.youn@samsung.com>

This patch removes unused code in rtc-s3c.c

1. removes PIE related code because commit 6610e089
   emulates PIE using a hrtimer.
2. removes unused spinlock definition.
3. removes rtc_class_ops->proc which gives wrong information.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/rtc/rtc-s3c.c |   94 +------------------------------------------------
 1 files changed, 1 insertions(+), 93 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index 16512ec..883a16f 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -45,12 +45,9 @@ static struct resource *s3c_rtc_mem;
 static struct clk *rtc_clk;
 static void __iomem *s3c_rtc_base;
 static int s3c_rtc_alarmno = NO_IRQ;
-static int s3c_rtc_tickno  = NO_IRQ;
 static bool wake_en;
 static enum s3c_cpu_type s3c_rtc_cpu_type;
 
-static DEFINE_SPINLOCK(s3c_rtc_pie_lock);
-
 /* IRQ Handlers */
 
 static irqreturn_t s3c_rtc_alarmirq(int irq, void *id)
@@ -65,18 +62,6 @@ static irqreturn_t s3c_rtc_alarmirq(int irq, void *id)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t s3c_rtc_tickirq(int irq, void *id)
-{
-	struct rtc_device *rdev = id;
-
-	rtc_update_irq(rdev, 1, RTC_PF | RTC_IRQF);
-
-	if (s3c_rtc_cpu_type == TYPE_S3C64XX)
-		writeb(S3C2410_INTP_TIC, s3c_rtc_base + S3C2410_INTP);
-
-	return IRQ_HANDLED;
-}
-
 /* Update control registers */
 static int s3c_rtc_setaie(struct device *dev, unsigned int enabled)
 {
@@ -94,30 +79,6 @@ static int s3c_rtc_setaie(struct device *dev, unsigned int enabled)
 	return 0;
 }
 
-static int s3c_rtc_setfreq(struct device *dev, int freq)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rtc_device *rtc_dev = platform_get_drvdata(pdev);
-	unsigned int tmp = 0;
-
-	if (!is_power_of_2(freq))
-		return -EINVAL;
-
-	spin_lock_irq(&s3c_rtc_pie_lock);
-
-	if (s3c_rtc_cpu_type == TYPE_S3C2410) {
-		tmp = readb(s3c_rtc_base + S3C2410_TICNT);
-		tmp &= S3C2410_TICNT_ENABLE;
-	}
-
-	tmp |= (rtc_dev->max_user_freq / freq)-1;
-
-	writel(tmp, s3c_rtc_base + S3C2410_TICNT);
-	spin_unlock_irq(&s3c_rtc_pie_lock);
-
-	return 0;
-}
-
 /* Time read/write */
 
 static int s3c_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
@@ -285,22 +246,6 @@ static int s3c_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	return 0;
 }
 
-static int s3c_rtc_proc(struct device *dev, struct seq_file *seq)
-{
-	unsigned int ticnt;
-
-	if (s3c_rtc_cpu_type == TYPE_S3C64XX) {
-		ticnt = readw(s3c_rtc_base + S3C2410_RTCCON);
-		ticnt &= S3C64XX_RTCCON_TICEN;
-	} else {
-		ticnt = readb(s3c_rtc_base + S3C2410_TICNT);
-		ticnt &= S3C2410_TICNT_ENABLE;
-	}
-
-	seq_printf(seq, "periodic_IRQ\t: %s\n", ticnt  ? "yes" : "no");
-	return 0;
-}
-
 static int s3c_rtc_open(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -315,18 +260,6 @@ static int s3c_rtc_open(struct device *dev)
 		return ret;
 	}
 
-	ret = request_irq(s3c_rtc_tickno, s3c_rtc_tickirq,
-			  IRQF_DISABLED,  "s3c2410-rtc tick", rtc_dev);
-
-	if (ret) {
-		dev_err(dev, "IRQ%d error %d\n", s3c_rtc_tickno, ret);
-		goto tick_err;
-	}
-
-	return ret;
-
- tick_err:
-	free_irq(s3c_rtc_alarmno, rtc_dev);
 	return ret;
 }
 
@@ -338,7 +271,6 @@ static void s3c_rtc_release(struct device *dev)
 	/* do not clear AIE here, it may be needed for wake */
 
 	free_irq(s3c_rtc_alarmno, rtc_dev);
-	free_irq(s3c_rtc_tickno, rtc_dev);
 }
 
 static const struct rtc_class_ops s3c_rtcops = {
@@ -348,7 +280,6 @@ static const struct rtc_class_ops s3c_rtcops = {
 	.set_time	= s3c_rtc_settime,
 	.read_alarm	= s3c_rtc_getalarm,
 	.set_alarm	= s3c_rtc_setalarm,
-	.proc		= s3c_rtc_proc,
 	.alarm_irq_enable = s3c_rtc_setaie,
 };
 
@@ -432,20 +363,13 @@ static int __devinit s3c_rtc_probe(struct platform_device *pdev)
 
 	/* find the IRQs */
 
-	s3c_rtc_tickno = platform_get_irq(pdev, 1);
-	if (s3c_rtc_tickno < 0) {
-		dev_err(&pdev->dev, "no irq for rtc tick\n");
-		return -ENOENT;
-	}
-
 	s3c_rtc_alarmno = platform_get_irq(pdev, 0);
 	if (s3c_rtc_alarmno < 0) {
 		dev_err(&pdev->dev, "no irq for alarm\n");
 		return -ENOENT;
 	}
 
-	pr_debug("s3c2410_rtc: tick irq %d, alarm irq %d\n",
-		 s3c_rtc_tickno, s3c_rtc_alarmno);
+	pr_debug("s3c2410_rtc: alarm irq %d\n", s3c_rtc_alarmno);
 
 	/* get the memory region */
 
@@ -528,7 +452,6 @@ static int __devinit s3c_rtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, rtc);
 
-	s3c_rtc_setfreq(&pdev->dev, 1);
 
 	return 0;
 
@@ -551,16 +474,8 @@ static int __devinit s3c_rtc_probe(struct platform_device *pdev)
 
 /* RTC Power management control */
 
-static int ticnt_save, ticnt_en_save;
-
 static int s3c_rtc_suspend(struct platform_device *pdev, pm_message_t state)
 {
-	/* save TICNT for anyone using periodic interrupts */
-	ticnt_save = readb(s3c_rtc_base + S3C2410_TICNT);
-	if (s3c_rtc_cpu_type == TYPE_S3C64XX) {
-		ticnt_en_save = readw(s3c_rtc_base + S3C2410_RTCCON);
-		ticnt_en_save &= S3C64XX_RTCCON_TICEN;
-	}
 	s3c_rtc_enable(pdev, 0);
 
 	if (device_may_wakeup(&pdev->dev) && !wake_en) {
@@ -575,14 +490,7 @@ static int s3c_rtc_suspend(struct platform_device *pdev, pm_message_t state)
 
 static int s3c_rtc_resume(struct platform_device *pdev)
 {
-	unsigned int tmp;
-
 	s3c_rtc_enable(pdev, 1);
-	writeb(ticnt_save, s3c_rtc_base + S3C2410_TICNT);
-	if (s3c_rtc_cpu_type == TYPE_S3C64XX && ticnt_en_save) {
-		tmp = readw(s3c_rtc_base + S3C2410_RTCCON);
-		writew(tmp | ticnt_en_save, s3c_rtc_base + S3C2410_RTCCON);
-	}
 
 	if (device_may_wakeup(&pdev->dev) && wake_en) {
 		disable_irq_wake(s3c_rtc_alarmno);
-- 
1.7.1
