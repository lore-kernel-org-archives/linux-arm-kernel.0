From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Fri, 9 Dec 2011 10:50:10 +0100
Subject: [PATCH 2/4] rtc-s3c: make room for more variants in devicetree block
In-Reply-To: <201112091046.26563.heiko@sntech.de>
References: <201112091046.26563.heiko@sntech.de>
Message-ID: <201112091050.11095.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the data field of of_device_id to hold the type for
s3c_cpu_type.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/rtc/rtc-s3c.c |   27 +++++++++++++++++++++------
 1 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index 175067a..71807a6 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -428,11 +428,18 @@ static int __devexit s3c_rtc_remove(struct platform_device *dev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id s3c_rtc_dt_match[];
+#endif
+
 static int __devinit s3c_rtc_probe(struct platform_device *pdev)
 {
 	struct rtc_device *rtc;
 	struct rtc_time rtc_tm;
 	struct resource *res;
+#ifdef CONFIG_OF
+	const struct of_device_id *match;
+#endif
 	int ret;
 
 	pr_debug("%s: probe=%p\n", __func__, pdev);
@@ -509,12 +516,15 @@ static int __devinit s3c_rtc_probe(struct platform_device *pdev)
 	}
 
 #ifdef CONFIG_OF
-	if (pdev->dev.of_node)
-		s3c_rtc_cpu_type = of_device_is_compatible(pdev->dev.of_node,
-			"samsung,s3c6410-rtc") ? TYPE_S3C64XX : TYPE_S3C2410;
-	else
+	if (pdev->dev.of_node) {
+		match = of_match_node(s3c_rtc_dt_match, pdev->dev.of_node);
+		s3c_rtc_cpu_type = match->data;
+	} else {
 #endif
 		s3c_rtc_cpu_type = platform_get_device_id(pdev)->driver_data;
+#ifdef CONFIG_OF
+	}
+#endif
 
 	/* Check RTC Time */
 
@@ -638,8 +648,13 @@ static int s3c_rtc_resume(struct platform_device *pdev)
 
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
