From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 17 May 2016 09:26:14 +0200
Subject: [PATCH] clk: samsung: Suppress unbinding to prevent theoretical
 attacks
Message-ID: <1463469974-13340-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Although unbinding a driver requires root privileges but it still might
be used theoretically in certain attacks (by triggering NULL pointer
exception or memory corruption if driver does not provide proper remove
callbacks or core does not handle it).

Samsung clock drivers are essential for system operation so their
removal is not expected. More over, the Exynos3250 ISP clock driver does
not implement remove() driver callback and it is not buildable as
modules.

Suppress the unbind interface for Exynos3250 ISP and S3C2410 DCLK clock
drivers.

Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/samsung/clk-exynos3250.c   | 1 +
 drivers/clk/samsung/clk-s3c2410-dclk.c | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos3250.c b/drivers/clk/samsung/clk-exynos3250.c
index 16575ee874cb..dc4d493e61c2 100644
--- a/drivers/clk/samsung/clk-exynos3250.c
+++ b/drivers/clk/samsung/clk-exynos3250.c
@@ -1087,6 +1087,7 @@ static const struct of_device_id exynos3250_cmu_isp_of_match[] = {
 static struct platform_driver exynos3250_cmu_isp_driver = {
 	.driver = {
 		.name = "exynos3250-cmu-isp",
+		.suppress_bind_attrs = true,
 		.of_match_table = exynos3250_cmu_isp_of_match,
 	},
 };
diff --git a/drivers/clk/samsung/clk-s3c2410-dclk.c b/drivers/clk/samsung/clk-s3c2410-dclk.c
index ec6fb14d951c..ae9a595c72d0 100644
--- a/drivers/clk/samsung/clk-s3c2410-dclk.c
+++ b/drivers/clk/samsung/clk-s3c2410-dclk.c
@@ -428,8 +428,9 @@ MODULE_DEVICE_TABLE(platform, s3c24xx_dclk_driver_ids);
 
 static struct platform_driver s3c24xx_dclk_driver = {
 	.driver = {
-		.name		= "s3c24xx-dclk",
-		.pm		= &s3c24xx_dclk_pm_ops,
+		.name			= "s3c24xx-dclk",
+		.pm			= &s3c24xx_dclk_pm_ops,
+		.suppress_bind_attrs	= true,
 	},
 	.probe = s3c24xx_dclk_probe,
 	.remove = s3c24xx_dclk_remove,
-- 
1.9.1
