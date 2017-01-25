From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Wed, 25 Jan 2017 16:41:57 +0800
Subject: [PATCH 4/4] rtc: sunxi: using devm_rtc_device_register helper
In-Reply-To: <1485333717-47536-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1485333717-47536-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1485333717-47536-4-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using devm_rtc_device_register() helper to simplify code.

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/rtc/rtc-sunxi.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-sunxi.c b/drivers/rtc/rtc-sunxi.c
index abada60..6fba5ae 100644
--- a/drivers/rtc/rtc-sunxi.c
+++ b/drivers/rtc/rtc-sunxi.c
@@ -481,8 +481,8 @@ static int sunxi_rtc_probe(struct platform_device *pdev)
 	writel(SUNXI_ALRM_IRQ_STA_CNT_IRQ_PEND, chip->base +
 			SUNXI_ALRM_IRQ_STA);
 
-	chip->rtc = rtc_device_register("rtc-sunxi", &pdev->dev,
-			&sunxi_rtc_ops, THIS_MODULE);
+	chip->rtc = devm_rtc_device_register(&pdev->dev, "rtc-sunxi",
+					     &sunxi_rtc_ops, THIS_MODULE);
 	if (IS_ERR(chip->rtc)) {
 		dev_err(&pdev->dev, "unable to register device\n");
 		return PTR_ERR(chip->rtc);
@@ -493,18 +493,8 @@ static int sunxi_rtc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int sunxi_rtc_remove(struct platform_device *pdev)
-{
-	struct sunxi_rtc_dev *chip = platform_get_drvdata(pdev);
-
-	rtc_device_unregister(chip->rtc);
-
-	return 0;
-}
-
 static struct platform_driver sunxi_rtc_driver = {
 	.probe		= sunxi_rtc_probe,
-	.remove		= sunxi_rtc_remove,
 	.driver		= {
 		.name		= "sunxi-rtc",
 		.of_match_table = sunxi_rtc_dt_ids,
-- 
1.7.12.4
