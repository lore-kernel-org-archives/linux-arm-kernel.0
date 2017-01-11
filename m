From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 11 Jan 2017 10:16:58 +0000
Subject: [PATCH] rtc: armada38x: make struct rtc_class_ops const
Message-ID: <E1cRFxi-00083n-FY@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Armada38x wants to modify its rtc_class_ops to remove the interrupt
handling when there is no usable interrupt, but this means we leave
function pointers in writable memory.

Since rtc_class_ops is small, arrange to have two instances, one for
when we have interrupts, and one for when we have none, both marked
const.  This allows the compiler to place them in read-only memory,
which is better than placing them in __ro_after_init.

Thanks to Bhumika Goyal <bhumirks@gmail.com> for pointing out that
the structure was writable and submitting a patch to add
__ro_after_init.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
As the thread has gone quiet, I'm submitting the patch I sent within that
thread.  No one appears to have raised an objection to it (other than what
appears to be a misunderstanding.)

 drivers/rtc/rtc-armada38x.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
index 9a3f2a6f512e..a4166ccfce36 100644
--- a/drivers/rtc/rtc-armada38x.c
+++ b/drivers/rtc/rtc-armada38x.c
@@ -202,7 +202,7 @@ static irqreturn_t armada38x_rtc_alarm_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static struct rtc_class_ops armada38x_rtc_ops = {
+static const struct rtc_class_ops armada38x_rtc_ops = {
 	.read_time = armada38x_rtc_read_time,
 	.set_time = armada38x_rtc_set_time,
 	.read_alarm = armada38x_rtc_read_alarm,
@@ -210,8 +210,15 @@ static struct rtc_class_ops armada38x_rtc_ops = {
 	.alarm_irq_enable = armada38x_rtc_alarm_irq_enable,
 };
 
+static const struct rtc_class_ops armada38x_rtc_ops_noirq = {
+	.read_time = armada38x_rtc_read_time,
+	.set_time = armada38x_rtc_set_time,
+	.read_alarm = armada38x_rtc_read_alarm,
+};
+
 static __init int armada38x_rtc_probe(struct platform_device *pdev)
 {
+	const struct rtc_class_ops *ops;
 	struct resource *res;
 	struct armada38x_rtc *rtc;
 	int ret;
@@ -242,19 +249,22 @@ static __init int armada38x_rtc_probe(struct platform_device *pdev)
 				0, pdev->name, rtc) < 0) {
 		dev_warn(&pdev->dev, "Interrupt not available.\n");
 		rtc->irq = -1;
+	}
+	platform_set_drvdata(pdev, rtc);
+
+	if (rtc->irq != -1) {
+		device_init_wakeup(&pdev->dev, 1);
+		ops = &armada38x_rtc_ops;
+	} else {
 		/*
 		 * If there is no interrupt available then we can't
 		 * use the alarm
 		 */
-		armada38x_rtc_ops.set_alarm = NULL;
-		armada38x_rtc_ops.alarm_irq_enable = NULL;
+		ops = &armada38x_rtc_ops_noirq;
 	}
-	platform_set_drvdata(pdev, rtc);
-	if (rtc->irq != -1)
-		device_init_wakeup(&pdev->dev, 1);
 
 	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, pdev->name,
-					&armada38x_rtc_ops, THIS_MODULE);
+						ops, THIS_MODULE);
 	if (IS_ERR(rtc->rtc_dev)) {
 		ret = PTR_ERR(rtc->rtc_dev);
 		dev_err(&pdev->dev, "Failed to register RTC device: %d\n", ret);
-- 
2.7.4
