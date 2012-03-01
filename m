From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu,  1 Mar 2012 14:10:26 +0800
Subject: [PATCH 6/8] ARM: mmp: append OF support on pxa168
In-Reply-To: <1330582228-12424-1-git-send-email-haojian.zhuang@marvell.com>
References: <1330582228-12424-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1330582228-12424-7-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable PXA168 and aspenite support.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/Kconfig  |   10 ++++++
 arch/arm/mach-mmp/Makefile |    1 +
 arch/arm/mach-mmp/mmp-dt.c |   75 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mmp/mmp-dt.c

diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index 323d4c9..5a90b9a 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -2,6 +2,16 @@ if ARCH_MMP
 
 menu "Marvell PXA168/910/MMP2 Implmentations"
 
+config MACH_MMP_DT
+	bool "Support MMP2 platforms from device tree"
+	select CPU_PXA168
+	select CPU_PXA910
+	select USE_OF
+	help
+	  Include support for Marvell MMP2 based platforms using
+	  the device tree. Needn't select any other machine while
+	  MACH_MMP_DT is enabled.
+
 config MACH_ASPENITE
 	bool "Marvell's PXA168 Aspenite Development Board"
 	select CPU_PXA168
diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
index ba254a7..4fc0ff5 100644
--- a/arch/arm/mach-mmp/Makefile
+++ b/arch/arm/mach-mmp/Makefile
@@ -18,5 +18,6 @@ obj-$(CONFIG_MACH_TTC_DKB)	+= ttc_dkb.o
 obj-$(CONFIG_MACH_BROWNSTONE)	+= brownstone.o
 obj-$(CONFIG_MACH_FLINT)	+= flint.o
 obj-$(CONFIG_MACH_MARVELL_JASPER) += jasper.o
+obj-$(CONFIG_MACH_MMP_DT)	+= mmp-dt.o
 obj-$(CONFIG_MACH_TETON_BGA)	+= teton_bga.o
 obj-$(CONFIG_MACH_GPLUGD)	+= gplugd.o
diff --git a/arch/arm/mach-mmp/mmp-dt.c b/arch/arm/mach-mmp/mmp-dt.c
new file mode 100644
index 0000000..6707539
--- /dev/null
+++ b/arch/arm/mach-mmp/mmp-dt.c
@@ -0,0 +1,75 @@
+/*
+ *  linux/arch/arm/mach-mmp/mmp-dt.c
+ *
+ *  Copyright (C) 2012 Marvell Technology Group Ltd.
+ *  Author: Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  publishhed by the Free Software Foundation.
+ */
+
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <asm/mach/arch.h>
+#include <mach/irqs.h>
+
+#include "common.h"
+
+extern struct sys_timer pxa168_timer;
+extern void __init icu_init_irq(void);
+
+static const struct of_dev_auxdata mmp_auxdata_lookup[] __initconst = {
+	OF_DEV_AUXDATA("mrvl,mmp-uart", 0xd4017000, "pxa2xx-uart.0", NULL),
+	OF_DEV_AUXDATA("mrvl,mmp-uart", 0xd4018000, "pxa2xx-uart.1", NULL),
+	OF_DEV_AUXDATA("mrvl,mmp-uart", 0xd4026000, "pxa2xx-uart.2", NULL),
+	OF_DEV_AUXDATA("mrvl,mmp-twsi", 0xd4011000, "pxa2xx-i2c.0", NULL),
+	OF_DEV_AUXDATA("mrvl,mmp-twsi", 0xd4025000, "pxa2xx-i2c.1", NULL),
+	OF_DEV_AUXDATA("mrvl,mmp-gpio", 0xd4019000, "pxa-gpio", NULL),
+	OF_DEV_AUXDATA("mrvl,mmp-rtc", 0xd4010000, "sa1100-rtc", NULL),
+	{}
+};
+
+static int __init mmp_intc_add_irq_domain(struct device_node *np,
+					   struct device_node *parent)
+{
+	irq_domain_add_simple(np, 0);
+	return 0;
+}
+
+static int __init mmp_gpio_add_irq_domain(struct device_node *np,
+					   struct device_node *parent)
+{
+	irq_domain_add_simple(np, IRQ_GPIO_START);
+	return 0;
+}
+
+static const struct of_device_id mmp_irq_match[] __initconst = {
+	{ .compatible = "mrvl,mmp-intc", .data = mmp_intc_add_irq_domain, },
+	{ .compatible = "mrvl,mmp-gpio", .data = mmp_gpio_add_irq_domain, },
+	{}
+};
+
+static void __init mmp_dt_init(void)
+{
+
+	of_irq_init(mmp_irq_match);
+
+	of_platform_populate(NULL, of_default_bus_match_table,
+			     mmp_auxdata_lookup, NULL);
+}
+
+static const char *pxa168_dt_board_compat[] __initdata = {
+	"mrvl,pxa168-aspenite",
+	NULL,
+};
+
+DT_MACHINE_START(PXA168_DT, "Marvell PXA168 (Device Tree Support)")
+	.map_io		= mmp_map_io,
+	.init_irq	= icu_init_irq,
+	.timer		= &pxa168_timer,
+	.init_machine	= mmp_dt_init,
+	.dt_compat	= pxa168_dt_board_compat,
+MACHINE_END
-- 
1.7.0.4
