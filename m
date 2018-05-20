From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Sun, 20 May 2018 14:33:36 +0200
Subject: [PATCH 1/2] rtc: st-lpc: fix possible race condition
Message-ID: <20180520123337.14856-1-alexandre.belloni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IRQ is requested before the struct rtc is allocated and registered, but
this struct is used in the IRQ handler. This may lead to a NULL pointer
dereference.

Switch to devm_rtc_allocate_device/rtc_register_device to allocate the rtc
before requesting the IRQ.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-st-lpc.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/rtc/rtc-st-lpc.c b/drivers/rtc/rtc-st-lpc.c
index d5222667f892..2f1ef2c28740 100644
--- a/drivers/rtc/rtc-st-lpc.c
+++ b/drivers/rtc/rtc-st-lpc.c
@@ -212,6 +212,10 @@ static int st_rtc_probe(struct platform_device *pdev)
 	if (!rtc)
 		return -ENOMEM;
 
+	rtc->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc->rtc_dev))
+		return PTR_ERR(rtc->rtc_dev);
+
 	spin_lock_init(&rtc->lock);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -253,26 +257,17 @@ static int st_rtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, rtc);
 
-	rtc->rtc_dev = rtc_device_register("st-lpc-rtc", &pdev->dev,
-					   &st_rtc_ops, THIS_MODULE);
-	if (IS_ERR(rtc->rtc_dev)) {
+	rtc->rtc_dev->ops = &st_rtc_ops;
+
+	ret = rtc_register_device(rtc->rtc_dev);
+	if (ret) {
 		clk_disable_unprepare(rtc->clk);
-		return PTR_ERR(rtc->rtc_dev);
+		return ret;
 	}
 
 	return 0;
 }
 
-static int st_rtc_remove(struct platform_device *pdev)
-{
-	struct st_rtc *rtc = platform_get_drvdata(pdev);
-
-	if (likely(rtc->rtc_dev))
-		rtc_device_unregister(rtc->rtc_dev);
-
-	return 0;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int st_rtc_suspend(struct device *dev)
 {
@@ -325,7 +320,6 @@ static struct platform_driver st_rtc_platform_driver = {
 		.of_match_table = st_rtc_match,
 	},
 	.probe = st_rtc_probe,
-	.remove = st_rtc_remove,
 };
 
 module_platform_driver(st_rtc_platform_driver);
-- 
2.17.0
