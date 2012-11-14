From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 15 Nov 2012 03:37:29 +0530
Subject: [PATCH v3 07/11] ARM: Exynos4: allow legacy board support to specify
 xxti and xusbxti clock speed
In-Reply-To: <1352930853-12268-1-git-send-email-thomas.abraham@linaro.org>
References: <1352930853-12268-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1352930853-12268-8-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock speed of xxti and xusbxti clocks depends on the oscillator used on the
board to generate these clocks. For non-dt platforms, allow the board support
for those platforms to set the clock frequency of xxti and xusbxti clocks.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/common.c              |    2 ++
 arch/arm/mach-exynos/common.h              |    1 +
 arch/arm/mach-exynos/mach-nuri.c           |    2 ++
 arch/arm/mach-exynos/mach-origen.c         |    2 ++
 arch/arm/mach-exynos/mach-smdkv310.c       |    2 ++
 arch/arm/mach-exynos/mach-universal_c210.c |    2 ++
 arch/arm/mach-exynos/mct.c                 |    1 +
 7 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 138a41d..64c0012 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -65,6 +65,8 @@ static void exynos5_init_clocks(int xtal);
 static void exynos4_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 static int exynos_init(void);
 
+unsigned long xxti_f = 0, xusbxti_f = 0;
+
 static struct cpu_table cpu_ids[] __initdata = {
 	{
 		.idcode		= EXYNOS4210_CPU_ID,
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 2cacd48..f947789 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -22,6 +22,7 @@ void exynos4_restart(char mode, const char *cmd);
 void exynos5_restart(char mode, const char *cmd);
 void exynos_init_late(void);
 
+extern unsigned long xxti_f, xusbxti_f;
 void exynos4_clk_init(void);
 void exynos4_clk_register_fixed_ext(unsigned long, unsigned long);
 
diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
index 5b5c941..e14332c 100644
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
index d4a0ef1..1196a78 100644
--- a/arch/arm/mach-exynos/mach-origen.c
+++ b/arch/arm/mach-exynos/mach-origen.c
@@ -754,6 +754,8 @@ static void __init origen_map_io(void)
 {
 	exynos_init_io(NULL, 0);
 	s3c24xx_init_uarts(origen_uartcfgs, ARRAY_SIZE(origen_uartcfgs));
+	xxti_f = 0;
+	xusbxti_f = 24000000;
 }
 
 static void __init origen_power_init(void)
diff --git a/arch/arm/mach-exynos/mach-smdkv310.c b/arch/arm/mach-exynos/mach-smdkv310.c
index ce32dd1..cea4803 100644
--- a/arch/arm/mach-exynos/mach-smdkv310.c
+++ b/arch/arm/mach-exynos/mach-smdkv310.c
@@ -374,6 +374,8 @@ static void __init smdkv310_map_io(void)
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
diff --git a/arch/arm/mach-exynos/mct.c b/arch/arm/mach-exynos/mct.c
index c2e806c..cd061b2 100644
--- a/arch/arm/mach-exynos/mct.c
+++ b/arch/arm/mach-exynos/mct.c
@@ -532,6 +532,7 @@ static void __init exynos4_timer_init(void)
 		if (soc_is_exynos4210() || soc_is_exynos4212() ||
 				soc_is_exynos4412()) {
 			exynos4_clk_init();
+			exynos4_clk_register_fixed_ext(xxti_f, xusbxti_f);
 		}
 	}
 #endif
-- 
1.7.4.4
