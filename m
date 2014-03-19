From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 19 Mar 2014 17:55:55 +0530
Subject: [PATCH 2/4] ARM: EXYNOS: Consolidate Exynos4 and 5 machine files
In-Reply-To: <1395231957-22032-1-git-send-email-sachin.kamat@linaro.org>
References: <1395231957-22032-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1395231957-22032-3-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since there is very little difference between these two files,
they can be easily combined into one with necessary SoC checks.
While at it also merge the common.c file into this as it does
not have any other users.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 arch/arm/mach-exynos/Makefile               |    7 +-
 arch/arm/mach-exynos/common.h               |    3 +-
 arch/arm/mach-exynos/{common.c => exynos.c} |  133 ++++++++++++++++++---------
 arch/arm/mach-exynos/mach-exynos4-dt.c      |   53 -----------
 arch/arm/mach-exynos/mach-exynos5-dt.c      |   83 -----------------
 arch/arm/mach-exynos/regs-pmu.h             |    1 -
 6 files changed, 93 insertions(+), 187 deletions(-)
 rename arch/arm/mach-exynos/{common.c => exynos.c} (75%)
 delete mode 100644 arch/arm/mach-exynos/mach-exynos4-dt.c
 delete mode 100644 arch/arm/mach-exynos/mach-exynos5-dt.c

diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 58fe9e6f542f..a656dbe3b78c 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -12,7 +12,7 @@ obj-				:=
 
 # Core
 
-obj-$(CONFIG_ARCH_EXYNOS)	+= common.o
+obj-$(CONFIG_ARCH_EXYNOS)	+= exynos.o
 
 obj-$(CONFIG_PM_SLEEP)		+= pm.o sleep.o
 obj-$(CONFIG_PM_GENERIC_DOMAINS) += pm_domains.o
@@ -29,8 +29,3 @@ obj-$(CONFIG_ARCH_EXYNOS)	+= firmware.o
 
 plus_sec := $(call as-instr,.arch_extension sec,+sec)
 AFLAGS_exynos-smc.o		:=-Wa,-march=armv7-a$(plus_sec)
-
-# machine support
-
-obj-$(CONFIG_ARCH_EXYNOS4)	+= mach-exynos4-dt.o
-obj-$(CONFIG_ARCH_EXYNOS5)	+= mach-exynos5-dt.o
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index aba6a2ad7d1b..9ef3f83efaff 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -19,8 +19,7 @@ void mct_init(void __iomem *base, int irq_g0, int irq_l0, int irq_l1);
 
 struct map_desc;
 void exynos_init_io(void);
-void exynos4_restart(enum reboot_mode mode, const char *cmd);
-void exynos5_restart(enum reboot_mode mode, const char *cmd);
+void exynos_restart(enum reboot_mode mode, const char *cmd);
 void exynos_cpuidle_init(void);
 void exynos_cpufreq_init(void);
 void exynos_init_late(void);
diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/exynos.c
similarity index 75%
rename from arch/arm/mach-exynos/common.c
rename to arch/arm/mach-exynos/exynos.c
index d9ae5cd49194..b6fd40e76936 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -1,55 +1,39 @@
 /*
- * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
+ * SAMSUNG EXYNOS Flattened Device Tree enabled machine
  *
- * Common Codes for EXYNOS
+ * Copyright (c) 2010-2014 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
- */
+*/
 
-#include <linux/kernel.h>
-#include <linux/bitops.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/irqchip.h>
+#include <linux/init.h>
 #include <linux/io.h>
-#include <linux/device.h>
-#include <linux/gpio.h>
-#include <clocksource/samsung_pwm.h>
-#include <linux/sched.h>
-#include <linux/serial_core.h>
-#include <linux/serial_s3c.h>
+#include <linux/kernel.h>
 #include <linux/of.h>
-#include <linux/of_fdt.h>
-#include <linux/of_irq.h>
-#include <linux/pm_domain.h>
-#include <linux/export.h>
-#include <linux/irqdomain.h>
 #include <linux/of_address.h>
-#include <linux/irqchip/arm-gic.h>
-#include <linux/irqchip/chained_irq.h>
+#include <linux/of_fdt.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 
-#include <asm/proc-fns.h>
-#include <asm/exception.h>
+#include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
+#include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <asm/mach/irq.h>
-#include <asm/cacheflush.h>
+#include <asm/memory.h>
 
 #include <plat/cpu.h>
-#include <plat/pm.h>
 
 #include "common.h"
+#include "mfc.h"
 #include "regs-pmu.h"
 
 #define L2_AUX_VAL 0x7C470001
 #define L2_AUX_MASK 0xC200ffff
 
