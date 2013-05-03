From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 3 May 2013 11:49:53 +0800
Subject: [PATCH 3/5] ARM: imx: add initial support for imx6sl
In-Reply-To: <1367552995-31777-1-git-send-email-shawn.guo@linaro.org>
References: <1367552995-31777-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1367552995-31777-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial support for i.MX6 SoloLite.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/Kconfig       |   19 ++++++++++++++++
 arch/arm/mach-imx/Makefile      |    1 +
 arch/arm/mach-imx/common.h      |    1 +
 arch/arm/mach-imx/mach-imx6sl.c |   48 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+)
 create mode 100644 arch/arm/mach-imx/mach-imx6sl.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index c132f6f..8454221 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -820,6 +820,25 @@ config SOC_IMX6Q
 	help
 	  This enables support for Freescale i.MX6 Quad processor.
 
+config SOC_IMX6SL
+	bool "i.MX6 SoloLite support"
+	select ARM_ERRATA_754322
+	select ARM_ERRATA_775420
+	select ARM_GIC
+	select CPU_V7
+	select HAVE_IMX_ANATOP
+	select HAVE_IMX_GPC
+	select HAVE_IMX_MMDC
+	select HAVE_IMX_SRC
+	select PINCTRL
+	select PINCTRL_IMX6SL
+	select PL310_ERRATA_588369 if CACHE_PL310
+	select PL310_ERRATA_727915 if CACHE_PL310
+	select PL310_ERRATA_769419 if CACHE_PL310
+
+	help
+	  This enables support for Freescale i.MX6 SoloLite processor.
+
 endif
 
 source "arch/arm/mach-imx/devices/Kconfig"
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index b16eb39..d6f99e1 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -99,6 +99,7 @@ AFLAGS_headsmp.o :=-Wa,-march=armv7-a
 obj-$(CONFIG_SMP) += headsmp.o platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
 obj-$(CONFIG_SOC_IMX6Q) += clk-imx6q.o mach-imx6q.o
+obj-$(CONFIG_SOC_IMX6SL) += clk-imx6sl.o mach-imx6sl.o
 
 ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_SOC_IMX6Q) += pm-imx6q.o headsmp.o
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 4cba7db..efae60c 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -68,6 +68,7 @@ extern int mx31_clocks_init_dt(void);
 extern int mx51_clocks_init_dt(void);
 extern int mx53_clocks_init_dt(void);
 extern int mx6q_clocks_init(void);
+extern int imx6sl_clocks_init(void);
 extern struct platform_device *mxc_register_gpio(char *name, int id,
 	resource_size_t iobase, resource_size_t iosize, int irq, int irq_high);
 extern void mxc_set_cpu_type(unsigned int type);
diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
new file mode 100644
index 0000000..b044134
--- /dev/null
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -0,0 +1,48 @@
+/*
+ * Copyright 2013 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/irqchip.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <asm/hardware/cache-l2x0.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#include "common.h"
+
+static void __init imx6sl_init_machine(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static void __init imx6sl_init_irq(void)
+{
+	l2x0_of_init(0, ~0UL);
+	imx_src_init();
+	imx_gpc_init();
+	irqchip_init();
+}
+
+static void __init imx6sl_timer_init(void)
+{
+	imx6sl_clocks_init();
+}
+
+static const char *imx6sl_dt_compat[] __initdata = {
+	"fsl,imx6sl",
+	NULL,
+};
+
+DT_MACHINE_START(IMX6SL, "Freescale i.MX6 SoloLite (Device Tree)")
+	.map_io		= debug_ll_io_init,
+	.init_irq	= imx6sl_init_irq,
+	.init_time	= imx6sl_timer_init,
+	.init_machine	= imx6sl_init_machine,
+	.dt_compat	= imx6sl_dt_compat,
+MACHINE_END
-- 
1.7.9.5
