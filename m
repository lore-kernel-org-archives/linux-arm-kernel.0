From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 22 Jun 2011 23:20:13 +0200
Subject: [PATCH 1/2] rtc: vt8500: cleanup rtc_class_ops->update_irq_enable()
Message-ID: <1308777614-19043-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexey Charkov <alchark@gmail.com>

Now that the generic code handles UIE mode irqs via periodic
alarm interrupts, no one calls the
rtc_class_ops->update_irq_enable() method anymore.

This patch removes the driver hooks and implementations of
update_irq_enable and the associated setup.

[wsa: updated commit-message and removed update_irq_enable-function, too]

Signed-off-by: Alexey Charkov <alchark@gmail.com>
Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
---

This should go to 3.0, since building the driver breaks currently.

 drivers/rtc/rtc-vt8500.c |   45 +++------------------------------------------
 1 files changed, 3 insertions(+), 42 deletions(-)

diff --git a/drivers/rtc/rtc-vt8500.c b/drivers/rtc/rtc-vt8500.c
index b8bc862..efd6066 100644
--- a/drivers/rtc/rtc-vt8500.c
+++ b/drivers/rtc/rtc-vt8500.c
@@ -78,7 +78,6 @@ struct vt8500_rtc {
 	void __iomem		*regbase;
 	struct resource		*res;
 	int			irq_alarm;
-	int			irq_hz;
 	struct rtc_device	*rtc;
 	spinlock_t		lock;		/* Protects this structure */
 };
@@ -100,10 +99,6 @@ static irqreturn_t vt8500_rtc_irq(int irq, void *dev_id)
 	if (isr & 1)
 		events |= RTC_AF | RTC_IRQF;
 
-	/* Only second/minute interrupts are supported */
-	if (isr & 2)
-		events |= RTC_UF | RTC_IRQF;
-
 	rtc_update_irq(vt8500_rtc->rtc, 1, events);
 
 	return IRQ_HANDLED;
@@ -199,27 +194,12 @@ static int vt8500_alarm_irq_enable(struct device *dev, unsigned int enabled)
 	return 0;
 }
 
-static int vt8500_update_irq_enable(struct device *dev, unsigned int enabled)
-{
-	struct vt8500_rtc *vt8500_rtc = dev_get_drvdata(dev);
-	unsigned long tmp = readl(vt8500_rtc->regbase + VT8500_RTC_CR);
-
-	if (enabled)
-		tmp |= VT8500_RTC_CR_SM_SEC | VT8500_RTC_CR_SM_ENABLE;
-	else
-		tmp &= ~VT8500_RTC_CR_SM_ENABLE;
-
-	writel(tmp, vt8500_rtc->regbase + VT8500_RTC_CR);
-	return 0;
-}
-
 static const struct rtc_class_ops vt8500_rtc_ops = {
 	.read_time = vt8500_rtc_read_time,
 	.set_time = vt8500_rtc_set_time,
 	.read_alarm = vt8500_rtc_read_alarm,
 	.set_alarm = vt8500_rtc_set_alarm,
 	.alarm_irq_enable = vt8500_alarm_irq_enable,
-	.update_irq_enable = vt8500_update_irq_enable,
 };
 
 static int __devinit vt8500_rtc_probe(struct platform_device *pdev)
@@ -248,13 +228,6 @@ static int __devinit vt8500_rtc_probe(struct platform_device *pdev)
 		goto err_free;
 	}
 
-	vt8500_rtc->irq_hz = platform_get_irq(pdev, 1);
-	if (vt8500_rtc->irq_hz < 0) {
-		dev_err(&pdev->dev, "No 1Hz IRQ resource defined\n");
-		ret = -ENXIO;
-		goto err_free;
-	}
-
 	vt8500_rtc->res = request_mem_region(vt8500_rtc->res->start,
 					     resource_size(vt8500_rtc->res),
 					     "vt8500-rtc");
@@ -272,9 +245,8 @@ static int __devinit vt8500_rtc_probe(struct platform_device *pdev)
 		goto err_release;
 	}
 
-	/* Enable the second/minute interrupt generation and enable RTC */
-	writel(VT8500_RTC_CR_ENABLE | VT8500_RTC_CR_24H
-		| VT8500_RTC_CR_SM_ENABLE | VT8500_RTC_CR_SM_SEC,
+	/* Enable RTC and set it to 24-hour mode */
+	writel(VT8500_RTC_CR_ENABLE | VT8500_RTC_CR_24H,
 	       vt8500_rtc->regbase + VT8500_RTC_CR);
 
 	vt8500_rtc->rtc = rtc_device_register("vt8500-rtc", &pdev->dev,
@@ -286,26 +258,16 @@ static int __devinit vt8500_rtc_probe(struct platform_device *pdev)
 		goto err_unmap;
 	}
 
-	ret = request_irq(vt8500_rtc->irq_hz, vt8500_rtc_irq, 0,
-			  "rtc 1Hz", vt8500_rtc);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "can't get irq %i, err %d\n",
-			vt8500_rtc->irq_hz, ret);
-		goto err_unreg;
-	}
-
 	ret = request_irq(vt8500_rtc->irq_alarm, vt8500_rtc_irq, 0,
 			  "rtc alarm", vt8500_rtc);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "can't get irq %i, err %d\n",
 			vt8500_rtc->irq_alarm, ret);
-		goto err_free_hz;
+		goto err_unreg;
 	}
 
 	return 0;
 
-err_free_hz:
-	free_irq(vt8500_rtc->irq_hz, vt8500_rtc);
 err_unreg:
 	rtc_device_unregister(vt8500_rtc->rtc);
 err_unmap:
@@ -323,7 +285,6 @@ static int __devexit vt8500_rtc_remove(struct platform_device *pdev)
 	struct vt8500_rtc *vt8500_rtc = platform_get_drvdata(pdev);
 
 	free_irq(vt8500_rtc->irq_alarm, vt8500_rtc);
-	free_irq(vt8500_rtc->irq_hz, vt8500_rtc);
 
 	rtc_device_unregister(vt8500_rtc->rtc);
 
-- 
1.7.2.5