-/* Initial IO mappings */
-
 static struct map_desc exynos4_iodesc[] __initdata = {
 	{
 		.virtual	= (unsigned long)S3C_VA_SYS,
@@ -163,19 +147,11 @@ static struct map_desc exynos5_iodesc[] __initdata = {
 	},
 };
 
-void exynos4_restart(enum reboot_mode mode, const char *cmd)
-{
-	__raw_writel(0x1, S5P_SWRESET);
-}
-
-void exynos5_restart(enum reboot_mode mode, const char *cmd)
+void exynos_restart(enum reboot_mode mode, const char *cmd)
 {
 	struct device_node *np;
-	u32 val;
-	void __iomem *addr;
-
-	val = 0x1;
-	addr = EXYNOS_SWRESET;
+	u32 val = 0x1;
+	void __iomem *addr = EXYNOS_SWRESET;
 
 	if (of_machine_is_compatible("samsung,exynos5440")) {
 		u32 status;
@@ -286,10 +262,10 @@ static int __init exynos_fdt_map_sysram(unsigned long node, const char *uname,
  */
 static void __init exynos_map_io(void)
 {
-	if (soc_is_exynos4210() || soc_is_exynos4212() || soc_is_exynos4412())
+	if (soc_is_exynos4())
 		iotable_init(exynos4_iodesc, ARRAY_SIZE(exynos4_iodesc));
 
-	if (soc_is_exynos5250() || soc_is_exynos5420())
+	if (soc_is_exynos5())
 		iotable_init(exynos5_iodesc, ARRAY_SIZE(exynos5_iodesc));
 }
 
@@ -331,3 +307,76 @@ static int __init exynos4_l2x0_cache_init(void)
 	return 0;
 }
 early_initcall(exynos4_l2x0_cache_init);
+
+static void __init exynos_dt_machine_init(void)
+{
+	struct device_node *i2c_np;
+	const char *i2c_compat = "samsung,s3c2440-i2c";
+	unsigned int tmp;
+	int id;
+
+	/*
+	 * Exynos5's legacy i2c controller and new high speed i2c
+	 * controller have muxed interrupt sources. By default the
+	 * interrupts for 4-channel HS-I2C controller are enabled.
+	 * If node for first four channels of legacy i2c controller
+	 * are available then re-configure the interrupts via the
+	 * system register.
+	 */
+	if (soc_is_exynos5()) {
+		for_each_compatible_node(i2c_np, NULL, i2c_compat) {
+			if (of_device_is_available(i2c_np)) {
+				id = of_alias_get_id(i2c_np, "i2c");
+				if (id < 4) {
+					tmp = readl(EXYNOS5_SYS_I2C_CFG);
+					writel(tmp & ~(0x1 << id),
+							EXYNOS5_SYS_I2C_CFG);
+				}
+			}
+		}
+	}
+
+	exynos_cpuidle_init();
+	exynos_cpufreq_init();
+
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static char const *exynos_dt_compat[] __initconst = {
+	"samsung,exynos4210",
+	"samsung,exynos4212",
+	"samsung,exynos4412",
+	"samsung,exynos5250",
+	"samsung,exynos5420",
+	"samsung,exynos5440",
+	NULL
+};
+
+static void __init exynos_reserve(void)
+{
+#ifdef CONFIG_S5P_DEV_MFC
+	int i;
+	char *mfc_mem[] = {
+		"samsung,mfc-v5",
+		"samsung,mfc-v6",
+		"samsung,mfc-v7",
+	};
+
+	for (i = 0; i < ARRAY_SIZE(mfc_mem); i++)
+		if (of_scan_flat_dt(s5p_fdt_alloc_mfc_mem, mfc_mem[i]))
+			break;
+#endif
+}
+
+DT_MACHINE_START(EXYNOS_DT, "SAMSUNG EXYNOS (Flattened Device Tree)")
+	/* Maintainer: Thomas Abraham <thomas.abraham@linaro.org> */
+	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
+	.smp		= smp_ops(exynos_smp_ops),
+	.map_io		= exynos_init_io,
+	.init_early	= exynos_firmware_init,
+	.init_machine	= exynos_dt_machine_init,
+	.init_late	= exynos_init_late,
+	.dt_compat	= exynos_dt_compat,
+	.restart	= exynos_restart,
+	.reserve	= exynos_reserve,
+MACHINE_END
diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c b/arch/arm/mach-exynos/mach-exynos4-dt.c
deleted file mode 100644
index fa019fd730bb..000000000000
--- a/arch/arm/mach-exynos/mach-exynos4-dt.c
+++ /dev/null
@@ -1,53 +0,0 @@
-/*
- * Samsung's EXYNOS4 flattened device tree enabled machine
- *
- * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- * Copyright (c) 2010-2011 Linaro Ltd.
- *		www.linaro.org
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/of_platform.h>
-#include <linux/of_fdt.h>
-
-#include <asm/mach/arch.h>
-
-#include "common.h"
-#include "mfc.h"
-
-static void __init exynos4_dt_machine_init(void)
-{
-	exynos_cpuidle_init();
-	exynos_cpufreq_init();
-
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
-
-static char const *exynos4_dt_compat[] __initdata = {
-	"samsung,exynos4210",
-	"samsung,exynos4212",
-	"samsung,exynos4412",
-	NULL
-};
-
-static void __init exynos4_reserve(void)
-{
-#ifdef CONFIG_S5P_DEV_MFC
-	of_scan_flat_dt(s5p_fdt_alloc_mfc_mem, "samsung,mfc-v5");
-#endif
-}
-DT_MACHINE_START(EXYNOS4210_DT, "Samsung Exynos4 (Flattened Device Tree)")
-	/* Maintainer: Thomas Abraham <thomas.abraham@linaro.org> */
-	.smp		= smp_ops(exynos_smp_ops),
-	.map_io		= exynos_init_io,
-	.init_early	= exynos_firmware_init,
-	.init_machine	= exynos4_dt_machine_init,
-	.init_late	= exynos_init_late,
-	.dt_compat	= exynos4_dt_compat,
-	.restart        = exynos4_restart,
-	.reserve	= exynos4_reserve,
-MACHINE_END
diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
deleted file mode 100644
index 9a8a798d2ad0..000000000000
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ /dev/null
@@ -1,83 +0,0 @@
-/*
- * SAMSUNG EXYNOS5250 Flattened Device Tree enabled machine
- *
- * Copyright (c) 2012 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/of_platform.h>
-#include <linux/of_fdt.h>
-#include <linux/io.h>
-
-#include <asm/mach/arch.h>
-
-#include "common.h"
-#include "mfc.h"
-#include "regs-pmu.h"
-
-static void __init exynos5_dt_machine_init(void)
-{
-	struct device_node *i2c_np;
-	const char *i2c_compat = "samsung,s3c2440-i2c";
-	unsigned int tmp;
-
-	/*
-	 * Exynos5's legacy i2c controller and new high speed i2c
-	 * controller have muxed interrupt sources. By default the
-	 * interrupts for 4-channel HS-I2C controller are enabled.
-	 * If node for first four channels of legacy i2c controller
-	 * are available then re-configure the interrupts via the
-	 * system register.
-	 */
-	for_each_compatible_node(i2c_np, NULL, i2c_compat) {
-		if (of_device_is_available(i2c_np)) {
-			if (of_alias_get_id(i2c_np, "i2c") < 4) {
-				tmp = readl(EXYNOS5_SYS_I2C_CFG);
-				writel(tmp & ~(0x1 << of_alias_get_id(i2c_np, "i2c")),
-						EXYNOS5_SYS_I2C_CFG);
-			}
-		}
-	}
-
-	exynos_cpuidle_init();
-	exynos_cpufreq_init();
-
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
-
-static char const *exynos5_dt_compat[] __initdata = {
-	"samsung,exynos5250",
-	"samsung,exynos5420",
-	"samsung,exynos5440",
-	NULL
-};
-
-static void __init exynos5_reserve(void)
-{
-#ifdef CONFIG_S5P_DEV_MFC
-	int i;
-	char *mfc_mem[] = {
-		"samsung,mfc-v6",
-		"samsung,mfc-v7",
-	};
-
-	for (i = 0; i < ARRAY_SIZE(mfc_mem); i++)
-		if (of_scan_flat_dt(s5p_fdt_alloc_mfc_mem, mfc_mem[i]))
-			break;
-#endif
-}
-
-DT_MACHINE_START(EXYNOS5_DT, "SAMSUNG EXYNOS5 (Flattened Device Tree)")
-	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
-	.smp		= smp_ops(exynos_smp_ops),
-	.map_io		= exynos_init_io,
-	.init_machine	= exynos5_dt_machine_init,
-	.init_late	= exynos_init_late,
-	.dt_compat	= exynos5_dt_compat,
-	.restart        = exynos5_restart,
-	.reserve	= exynos5_reserve,
-MACHINE_END
diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index 2c15a8fbcb5a..4f6a2560d022 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -26,7 +26,6 @@
 #define S5P_USE_STANDBY_WFI0			(1 << 16)
 #define S5P_USE_STANDBY_WFE0			(1 << 24)
 
-#define S5P_SWRESET				S5P_PMUREG(0x0400)
 #define EXYNOS_SWRESET				S5P_PMUREG(0x0400)
 #define EXYNOS5440_SWRESET			S5P_PMUREG(0x00C4)
 
-- 
1.7.9.5
