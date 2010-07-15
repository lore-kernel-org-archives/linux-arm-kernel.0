From: alchark@gmail.com (Alexey Charkov)
Date: Thu, 15 Jul 2010 23:31:36 +0400
Subject: [PATCH v2][RFC] arm: Add basic support for VIA/WonderMedia SoC's
In-Reply-To: <201007122122.32623.arnd@arndb.de>
References: <20100712165025.GA13818@alchark-u3s.alchark.ru>
	<201007122122.32623.arnd@arndb.de>
Message-ID: <20100715193136.GA19050@alchark-u3s.alchark.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds basic support for machine initialization, interrupts, timers and
serial console on VIA/WonderMedia VT8500 and WM8505 Systems-on-Chip.

These SoC's are used in quite many netbooks and tablets produced in China
and sold online at relatively low prices (typically below 100 USD).

Support for WM8505 is known incomplete, while VT8500 is tested by me on the
hardware and at least prints kernel messages to the serial console with timing
information.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---

This is a second attempt, I tried to implement all the comments that I've
received previously. Please comment and, if possible, integrate. Serial
driver will follow separately.

Best regards,
Alexey

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 98922f7..9f64b8c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -794,6 +794,17 @@ config PLAT_SPEAR
 	help
 	  Support for ST's SPEAr platform (SPEAr3xx, SPEAr6xx and SPEAr13xx).
 
+config ARCH_VT8500
+	bool "VIA/WonderMedia 85xx"
+	select CPU_ARM926T
+	select GENERIC_GPIO
+	select ARCH_HAS_CPUFREQ
+	select GENERIC_TIME
+	select GENERIC_CLOCKEVENTS
+	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select HAVE_CLK
+	help
+	  Support for VIA/WonderMedia VT8500/WM85xx System-on-Chip.
 endchoice
 
 #
@@ -916,6 +927,8 @@ source "arch/arm/mach-versatile/Kconfig"
 
 source "arch/arm/mach-vexpress/Kconfig"
 
+source "arch/arm/mach-vt8500/Kconfig"
+
 source "arch/arm/mach-w90x900/Kconfig"
 
 # Definitions to make life easier
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 64ba313..dcb5b64 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -179,6 +179,7 @@ machine-$(CONFIG_ARCH_U300)		:= u300
 machine-$(CONFIG_ARCH_U8500)		:= ux500
 machine-$(CONFIG_ARCH_VERSATILE)	:= versatile
 machine-$(CONFIG_ARCH_VEXPRESS)		:= vexpress
+machine-$(CONFIG_ARCH_VT8500)		:= vt8500
 machine-$(CONFIG_ARCH_W90X900)		:= w90x900
 machine-$(CONFIG_ARCH_NUC93X)		:= nuc93x
 machine-$(CONFIG_FOOTBRIDGE)		:= footbridge
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 53faa90..4f67531 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -32,6 +32,10 @@ ifeq ($(CONFIG_ARCH_SA1100),y)
 OBJS		+= head-sa1100.o
 endif
 
+ifeq ($(CONFIG_ARCH_VT8500),y)
+OBJS		+= head-vt8500.o
+endif
+
 ifeq ($(CONFIG_CPU_XSCALE),y)
 OBJS		+= head-xscale.o
 endif
