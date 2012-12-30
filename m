From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sat, 29 Dec 2012 16:33:37 -0800
Subject: [PATCH v5 08/12] ARM: Exynos4: allow legacy board support to specify
 xxti and xusbxti clock speed
In-Reply-To: <1356827621-27617-1-git-send-email-thomas.abraham@linaro.org>
References: <1356827621-27617-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1356827621-27617-9-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock speed of xxti and xusbxti clocks depends on the oscillator used on the
board to generate these clocks. For non-dt platforms, allow the board support
for those platforms to set the clock frequency of xxti and xusbxti clocks.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/common.c              |    3 +++
 arch/arm/mach-exynos/common.h              |    1 +
 arch/arm/mach-exynos/mach-nuri.c           |    2 ++
 arch/arm/mach-exynos/mach-origen.c         |    2 ++
 arch/arm/mach-exynos/mach-smdkv310.c       |    2 ++
 arch/arm/mach-exynos/mach-universal_c210.c |    2 ++
 6 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 2b1b225..6349432 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -71,6 +71,8 @@ static void exynos5_init_clocks(int xtal);
 static void exynos4_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 static int exynos_init(void);
 
+unsigned long xxti_f = 0, xusbxti_f = 0;
+
 static struct cpu_table cpu_ids[] __initdata = {
 	{
 		.idcode		= EXYNOS4210_CPU_ID,
@@ -455,6 +457,7 @@ void __init exynos_timer_init(void)
 	if (!of_have_populated_dt() && (soc_is_exynos4210() ||
 		soc_is_exynos4212() || soc_is_exynos4412())) {
 		exynos4_clk_init();
+		exynos4_clk_register_fixed_ext(xxti_f, xusbxti_f);
 		exynos_mct_init();
 		return;
 	}
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index e3ed6bb..6636002 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -24,6 +24,7 @@ void exynos_init_late(void);
 extern void exynos_mct_init(void);
 
 #ifdef CONFIG_COMMON_CLK
+extern unsigned long xxti_f, xusbxti_f;
 extern void exynos4_clk_init(void);
 extern void exynos4_clk_register_fixed_ext(unsigned long, unsigned long);
 #else
diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
index 8695d33..afe068f 100644
--- a/arch/arm/mach-exynos/mach-nuri.c
+++ b/arch/arm/mach-exynos/mach-nuri.c
@@ -1332,6 +1332,8 @@ static void __init nuri_map_io(void)
 {
 	exynos_init_io(NULL, 0);
 	s3c24xx_init_uarts(nuri_uartcfgs, ARRAY_SIZE(nuri_uartcfgs));
+	xxti_f = 0;
+	xusbxti_f = 24000000;
 }
 
 static void __init nuri_reserve(void)
diff --git a/arch/arm/mach-exynos/mach-origen.c b/arch/arm/mach-exynos/mach-origen.c
index 5d9479d..bb72168 100644
--- a/arch/arm/mach-exynos/mach-origen.c
+++ b/arch/arm/mach-exynos/mach-origen.c
@@ -756,6 +756,8 @@ static void __init origen_map_io(void)
 {
 	exynos_init_io(NULL, 0);
 	s3c24xx_init_uarts(origen_uartcfgs, ARRAY_SIZE(origen_uartcfgs));
+	xxti_f = 0;
+	xusbxti_f = 24000000;
 }
 
 static void __init origen_power_init(void)
diff --git a/arch/arm/mach-exynos/mach-smdkv310.c b/arch/arm/mach-exynos/mach-smdkv310.c
index a1be874..7d4e72d 100644
--- a/arch/arm/mach-exynos/mach-smdkv310.c
+++ b/arch/arm/mach-exynos/mach-smdkv310.c
@@ -373,6 +373,8 @@ static void __init smdkv310_map_io(void)
 {
 	exynos_init_io(NULL, 0);
 	s3c24xx_init_uarts(smdkv310_uartcfgs, ARRAY_SIZE(smdkv310_uartcfgs));
+	xxti_f = 12000000;
+	xusbxti_f = 24000000;
 }
 
 static void __init smdkv310_reserve(void)
diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index 3999c16..3de63cb 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -1095,6 +1095,8 @@ static void __init universal_map_io(void)
 	exynos_init_io(NULL, 0);
 	s3c24xx_init_uarts(universal_uartcfgs, ARRAY_SIZE(universal_uartcfgs));
 	s5p_set_timer_source(S5P_PWM2, S5P_PWM4);
+	xxti_f = 0;
+	xusbxti_f = 24000000;
 }
 
 static void s5p_tv_setup(void)
-- 
1.7.5.4
