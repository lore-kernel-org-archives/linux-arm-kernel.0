From: heiko@sntech.de (Heiko =?windows-1252?q?St=FCbner?=)
Date: Wed, 4 Jan 2012 15:14:16 +0100
Subject: [PATCH] rtc-s3c: Fix breakage introduced by S3C2443/S3C2416 support
In-Reply-To: <201201041512.55126.heiko@sntech.de>
References: <201112211014.30695.heiko@sntech.de>
 <201201041251.42509.heiko@sntech.de> <201201041512.55126.heiko@sntech.de>
Message-ID: <201201041514.16813.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commits 7006ee4f (rtc-s3c: make room for more variants in devicetree block)
and 6c0a2365 (rtc-s3c: add variants for S3C2443 and S3C2416)
introduced build-failures with enabled CONFIG_USE_OF option.

This patch fixes missing "," in s3c_rtc_dt_match and wrong handling of
the of_device_id.data property.

Reported-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/rtc/rtc-s3c.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index bb0f320..2b4feb8 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -449,7 +449,7 @@ static inline int s3c_rtc_get_driver_data(struct platform_device *pdev)
 	if (pdev->dev.of_node) {
 		const struct of_device_id *match;
 		match = of_match_node(s3c_rtc_dt_match, pdev->dev.of_node);
-		return match->data;
+		return (int)match->data;
 	}
 #endif
 	return platform_get_device_id(pdev)->driver_data;
@@ -667,17 +667,17 @@ static int s3c_rtc_resume(struct platform_device *pdev)
 #ifdef CONFIG_OF
 static const struct of_device_id s3c_rtc_dt_match[] = {
 	{
-		.compatible = "samsung,s3c2410-rtc"
-		.data = TYPE_S3C2410,
+		.compatible = "samsung,s3c2410-rtc",
+		.data = (void *)TYPE_S3C2410,
 	}, {
-		.compatible = "samsung,s3c2416-rtc"
-		.data = TYPE_S3C2416,
+		.compatible = "samsung,s3c2416-rtc",
+		.data = (void *)TYPE_S3C2416,
 	}, {
-		.compatible = "samsung,s3c2443-rtc"
-		.data = TYPE_S3C2443,
+		.compatible = "samsung,s3c2443-rtc",
+		.data = (void *)TYPE_S3C2443,
 	}, {
-		.compatible = "samsung,s3c6410-rtc"
-		.data = TYPE_S3C64XX,
+		.compatible = "samsung,s3c6410-rtc",
+		.data = (void *)TYPE_S3C64XX,
 	},
 	{},
 };
-- 
1.7.5.4
