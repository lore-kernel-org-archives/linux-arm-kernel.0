From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Mon, 12 Dec 2011 15:46:46 +0100
Subject: [PATCH 2/4] rtc-s3c: make room for more variants in devicetree block
In-Reply-To: <201112121543.42299.heiko@sntech.de>
References: <201112121543.42299.heiko@sntech.de>
Message-ID: <201112121546.46953.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the data field of of_device_id to hold the type for
s3c_cpu_type.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/rtc/rtc-s3c.c |   31 ++++++++++++++++++++++---------
 1 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index 175067a..2885b25 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -428,6 +428,20 @@ static int __devexit s3c_rtc_remove(struct platform_device *dev)
 	return 0;
 }
 
+static const struct of_device_id s3c_rtc_dt_match[];
+
+static inline int s3c_rtc_get_driver_data(struct platform_device *pdev)
+{
+#ifdef CONFIG_OF
+	if (pdev->dev.of_node) {
+		const struct of_device_id *match;
+		match = of_match_node(s3c_rtc_dt_match, pdev->dev.of_node);
+		return match->data;
+	}
+#endif
+	return platform_get_device_id(pdev)->driver_data;
+}
+
 static int __devinit s3c_rtc_probe(struct platform_device *pdev)
 {
 	struct rtc_device *rtc;
@@ -508,13 +522,7 @@ static int __devinit s3c_rtc_probe(struct platform_device *pdev)
 		goto err_nortc;
 	}
 
-#ifdef CONFIG_OF
-	if (pdev->dev.of_node)
-		s3c_rtc_cpu_type = of_device_is_compatible(pdev->dev.of_node,
-			"samsung,s3c6410-rtc") ? TYPE_S3C64XX : TYPE_S3C2410;
-	else
-#endif
-		s3c_rtc_cpu_type = platform_get_device_id(pdev)->driver_data;
+	s3c_rtc_cpu_type = s3c_rtc_get_driver_data(pdev);
 
 	/* Check RTC Time */
 
@@ -638,8 +646,13 @@ static int s3c_rtc_resume(struct platform_device *pdev)
 
 #ifdef CONFIG_OF
 static const struct of_device_id s3c_rtc_dt_match[] = {
-	{ .compatible = "samsung,s3c2410-rtc" },
-	{ .compatible = "samsung,s3c6410-rtc" },
+	{
+		.compatible = "samsung,s3c2410-rtc"
+		.data = TYPE_S3C2410,
+	}, {
+		.compatible = "samsung,s3c6410-rtc"
+		.data = TYPE_S3C64XX,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, s3c_rtc_dt_match);
-- 
1.7.5.4
