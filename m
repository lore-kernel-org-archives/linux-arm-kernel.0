From: khoroshilov@ispras.ru (Alexey Khoroshilov)
Date: Sat,  3 Feb 2018 00:45:57 +0300
Subject: [PATCH] rtc: gemini/ftrtc010: disable clk on error paths in
 ftrtc010_rtc_probe()
Message-ID: <1517607957-5664-1-git-send-email-khoroshilov@ispras.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ftrtc010_rtc_probe() leaves clks enabled in case of errors.
The patch adds proper disabling code.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/rtc/rtc-ftrtc010.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
index af8d6beae20c..67a0aadf488c 100644
--- a/drivers/rtc/rtc-ftrtc010.c
+++ b/drivers/rtc/rtc-ftrtc010.c
@@ -147,33 +147,52 @@ static int ftrtc010_rtc_probe(struct platform_device *pdev)
 		ret = clk_prepare_enable(rtc->extclk);
 		if (ret) {
 			dev_err(dev, "failed to enable EXTCLK\n");
-			return ret;
+			goto err_pclk;
 		}
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res)
-		return -ENODEV;
+	if (!res) {
+		ret = -ENODEV;
+		goto err_extclk;
+	}
 
 	rtc->rtc_irq = res->start;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
+	if (!res) {
+		ret = -ENODEV;
+		goto err_extclk;
+	}
 
 	rtc->rtc_base = devm_ioremap(dev, res->start,
 				     resource_size(res));
-	if (!rtc->rtc_base)
-		return -ENOMEM;
+	if (!rtc->rtc_base) {
+		ret = -ENOMEM;
+		goto err_extclk;
+	}
 
 	ret = devm_request_irq(dev, rtc->rtc_irq, ftrtc010_rtc_interrupt,
 			       IRQF_SHARED, pdev->name, dev);
 	if (unlikely(ret))
-		return ret;
+		goto err_extclk;
 
 	rtc->rtc_dev = rtc_device_register(pdev->name, dev,
 					   &ftrtc010_rtc_ops, THIS_MODULE);
-	return PTR_ERR_OR_ZERO(rtc->rtc_dev);
+	if (IS_ERR(rtc->rtc_dev)) {
+		ret = PTR_ERR(rtc->rtc_dev);
+		goto err_extclk;
+	}
+
+	return 0;
+
+err_extclk:
+	if (!IS_ERR(rtc->extclk))
+		clk_disable_unprepare(rtc->extclk);
+err_pclk:
+	if (!IS_ERR(rtc->pclk))
+		clk_disable_unprepare(rtc->pclk);
+	return ret;
 }
 
 static int ftrtc010_rtc_remove(struct platform_device *pdev)
-- 
2.7.4
