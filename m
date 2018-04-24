From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 24 Apr 2018 22:32:39 +0200
Subject: [RFC 10/10] ARM: exynos: Remove support for Exynos5440
In-Reply-To: <20180424203239.21885-1-krzk@kernel.org>
References: <20180424203239.21885-1-krzk@kernel.org>
Message-ID: <20180424203239.21885-11-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Exynos5440 is not actively developed, there are no development
boards available and probably there are no real products with it.
Remove wide-tree support for Exynos5440.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-exynos/Kconfig  | 12 ------------
 arch/arm/mach-exynos/common.h |  8 --------
 arch/arm/mach-exynos/exynos.c | 15 ++-------------
 3 files changed, 2 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 647c319f9f5f..219d389a8521 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -108,18 +108,6 @@ config SOC_EXYNOS5420
 	default y
 	depends on ARCH_EXYNOS5
 
-config SOC_EXYNOS5440
-	bool "SAMSUNG EXYNOS5440"
-	default y
-	depends on ARCH_EXYNOS5
-	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
-	select HAVE_ARM_ARCH_TIMER
-	select AUTO_ZRELADDR
-	select PINCTRL_EXYNOS5440
-	select PM_OPP
-	help
-	  Enable EXYNOS5440 SoC support
-
 config SOC_EXYNOS5800
 	bool "SAMSUNG EXYNOS5800"
 	default y
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 098f84a149a3..f332c654784b 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -21,7 +21,6 @@
 #define EXYNOS5250_SOC_ID	0x43520000
 #define EXYNOS5410_SOC_ID	0xE5410000
 #define EXYNOS5420_SOC_ID	0xE5420000
-#define EXYNOS5440_SOC_ID	0xE5440000
 #define EXYNOS5800_SOC_ID	0xE5422000
 #define EXYNOS5_SOC_MASK	0xFFFFF000
 
@@ -39,7 +38,6 @@ IS_SAMSUNG_CPU(exynos4412, EXYNOS4412_CPU_ID, EXYNOS4_CPU_MASK)
 IS_SAMSUNG_CPU(exynos5250, EXYNOS5250_SOC_ID, EXYNOS5_SOC_MASK)
 IS_SAMSUNG_CPU(exynos5410, EXYNOS5410_SOC_ID, EXYNOS5_SOC_MASK)
 IS_SAMSUNG_CPU(exynos5420, EXYNOS5420_SOC_ID, EXYNOS5_SOC_MASK)
-IS_SAMSUNG_CPU(exynos5440, EXYNOS5440_SOC_ID, EXYNOS5_SOC_MASK)
 IS_SAMSUNG_CPU(exynos5800, EXYNOS5800_SOC_ID, EXYNOS5_SOC_MASK)
 
 #if defined(CONFIG_SOC_EXYNOS3250)
@@ -82,12 +80,6 @@ IS_SAMSUNG_CPU(exynos5800, EXYNOS5800_SOC_ID, EXYNOS5_SOC_MASK)
 # define soc_is_exynos5420()	0
 #endif
 
-#if defined(CONFIG_SOC_EXYNOS5440)
-# define soc_is_exynos5440()	is_samsung_exynos5440()
-#else
-# define soc_is_exynos5440()	0
-#endif
-
 #if defined(CONFIG_SOC_EXYNOS5800)
 # define soc_is_exynos5800()	is_samsung_exynos5800()
 #else
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 8c4f5e342dc1..460ae13b3145 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -63,15 +63,6 @@ void __init exynos_sysram_init(void)
 	}
 }
 
-static void __init exynos_init_late(void)
-{
-	if (of_machine_is_compatible("samsung,exynos5440"))
-		/* to be supported later */
-		return;
-
-	exynos_pm_init();
-}
-
 static int __init exynos_fdt_map_chipid(unsigned long node, const char *uname,
 					int depth, void *data)
 {
@@ -79,8 +70,7 @@ static int __init exynos_fdt_map_chipid(unsigned long node, const char *uname,
 	const __be32 *reg;
 	int len;
 
-	if (!of_flat_dt_is_compatible(node, "samsung,exynos4210-chipid") &&
-		!of_flat_dt_is_compatible(node, "samsung,exynos5440-clock"))
+	if (!of_flat_dt_is_compatible(node, "samsung,exynos4210-chipid"))
 		return 0;
 
 	reg = of_get_flat_dt_prop(node, "reg", &len);
@@ -209,7 +199,6 @@ static char const *const exynos_dt_compat[] __initconst = {
 	"samsung,exynos5250",
 	"samsung,exynos5260",
 	"samsung,exynos5420",
-	"samsung,exynos5440",
 	NULL
 };
 
@@ -232,7 +221,7 @@ DT_MACHINE_START(EXYNOS_DT, "SAMSUNG EXYNOS (Flattened Device Tree)")
 	.init_early	= exynos_firmware_init,
 	.init_irq	= exynos_init_irq,
 	.init_machine	= exynos_dt_machine_init,
-	.init_late	= exynos_init_late,
+	.init_late	= exynos_pm_init,
 	.dt_compat	= exynos_dt_compat,
 	.dt_fixup	= exynos_dt_fixup,
 MACHINE_END
-- 
2.14.1
