From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Wed, 25 Jan 2017 16:41:54 +0800
Subject: [PATCH 1/4] rtc: gemini: using devm_rtc_device_register helper
Message-ID: <1485333717-47536-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using devm_rtc_device_register() helper to simplify code.

Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com> 
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/rtc/rtc-gemini.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-gemini.c b/drivers/rtc/rtc-gemini.c
index 688debc..504b6c1 100644
--- a/drivers/rtc/rtc-gemini.c
+++ b/drivers/rtc/rtc-gemini.c
@@ -145,26 +145,16 @@ static int gemini_rtc_probe(struct platform_device *pdev)
 	if (unlikely(ret))
 		return ret;
 
-	rtc->rtc_dev = rtc_device_register(pdev->name, dev,
-					   &gemini_rtc_ops, THIS_MODULE);
+	rtc->rtc_dev = devm_rtc_device_register(dev, pdev->name, &gemini_rtc_ops,
+						THIS_MODULE);
 	return PTR_ERR_OR_ZERO(rtc->rtc_dev);
 }
 
-static int gemini_rtc_remove(struct platform_device *pdev)
-{
-	struct gemini_rtc *rtc = platform_get_drvdata(pdev);
-
-	rtc_device_unregister(rtc->rtc_dev);
-
-	return 0;
-}
-
 static struct platform_driver gemini_rtc_driver = {
 	.driver		= {
 		.name	= DRV_NAME,
 	},
 	.probe		= gemini_rtc_probe,
-	.remove		= gemini_rtc_remove,
 };
 
 module_platform_driver_probe(gemini_rtc_driver, gemini_rtc_probe);
-- 
1.7.12.4
