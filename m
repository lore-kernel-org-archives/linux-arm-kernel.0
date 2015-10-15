From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Oct 2015 15:46:52 +0200
Subject: [PATCH 12/13] ARM: realview: add an DT SMP boot method
In-Reply-To: <1444916813-31024-1-git-send-email-linus.walleij@linaro.org>
References: <1444916813-31024-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1444916813-31024-13-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds an SMP boot method for the ARM RealView reference
designs. We also select HAVE_SMP by default and make it use
SMP_ON_UP so we only need to support one single kernel across
the RealView reference designs when using DT.

The RealViews need to have the SCU (Snoop Control Unit)
activated on boot, and this is now done by looking up its
address from the device tree and initializing it and counting
the available cores.

The RealViews boot by using a magic address register in the
system controller (SYS_FLAGS) to store the boot address,
the ROM will then read this register to the PC when the CPUs
are taken out of WFI. This code uses a handle to the syscon
regmap to access this register.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/arm/cpus.txt |  1 +
 arch/arm/mach-realview/Kconfig                 |  2 +
 arch/arm/mach-realview/Makefile                |  2 +-
 arch/arm/mach-realview/platsmp-dt.c            | 91 ++++++++++++++++++++++++++
 4 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-realview/platsmp-dt.c

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 91e6e5c478d0..95735e1f83ae 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -190,6 +190,7 @@ nodes to be present and contain the properties described below.
 			    "allwinner,sun6i-a31"
 			    "allwinner,sun8i-a23"
 			    "arm,psci"
+			    "arm,realview-smp"
 			    "brcm,brahma-b15"
 			    "marvell,armada-375-smp"
 			    "marvell,armada-380-smp"
diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index ea0b1d13eef6..a41e0911c2fe 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -5,11 +5,13 @@ config REALVIEW_DT
 	bool "Support RealView(R) Device Tree based boot"
 	select ARM_GIC
 	select CLK_SP810
+	select HAVE_SMP
 	select ICST
 	select MFD_SYSCON
 	select POWER_RESET
 	select POWER_RESET_VERSATILE
 	select POWER_SUPPLY
+	select SMP_ON_UP
 	select SOC_REALVIEW
 	select USE_OF
 	help
diff --git a/arch/arm/mach-realview/Makefile b/arch/arm/mach-realview/Makefile
index e07fdf7ae8a7..a46fa694cf07 100644
--- a/arch/arm/mach-realview/Makefile
+++ b/arch/arm/mach-realview/Makefile
@@ -3,7 +3,7 @@
 #
 
 obj-y					:= core.o
-obj-$(CONFIG_REALVIEW_DT)		+= realview-dt.o
+obj-$(CONFIG_REALVIEW_DT)		+= realview-dt.o platsmp-dt.o
 obj-$(CONFIG_MACH_REALVIEW_EB)		+= realview_eb.o
 obj-$(CONFIG_MACH_REALVIEW_PB11MP)	+= realview_pb11mp.o
 obj-$(CONFIG_MACH_REALVIEW_PB1176)	+= realview_pb1176.o
diff --git a/arch/arm/mach-realview/platsmp-dt.c b/arch/arm/mach-realview/platsmp-dt.c
new file mode 100644
index 000000000000..65585392655b
--- /dev/null
+++ b/arch/arm/mach-realview/platsmp-dt.c
@@ -0,0 +1,91 @@
+/*
+ * Copyright (C) 2015 Linus Walleij
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/smp.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+
+#include <asm/cacheflush.h>
+#include <asm/smp_plat.h>
+#include <asm/smp_scu.h>
+
+#include <plat/platsmp.h>
+
+#include "core.h"
+
+#define REALVIEW_SYS_FLAGSSET_OFFSET	0x30
+
+static const struct of_device_id realview_scu_match[] = {
+	{ .compatible = "arm,arm11mp-scu", },
+	{ .compatible = "arm,cortex-a9-scu", },
+	{ .compatible = "arm,cortex-a5-scu", },
+	{ }
+};
+
+static const struct of_device_id realview_syscon_match[] = {
+        { .compatible = "arm,core-module-integrator", },
+        { .compatible = "arm,realview-eb-syscon", },
+        { .compatible = "arm,realview-pb11mp-syscon", },
+        { .compatible = "arm,realview-pbx-syscon", },
+        { },
+};
+
+static void __init realview_smp_prepare_cpus(unsigned int max_cpus)
+{
+	struct device_node *np;
+	void __iomem *scu_base;
+	struct regmap *map;
+	unsigned int ncores;
+	int i;
+
+	np = of_find_matching_node(NULL, realview_scu_match);
+	if (!np) {
+		pr_err("PLATSMP: No SCU base address\n");
+		return;
+	}
+	scu_base = of_iomap(np, 0);
+	of_node_put(np);
+	if (!scu_base) {
+		pr_err("PLATSMP: No SCU remap\n");
+		return;
+	}
+
+	scu_enable(scu_base);
+	ncores = scu_get_core_count(scu_base);
+	pr_info("SCU: %d cores detected\n", ncores);
+	for (i = 0; i < ncores; i++)
+		set_cpu_possible(i, true);
+	iounmap(scu_base);
+
+	/* The syscon contains the magic SMP start address registers */
+	np = of_find_matching_node(NULL, realview_syscon_match);
+	if (!np) {
+		pr_err("PLATSMP: No syscon match\n");
+		return;
+	}
+	map = syscon_node_to_regmap(np);
+	if (IS_ERR(map)) {
+		pr_err("PLATSMP: No syscon regmap\n");
+		return;
+	}
+	/* Put the boot address in this magic register */
+	regmap_write(map, REALVIEW_SYS_FLAGSSET_OFFSET,
+		     virt_to_phys(versatile_secondary_startup));
+}
+
+struct smp_operations realview_dt_smp_ops __initdata = {
+	.smp_prepare_cpus	= realview_smp_prepare_cpus,
+	.smp_secondary_init	= versatile_secondary_init,
+	.smp_boot_secondary	= versatile_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_die		= realview_cpu_die,
+#endif
+};
+CPU_METHOD_OF_DECLARE(realview_smp, "arm,realview-smp", &realview_dt_smp_ops);
-- 
2.4.3
