From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 01 Jul 2014 06:32:15 +0900
Subject: [PATCH 05/17] pwm: samsung: remove s5p64x0 related pwm codes
In-Reply-To: <1404163947-3105-1-git-send-email-kgene.kim@samsung.com>
References: <1404163947-3105-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1404163947-3105-6-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes supporting s5p64x0 related pwm codes because of
no more support for S5P6440 and S5P6450 SoCs. And this patch changes
the name of s5p6440-pwm to exynos-pwm instead.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
---
 Documentation/devicetree/bindings/pwm/pwm-samsung.txt |    1 -
 arch/arm/boot/dts/exynos4210-universal_c210.dts       |    2 +-
 drivers/clocksource/samsung_pwm_timer.c               |   13 -------------
 drivers/pwm/pwm-samsung.c                             |    5 ++---
 4 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.txt b/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
index 5538de9..43925d3 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
@@ -11,7 +11,6 @@ Required properties:
 - compatible : should be one of following:
     samsung,s3c2410-pwm - for 16-bit timers present on S3C24xx SoCs
     samsung,s3c6400-pwm - for 32-bit timers present on S3C64xx SoCs
-    samsung,s5p6440-pwm - for 32-bit timers present on S5P64x0 SoCs
     samsung,s5pc100-pwm - for 32-bit timers present on S5PC100, S5PV210,
 			  Exynos4210 rev0 SoCs
     samsung,exynos4210-pwm - for 32-bit timers present on Exynos4210,
diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index d50eb3a..0ca26e0 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -461,7 +461,7 @@
 	};
 
 	pwm at 139D0000 {
-		compatible = "samsung,s5p6440-pwm";
+		compatible = "samsung,exynos4210-pwm";
 		status = "okay";
 	};
 
diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
index 5645cfc..e35a9b7 100644
--- a/drivers/clocksource/samsung_pwm_timer.c
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -480,19 +480,6 @@ static void __init s3c64xx_pwm_clocksource_init(struct device_node *np)
 }
 CLOCKSOURCE_OF_DECLARE(s3c6400_pwm, "samsung,s3c6400-pwm", s3c64xx_pwm_clocksource_init);
 
-static const struct samsung_pwm_variant s5p64x0_variant = {
-	.bits		= 32,
-	.div_base	= 0,
-	.has_tint_cstat	= true,
-	.tclk_mask	= 0,
-};
-
-static void __init s5p64x0_pwm_clocksource_init(struct device_node *np)
-{
-	samsung_pwm_alloc(np, &s5p64x0_variant);
-}
-CLOCKSOURCE_OF_DECLARE(s5p6440_pwm, "samsung,s5p6440-pwm", s5p64x0_pwm_clocksource_init);
-
 static const struct samsung_pwm_variant s5p_variant = {
 	.bits		= 32,
 	.div_base	= 0,
diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index ba6b650..68f3471 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -404,7 +404,7 @@ static const struct samsung_pwm_variant s3c64xx_variant = {
 	.tclk_mask	= BIT(7) | BIT(6) | BIT(5),
 };
 
-static const struct samsung_pwm_variant s5p64x0_variant = {
+static const struct samsung_pwm_variant exynos4210_variant = {
 	.bits		= 32,
 	.div_base	= 0,
 	.has_tint_cstat	= true,
@@ -421,9 +421,8 @@ static const struct samsung_pwm_variant s5pc100_variant = {
 static const struct of_device_id samsung_pwm_matches[] = {
 	{ .compatible = "samsung,s3c2410-pwm", .data = &s3c24xx_variant },
 	{ .compatible = "samsung,s3c6400-pwm", .data = &s3c64xx_variant },
-	{ .compatible = "samsung,s5p6440-pwm", .data = &s5p64x0_variant },
 	{ .compatible = "samsung,s5pc100-pwm", .data = &s5pc100_variant },
-	{ .compatible = "samsung,exynos4210-pwm", .data = &s5p64x0_variant },
+	{ .compatible = "samsung,exynos4210-pwm", .data = &exynos4210_variant },
 	{},
 };
 
-- 
1.7.10.4
