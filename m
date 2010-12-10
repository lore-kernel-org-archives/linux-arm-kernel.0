From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 10 Dec 2010 16:28:18 +0000
Subject: [PATCH v3 07/14] picoxcell: add common SoC devices
In-Reply-To: <1291998505-25891-1-git-send-email-jamie@jamieiles.com>
References: <1291998505-25891-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1291998505-25891-8-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the devices common to all picoXcell variants (UART and PMU). Other
peripherals such as DMA, SPI, fuses and EMAC will be added later
with driver support.

v2:
	- split the UARTs into two separate platform devices and use
	  PLAT8250_* as the IDs

v3:
	- mark common_devices with __initdata

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-picoxcell/Makefile              |    3 +-
 arch/arm/mach-picoxcell/devices.c             |  118 +++++++++++++++++++++++++
 arch/arm/mach-picoxcell/include/mach/clkdev.h |    2 +-
 arch/arm/mach-picoxcell/picoxcell_core.c      |    3 +
 arch/arm/mach-picoxcell/picoxcell_core.h      |    1 +
 5 files changed, 125 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-picoxcell/devices.c

diff --git a/arch/arm/mach-picoxcell/Makefile b/arch/arm/mach-picoxcell/Makefile
index 71a6523..f71a33e 100644
--- a/arch/arm/mach-picoxcell/Makefile
+++ b/arch/arm/mach-picoxcell/Makefile
@@ -2,4 +2,5 @@ obj-y				:= picoxcell_core.o io.o axi2cfg.o \
 				   time.o \
 				   mux.o \
 				   gpio.o \
-				   clk.o
+				   clk.o \
+				   devices.o
diff --git a/arch/arm/mach-picoxcell/devices.c b/arch/arm/mach-picoxcell/devices.c
new file mode 100644
index 0000000..809d0e0
--- /dev/null
+++ b/arch/arm/mach-picoxcell/devices.c
@@ -0,0 +1,118 @@
+/*
+ * Copyright (c) 2010 Picochip Ltd., Jamie Iles
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * All enquiries to support at picochip.com
+ */
+#include <linux/serial_8250.h>
+#include <linux/serial_reg.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <mach/hardware.h>
+#include <mach/irqs.h>
+
+#include <asm/pmu.h>
+
+#include "picoxcell_core.h"
+
+#define UART_USR_REG_OFFSET			0x7C
+static struct plat_serial8250_port serial1_platform_data[] = {
+	{
+		.membase	= IO_ADDRESS(PICOXCELL_UART1_BASE),
+		.mapbase	= PICOXCELL_UART1_BASE,
+		.irq		= IRQ_UART1,
+		.flags		= UPF_BOOT_AUTOCONF,
+		.iotype		= UPIO_DWAPB32,
+		.regshift	= 2,
+		.uartclk	= PICOXCELL_BASE_BAUD,
+		.private_data	= (void *)(PHYS_TO_IO(PICOXCELL_UART1_BASE +
+						      UART_USR_REG_OFFSET)),
+	},
+	{},
+};
+
+static struct resource serial1_resources[] = {
+	{
+		.start		= PICOXCELL_UART1_BASE,
+		.end		= PICOXCELL_UART1_BASE + 0xFFFF,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= IRQ_UART1,
+		.end		= IRQ_UART2,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device serial1_device = {
+	.name			= "serial8250",
+	.id			= PLAT8250_DEV_PLATFORM1,
+	.dev.platform_data	= serial1_platform_data,
+	.resource		= serial1_resources,
+	.num_resources		= ARRAY_SIZE(serial1_resources),
+};
+
+static struct plat_serial8250_port serial2_platform_data[] = {
+	{
+		.membase	= IO_ADDRESS(PICOXCELL_UART2_BASE),
+		.mapbase	= PICOXCELL_UART2_BASE,
+		.irq		= IRQ_UART2,
+		.flags		= UPF_BOOT_AUTOCONF,
+		.iotype		= UPIO_DWAPB32,
+		.regshift	= 2,
+		.uartclk	= PICOXCELL_BASE_BAUD,
+		.private_data	= (void *)(PHYS_TO_IO(PICOXCELL_UART2_BASE +
+						      UART_USR_REG_OFFSET)),
+	},
+	{},
+};
+
+static struct resource serial2_resources[] = {
+	{
+		.start		= PICOXCELL_UART2_BASE,
+		.end		= PICOXCELL_UART2_BASE + 0xFFFF,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= IRQ_UART2,
+		.end		= IRQ_UART2,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device serial2_device = {
+	.name			= "serial8250",
+	.id			= PLAT8250_DEV_PLATFORM2,
+	.dev.platform_data	= serial2_platform_data,
+	.resource		= serial2_resources,
+	.num_resources		= ARRAY_SIZE(serial2_resources),
+};
+
+static struct resource pmu_resource = {
+	.start			= IRQ_NPMUIRQ,
+	.end			= IRQ_NPMUIRQ,
+	.flags			= IORESOURCE_IRQ,
+};
+
+static struct platform_device pmu_device = {
+	.name			= "arm-pmu",
+	.id			= ARM_PMU_DEVICE_CPU,
+	.num_resources		= 1,
+	.resource		= &pmu_resource,
+};
+
+static struct __initdata platform_device *common_devices[] __initdata = {
+	&serial1_device,
+	&serial2_device,
+	&pmu_device,
+};
+
+void __init picoxcell_add_devices(void)
+{
+	WARN_ON(platform_add_devices(common_devices,
+				     ARRAY_SIZE(common_devices)));
+}
diff --git a/arch/arm/mach-picoxcell/include/mach/clkdev.h b/arch/arm/mach-picoxcell/include/mach/clkdev.h
index 437f7e8..2001ff0 100644
--- a/arch/arm/mach-picoxcell/include/mach/clkdev.h
+++ b/arch/arm/mach-picoxcell/include/mach/clkdev.h
@@ -10,7 +10,7 @@
 #ifndef __PICOXCELL_CLKDEV_H__
 #define __PICOXCELL_CLKDEV_H__
 
-#include <asm/clkdev.h>
+#include <linux/clkdev.h>
 
 struct clk {
 	const char	    *name;
diff --git a/arch/arm/mach-picoxcell/picoxcell_core.c b/arch/arm/mach-picoxcell/picoxcell_core.c
index c261500..a912cfe 100644
--- a/arch/arm/mach-picoxcell/picoxcell_core.c
+++ b/arch/arm/mach-picoxcell/picoxcell_core.c
@@ -271,4 +271,7 @@ void __init picoxcell_core_init(void)
 
 	/* Add handlers for the AXI bus snooping. */
 	picoxcell_axi_bus_error_init();
+
+	/* Register the devices. */
+	picoxcell_add_devices();
 }
diff --git a/arch/arm/mach-picoxcell/picoxcell_core.h b/arch/arm/mach-picoxcell/picoxcell_core.h
index 941d1a6..9647b7a 100644
--- a/arch/arm/mach-picoxcell/picoxcell_core.h
+++ b/arch/arm/mach-picoxcell/picoxcell_core.h
@@ -19,5 +19,6 @@ extern void __init picoxcell_core_init(void);
 extern void __init picoxcell_init_irq(void);
 extern void __init picoxcell_map_io(void);
 extern struct sys_timer picoxcell_sys_timer;
+extern void __init picoxcell_add_devices(void);
 
 #endif /* __ASM_ARCH_PICOXCELL_CORE_H__ */
-- 
1.7.2.3
