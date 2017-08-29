From: himanshujha199640@gmail.com (Himanshu Jha)
Date: Tue, 29 Aug 2017 19:16:59 +0530
Subject: [PATCH] rtc: Use PTR_ERR_OR_ZERO
Message-ID: <1504014419-16894-1-git-send-email-himanshujha199640@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/rtc/rtc-digicolor.c | 5 +----
 drivers/rtc/rtc-ds1347.c    | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-digicolor.c b/drivers/rtc/rtc-digicolor.c
index b253bf1..1e200a0 100644
--- a/drivers/rtc/rtc-digicolor.c
+++ b/drivers/rtc/rtc-digicolor.c
@@ -202,10 +202,7 @@ static int __init dc_rtc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, rtc);
 	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, pdev->name,
 						&dc_rtc_ops, THIS_MODULE);
-	if (IS_ERR(rtc->rtc_dev))
-		return PTR_ERR(rtc->rtc_dev);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(rtc->rtc_dev);
 }
 
 static const struct of_device_id dc_dt_ids[] = {
diff --git a/drivers/rtc/rtc-ds1347.c b/drivers/rtc/rtc-ds1347.c
index ccfc9d4..9a02ca7 100644
--- a/drivers/rtc/rtc-ds1347.c
+++ b/drivers/rtc/rtc-ds1347.c
@@ -155,10 +155,7 @@ static int ds1347_probe(struct spi_device *spi)
 	rtc = devm_rtc_device_register(&spi->dev, "ds1347",
 				&ds1347_rtc_ops, THIS_MODULE);
 
-	if (IS_ERR(rtc))
-		return PTR_ERR(rtc);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(rtc);
 }
 
 static struct spi_driver ds1347_driver = {
-- 
2.7.4
