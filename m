From: leo.yan@linaro.org (Leo Yan)
Date: Sun, 26 Mar 2017 22:41:51 +0800
Subject: [PATCH 2/5] drivers/rtc/rtc-pl030.c: Convert to use devm_*()
In-Reply-To: <1490539314-9681-1-git-send-email-leo.yan@linaro.org>
References: <1490539314-9681-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1490539314-9681-3-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert driver to use devm_*() APIs so rely on driver model core layer
to manage resources. This eliminates error path boilerplate and makes
code neat.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/rtc/rtc-pl030.c | 49 ++++++++++++-------------------------------------
 1 file changed, 12 insertions(+), 37 deletions(-)

diff --git a/drivers/rtc/rtc-pl030.c b/drivers/rtc/rtc-pl030.c
index f85a1a9..372b1fd 100644
--- a/drivers/rtc/rtc-pl030.c
+++ b/drivers/rtc/rtc-pl030.c
@@ -102,49 +102,30 @@ static int pl030_probe(struct amba_device *dev, const struct amba_id *id)
 	struct pl030_rtc *rtc;
 	int ret;
 
-	ret = amba_request_regions(dev, NULL);
-	if (ret)
-		goto err_req;
-
 	rtc = devm_kzalloc(&dev->dev, sizeof(*rtc), GFP_KERNEL);
-	if (!rtc) {
-		ret = -ENOMEM;
-		goto err_rtc;
-	}
+	if (!rtc)
+		return -ENOMEM;
 
-	rtc->base = ioremap(dev->res.start, resource_size(&dev->res));
-	if (!rtc->base) {
-		ret = -ENOMEM;
-		goto err_rtc;
-	}
+	rtc->base = devm_ioremap_resource(&dev->dev, &dev->res);
+	if (IS_ERR(rtc->base))
+		return PTR_ERR(rtc->base);
 
 	__raw_writel(0, rtc->base + RTC_CR);
 	__raw_writel(0, rtc->base + RTC_EOI);
 
 	amba_set_drvdata(dev, rtc);
 
-	ret = request_irq(dev->irq[0], pl030_interrupt, 0,
-			  "rtc-pl030", rtc);
+	ret = devm_request_irq(&dev->dev, dev->irq[0], pl030_interrupt, 0,
+			       "rtc-pl030", rtc);
 	if (ret)
-		goto err_irq;
+		return ret;
 
-	rtc->rtc = rtc_device_register("pl030", &dev->dev, &pl030_ops,
-				       THIS_MODULE);
-	if (IS_ERR(rtc->rtc)) {
-		ret = PTR_ERR(rtc->rtc);
-		goto err_reg;
-	}
+	rtc->rtc = devm_rtc_device_register(&dev->dev, "pl030", &pl030_ops,
+					    THIS_MODULE);
+	if (IS_ERR(rtc->rtc))
+		return PTR_ERR(rtc->rtc);
 
 	return 0;
-
- err_reg:
-	free_irq(dev->irq[0], rtc);
- err_irq:
-	iounmap(rtc->base);
- err_rtc:
-	amba_release_regions(dev);
- err_req:
-	return ret;
 }
 
 static int pl030_remove(struct amba_device *dev)
@@ -152,12 +133,6 @@ static int pl030_remove(struct amba_device *dev)
 	struct pl030_rtc *rtc = amba_get_drvdata(dev);
 
 	writel(0, rtc->base + RTC_CR);
-
-	free_irq(dev->irq[0], rtc);
-	rtc_device_unregister(rtc->rtc);
-	iounmap(rtc->base);
-	amba_release_regions(dev);
-
 	return 0;
 }
 
-- 
2.7.4
