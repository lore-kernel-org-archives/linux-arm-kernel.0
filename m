From: zonque@gmail.com (Daniel Mack)
Date: Sat, 28 Jul 2012 12:07:40 +0200
Subject: [PATCH v3 8/9] ARM: pxa3xx: add generic DT machine code
In-Reply-To: <1343470061-16879-1-git-send-email-zonque@gmail.com>
References: <1343470061-16879-1-git-send-email-zonque@gmail.com>
Message-ID: <1343470061-16879-9-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a DT_MACHINE_START entry for PXA3xx machines and a auxdata table for
some of the devices. This file can be extended to also support pxa2xx
and pxa9xx boards.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/mach-pxa/Kconfig  | 12 +++++++++
 arch/arm/mach-pxa/Makefile |  3 +++
 arch/arm/mach-pxa/pxa-dt.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)
 create mode 100644 arch/arm/mach-pxa/pxa-dt.c

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index fe2d1f8..8e6288d 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -25,6 +25,18 @@ config PXA_V7_MACH_AUTO
 if !ARCH_PXA_V7
 comment "Intel/Marvell Dev Platforms (sorted by hardware release time)"
 
+config MACH_PXA3XX_DT
+	bool "Support PXA3xx platforms from device tree"
+	select PXA3xx
+	select CPU_PXA300
+	select POWER_SUPPLY
+	select HAVE_PWM
+	select USE_OF
+	help
+	  Include support for Marvell PXA3xx based platforms using
+	  the device tree. Needn't select any other machine while
+	  MACH_PXA3XX_DT is enabled.
+
 config ARCH_LUBBOCK
 	bool "Intel DBPXA250 Development Platform (aka Lubbock)"
 	select PXA25x
diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index be0f7df..2bedc9e 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -26,6 +26,9 @@ obj-$(CONFIG_CPU_PXA930)	+= pxa930.o
 
 # NOTE: keep the order of boards in accordance to their order in Kconfig
 
+# Device Tree support
+obj-$(CONFIG_MACH_PXA3XX_DT)	+= pxa-dt.o
+
 # Intel/Marvell Dev Platforms
 obj-$(CONFIG_ARCH_LUBBOCK)	+= lubbock.o
 obj-$(CONFIG_MACH_MAINSTONE)	+= mainstone.o
diff --git a/arch/arm/mach-pxa/pxa-dt.c b/arch/arm/mach-pxa/pxa-dt.c
new file mode 100644
index 0000000..c9192ce
--- /dev/null
+++ b/arch/arm/mach-pxa/pxa-dt.c
@@ -0,0 +1,63 @@
+/*
+ *  linux/arch/arm/mach-pxa/pxa-dt.c
+ *
+ *  Copyright (C) 2012 Daniel Mack
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
+#include <asm/mach/time.h>
+#include <mach/irqs.h>
+#include <mach/pxa3xx.h>
+
+#include "generic.h"
+
+#ifdef CONFIG_PXA3xx
+extern void __init pxa3xx_dt_init_irq(void);
+
+static const struct of_dev_auxdata pxa3xx_auxdata_lookup[] __initconst = {
+	OF_DEV_AUXDATA("mrvl,pxa-uart",		0x40100000, "pxa2xx-uart.0", NULL),
+	OF_DEV_AUXDATA("mrvl,pxa-uart",		0x40200000, "pxa2xx-uart.1", NULL),
+	OF_DEV_AUXDATA("mrvl,pxa-uart",		0x40700000, "pxa2xx-uart.2", NULL),
+	OF_DEV_AUXDATA("mrvl,pxa-uart",		0x41600000, "pxa2xx-uart.3", NULL),
+	OF_DEV_AUXDATA("marvell,pxa-mmc",	0x41100000, "pxa2xx-mci.0", NULL),
+	OF_DEV_AUXDATA("mrvl,pxa-gpio",		0x40e00000, "pxa-gpio", NULL),
+	OF_DEV_AUXDATA("marvell,pxa-ohci",	0x4c000000, "pxa27x-ohci", NULL),
+	OF_DEV_AUXDATA("mrvl,pxa-i2c",		0x40301680, "pxa2xx-i2c.0", NULL),
+	OF_DEV_AUXDATA("mrvl,pwri2c",		0x40f500c0, "pxa3xx-i2c.1", NULL),
+	OF_DEV_AUXDATA("marvell,pxa3xx-nand",	0x43100000, "pxa3xx-nand", NULL),
+	{}
+};
+
+static void __init pxa3xx_dt_init(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table,
+			     pxa3xx_auxdata_lookup, NULL);
+}
+
+static const char *pxa3xx_dt_board_compat[] __initdata = {
+	"marvell,pxa300",
+	"marvell,pxa310",
+	"marvell,pxa320",
+	NULL,
+};
+#endif
+
+#ifdef CONFIG_PXA3xx
+DT_MACHINE_START(PXA_DT, "Marvell PXA3xx (Device Tree Support)")
+	.map_io		= pxa3xx_map_io,
+	.init_irq	= pxa3xx_dt_init_irq,
+	.handle_irq	= pxa3xx_handle_irq,
+	.timer		= &pxa_timer,
+	.restart	= pxa_restart,
+	.init_machine	= pxa3xx_dt_init,
+	.dt_compat	= pxa3xx_dt_board_compat,
+MACHINE_END
+#endif
-- 
1.7.11.2
