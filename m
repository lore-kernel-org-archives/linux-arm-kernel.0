From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 13 May 2014 22:05:04 +0900
Subject: [PATCHv5 1/5] ARM: EXYNOS: Add Exynos3250 SoC ID
In-Reply-To: <1399986308-23744-1-git-send-email-cw00.choi@samsung.com>
References: <1399986308-23744-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1399986308-23744-2-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add Exynos3250's SoC ID. Exynos 3250 is System-On-Chip(SoC) that
is based on the 32-bit RISC processor for Smartphone. Exynos3250 uses Cortex-A7
dual cores and has a target speed of 1.0GHz.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/Kconfig  | 22 ++++++++++++++++++++++
 arch/arm/mach-exynos/common.h | 10 ++++++++++
 arch/arm/mach-exynos/exynos.c |  2 ++
 3 files changed, 34 insertions(+)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index fc8bf18..6da8a68 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -11,6 +11,17 @@ if ARCH_EXYNOS
 
 menu "SAMSUNG EXYNOS SoCs Support"
 
+config ARCH_EXYNOS3
+	bool "SAMSUNG EXYNOS3"
+	select ARM_AMBA
+	select CLKSRC_OF
+	select HAVE_ARM_SCU if SMP
+	select HAVE_SMP
+	select PINCTRL
+	select PM_GENERIC_DOMAINS if PM_RUNTIME
+	help
+	  Samsung EXYNOS3 SoCs based systems
+
 config ARCH_EXYNOS4
 	bool "SAMSUNG EXYNOS4"
 	default y
@@ -41,6 +52,17 @@ config ARCH_EXYNOS5
 
 comment "EXYNOS SoCs"
 
+config SOC_EXYNOS3250
+	bool "SAMSUNG EXYNOS3250"
+	default y
+	depends on ARCH_EXYNOS3
+	select ARCH_HAS_BANDGAP
+	select ARM_CPU_SUSPEND if PM
+	select PINCTRL_EXYNOS
+	select SAMSUNG_DMADEV
+	help
+	  Enable EXYNOS3250 CPU support
+
 config CPU_EXYNOS4210
 	bool "SAMSUNG EXYNOS4210"
 	default y
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 278b573..fb43ff4 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -15,6 +15,9 @@
 #include <linux/reboot.h>
 #include <linux/of.h>
 
+#define EXYNOS3250_SOC_ID       0xE3472000
+#define EXYNOS3_SOC_MASK        0xFFFFF000
+
 #define EXYNOS4210_CPU_ID	0x43210000
 #define EXYNOS4212_CPU_ID	0x43220000
 #define EXYNOS4412_CPU_ID	0xE4412200
@@ -33,6 +36,7 @@ static inline int is_samsung_##name(void)	\
 	return ((samsung_cpu_id & mask) == (id & mask));	\
 }
 
+IS_SAMSUNG_CPU(exynos3250, EXYNOS3250_SOC_ID, EXYNOS3_SOC_MASK)
 IS_SAMSUNG_CPU(exynos4210, EXYNOS4210_CPU_ID, EXYNOS4_CPU_MASK)
 IS_SAMSUNG_CPU(exynos4212, EXYNOS4212_CPU_ID, EXYNOS4_CPU_MASK)
 IS_SAMSUNG_CPU(exynos4412, EXYNOS4412_CPU_ID, EXYNOS4_CPU_MASK)
@@ -40,6 +44,12 @@ IS_SAMSUNG_CPU(exynos5250, EXYNOS5250_SOC_ID, EXYNOS5_SOC_MASK)
 IS_SAMSUNG_CPU(exynos5420, EXYNOS5420_SOC_ID, EXYNOS5_SOC_MASK)
 IS_SAMSUNG_CPU(exynos5440, EXYNOS5440_SOC_ID, EXYNOS5_SOC_MASK)
 
+#if defined(CONFIG_SOC_EXYNOS3250)
+# define soc_is_exynos3250()    is_samsung_exynos3250()
+#else
+# define soc_is_exynos3250()    0
+#endif
+
 #if defined(CONFIG_CPU_EXYNOS4210)
 # define soc_is_exynos4210()	is_samsung_exynos4210()
 #else
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 4df3452..f2b8e80 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -293,6 +293,8 @@ static void __init exynos_dt_machine_init(void)
 }
 
 static char const *exynos_dt_compat[] __initconst = {
+	"samsung,exynos3",
+	"samsung,exynos3250",
 	"samsung,exynos4",
 	"samsung,exynos4210",
 	"samsung,exynos4212",
-- 
1.8.0
