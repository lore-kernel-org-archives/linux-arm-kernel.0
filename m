From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 18 Feb 2013 13:51:18 +0530
Subject: [PATCH v6 08/16] ARM: Exynos4: allow legacy board support to specify
 xxti and xusbxti clock speed
In-Reply-To: <1361175686-19400-1-git-send-email-thomas.abraham@linaro.org>
References: <1361175686-19400-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1361175686-19400-9-git-send-email-thomas.abraham@linaro.org>
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
index 64585af..974978b 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -68,6 +68,8 @@ static void exynos5440_map_io(void);
 static void exynos4_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 static int exynos_init(void);
 
+unsigned long xxti_f = 0, xusbxti_f = 0;
+
 static struct cpu_table cpu_ids[] __initdata = {
 	{
 		.idcode		= EXYNOS4210_CPU_ID,
@@ -448,6 +450,7 @@ void __init exynos_init_time(void)
 	} else {
 		/* todo: remove after migrating legacy E4 platforms to dt */
 		exynos4_clk_init(NULL);
+		exynos4_clk_register_fixed_ext(xxti_f, xusbxti_f);
 		mct_init();
 	}
 }
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 2c3cdae..8d9ae73 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -16,6 +16,7 @@
 
 extern void mct_init(void);
 void exynos_init_time(void);
+extern unsigned long xxti_f, xusbxti_f;
 
 struct map_desc;
 void exynos_init_io(struct map_desc *mach_desc, int size);
diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
index cdae74b..abe36ec 100644
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
index e9ab921..e7b36ca 100644
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
index eb51c06..d146393 100644
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
index 53de074..8cc315e 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -1095,6 +1095,8 @@ static void __init universal_map_io(void)
 	exynos_init_io(NULL, 0);
 	s3c24xx_init_uarts(universal_uartcfgs, ARRAY_SIZE(universal_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM2, SAMSUNG_PWM4);
+	xxti_f = 0;
+	xusbxti_f = 24000000;
 }
 
 static void s5p_tv_setup(void)
-- 
1.7.5.4
