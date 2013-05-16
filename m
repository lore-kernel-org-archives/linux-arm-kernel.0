From: b35083@freescale.com (Jingchang Lu)
Date: Thu, 16 May 2013 14:10:46 +0800
Subject: [PATCH v3 2/4] ARM: imx: add initial support for MVF600
In-Reply-To: <1368684648-20826-1-git-send-email-b35083@freescale.com>
References: <1368684648-20826-1-git-send-email-b35083@freescale.com>
Message-ID: <1368684648-20826-3-git-send-email-b35083@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial support for Vybrid MVF600 SoC.

Signed-off-by: Jingchang Lu <b35083@freescale.com>
---
v3:
  remove unused #include header lines.
  use common mxc restart function.

 arch/arm/mach-imx/Kconfig       | 15 +++++++++
 arch/arm/mach-imx/Makefile      |  2 ++
 arch/arm/mach-imx/common.h      |  1 +
 arch/arm/mach-imx/mach-mvf600.c | 70 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+)
 create mode 100644 arch/arm/mach-imx/mach-mvf600.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index a402248..b9c01a1 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -835,6 +835,21 @@ config SOC_IMX6SL
 	help
 	  This enables support for Freescale i.MX6 SoloLite processor.
 
+config SOC_MVF600
+	bool "Vybrid Family MVF600 support"
+	select CPU_V7
+	select ARM_GIC
+	select CLKSRC_OF
+	select PINCTRL
+	select PINCTRL_MVF600
+	select MVF600_PIT_TIMER
+	select PL310_ERRATA_588369 if CACHE_PL310
+	select PL310_ERRATA_727915 if CACHE_PL310
+	select PL310_ERRATA_769419 if CACHE_PL310
+
+	help
+	  This enable support for Freescale Vybrid MVF600 processor.
+
 endif
 
 source "arch/arm/mach-imx/devices/Kconfig"
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 2a4754d..28d8b4c 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -112,4 +112,6 @@ obj-$(CONFIG_MACH_EUKREA_MBIMXSD51_BASEBOARD) += eukrea_mbimxsd51-baseboard.o
 obj-$(CONFIG_MACH_IMX51_DT) += imx51-dt.o
 obj-$(CONFIG_SOC_IMX53) += mach-imx53.o
 
+obj-$(CONFIG_SOC_MVF600) += clk-mvf600.o mach-mvf600.o
+
 obj-y += devices/
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 208e76f..55cdba0 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -70,6 +70,7 @@ extern int mx51_clocks_init_dt(void);
 extern int mx53_clocks_init_dt(void);
 extern int mx6q_clocks_init(void);
 extern int imx6sl_clocks_init(void);
+extern int mvf600_clocks_init(void);
 extern struct platform_device *mxc_register_gpio(char *name, int id,
 	resource_size_t iobase, resource_size_t iosize, int irq, int irq_high);
 extern void mxc_set_cpu_type(unsigned int type);
diff --git a/arch/arm/mach-imx/mach-mvf600.c b/arch/arm/mach-imx/mach-mvf600.c
new file mode 100644
index 0000000..deffe74
--- /dev/null
+++ b/arch/arm/mach-imx/mach-mvf600.c
@@ -0,0 +1,70 @@
+/*
+ * Copyright 2012-2013 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/clk.h>
+#include <linux/clocksource.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/arm-gic.h>
+#include <asm/mach/arch.h>
+#include <asm/hardware/cache-l2x0.h>
+#include <asm/system_misc.h>
+
+#include "common.h"
+
+static void __init mvf600_init_machine(void)
+{
+	mxc_arch_reset_init_dt();
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static void __init mvf600_init_irq(void)
+{
+	struct device_node *np;
+	void __iomem *mscm_base;
+	int i;
+
+	l2x0_of_init(0, ~0UL);
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,mvf600-mscm");
+	mscm_base = of_iomap(np, 0);
+	if (!mscm_base)
+		return;
+
+	/* route all shared peripheral interrupts to CP0 */
+	for (i = 0; i < 111; i++)
+		__raw_writew(1, mscm_base + 0x880 + 2 * i);
+
+	iounmap(mscm_base);
+
+	irqchip_init();
+}
+
+static void __init mvf600_init_time(void)
+{
+	mvf600_clocks_init();
+	clocksource_of_init();
+}
+
+static const char *mvf600_dt_compat[] __initdata = {
+	"fsl,mvf600",
+	NULL,
+};
+
+DT_MACHINE_START(VYBRID_VF6XX, "Freescale Vybrid MVF600 (Device Tree)")
+	.init_irq	= mvf600_init_irq,
+	.init_time	= mvf600_init_time,
+	.init_machine   = mvf600_init_machine,
+	.dt_compat	= mvf600_dt_compat,
+	.restart	= mxc_restart,
+MACHINE_END
-- 
1.8.0
