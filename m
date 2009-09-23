From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Thu, 24 Sep 2009 01:18:01 +0530
Subject: [PATCH 3/8] [ARM] U8500: adds mop500 platform
Message-ID: <1253735281.21542.169.camel@vinay-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>

This adds mop500 target platform which is based
on U8500 architecture.The platform is based
on early drop silicon version of 8500.
By selecting this platform CPU_V7 and GIC are
enabled.

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Acked-by: Andrea Gallo <andrea.gallo@stericsson.com>
Reviewed-by: Alessandro Rubini <ru@gnudd.com>
Reviewed-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-ux500/Kconfig        |   15 +++++++
 arch/arm/mach-ux500/Makefile       |    8 ++++
 arch/arm/mach-ux500/board-mop500.c |   79 ++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-ux500/Kconfig
 create mode 100644 arch/arm/mach-ux500/Makefile
 create mode 100644 arch/arm/mach-ux500/board-mop500.c

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
new file mode 100644
index 0000000..612b0b7
--- /dev/null
+++ b/arch/arm/mach-ux500/Kconfig
@@ -0,0 +1,15 @@
+menu "ST-Ericsson platform type"
+	depends on ARCH_U8500
+
+comment "ST-Ericsson Multicore Mobile Platforms"
+
+config MACH_U8500_MOP
+	bool "U8500 Development platform"
+	default y
+	select CPU_V7
+	select ARM_GIC
+	help
+	  Include support for mop500 development platform
+	  based on U8500 architecture. The platform is based
+	  on early drop silicon version of 8500.
+endmenu
diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
new file mode 100644
index 0000000..e71431c
--- /dev/null
+++ b/arch/arm/mach-ux500/Makefile
@@ -0,0 +1,8 @@
+#
+# Makefile for the linux kernel, U8500 machine.
+#
+
+obj-y				:= clock.o timer.o
+obj-$(CONFIG_ARCH_U8500)	+= cpu-u8500.o
+obj-$(CONFIG_MACH_U8500_MOP)	+= board-mop500.o
+obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o localtimer.o
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
new file mode 100644
index 0000000..bca2e84
--- /dev/null
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -0,0 +1,79 @@
+/*
+ * Copyright (C) 2008-2009 ST-Ericsson
+ *
+ * Author: Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/amba/bus.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+#include <mach/hardware.h>
+#include <mach/setup.h>
+
+#define __MEM_4K_RESOURCE(x) \
+	.res = {.start = (x), .end = (x) + SZ_4K - 1, .flags = IORESOURCE_MEM}
+
+/* These are active devices on this board */
+static struct amba_device uart0_device = {
+	.dev = { .init_name = "uart0" },
+	__MEM_4K_RESOURCE(U8500_UART0_BASE),
+	.irq = {IRQ_UART0, NO_IRQ},
+};
+
+static struct amba_device uart1_device = {
+	.dev = { .init_name = "uart1" },
+	__MEM_4K_RESOURCE(U8500_UART1_BASE),
+	.irq = {IRQ_UART1, NO_IRQ},
+};
+
+static struct amba_device uart2_device = {
+	.dev = { .init_name = "uart2" },
+	__MEM_4K_RESOURCE(U8500_UART2_BASE),
+	.irq = {IRQ_UART2, NO_IRQ},
+};
+
+static struct amba_device *amba_devs[] __initdata = {
+	&uart0_device,
+	&uart1_device,
+	&uart2_device,
+};
+
+/* add any platform devices here - TODO */
+static struct platform_device *platform_devs[] __initdata = {
+	/* yet to be added, add i2c0, gpio.. */
+};
+
+static void __init u8500_init_machine(void)
+{
+	int i;
+	/* Register the active AMBA devices*/
+	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
+		amba_device_register(amba_devs[i], &iomem_resource);
+
+	/* Register the platform devices */
+	platform_add_devices(platform_devs, ARRAY_SIZE(platform_devs));
+
+	u8500_init_devices();
+}
+
+MACHINE_START(NOMADIK, "ST-Ericsson MOP500 platform")
+	/* Maintainer: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com> */
+	.phys_io	= U8500_UART2_BASE,
+	.io_pg_offst	= (IO_ADDRESS(U8500_UART2_BASE) >> 18) & 0xfffc,
+	.boot_params	= 0x100,
+	.map_io		= u8500_map_io,
+	.init_irq	= u8500_init_irq,
+	.timer		= &u8500_timer,
+	.init_machine	= u8500_init_machine,
+MACHINE_END
-- 
1.6.3.GIT
