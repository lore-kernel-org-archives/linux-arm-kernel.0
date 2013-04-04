From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 04 Apr 2013 18:51:14 +0200
Subject: [PATCH 2/3] ARM: EXYNOS: Add support for Exynos4210 EVT0 SoC
In-Reply-To: <1365094275-4811-1-git-send-email-t.figa@samsung.com>
References: <1365094275-4811-1-git-send-email-t.figa@samsung.com>
Message-ID: <1365094275-4811-3-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch extends mach-exynos4-dt generic board file with support for
Exynos4210 EVT0 SoC, which differs in availability of system timers and
needs different time initialization.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/Kconfig           |  9 +++++++++
 arch/arm/mach-exynos/mach-exynos4-dt.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index e538705..56920b3 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -39,6 +39,15 @@ config CPU_EXYNOS4210
 	help
 	  Enable EXYNOS4210 CPU support
 
+config SOC_EXYNOS4210_EVT0
+	bool "SAMSUNG EXYNOS4210 EVT0"
+	default y
+	select SOC_EXYNOS4210
+	select CLKSRC_MMIO
+	select SAMSUNG_HRT
+	help
+	  Enable EXYNOS4210 EVT0 SoC support
+
 config SOC_EXYNOS4212
 	bool "SAMSUNG EXYNOS4212"
 	default y
diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c b/arch/arm/mach-exynos/mach-exynos4-dt.c
index b9ed834..ec6dd17 100644
--- a/arch/arm/mach-exynos/mach-exynos4-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
@@ -16,10 +16,12 @@
 #include <linux/of_fdt.h>
 #include <linux/serial_core.h>
 #include <linux/memblock.h>
+#include <linux/clk-provider.h>
 #include <linux/clocksource.h>
 
 #include <asm/mach/arch.h>
 #include <plat/mfc.h>
+#include <plat/samsung-time.h>
 
 #include "common.h"
 
@@ -65,3 +67,34 @@ DT_MACHINE_START(EXYNOS4210_DT, "Samsung Exynos4 (Flattened Device Tree)")
 	.restart        = exynos4_restart,
 	.reserve	= exynos4_reserve,
 MACHINE_END
+
+#ifdef CONFIG_SOC_EXYNOS4210_EVT0
+static void __init exynos4210_evt0_init_time(void)
+{
+	of_clk_init(NULL);
+	samsung_time_init();
+}
+
+static void __init exynos4210_evt0_dt_map_io(void)
+{
+	exynos4_dt_map_io();
+}
+
+static char const *exynos4210_evt0_dt_compat[] __initdata = {
+	"samsung,exynos4210-evt0",
+	NULL
+};
+
+DT_MACHINE_START(EXYNOS4210_EVT0_DT, "Samsung Exynos4210 EVT0 (Device Tree)")
+	.smp		= smp_ops(exynos_smp_ops),
+	.init_irq	= exynos4_init_irq,
+	.map_io		= exynos4210_evt0_dt_map_io,
+	.init_early	= exynos_firmware_init,
+	.init_machine	= exynos4_dt_machine_init,
+	.init_late	= exynos_init_late,
+	.init_time	= exynos4210_evt0_init_time,
+	.dt_compat	= exynos4210_evt0_dt_compat,
+	.restart        = exynos4_restart,
+	.reserve	= exynos4_reserve,
+MACHINE_END
+#endif
-- 
1.8.1.5