diff --git a/arch/arm/boot/compressed/head-vt8500.S b/arch/arm/boot/compressed/head-vt8500.S
new file mode 100644
index 0000000..2faa7d6
--- /dev/null
+++ b/arch/arm/boot/compressed/head-vt8500.S
@@ -0,0 +1,23 @@
+/*
+ * linux/arch/arm/boot/compressed/head-vt8500.S
+ *
+ * Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
+ *
+ * VIA VT8500 specific tweaks. This is merged into head.S by the linker.
+ *
+ */
+
+#include <linux/linkage.h>
+#include <asm/mach-types.h>
+
+		.section        ".start", "ax"
+
+__VT8500_start:
+		/* Override the obscure machine id from bootloader */
+#ifdef CONFIG_MACH_BV07
+		mov	r7, #(MACH_TYPE_BV07 & ~0xf)
+		orr	r7, r7, #(MACH_TYPE_BV07 & 0xf)
+#elif defined CONFIG_MACH_WM8505_7IN_NETBOOK
+		mov	r7, #(MACH_TYPE_WM8505_7IN_NETBOOK & ~0xf)
+		orr	r7, r7, #(MACH_TYPE_WM8505_7IN_NETBOOK & 0xf)
+#endif
diff --git a/arch/arm/mach-vt8500/Kconfig b/arch/arm/mach-vt8500/Kconfig
new file mode 100644
index 0000000..bd75043
--- /dev/null
+++ b/arch/arm/mach-vt8500/Kconfig
@@ -0,0 +1,33 @@
+if ARCH_VT8500
+
+choice
+	prompt "VIA/WonderMedia System Type"
+	default VTWM_VERSION_VT8500
+
+config VTWM_VERSION_VT8500
+	bool "VIA VT8500"
+
+config VTWM_VERSION_WM8505
+	bool "WonderMedia WM8505"
+
+endchoice
+
+config MACH_BV07
+	bool "Benign BV07-8500 Mini Netbook"
+	depends on ARCH_VT8500 && VTWM_VERSION_VT8500
+	help
+	  Add support for the inexpensive 7-inch netbooks sold by many
+	  Chinese distributors under various names. Note that there are
+	  many hardware implementations in identical exterior, make sure
+	  that yours is indeed based on a VIA VT8500 chip.
+
+config MACH_WM8505_7IN_NETBOOK
+	bool "WM8505 7-inch generic netbook"
+	depends on ARCH_VT8500 && VTWM_VERSION_WM8505
+	help
+	  Add support for the inexpensive 7-inch netbooks sold by many
+	  Chinese distributors under various names. Note that there are
+	  many hardware implementations in identical exterior, make sure
+	  that yours is indeed based on a WonderMedia WM8505 chip.
+
+endif
diff --git a/arch/arm/mach-vt8500/Makefile b/arch/arm/mach-vt8500/Makefile
new file mode 100644
index 0000000..948f3c8
--- /dev/null
+++ b/arch/arm/mach-vt8500/Makefile
@@ -0,0 +1,3 @@
+obj-y += devices.o irq.o timer.o
+
+obj-$(CONFIG_MACH_BV07) += bv07.o
diff --git a/arch/arm/mach-vt8500/Makefile.boot b/arch/arm/mach-vt8500/Makefile.boot
new file mode 100644
index 0000000..a8acc4e
--- /dev/null
+++ b/arch/arm/mach-vt8500/Makefile.boot
@@ -0,0 +1,3 @@
+   zreladdr-y	:= 0x00008000
+params_phys-y	:= 0x00000100
+initrd_phys-y	:= 0x01000000
diff --git a/arch/arm/mach-vt8500/bv07.c b/arch/arm/mach-vt8500/bv07.c
new file mode 100644
index 0000000..3a6f769
--- /dev/null
+++ b/arch/arm/mach-vt8500/bv07.c
@@ -0,0 +1,44 @@
+/*
+ *  arch/arm/mach-vt8500/bv07.c
+ *
+ *  Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+#include <mach/vt8500.h>
+#include "devices.h"
+
+static struct platform_device *devices[] __initdata = {
+	&vt8500_device_uart0,
+};
+
+void __init bv07_init(void)
+{
+	platform_add_devices(devices, ARRAY_SIZE(devices));
+}
+
+MACHINE_START(BV07, "Benign BV07 Mini Netbook")
+	.phys_io	= VT8500_REGS_START_PHYS,
+	.io_pg_offst	= ((VT8500_REGS_START_VIRT) >> 18) & 0xfffc,
+	.boot_params	= 0x00000100,
+	.map_io		= vt8500_map_io,
+	.init_irq	= vt8500_init_irq,
+	.timer		= &vt8500_timer,
+	.init_machine	= bv07_init,
+MACHINE_END
diff --git a/arch/arm/mach-vt8500/devices.c b/arch/arm/mach-vt8500/devices.c
new file mode 100644
index 0000000..a6d7890
--- /dev/null
+++ b/arch/arm/mach-vt8500/devices.c
@@ -0,0 +1,149 @@
+/* linux/arch/arm/mach-vt8500/devices.c
+ *
+ * Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#include <mach/irqs.h>
+#include <mach/hardware.h>
+#include <mach/vt8500.h>
+#include "devices.h"
+
+static struct map_desc vt8500_io_desc[] __initdata = {
+	{
+		.virtual	=  VT8500_REGS_START_VIRT,
+		.pfn		= __phys_to_pfn(VT8500_REGS_START_PHYS),
+		.length		= VT8500_REGS_LENGTH,
+		.type		= MT_DEVICE
+	},
+};
+
+void __init vt8500_map_io(void)
+{
+	iotable_init(vt8500_io_desc, ARRAY_SIZE(vt8500_io_desc));
+}
+
+static struct resource resources_uart0[] = {
+	{
+		.start	= IRQ_UART0,
+		.end	= IRQ_UART0,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= VT8500_UART0_BASE,
+		.end	= VT8500_UART0_BASE + VT8500_UART_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct resource resources_uart1[] = {
+	{
+		.start	= IRQ_UART1,
+		.end	= IRQ_UART1,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= VT8500_UART1_BASE,
+		.end	= VT8500_UART1_BASE + VT8500_UART_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct resource resources_uart2[] = {
+	{
+		.start	= IRQ_UART2,
+		.end	= IRQ_UART2,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= VT8500_UART2_BASE,
+		.end	= VT8500_UART2_BASE + VT8500_UART_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct resource resources_uart3[] = {
+	{
+		.start	= IRQ_UART3,
+		.end	= IRQ_UART3,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= VT8500_UART3_BASE,
+		.end	= VT8500_UART3_BASE + VT8500_UART_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+#ifdef CONFIG_VTWM_VERSION_WM8505
+static struct resource resources_uart4[] = {
+	{
+		.start	= IRQ_UART4,
+		.end	= IRQ_UART4,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= VT8500_UART4_BASE,
+		.end	= VT8500_UART4_BASE + VT8500_UART_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct resource resources_uart5[] = {
+	{
+		.start	= IRQ_UART5,
+		.end	= IRQ_UART5,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= VT8500_UART5_BASE,
+		.end	= VT8500_UART5_BASE + VT8500_UART_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+#endif
+
+struct platform_device vt8500_device_uart0 = {
+	.name		= "vt8500_serial",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(resources_uart0),
+	.resource	= resources_uart0,
+};
+
+struct platform_device vt8500_device_uart1 = {
+	.name		= "vt8500_serial",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(resources_uart1),
+	.resource	= resources_uart1,
+};
+
+struct platform_device vt8500_device_uart2 = {
+	.name		= "vt8500_serial",
+	.id		= 2,
+	.num_resources	= ARRAY_SIZE(resources_uart2),
+	.resource	= resources_uart2,
+};
+
+struct platform_device vt8500_device_uart3 = {
+	.name		= "vt8500_serial",
+	.id		= 3,
+	.num_resources	= ARRAY_SIZE(resources_uart3),
+	.resource	= resources_uart3,
+};
diff --git a/arch/arm/mach-vt8500/devices.h b/arch/arm/mach-vt8500/devices.h
new file mode 100644
index 0000000..243ed0a
--- /dev/null
+++ b/arch/arm/mach-vt8500/devices.h
@@ -0,0 +1,34 @@
+/* linux/arch/arm/mach-vt8500/devices.h
+ *
+ * Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __ARCH_ARM_MACH_VT8500_DEVICES_H
+#define __ARCH_ARM_MACH_VT8500_DEVICES_H
+
+#include <linux/platform_device.h>
+
+void __init vt8500_init_irq(void);
+void __init vt8500_map_io(void);
+extern struct sys_timer vt8500_timer;
+
+extern struct platform_device vt8500_device_uart0;
+extern struct platform_device vt8500_device_uart1;
+extern struct platform_device vt8500_device_uart2;
+extern struct platform_device vt8500_device_uart3;
+#ifdef CONFIG_VTWM_VERSION_WM8505
+extern struct platform_device vt8500_device_uart4;
+extern struct platform_device vt8500_device_uart5;
+#endif
+
+#endif
diff --git a/arch/arm/mach-vt8500/include/mach/debug-macro.S b/arch/arm/mach-vt8500/include/mach/debug-macro.S
new file mode 100644
index 0000000..264e0be
--- /dev/null
+++ b/arch/arm/mach-vt8500/include/mach/debug-macro.S
@@ -0,0 +1,35 @@
+/*
+ * arch/arm/mach-vt8500/include/mach/debug-macro.S
+ *
+ *  Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
+ *
+ * Debugging macro include header
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+*/
+
+#include <mach/vt8500.h>
+
+	.macro	addruart, rx, tmp
+	mrc	p15, 0, \rx, c1, c0
+	tst	\rx, #1			@ MMU enabled?
+	moveq	\rx,      #0xd8000000
+	movne	\rx,      #0xf8000000	@ virtual base
+	orr	\rx, \rx, #0x00200000
+	.endm
+
+	.macro	senduart,rd,rx
+	strb	\rd, [\rx, #0]
+	.endm
+
+	.macro	busyuart,rd,rx
+1001:	ldr	\rd, [\rx, #0x1c]
+	ands	\rd, \rd, #0x2
+	bne	1001b
+	.endm
+
+	.macro	waituart,rd,rx
+	.endm
diff --git a/arch/arm/mach-vt8500/include/mach/entry-macro.S b/arch/arm/mach-vt8500/include/mach/entry-macro.S
new file mode 100644
index 0000000..6b8a04e
--- /dev/null
+++ b/arch/arm/mach-vt8500/include/mach/entry-macro.S
@@ -0,0 +1,41 @@
+/*
+ * arch/arm/mach-vt8500/include/mach/entry-macro.S
+ *
+ * Low-level IRQ helper macros for VIA VT8500
+ *
+ * This file is licensed under  the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+	.macro	disable_fiq
+	.endm
+
+	.macro  get_irqnr_preamble, base, tmp
+	@ physical 0xd8140000 is virtual 0xf8140000
+	mov	\base, #0xf8000000
+	orr	\base, \base, #0x00140000
+	.endm
+
+	.macro  arch_ret_to_user, tmp1, tmp2
+	.endm
+
+	/* Reserved interrupts, to be masked off: 2, 4, 23 */
+	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
+	@ check low interrupts
+	ldr	\irqstat, [\base, #0x80]
+	mov	\tmp, #0x800000		@ 1 << 23
+	orr	\tmp, \tmp, #0x14	@ (1 << 4) + (1 << 2)
+	mov	\irqnr, #31
+	bics	\irqstat, \irqstat, \tmp
+
+	@ if no low interrupts set, check high interrupts
+	ldreq	\irqstat, [\base, #0x84]
+	moveq	\irqnr, #63
+	cmpeq	\irqstat, #0
+
+	@ find first active interrupt source
+	clzne	\irqstat, \irqstat
+	subne	\irqnr, \irqnr, \irqstat
+	.endm
+
diff --git a/arch/arm/mach-vt8500/include/mach/gpio.h b/arch/arm/mach-vt8500/include/mach/gpio.h
new file mode 100644
index 0000000..94ff276
--- /dev/null
+++ b/arch/arm/mach-vt8500/include/mach/gpio.h
@@ -0,0 +1,6 @@
+#include <asm-generic/gpio.h>
+
+#define gpio_get_value	__gpio_get_value
+#define gpio_set_value	__gpio_set_value
+#define gpio_cansleep	__gpio_cansleep
+#define gpio_to_irq	__gpio_to_irq
diff --git a/arch/arm/mach-vt8500/include/mach/hardware.h b/arch/arm/mach-vt8500/include/mach/hardware.h
new file mode 100644
index 0000000..db4163f
--- /dev/null
+++ b/arch/arm/mach-vt8500/include/mach/hardware.h
@@ -0,0 +1,12 @@
+/* arch/arm/mach-vt8500/include/mach/hardware.h
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
diff --git a/arch/arm/mach-vt8500/include/mach/io.h b/arch/arm/mach-vt8500/include/mach/io.h
new file mode 100644
index 0000000..dc2181a
--- /dev/null
+++ b/arch/arm/mach-vt8500/include/mach/io.h
@@ -0,0 +1,28 @@
+/*
+ *  arch/arm/mach-vt8500/include/mach/io.h
+ *
+ *  Copyright (C) 2003 ARM Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#ifndef __ASM_ARM_ARCH_IO_H
+#define __ASM_ARM_ARCH_IO_H
+
+#define IO_SPACE_LIMIT 0xffffffff
+
+#define __io(a)		__typesafe_io(a)
+#define __mem_pci(a)	(a)
+
+#endif
diff --git a/arch/arm/mach-vt8500/include/mach/irqs.h b/arch/arm/mach-vt8500/include/mach/irqs.h
new file mode 100644
index 0000000..4bfd673
--- /dev/null
+++ b/arch/arm/mach-vt8500/include/mach/irqs.h
@@ -0,0 +1,87 @@
+/*
+ *  arch/arm/mach-vt8500/include/mach/irqs.h
+ *
+ *  Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#define IRQ_JPEGENC	0	/* JPEG Encoder */
+#define IRQ_JPEGDEC	1	/* JPEG Decoder */
+				/* Reserved */
+#define IRQ_PATA	3	/* PATA Controller */
+				/* Reserved */
+#define IRQ_DMA		5	/* DMA Controller */
+#define IRQ_EXT0	6	/* External Interrupt 0 */
+#define IRQ_EXT1	7	/* External Interrupt 1 */
+#define IRQ_GRAPH	8	/* Graphic Engine */
+#define IRQ_GRAPH_OVER	9	/* Graphic Overlay Engine */
+#define IRQ_ETHER	10	/* Ethernet MAC */
+#define IRQ_MPEGTS	11	/* Transport Stream Interface */
+#define IRQ_LCDC	12	/* LCD Controller */
+#define IRQ_EXT2	13	/* External Interrupt 2 */
+#define IRQ_EXT3	14	/* External Interrupt 3 */
+#define IRQ_EXT4	15	/* External Interrupt 4 */
+#define IRQ_CIPHER	16	/* Cipher */
+#define IRQ_VPP		17	/* Video Post-Processor */
+#define IRQ_I2C1	18	/* I2C 1 */
+#define IRQ_I2C0	19	/* I2C 0 */
+#define IRQ_SDMMC	20	/* SD/MMC Controller */
+#define IRQ_SDMMC_DMA	21	/* SD/MMC Controller DMA */
+#define IRQ_PMC_WU	22	/* Power Management Controller Wakeup */
+				/* Reserved */
+#define IRQ_SPI0	24	/* SPI 0 */
+#define IRQ_SPI1	25	/* SPI 1 */
+#define IRQ_SPI2	26	/* SPI 2 */
+#define IRQ_LCDDF	27	/* LCD Data Formatter */
+#define IRQ_NAND	28	/* NAND Flash Controller */
+#define IRQ_NAND_DMA	29	/* NAND Flash Controller DMA */
+#define IRQ_MS		30	/* MemoryStick Controller */
+#define IRQ_MS_DMA	31	/* MemoryStick Controller DMA */
+#define IRQ_UART0	32	/* UART 0 */
+#define IRQ_UART1	33	/* UART 1 */
+#define IRQ_I2S		34	/* I2S */
+#define IRQ_PCM		35	/* PCM */
+#define IRQ_PMCOS0	36	/* PMC OS Timer 0 */
+#define IRQ_PMCOS1	37	/* PMC OS Timer 1 */
+#define IRQ_PMCOS2	38	/* PMC OS Timer 2 */
+#define IRQ_PMCOS3	39	/* PMC OS Timer 3 */
+#define IRQ_VPU		40	/* Video Processing Unit */
+#define IRQ_VDI		41	/* Video Digital Input Interface */
+#define IRQ_AC97	42	/* AC97 Interface */
+#define IRQ_USB		43	/* USB */
+#define IRQ_NOR		44	/* NOR Flash Controller */
+#define IRQ_PS2MOUSE	45	/* PS/2 Mouse */
+#define IRQ_PS2KBD	46	/* PS/2 Keyboard */
+#define IRQ_UART2	47	/* UART 2 */
+#define IRQ_RTC		48	/* RTC Interrupt */
+#define IRQ_RTCSM	49	/* RTC Second/Minute Update Interrupt */
+#define IRQ_UART3	50	/* UART 3 */
+#define IRQ_ADC		51	/* ADC */
+#define IRQ_EXT5	52	/* External Interrupt 5 */
+#define IRQ_EXT6	53	/* External Interrupt 6 */
+#define IRQ_EXT7	54	/* External Interrupt 7 */
+#define IRQ_CIR		55	/* CIR */
+#define IRQ_DMA0	56	/* DMA Channel 0 */
+#define IRQ_DMA1	57	/* DMA Channel 1 */
+#define IRQ_DMA2	58	/* DMA Channel 2 */
+#define IRQ_DMA3	59	/* DMA Channel 3 */
+#define IRQ_DMA4	60	/* DMA Channel 4 */
+#define IRQ_DMA5	61	/* DMA Channel 5 */
+#define IRQ_DMA6	62	/* DMA Channel 6 */
+#define IRQ_DMA7	63	/* DMA Channel 7 */
+
+
+#define NR_IRQS		64
diff --git a/arch/arm/mach-vt8500/include/mach/memory.h b/arch/arm/mach-vt8500/include/mach/memory.h
new file mode 100644
index 0000000..175f914
--- /dev/null
+++ b/arch/arm/mach-vt8500/include/mach/memory.h
@@ -0,0 +1,28 @@
+/*
+ *  arch/arm/mach-vt8500/include/mach/memory.h
+ *
+ *  Copyright (C) 2003 ARM Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#ifndef __ASM_ARCH_MEMORY_H
+#define __ASM_ARCH_MEMORY_H
+
+/*
+ * Physical DRAM offset.
+ */
+#define PHYS_OFFSET	UL(0x00000000)
+
+#endif
diff --git a/arch/arm/mach-vt8500/include/mach/system.h b/arch/arm/mach-vt8500/include/mach/system.h
new file mode 100644
index 0000000..f3fac00
--- /dev/null
+++ b/arch/arm/mach-vt8500/include/mach/system.h
@@ -0,0 +1,15 @@
+/*
+ * arch/arm/mach-vt8500/include/mach/system.h
+ *
+ */
+#include <mach/hardware.h>
+
+static inline void arch_idle(void)
+{
+	cpu_do_idle();
+}
+
+static inline void arch_reset(char mode, const char *cmd)
+{
+	cpu_reset(0);
+}
diff --git a/arch/arm/mach-vt8500/include/mach/timex.h b/arch/arm/mach-vt8500/include/mach/timex.h
new file mode 100644
index 0000000..8487e4c
--- /dev/null
+++ b/arch/arm/mach-vt8500/include/mach/timex.h
@@ -0,0 +1,26 @@
+/*
+ *  arch/arm/mach-vt8500/include/mach/timex.h
+ *
+ *  Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef MACH_TIMEX_H
+#define MACH_TIMEX_H
+
+#define CLOCK_TICK_RATE		(3000000)
+
+#endif /* MACH_TIMEX_H */
diff --git a/arch/arm/mach-vt8500/include/mach/uncompress.h b/arch/arm/mach-vt8500/include/mach/uncompress.h
new file mode 100644
index 0000000..e5d6436
--- /dev/null
+++ b/arch/arm/mach-vt8500/include/mach/uncompress.h
@@ -0,0 +1,37 @@
+/* arch/arm/mach-vt8500/include/mach/uncompress.h
+ *
+ * Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
+ *
+ * Based on arch/arm/mach-dove/include/mach/uncompress.h
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <mach/vt8500.h>
+#include <asm/io.h>
+
+static void putc(const char c)
+{
+	while (readb(VT8500_UART0_BASE + 0x1c) & 0x2)
+		/* Tx busy, wait and poll */;
+
+	writeb(c, VT8500_UART0_BASE);
+}
+
+static void flush(void)
+{
+}
+
+/*
+ * nothing to do
+ */
+#define arch_decomp_setup()
+#define arch_decomp_wdog()
diff --git a/arch/arm/mach-vt8500/include/mach/vmalloc.h b/arch/arm/mach-vt8500/include/mach/vmalloc.h
new file mode 100644
index 0000000..75a6912
--- /dev/null
+++ b/arch/arm/mach-vt8500/include/mach/vmalloc.h
@@ -0,0 +1,20 @@
+/*
+ *  arch/arm/mach-vt8500/include/mach/vmalloc.h
+ *
+ *  Copyright (C) 2000 Russell King.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#define VMALLOC_END		(PAGE_OFFSET + 0x10000000)
diff --git a/arch/arm/mach-vt8500/include/mach/vt8500.h b/arch/arm/mach-vt8500/include/mach/vt8500.h
new file mode 100644
index 0000000..4136626
--- /dev/null
+++ b/arch/arm/mach-vt8500/include/mach/vt8500.h
@@ -0,0 +1,159 @@
+/*
+ *  arch/arm/mach-vt8500/include/mach/vt8500.h
+ *
+ *  Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#ifndef __ASM_ARM_ARCH_VT8500_H
+#define __ASM_ARM_ARCH_VT8500_H
+
+#ifdef CONFIG_VTWM_VERSION_VT8500
+/* VT8500 Registers Map */
+
+#define VT8500_REGS_START_PHYS	0xd8000000	/* Start of MMIO registers */
+#define VT8500_REGS_START_VIRT	0xf8000000	/* Virtual mapping start */
+
+#define VT8500_DDR_BASE		0xd8000000	/* 1k	DDR/DDR2 Memory
+							Controller */
+#define VT8500_DMA_BASE		0xd8001000	/* 1k	DMA Controller */
+#define VT8500_SFLASH_BASE	0xd8002000	/* 1k	Serial Flash Memory
+							Controller */
+#define VT8500_ETHER_BASE	0xd8004000	/* 1k	Ethernet MAC 0 */
+#define VT8500_CIPHER_BASE	0xd8006000	/* 4k	Cipher */
+#define VT8500_USB_BASE		0xd8007800	/* 2k	USB OTG */
+#define VT8500_PATA_BASE	0xd8008000	/* 512	PATA */
+#define VT8500_PS2_BASE		0xd8008800	/* 1k	PS/2 */
+#define VT8500_NAND_BASE	0xd8009000	/* 1k	NAND Controller */
+#define VT8500_NOR_BASE		0xd8009400	/* 1k	NOR Controller */
+#define VT8500_SDMMC_BASE	0xd800a000	/* 1k	SD/MMC Controller */
+#define VT8500_MS_BASE		0xd800b000	/* 1k	MS/MSPRO Controller */
+#define VT8500_LCDC_BASE	0xd800e400	/* 1k	LCD Controller */
+#define VT8500_VPU_BASE		0xd8050000	/* 256	VPU */
+#define VT8500_GOV_BASE		0xd8050300	/* 256	GOV */
+#define VT8500_GEGEA_BASE	0xd8050400	/* 768	GE/GE Alpha Mixing */
+#define VT8500_LCDF_BASE	0xd8050900	/* 256	LCD Formatter */
+#define VT8500_VID_BASE		0xd8050a00	/* 256	VID */
+#define VT8500_VPP_BASE		0xd8050b00	/* 256	VPP */
+#define VT8500_TSBK_BASE	0xd80f4000	/* 4k	TSBK */
+#define VT8500_JPEGDEC_BASE	0xd80fe000	/* 4k	JPEG Decoder */
+#define VT8500_JPEGENC_BASE	0xd80ff000	/* 4k	JPEG Encoder */
+#define VT8500_RTC_BASE		0xd8100000	/* 64k	RTC */
+#define VT8500_GPIO_BASE	0xd8110000	/* 64k	GPIO Configuration */
+#define VT8500_SCC_BASE		0xd8120000	/* 64k	System Configuration*/
+#define VT8500_PMC_BASE		0xd8130000	/* 64k	PMC Configuration */
+#define VT8500_IC_BASE		0xd8140000	/* 64k	Interrupt Controller*/
+#define VT8500_UART0_BASE	0xd8200000	/* 64k	UART 0 */
+#define VT8500_UART2_BASE	0xd8210000	/* 64k	UART 2 */
+#define VT8500_PWM_BASE		0xd8220000	/* 64k	PWM Configuration */
+#define VT8500_SPI0_BASE	0xd8240000	/* 64k	SPI 0 */
+#define VT8500_SPI1_BASE	0xd8250000	/* 64k	SPI 1 */
+#define VT8500_CIR_BASE		0xd8270000	/* 64k	CIR */
+#define VT8500_I2C0_BASE	0xd8280000	/* 64k	I2C 0 */
+#define VT8500_AC97_BASE	0xd8290000	/* 64k	AC97 */
+#define VT8500_SPI2_BASE	0xd82a0000	/* 64k	SPI 2 */
+#define VT8500_UART1_BASE	0xd82b0000	/* 64k	UART 1 */
+#define VT8500_UART3_BASE	0xd82c0000	/* 64k	UART 3 */
+#define VT8500_PCM_BASE		0xd82d0000	/* 64k	PCM */
+#define VT8500_I2C1_BASE	0xd8320000	/* 64k	I2C 1 */
+#define VT8500_I2S_BASE		0xd8330000	/* 64k	I2S */
+#define VT8500_ADC_BASE		0xd8340000	/* 64k	ADC */
+
+#define VT8500_REGS_END_PHYS	0xd834ffff	/* End of MMIO registers */
+#define VT8500_REGS_LENGTH	(VT8500_REGS_END_PHYS \
+				- VT8500_REGS_START_PHYS + 1)
+
+#elif defined CONFIG_VTWM_VERSION_WM8505
+/* WM8505 Registers Map */
+/* To be confirmed! */
+
+#define VT8500_REGS_START_PHYS	0xd8000000	/* Start of MMIO registers */
+#define VT8500_REGS_START_VIRT	0xf8000000	/* Virtual mapping start */
+
+#define VT8500_DDR_BASE		0xd8000400	/* 1k	DDR/DDR2 Memory
+							Controller */
+#define VT8500_DMA_BASE		0xd8001800	/* 1k	DMA Controller */
+#define VT8500_VDMA_BASE	0xd8001c00	/* 1k	VDMA */
+#define VT8500_SFLASH_BASE	0xd8002000	/* 1k	Serial Flash Memory
+							Controller */
+#define VT8500_ETHER_BASE	0xd8004000	/* 1k	Ethernet MAC 0 */
+#define VT8500_CIPHER_BASE	0xd8006000	/* 4k	Cipher */
+#define VT8500_USB_BASE		0xd8007000	/* 2k	USB 2.0 Host */
+#define VT8500_PS2_BASE		0xd8008800	/* 1k	PS/2 */
+#define VT8500_NAND_BASE	0xd8009000	/* 1k	NAND Controller */
+#define VT8500_NOR_BASE		0xd8009400	/* 1k	NOR Controller */
+#define VT8500_SDMMC_BASE	0xd800a000	/* 1k	SD/MMC Controller */
+#define VT8500_LCDC_BASE	0xd800e400	/* 1k	LCD Controller */
+#define VT8500_VPU_BASE		0xd8050000	/* 256	VPU */
+#define VT8500_GOV_BASE		0xd8050300	/* 256	GOV */
+#define VT8500_GEGEA_BASE	0xd8050400	/* 768	GE/GE Alpha Mixing */
+#define VT8500_LCDF_BASE	0xd8050900	/* 256	LCD Formatter */
+#define VT8500_VID_BASE		0xd8050a00	/* 256	VID */
+#define VT8500_VPP_BASE		0xd8050b00	/* 256	VPP */
+#define VT8500_TSBK_BASE	0xd80f4000	/* 4k	TSBK */
+#define VT8500_JPEGDEC_BASE	0xd80fe000	/* 4k	JPEG Decoder */
+#define VT8500_JPEGENC_BASE	0xd80ff000	/* 4k	JPEG Encoder */
+#define VT8500_RTC_BASE		0xd8100000	/* 64k	RTC */
+#define VT8500_GPIO_BASE	0xd8110000	/* 64k	GPIO Configuration */
+#define VT8500_SCC_BASE		0xd8120000	/* 64k	System Configuration*/
+#define VT8500_PMC_BASE		0xd8130000	/* 64k	PMC Configuration */
+#define VT8500_IC_BASE		0xd8140000	/* 64k	Interrupt Controller*/
+#define VT8500_SIC_BASE		0xd8150000	/* 64k	Secondary IC */
+#define VT8500_UART0_BASE	0xd8200000	/* 64k	UART 0 */
+#define VT8500_UART2_BASE	0xd8210000	/* 64k	UART 2 */
+#define VT8500_PWM_BASE		0xd8220000	/* 64k	PWM Configuration */
+#define VT8500_SPI0_BASE	0xd8240000	/* 64k	SPI 0 */
+#define VT8500_SPI1_BASE	0xd8250000	/* 64k	SPI 1 */
+#define VT8500_CIR_BASE		0xd8270000	/* 64k	CIR */
+#define VT8500_I2C0_BASE	0xd8280000	/* 64k	I2C 0 */
+#define VT8500_AC97_BASE	0xd8290000	/* 64k	AC97 */
+#define VT8500_SPI2_BASE	0xd82a0000	/* 64k	SPI 2 */
+#define VT8500_UART1_BASE	0xd82b0000	/* 64k	UART 1 */
+#define VT8500_UART3_BASE	0xd82c0000	/* 64k	UART 3 */
+#define VT8500_PCM_BASE		0xd82d0000	/* 64k	PCM */
+#define VT8500_I2C1_BASE	0xd8320000	/* 64k	I2C 1 */
+#define VT8500_I2S_BASE		0xd8330000	/* 64k	I2S */
+#define VT8500_ADC_BASE		0xd8340000	/* 64k	ADC */
+#define VT8500_UART1_BASE	0xd8370000	/* 64k	UART 4 */
+#define VT8500_UART3_BASE	0xd8380000	/* 64k	UART 5 */
+
+#define VT8500_REGS_END_PHYS	0xd838ffff	/* End of MMIO registers */
+#define VT8500_REGS_LENGTH	(VT8500_REGS_END_PHYS \
+				- VT8500_REGS_START_PHYS + 1)
+
+#endif
+
+/*
+ * UART Register offsets
+ */
+
+#define VT8500_URTDR		0x0000	/* Transmit data */
+#define VT8500_URRDR		0x0004	/* Receive data */
+#define VT8500_URDIV		0x0008	/* Clock/Baud rate divisor */
+#define VT8500_URLCR		0x000C	/* Line control */
+#define VT8500_URICR		0x0010	/* IrDA control */
+#define VT8500_URIER		0x0014	/* Interrupt enable */
+#define VT8500_URISR		0x0018	/* Interrupt status */
+#define VT8500_URUSR		0x001c	/* UART status */
+#define VT8500_URFCR		0x0020	/* FIFO control */
+#define VT8500_URFIDX		0x0024	/* FIFO index */
+#define VT8500_URBKR		0x0028	/* Break signal count */
+#define VT8500_URTOD		0x002c	/* Time out divisor */
+#define VT8500_TXFIFO		0x1000	/* Transmit FIFO (16x8) */
+#define VT8500_RXFIFO		0x1020	/* Receive FIFO (16x10) */
+
+#define VT8500_UART_SIZE	0x1040
+
+#endif
diff --git a/arch/arm/mach-vt8500/irq.c b/arch/arm/mach-vt8500/irq.c
new file mode 100644
index 0000000..48c68e3
--- /dev/null
+++ b/arch/arm/mach-vt8500/irq.c
@@ -0,0 +1,127 @@
+/*
+ *  arch/arm/mach-vt8500/irq.c
+ *
+ *  Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+
+#include <asm/irq.h>
+
+#include <mach/hardware.h>
+#include <mach/irqs.h>
+#include <mach/vt8500.h>
+
+#define VT8500_IC_DCTR		0x40		/* Destination control
+						register, 64*u8 */
+#define VT8500_INT_ENABLE	(1 << 3)
+#define VT8500_TRIGGER_HIGH	(0 << 4)
+#define VT8500_TRIGGER_RISING	(1 << 4)
+#define VT8500_TRIGGER_FALLING	(2 << 4)
+#define VT8500_IC_STATUS	0x80		/* Interrupt status, 2*u32 */
+
+static void __iomem *ic_regbase = NULL;
+
+static void vt8500_irq_mask(unsigned int irq)
+{
+	u8 edge = readb(ic_regbase
+			+ VT8500_IC_DCTR + irq) & (3 << 4);
+	if (edge)
+		writel(readl(ic_regbase
+			+ VT8500_IC_STATUS + (irq < 32 ? 0 : 4))
+			| (1 << (irq & 0x1f)), ic_regbase
+			+ VT8500_IC_STATUS + (irq & 0x20 ? 4 : 0));
+	else
+		writeb(readb(ic_regbase
+			+ VT8500_IC_DCTR + irq) & ~VT8500_INT_ENABLE,
+			ic_regbase + VT8500_IC_DCTR + irq);
+}
+
+static void vt8500_irq_unmask(unsigned int irq)
+{
+	writeb(readb(ic_regbase
+		+ VT8500_IC_DCTR + irq) | VT8500_INT_ENABLE,
+		ic_regbase + VT8500_IC_DCTR + irq);
+}
+
+static int vt8500_irq_set_wake(unsigned int irq, unsigned int on)
+{
+	return -EINVAL;
+}
+
+static int vt8500_irq_set_type(unsigned int irq, unsigned int flow_type)
+{
+	switch (flow_type) {
+	case IRQF_TRIGGER_LOW:
+		return -EINVAL;
+	case IRQF_TRIGGER_HIGH:
+		writeb((readb(ic_regbase
+			+ VT8500_IC_DCTR + irq) & ~(3 << 4))
+			| VT8500_TRIGGER_HIGH, ic_regbase
+			+ VT8500_IC_DCTR + irq);
+		set_irq_handler(irq, handle_level_irq);
+		break;
+	case IRQF_TRIGGER_FALLING:
+		writeb((readb(ic_regbase
+			+ VT8500_IC_DCTR + irq) & ~(3 << 4))
+			| VT8500_TRIGGER_FALLING, ic_regbase
+			+ VT8500_IC_DCTR + irq);
+		set_irq_handler(irq, handle_edge_irq);
+		break;
+	case IRQF_TRIGGER_RISING:
+		writeb((readb(ic_regbase
+			+ VT8500_IC_DCTR + irq) & ~(3 << 4))
+			| VT8500_TRIGGER_RISING, ic_regbase
+			+ VT8500_IC_DCTR + irq);
+		set_irq_handler(irq, handle_edge_irq);
+		break;
+	}
+
+	return 0;
+}
+
+static struct irq_chip vt8500_irq_chip = {
+	.name      = "vt8500",
+	.ack       = vt8500_irq_mask,
+	.mask      = vt8500_irq_mask,
+	.unmask    = vt8500_irq_unmask,
+	.set_wake  = vt8500_irq_set_wake,
+	.set_type  = vt8500_irq_set_type,
+};
+
+void __init vt8500_init_irq(void)
+{
+	unsigned int i;
+
+	if (!ic_regbase)
+		ic_regbase = ioremap(VT8500_IC_BASE, SZ_64K);
+
+	/* Enable rotating priority for IRQ */
+	writel((1 << 6), ic_regbase + 0x20);
+	writel(0, ic_regbase + 0x24);
+
+	for (i = 0; i < NR_IRQS; i++) {
+		/* Disable all interrupts and route them to IRQ */
+		writeb(0x00, ic_regbase + VT8500_IC_DCTR + i);
+
+		set_irq_chip(i, &vt8500_irq_chip);
+		set_irq_handler(i, handle_level_irq);
+		set_irq_flags(i, IRQF_VALID);
+	}
+}
diff --git a/arch/arm/mach-vt8500/timer.c b/arch/arm/mach-vt8500/timer.c
new file mode 100644
index 0000000..01e8469
--- /dev/null
+++ b/arch/arm/mach-vt8500/timer.c
@@ -0,0 +1,192 @@
+/*
+ *  arch/arm/mach-vt8500/timer.c
+ *
+ *  Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/cnt32_to_63.h>
+
+#include <asm/mach/time.h>
+#include <asm/io.h>
+
+#include <mach/hardware.h>
+#include <mach/irqs.h>
+#include <mach/vt8500.h>
+
+#define VT8500_TIMER_OFFSET	0x0100
+#define TIMER_MATCH_VAL		0x0000
+#define TIMER_COUNT_VAL		0x0010
+#define TIMER_STATUS_VAL	0x0014
+#define TIMER_IER_VAL		0x001c		/* interrupt enable */
+#define TIMER_CTRL_VAL		0x0020
+#define TIMER_AS_VAL		0x0024		/* access status */
+#define TIMER_COUNT_R_ACTIVE	(1 << 5)	/* not ready for read */
+#define TIMER_COUNT_W_ACTIVE	(1 << 4)	/* not ready for write */
+#define TIMER_MATCH_W_ACTIVE	(1 << 0)	/* not ready for write */
+#define VT8500_TIMER_HZ		3000000
+
+static void __iomem *regbase = NULL;
+
+unsigned long long sched_clock(void)
+{
+	unsigned long long v;
+
+	if (!regbase)
+		regbase = ioremap(VT8500_PMC_BASE + VT8500_TIMER_OFFSET, 0x28);
+
+	writel(0x3, regbase + TIMER_CTRL_VAL);
+	while (readl(regbase + TIMER_AS_VAL) & TIMER_COUNT_R_ACTIVE)
+		/* wait and poll */;
+
+	v = cnt32_to_63(readl(regbase + TIMER_COUNT_VAL));
+
+	/* the <<1 gets rid of the cnt_32_to_63 top bit saving on a bic insn*/
+	v *= 1000 << 1;		/* 3MHz timer tick implies 333ns resolution */
+	do_div(v, 3 << 1);
+
+	return v;
+}
+
+static int vt8500_timer_set_next_event(unsigned long cycles,
+				    struct clock_event_device *evt)
+{
+	unsigned long now, alarm;
+	int late;
+
+	writel(3, regbase + TIMER_CTRL_VAL);
+	while (readl(regbase + TIMER_AS_VAL) & TIMER_COUNT_R_ACTIVE)
+		/* wait and poll */;
+	now = readl(regbase + TIMER_COUNT_VAL);
+	alarm = now + cycles;
+	while (readl(regbase + TIMER_AS_VAL) & TIMER_MATCH_W_ACTIVE)
+		/* wait and poll */;
+	writel(alarm, regbase + TIMER_MATCH_VAL);
+
+	writel(3, regbase + TIMER_CTRL_VAL);
+	while (readl(regbase + TIMER_AS_VAL) & TIMER_COUNT_R_ACTIVE)
+		/* wait and poll */;
+	now = readl(regbase + TIMER_COUNT_VAL);
+	late = now - alarm;
+	if (late >= (-2) && late < VT8500_TIMER_HZ*5)
+		return -ETIME;
+
+	writel(1, regbase + TIMER_IER_VAL);
+
+	return 0;
+}
+
+static void vt8500_timer_set_mode(enum clock_event_mode mode,
+			      struct clock_event_device *evt)
+{
+	switch (mode) {
+	case CLOCK_EVT_MODE_RESUME:
+	case CLOCK_EVT_MODE_PERIODIC:
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		writel(readl(regbase + TIMER_CTRL_VAL) | 1,
+			regbase + TIMER_CTRL_VAL);
+		writel(0, regbase + TIMER_IER_VAL);
+		break;
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+		writel(readl(regbase + TIMER_CTRL_VAL) & ~1,
+			regbase + TIMER_CTRL_VAL);
+		break;
+	}
+}
+
+struct clock_event_device clockevent = {
+	.name           = "vt8500_timer",
+	.features       = CLOCK_EVT_FEAT_ONESHOT,
+	.rating         = 200,
+	.set_next_event = vt8500_timer_set_next_event,
+	.set_mode       = vt8500_timer_set_mode,
+};
+
+static irqreturn_t vt8500_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+	evt->event_handler(evt);
+	writel(0xf, regbase + TIMER_STATUS_VAL);
+
+	return IRQ_HANDLED;
+}
+
+static cycle_t vt8500_timer_read(struct clocksource *cs)
+{
+	writel(3, regbase + TIMER_CTRL_VAL);
+	while (readl((regbase + TIMER_AS_VAL)) & TIMER_COUNT_R_ACTIVE)
+		/* wait and poll */;
+	return readl(regbase + TIMER_COUNT_VAL);
+}
+
+struct clocksource clocksource = {
+	.name           = "vt8500_timer",
+	.rating         = 200,
+	.read           = vt8500_timer_read,
+	.mask           = CLOCKSOURCE_MASK(32),
+	.flags          = CLOCK_SOURCE_IS_CONTINUOUS,
+};
+struct irqaction irq = {
+	.name    = "vt8500_timer",
+	.flags   = IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.handler = vt8500_timer_interrupt,
+	.dev_id  = &clockevent,
+};
+
+static void __init vt8500_timer_init(void)
+{
+	int res;
+
+	struct clock_event_device *ce = &clockevent;
+	struct clocksource *cs = &clocksource;
+
+	if (!regbase)
+		regbase = ioremap(VT8500_PMC_BASE + VT8500_TIMER_OFFSET, 0x28);
+	writel(1, regbase + TIMER_CTRL_VAL);
+	writel(0xf, regbase + TIMER_STATUS_VAL);
+	writel(~0, regbase + TIMER_MATCH_VAL);
+
+	clockevents_calc_mult_shift(ce, VT8500_TIMER_HZ, 4);
+	clocksource_calc_mult_shift(cs, VT8500_TIMER_HZ, 4);
+
+	/* copy-pasted from mach-msm; no idea */
+	ce->max_delta_ns =
+		clockevent_delta2ns(0xf0000000, ce);
+	ce->min_delta_ns = clockevent_delta2ns(4, ce);
+	ce->cpumask = cpumask_of(0);
+
+	res = clocksource_register(cs);
+	if (res)
+		printk(KERN_ERR "vt8500_timer_init: clocksource_register "
+			"failed for %s\n", cs->name);
+
+	res = setup_irq(IRQ_PMCOS0, &irq);
+
+	if (res)
+		printk(KERN_ERR "vt8500_timer_init: setup_irq "
+			"failed for %s\n", cs->name);
+	clockevents_register_device(ce);
+}
+
+struct sys_timer vt8500_timer = {
+	.init = vt8500_timer_init
+};
diff --git a/arch/arm/mach-vt8500/wm8505_7in.c b/arch/arm/mach-vt8500/wm8505_7in.c
new file mode 100644
index 0000000..5fef99a
--- /dev/null
+++ b/arch/arm/mach-vt8500/wm8505_7in.c
@@ -0,0 +1,44 @@
+/*
+ *  arch/arm/mach-vt8500/wm8505_7in.c
+ *
+ *  Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+#include <mach/vt8500.h>
+#include "devices.h"
+
+static struct platform_device *devices[] __initdata = {
+	&vt8500_device_uart0,
+};
+
+void __init wm8505_7in_init(void)
+{
+	platform_add_devices(devices, ARRAY_SIZE(devices));
+}
+
+MACHINE_START(WM8505_7IN_NETBOOK, "WM8505 7-inch generic netbook")
+	.phys_io	= VT8500_REGS_START_PHYS,
+	.io_pg_offst	= ((VT8500_REGS_START_VIRT) >> 18) & 0xfffc,
+	.boot_params	= 0x00000100,
+	.map_io		= vt8500_map_io,
+	.init_irq	= vt8500_init_irq,
+	.timer		= &vt8500_timer,
+	.init_machine	= wm8505_7in_init,
+MACHINE_END
