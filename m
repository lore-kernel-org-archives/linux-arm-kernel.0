From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 04 Jul 2014 16:32:22 +0900
Subject: [PATCH 11/17] pwm: samsung: remove s5pc100 related pwm codes
In-Reply-To: <53B55021.9020307@samsung.com>
References: <1404163947-3105-1-git-send-email-kgene.kim@samsung.com>
 <1404163947-3105-12-git-send-email-kgene.kim@samsung.com>
 <53B55021.9020307@samsung.com>
Message-ID: <02ca01cf975a$1848aaa0$48d9ffe0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> Hi Kukjin,
> 
Hi,

> On 30.06.2014 23:32, Kukjin Kim wrote:
> > This patch removes supporting s5pc100 related pwm codes.
> >
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/pwm/pwm-samsung.txt |    2 --
> >  drivers/clocksource/samsung_pwm_timer.c               |   12 ------------
> >  drivers/pwm/pwm-samsung.c                             |    8 --------
> >  3 files changed, 22 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
> b/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
> > index 43925d3..82c7f6b 100644
> > --- a/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
> > @@ -11,8 +11,6 @@ Required properties:
> >  - compatible : should be one of following:
> >      samsung,s3c2410-pwm - for 16-bit timers present on S3C24xx SoCs
> >      samsung,s3c6400-pwm - for 32-bit timers present on S3C64xx SoCs
> > -    samsung,s5pc100-pwm - for 32-bit timers present on S5PC100, S5PV210,
> > -			  Exynos4210 rev0 SoCs
> 
> As you can see here, this variant is used for more than S5PC100. It is
> needed for S5PV210 and Exynos4210 rev0 SoCs as well. So this patch
> should be dropped.

Oh, I just now checked its datasheets and s5pv210 and early exynos4210 are
using BIT(5) for tclk_mask. You're right. But I couldn't its usage in mainline
when I created the patch. Anyway it can be used for s5pv210 so how about
following?

pwm: samsung: change s5pc100-pwm to s5pv210-pwm for support s5pv210 SoC

Reported-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Cc: Thierry Reding <thierry.reding@gmail.com>

---
diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.txt b/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
index 43925d3..ce005c0 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
@@ -11,8 +11,8 @@ Required properties:
 - compatible : should be one of following:
     samsung,s3c2410-pwm - for 16-bit timers present on S3C24xx SoCs
     samsung,s3c6400-pwm - for 32-bit timers present on S3C64xx SoCs
-    samsung,s5pc100-pwm - for 32-bit timers present on S5PC100, S5PV210,
-			  Exynos4210 rev0 SoCs
+    samsung,s5pv210-pwm - for 32-bit timers present on S5PV210 and
+                          Exynos4210 rev0 SoCs
     samsung,exynos4210-pwm - for 32-bit timers present on Exynos4210,
                           Exynos4x12, Exynos5250 and Exynos5420 SoCs
 - reg: base address and size of register area
diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
index e35a9b7..f0a5918 100644
--- a/drivers/clocksource/samsung_pwm_timer.c
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -480,16 +480,16 @@ static void __init s3c64xx_pwm_clocksource_init(struct device_node *np)
 }
 CLOCKSOURCE_OF_DECLARE(s3c6400_pwm, "samsung,s3c6400-pwm", s3c64xx_pwm_clocksource_init);
 
-static const struct samsung_pwm_variant s5p_variant = {
+static const struct samsung_pwm_variant s5pv210_variant = {
 	.bits		= 32,
 	.div_base	= 0,
 	.has_tint_cstat	= true,
 	.tclk_mask	= (1 << 5),
 };
 
-static void __init s5p_pwm_clocksource_init(struct device_node *np)
+static void __init s5pv210_pwm_clocksource_init(struct device_node *np)
 {
-	samsung_pwm_alloc(np, &s5p_variant);
+	samsung_pwm_alloc(np, &s5pv210_variant);
 }
-CLOCKSOURCE_OF_DECLARE(s5pc100_pwm, "samsung,s5pc100-pwm", s5p_pwm_clocksource_init);
+CLOCKSOURCE_OF_DECLARE(s5pv210_pwm, "samsung,s5pv210-pwm", s5pv210_pwm_clocksource_init);
 #endif
diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index 68f3471..a2bafc9 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -404,24 +404,24 @@ static const struct samsung_pwm_variant s3c64xx_variant = {
 	.tclk_mask	= BIT(7) | BIT(6) | BIT(5),
 };
 
-static const struct samsung_pwm_variant exynos4210_variant = {
+static const struct samsung_pwm_variant s5pv210_variant = {
 	.bits		= 32,
 	.div_base	= 0,
 	.has_tint_cstat	= true,
-	.tclk_mask	= 0,
+	.tclk_mask	= BIT(5),
 };
 
-static const struct samsung_pwm_variant s5pc100_variant = {
+static const struct samsung_pwm_variant exynos4210_variant = {
 	.bits		= 32,
 	.div_base	= 0,
 	.has_tint_cstat	= true,
-	.tclk_mask	= BIT(5),
+	.tclk_mask	= 0,
 };
 
 static const struct of_device_id samsung_pwm_matches[] = {
 	{ .compatible = "samsung,s3c2410-pwm", .data = &s3c24xx_variant },
 	{ .compatible = "samsung,s3c6400-pwm", .data = &s3c64xx_variant },
-	{ .compatible = "samsung,s5pc100-pwm", .data = &s5pc100_variant },
+	{ .compatible = "samsung,s5pv210-pwm", .data = &s5pv210_variant },
 	{ .compatible = "samsung,exynos4210-pwm", .data = &exynos4210_variant },
 	{},
 };
