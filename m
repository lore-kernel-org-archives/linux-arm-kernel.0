From: t.dakhran@samsung.com (Tarek Dakhran)
Date: Mon, 19 May 2014 07:37:18 +0400
Subject: [PATCH v9 1/3] ARM: EXYNOS: Add support for EXYNOS5410 SoC
In-Reply-To: <1400470640-30611-1-git-send-email-t.dakhran@samsung.com>
References: <1400470640-30611-1-git-send-email-t.dakhran@samsung.com>
Message-ID: <1400470640-30611-2-git-send-email-t.dakhran@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

EXYNOS5410 is SoC in Samsung's Exynos5 SoC series.
Add initial support for this SoC.

Signed-off-by: Tarek Dakhran <t.dakhran@samsung.com>
Signed-off-by: Vyacheslav Tyrtov <v.tyrtov@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/Kconfig             |    8 ++++++++
 arch/arm/mach-exynos/exynos.c            |    1 +
 arch/arm/mach-exynos/platsmp.c           |    4 ++++
 arch/arm/plat-samsung/include/plat/cpu.h |   11 ++++++++++-
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 1602abc..79a3e85 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -84,6 +84,14 @@ config SOC_EXYNOS5250
 	help
 	  Enable EXYNOS5250 SoC support
 
+config SOC_EXYNOS5410
+	bool "SAMSUNG EXYNOS5410"
+	default y
+	depends on ARCH_EXYNOS5
+	select PM_GENERIC_DOMAINS if PM_RUNTIME
+	help
+	  Enable EXYNOS5410 SoC support
+
 config SOC_EXYNOS5420
 	bool "SAMSUNG EXYNOS5420"
 	default y
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index e973ff5..12db6cf 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -312,6 +312,7 @@ static char const *exynos_dt_compat[] __initconst = {
 	"samsung,exynos4412",
 	"samsung,exynos5",
 	"samsung,exynos5250",
+	"samsung,exynos5410",
 	"samsung,exynos5420",
 	"samsung,exynos5440",
 	NULL
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 78002c7..a95213d 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -60,6 +60,8 @@ static inline void __iomem *cpu_boot_reg_base(void)
 {
 	if (soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_1_1)
 		return S5P_INFORM5;
+	if (soc_is_exynos5410())
+		return sysram_ns_base_addr;
 	return sysram_base_addr;
 }
 
@@ -72,6 +74,8 @@ static inline void __iomem *cpu_boot_reg(int cpu)
 		return ERR_PTR(-ENODEV);
 	if (soc_is_exynos4412())
 		boot_reg += 4*cpu;
+	else if (soc_is_exynos5410())
+		boot_reg += (0x1c);
 	else if (soc_is_exynos5420())
 		boot_reg += 4;
 	return boot_reg;
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index 5992b8d..21db380 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -49,6 +49,7 @@ extern unsigned long samsung_cpu_id;
 #define EXYNOS4_CPU_MASK	0xFFFE0000
 
 #define EXYNOS5250_SOC_ID	0x43520000
+#define EXYNOS5410_SOC_ID	0xE5410000
 #define EXYNOS5420_SOC_ID	0xE5420000
 #define EXYNOS5440_SOC_ID	0xE5440000
 #define EXYNOS5_SOC_MASK	0xFFFFF000
@@ -72,6 +73,7 @@ IS_SAMSUNG_CPU(exynos4210, EXYNOS4210_CPU_ID, EXYNOS4_CPU_MASK)
 IS_SAMSUNG_CPU(exynos4212, EXYNOS4212_CPU_ID, EXYNOS4_CPU_MASK)
 IS_SAMSUNG_CPU(exynos4412, EXYNOS4412_CPU_ID, EXYNOS4_CPU_MASK)
 IS_SAMSUNG_CPU(exynos5250, EXYNOS5250_SOC_ID, EXYNOS5_SOC_MASK)
+IS_SAMSUNG_CPU(exynos5410, EXYNOS5410_SOC_ID, EXYNOS5_SOC_MASK)
 IS_SAMSUNG_CPU(exynos5420, EXYNOS5420_SOC_ID, EXYNOS5_SOC_MASK)
 IS_SAMSUNG_CPU(exynos5440, EXYNOS5440_SOC_ID, EXYNOS5_SOC_MASK)
 
@@ -154,6 +156,12 @@ IS_SAMSUNG_CPU(exynos5440, EXYNOS5440_SOC_ID, EXYNOS5_SOC_MASK)
 # define soc_is_exynos5250()	0
 #endif
 
+#if defined(CONFIG_SOC_EXYNOS5410)
+# define soc_is_exynos5410()	is_samsung_exynos5410()
+#else
+# define soc_is_exynos5410()	0
+#endif
+
 #if defined(CONFIG_SOC_EXYNOS5420)
 # define soc_is_exynos5420()	is_samsung_exynos5420()
 #else
@@ -168,7 +176,8 @@ IS_SAMSUNG_CPU(exynos5440, EXYNOS5440_SOC_ID, EXYNOS5_SOC_MASK)
 
 #define soc_is_exynos4() (soc_is_exynos4210() || soc_is_exynos4212() || \
 			  soc_is_exynos4412())
-#define soc_is_exynos5() (soc_is_exynos5250() || soc_is_exynos5420())
+#define soc_is_exynos5() (soc_is_exynos5250() || soc_is_exynos5410() || \
+			  soc_is_exynos5420())
 
 #define IODESC_ENT(x) { (unsigned long)S3C24XX_VA_##x, __phys_to_pfn(S3C24XX_PA_##x), S3C24XX_SZ_##x, MT_DEVICE }
 
-- 
1.7.9.5
