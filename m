From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu, 27 May 2010 17:48:29 +0300
Subject: [PATCH] rtc-s3c: Fix rtc-s3c driver initialization
Message-ID: <1274971709-7874-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

setfreq should be called only after rtc device registration,
as it uses rtc device; s3c_rtc_cpu_type should be checked
only once it was set.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/rtc/rtc-s3c.c |   28 +++++++++++++---------------
 1 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index e5972b2..6b47f53 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -488,7 +488,19 @@ static int __devinit s3c_rtc_probe(struct platform_device *pdev)
 		goto err_nomap;
 	}
 
-	/* check to see if everything is setup correctly */
+	/* Register rtc and check to see if everything is setup correctly */
+	rtc = rtc_device_register("s3c", &pdev->dev, &s3c_rtcops,
+				  THIS_MODULE);
+
+	if (IS_ERR(rtc)) {
+		dev_err(&pdev->dev, "cannot attach rtc\n");
+		ret = PTR_ERR(rtc);
+		goto err_nortc;
+	}
+
+	s3c_rtc_cpu_type = platform_get_device_id(pdev)->driver_data;
+
+	platform_set_drvdata(pdev, rtc);
 
 	s3c_rtc_enable(pdev, 1);
 
@@ -499,25 +511,11 @@ static int __devinit s3c_rtc_probe(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, 1);
 
-	/* register RTC and exit */
-
-	rtc = rtc_device_register("s3c", &pdev->dev, &s3c_rtcops,
-				  THIS_MODULE);
-
-	if (IS_ERR(rtc)) {
-		dev_err(&pdev->dev, "cannot attach rtc\n");
-		ret = PTR_ERR(rtc);
-		goto err_nortc;
-	}
-
 	if (s3c_rtc_cpu_type == TYPE_S3C64XX)
 		rtc->max_user_freq = 32768;
 	else
 		rtc->max_user_freq = 128;
 
-	s3c_rtc_cpu_type = platform_get_device_id(pdev)->driver_data;
-
-	platform_set_drvdata(pdev, rtc);
 	return 0;
 
  err_nortc:
-- 
1.7.1
