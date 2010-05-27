From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu, 27 May 2010 18:57:26 +0300
Subject: [PATCH v2] rtc-s3c: Fix rtc-s3c driver initialization
Message-ID: <1274975846-14006-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

setfreq should be called only after rtc device registration,
as it uses rtc device; s3c_rtc_cpu_type should be checked
only once it was set.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/rtc/rtc-s3c.c |   29 +++++++++++++----------------
 1 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index e5972b2..dc2081f 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -488,19 +488,7 @@ static int __devinit s3c_rtc_probe(struct platform_device *pdev)
 		goto err_nomap;
 	}
 
-	/* check to see if everything is setup correctly */
-
-	s3c_rtc_enable(pdev, 1);
-
- 	pr_debug("s3c2410_rtc: RTCCON=%02x\n",
-		 readb(s3c_rtc_base + S3C2410_RTCCON));
-
-	s3c_rtc_setfreq(&pdev->dev, 1);
-
-	device_init_wakeup(&pdev->dev, 1);
-
-	/* register RTC and exit */
-
+	/* Register rtc and check to see if everything is setup correctly */
 	rtc = rtc_device_register("s3c", &pdev->dev, &s3c_rtcops,
 				  THIS_MODULE);
 
@@ -510,18 +498,27 @@ static int __devinit s3c_rtc_probe(struct platform_device *pdev)
 		goto err_nortc;
 	}
 
+	platform_set_drvdata(pdev, rtc);
+
+	s3c_rtc_cpu_type = platform_get_device_id(pdev)->driver_data;
+
 	if (s3c_rtc_cpu_type == TYPE_S3C64XX)
 		rtc->max_user_freq = 32768;
 	else
 		rtc->max_user_freq = 128;
 
-	s3c_rtc_cpu_type = platform_get_device_id(pdev)->driver_data;
+	s3c_rtc_enable(pdev, 1);
+
+	pr_debug("s3c2410_rtc: RTCCON=%02x\n",
+		 readb(s3c_rtc_base + S3C2410_RTCCON));
+
+	s3c_rtc_setfreq(&pdev->dev, 1);
+
+	device_init_wakeup(&pdev->dev, 1);
 
-	platform_set_drvdata(pdev, rtc);
 	return 0;
 
  err_nortc:
-	s3c_rtc_enable(pdev, 0);
 	iounmap(s3c_rtc_base);
 
  err_nomap:
-- 
1.7.1
