From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 15 May 2012 10:54:37 +0200
Subject: [PATCH 1/8] arm: mach-armada: add headers
In-Reply-To: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1337072084-21967-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

This patch adds basic header files for Armada SoCs.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Lior Amsalem <alior@marvell.com>
---
 arch/arm/mach-armada/include/mach/armada.h      |  234 +++++++++++++++++++++++
 arch/arm/mach-armada/include/mach/bridge-regs.h |   28 +++
 arch/arm/mach-armada/include/mach/debug-macro.S |   23 +++
 arch/arm/mach-armada/include/mach/gpio.h        |   13 ++
 arch/arm/mach-armada/include/mach/hardware.h    |   18 ++
 arch/arm/mach-armada/include/mach/io.h          |   24 +++
 arch/arm/mach-armada/include/mach/irqs.h        |   96 ++++++++++
 arch/arm/mach-armada/include/mach/system.h      |   21 ++
 arch/arm/mach-armada/include/mach/timex.h       |   13 ++
 arch/arm/mach-armada/include/mach/uncompress.h  |   41 ++++
 10 files changed, 511 insertions(+)
 create mode 100644 arch/arm/mach-armada/include/mach/armada.h
 create mode 100644 arch/arm/mach-armada/include/mach/bridge-regs.h
 create mode 100644 arch/arm/mach-armada/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-armada/include/mach/gpio.h
 create mode 100644 arch/arm/mach-armada/include/mach/hardware.h
 create mode 100644 arch/arm/mach-armada/include/mach/io.h
 create mode 100644 arch/arm/mach-armada/include/mach/irqs.h
 create mode 100644 arch/arm/mach-armada/include/mach/system.h
 create mode 100644 arch/arm/mach-armada/include/mach/timex.h
 create mode 100644 arch/arm/mach-armada/include/mach/uncompress.h

diff --git a/arch/arm/mach-armada/include/mach/armada.h b/arch/arm/mach-armada/include/mach/armada.h
new file mode 100644
index 0000000..be12667
--- /dev/null
+++ b/arch/arm/mach-armada/include/mach/armada.h
@@ -0,0 +1,234 @@
+/*
+ * Generic definitions for Marvell Armada SoCs
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_ARMADA_H
+#define __MACH_ARMADA_H
+
+/*
+ * Marvell ARMADA address maps.
+ *
+ * phys		virt		size
+ * d0000000	feb00000	1M	internal registers
+ * d0100000	@runtime	1M	uart
+ * d0200000	fec00000	1M	PCIe-0 I/O (port 0.0)
+ * d0300000	fed00000	1M	PCIe-1 I/O (port 1.0)
+ * d0400000	fee00000	1M	PCIe-2 I/O (port 2.0)
+ * d0500000	fef00000	1M	PCIe-3 I/O (port 3.0)
+ * d0600000	@runtime	1M	cryptographic sram-0
+ * d0700000	@runtime	1M	cryptographic sram-1
+ * d0800000	reserved	8M	reserved for future
+ * d1000000	@runtime	16M	device bus cs-0
+ * d2000000	@runtime	16M	device bus cs-0
+ * d3000000	@runtime	16M	device bus cs-0
+ * d4000000	@runtime	16M	device bus cs-0
+ * d5000000	@runtime	16M	device bus boot cs
+ * d6000000	@runtime	16M	spi-0 flash
+ * d7000000	@runtime	16M	spi-1 flash
+ * d8000000	@runtime	64M	PCIe-0 Memory (port 0.0)
+ * dc000000	@runtime	64M	PCIe-1 Memory (port 1.0)
+ * e0000000	@runtime	64M	PCIe-2 Memory (port 2.0)
+ * e4000000	@runtime	64M	PCIe-3 Memory (port 3.0)
+ * fff00000	@runtime	1M	internal bootrom
+ */
+
+#define ARMADA_REGS_PHYS_BASE		0xd0000000
+#define ARMADA_REGS_VIRT_BASE		0xfeb00000
+#define ARMADA_REGS_SIZE		SZ_1M
+
+#define ARMADA_UART_REGS_BASE		0xd0100000
+#define ARMADA_UART_SIZE		_1M
+
+#define ARMADA_PCIE0_IO_PHYS_BASE	0xd0200000
+#define ARMADA_PCIE0_IO_VIRT_BASE	0xfec00000
+#define ARMADA_PCIE0_IO_BUS_BASE	0x00100000
+#define ARMADA_PCIE0_IO_SIZE		SZ_1M
+
+#define ARMADA_PCIE1_IO_PHYS_BASE	0xd0300000
+#define ARMADA_PCIE1_IO_VIRT_BASE	0xfed00000
+#define ARMADA_PCIE1_IO_BUS_BASE	0x00200000
+#define ARMADA_PCIE1_IO_SIZE		SZ_1M
+
+#define ARMADA_PCIE2_IO_PHYS_BASE	0xd0400000
+#define ARMADA_PCIE2_IO_VIRT_BASE	0xfee00000
+#define ARMADA_PCIE2_IO_BUS_BASE	0x00300000
+#define ARMADA_PCIE2_IO_SIZE		SZ_1M
+
+#define ARMADA_PCIE3_IO_PHYS_BASE	0xd0500000
+#define ARMADA_PCIE3_IO_VIRT_BASE	0xfef00000
+#define ARMADA_PCIE3_IO_BUS_BASE	0x00400000
+#define ARMADA_PCIE3_IO_SIZE		SZ_1M
+
+#define ARMADA_CESA0_PHYS_BASE		0xd0600000
+#define ARMADA_CESA0_SIZE		SZ_1M
+
+#define ARMADA_CESA1_PHYS_BASE		0xd0700000
+#define ARMADA_CESA1_SIZE		SZ_1M
+
+#define ARMADA_DEVICE_CS0_PHYS_BASE	0xd1000000
+#define ARMADA_DEVICE_CS0_SIZE		SZ_16M
+
+#define ARMADA_DEVICE_CS1_PHYS_BASE	0xd2000000
+#define ARMADA_DEVICE_CS1_SIZE		SZ_16M
+
+#define ARMADA_DEVICE_CS2_PHYS_BASE	0xd3000000
+#define ARMADA_DEVICE_CS2_SIZE		SZ_16M
+
+#define ARMADA_DEVICE_CS3_PHYS_BASE	0xd4000000
+#define ARMADA_DEVICE_CS3_SIZE		SZ_16M
+
+#define ARMADA_DEVICE_BOOT_CS_PHYS_BASE	0xd5000000
+#define ARMADA_DEVICE_BOOT_CS_SIZE	SZ_16M
+
+#define ARMADA_SPI0_CS0_PHYS_BASE	0xd6000000
+#define ARMADA_SPI0_CS0_SIZE		SZ_16M
+
+#define ARMADA_SPI1_CS0_PHYS_BASE	0xd7000000
+#define ARMADA_SPI1_CS0_SIZE		SZ_16M
+
+#define ARMADA_PCIE0_MEM_PHYS_BASE	0xd8000000
+#define ARMADA_PCIE0_MEM_SIZE		SZ_64M
+
+#define ARMADA_PCIE1_MEM_PHYS_BASE	0xdc000000
+#define ARMADA_PCIE1_MEM_SIZE		SZ_64M
+
+#define ARMADA_PCIE2_MEM_PHYS_BASE	0xe0000000
+#define ARMADA_PCIE2_MEM_SIZE		SZ_64M
+
+#define ARMADA_PCIE3_MEM_PHYS_BASE	0xe4000000
+#define ARMADA_PCIE3_MEM_SIZE		SZ_64M
+
+#define ARMADA_BOOTROM_PHYS_BASE	0xFFF00000
+#define ARMADA_BOOTROM_SIZE		SZ_1M
+
+/*
+ * Core Registers Map
+ */
+
+/* DRAM */
+#define ARMADA_DRAM_PHYS_BASE     (ARMADA_REGS_PHYS_BASE | 0x0)
+#define ARMADA_DRAM_VIRT_BASE     (ARMADA_REGS_VIRT_BASE | 0x0)
+
+/* L2 Cache */
+#define ARMADA_L2_CACHE_PHYS_BASE (ARMADA_REGS_PHYS_BASE | 0x8000)
+#define ARMADA_L2_CACHE_VIRT_BASE (ARMADA_REGS_VIRT_BASE | 0x8000)
+
+/* RTC */
+#define ARMADA_RTC_PHYS_BASE      (ARMADA_REGS_PHYS_BASE | 0x10300)
+#define ARMADA_RTC_VIRT_BASE      (ARMADA_REGS_VIRT_BASE | 0x10300)
+
+/* SPI */
+#define ARMADA_SPI0_PHYS_BASE	(ARMADA_REGS_PHYS_BASE | 0x10600)
+#define ARMADA_SPI0_VIRT_BASE	(ARMADA_REGS_VIRT_BASE | 0x10600)
+#define ARMADA_SPI1_PHYS_BASE	(ARMADA_REGS_PHYS_BASE | 0x10680)
+#define ARMADA_SPI1_VIRT_BASE	(ARMADA_REGS_VIRT_BASE | 0x10680)
+
+/* I2C */
+#define ARMADA_I2C0_PHYS_BASE	(ARMADA_REGS_PHYS_BASE | 0x11000)
+#define ARMADA_I2C0_VIRT_BASE     (ARMADA_REGS_VIRT_BASE | 0x11000)
+#define ARMADA_I2C1_PHYS_BASE	(ARMADA_REGS_PHYS_BASE | 0x11100)
+#define ARMADA_I2C1_VIRT_BASE	(ARMADA_REGS_PHYS_BASE | 0x11100)
+
+/* UART */
+#define ARMADA_UART0_PHYS_BASE	(ARMADA_REGS_PHYS_BASE | 0x12000)
+#define ARMADA_UART0_VIRT_BASE	(ARMADA_REGS_VIRT_BASE | 0x12000)
+#define ARMADA_UART1_PHYS_BASE	(ARMADA_REGS_PHYS_BASE | 0x12100)
+#define ARMADA_UART1_VIRT_BASE	(ARMADA_REGS_VIRT_BASE | 0x12100)
+
+/* MPP (pin muxing) */
+#define ARMADA_MPP_PHYS_BASE      (ARMADA_REGS_PHYS_BASE | 0x18000)
+#define ARMADA_MPP_VIRT_BASE      (ARMADA_REGS_VIRT_BASE | 0x18000)
+
+/* GPIO */
+#define ARMADA_GPIO_PHYS_BASE     (ARMADA_REGS_PHYS_BASE | 0x18100)
+#define ARMADA_GPIO_VIRT_BASE     (ARMADA_REGS_VIRT_BASE | 0x18100)
+
+/* Misc registers */
+#define ARMADA_SYSTEM_PHYS_BASE     (ARMADA_REGS_PHYS_BASE | 0x18200)
+#define ARMADA_SYSTEM_VIRT_BASE     (ARMADA_REGS_VIRT_BASE | 0x18200)
+
+/* CPU */
+#define ARMADA_CPU_PHYS_BASE      (ARMADA_REGS_PHYS_BASE | 0x20000)
+#define ARMADA_CPU_VIRT_BASE      (ARMADA_REGS_VIRT_BASE | 0x20000)
+
+/* Audio */
+#define ARMADA_AUDIO_PHYS_BASE    (ARMADA_REGS_PHYS_BASE | 0x30000)
+#define ARMADA_AUDIO_VIRT_BASE    (ARMADA_REGS_VIRT_BASE | 0x30000)
+
+/* PCIe */
+#define ARMADA_PCIE0_PHYS_BASE	(ARMADA_REGS_PHYS_BASE | 0x40000)
+#define ARMADA_PCIE0_VIRT_BASE	(ARMADA_REGS_VIRT_BASE | 0x40000)
+#define ARMADA_PCIE1_PHYS_BASE	(ARMADA_REGS_PHYS_BASE | 0x80000)
+#define ARMADA_PCIE1_VIRT_BASE	(ARMADA_REGS_VIRT_BASE | 0x80000)
+#define ARMADA_PCIE2_PHYS_BASE	(ARMADA_REGS_PHYS_BASE | 0x42000)
+#define ARMADA_PCIE2_VIRT_BASE	(ARMADA_REGS_VIRT_BASE | 0x42000)
+#define ARMADA_PCIE3_PHYS_BASE	(ARMADA_REGS_PHYS_BASE | 0x82000)
+#define ARMADA_PCIE3_VIRT_BASE	(ARMADA_REGS_VIRT_BASE | 0x82000)
+
+/* USB */
+#define ARMADA_USB0_PHYS_BASE	(ARMADA_REGS_PHYS_BASE | 0x50000)
+#define ARMADA_USB0_VIRT_BASE	(ARMADA_REGS_VIRT_BASE | 0x50000)
+#define ARMADA_USB1_PHYS_BASE	(ARMADA_REGS_PHYS_BASE | 0x51000)
+#define ARMADA_USB1_VIRT_BASE	(ARMADA_REGS_VIRT_BASE | 0x51000)
+
+/* XOR Engines */
+#define ARMADA_XOR0_PHYS_BASE        (ARMADA_REGS_PHYS_BASE | 0x60900)
+#define ARMADA_XOR0_HIGH_PHYS_BASE   (ARMADA_REGS_PHYS_BASE | 0x60B00)
+#define ARMADA_XOR1_PHYS_BASE        (ARMADA_REGS_PHYS_BASE | 0xF0900)
+#define ARMADA_XOR1_HIGH_PHYS_BASE   (ARMADA_REGS_PHYS_BASE | 0xF0B00)
+
+/* Cryptographic Engine */
+#define ARMADA_CRYPT_PHYS_BASE	(ARMADA_REGS_PHYS_BASE | 0x30000)
+
+/* Gigabit Ethernet */
+#define ARMADA_GE00_PHYS_BASE	(ARMADA_REGS_PHYS_BASE | 0x70000)
+#define ARMADA_GE01_PHYS_BASE	(ARMADA_REGS_PHYS_BASE | 0x74000)
+#define ARMADA_GE10_PHYS_BASE	(ARMADA_REGS_PHYS_BASE | 0x30000)
+#define ARMADA_GE11_PHYS_BASE	(ARMADA_REGS_PHYS_BASE | 0x34000)
+
+/* SDIO */
+#define ARMADA_SDIO0_PHYS_BASE	(ARMADA_REGS_PHYS_BASE | 0x92000)
+
+/* SATA */
+#define ARMADA_SATA_PHYS_BASE	(ARMADA_REGS_PHYS_BASE | 0xa0000)
+
+/* NAND Flash Controller */
+#define ARMADA_NFC_PHYS_BASE	(ARMADA_REGS_PHYS_BASE | 0xd0000)
+
+/* MPP, GPIO, Reset Sampling */
+#define ARMADA_MPP_VIRT_BASE	(ARMADA_REGS_VIRT_BASE | 0x18000)
+#define ARMADA_GPIO0_VIRT_BASE	(ARMADA_REGS_VIRT_BASE | 0x18100)
+#define ARMADA_GPIO1_VIRT_BASE	(ARMADA_REGS_VIRT_BASE | 0x18140)
+#define ARMADA_GPIO2_VIRT_BASE	(ARMADA_REGS_VIRT_BASE | 0x18180)
+
+/* Power Management */
+#define ARMADA_PMU_VIRT_BASE	(ARMADA_REGS_VIRT_BASE | 0x1c000)
+
+/* Real Time Clock */
+#define ARMADA_RTC_PHYS_BASE	(ARMADA_REGS_PHYS_BASE | 0x10300)
+
+/* Memory Controller */
+#define ARMADA_MC_VIRT_BASE	(ARMADA_REGS_VIRT_BASE | 0x20180)
+
+/* Timers */
+#define ARMADA_TIMER_VIRT_BASE		(ARMADA_CPU_VIRT_BASE | 0x0300)
+#define  ARMADA_TIMERS_INT_TIMER1_CLR	(~0x0100)
+#define TIMER_VIRT_BASE                 ARMADA_TIMER_VIRT_BASE
+
+/* Main Interrupt Controller Control and Configuration */
+#define ARMADA_MAIN_INT_CNTL_BASE  (ARMADA_CPU_VIRT_BASE | 0x0)
+
+/* Per CPU Interrupt Controller Control and Configuration */
+#define ARMADA_PER_CPU_INT_CNTL_BASE  (ARMADA_CPU_VIRT_BASE | 0x1000)
+
+#endif /* __MACH_ARMADA_H */
diff --git a/arch/arm/mach-armada/include/mach/bridge-regs.h b/arch/arm/mach-armada/include/mach/bridge-regs.h
new file mode 100644
index 0000000..0eaefbd
--- /dev/null
+++ b/arch/arm/mach-armada/include/mach/bridge-regs.h
@@ -0,0 +1,28 @@
+/*
+ * Mbus-L to Mbus Bridge Registers
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __ASM_ARCH_BRIDGE_REGS_H
+#define __ASM_ARCH_BRIDGE_REGS_H
+
+#include <mach/armada.h>
+
+#define RSTOUTn_MASK		(ARMADA_SYSTEM_VIRT_BASE | 0x60)
+#define  SOFT_RESET_OUT_EN	0x00000001
+
+#define SYSTEM_SOFT_RESET	(ARMADA_SYSTEM_VIRT_BASE | 0x64)
+#define  SOFT_RESET		0x00000001
+
+#define SOC_ID                  (ARMADA_MISC_VIRT_BASE | 0x3C)
+
+#endif
diff --git a/arch/arm/mach-armada/include/mach/debug-macro.S b/arch/arm/mach-armada/include/mach/debug-macro.S
new file mode 100644
index 0000000..1c7c52f
--- /dev/null
+++ b/arch/arm/mach-armada/include/mach/debug-macro.S
@@ -0,0 +1,23 @@
+/*
+ * Early serial output macro for Marvell Armada SoC
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <mach/armada.h>
+
+	.macro	addruart, rp, rv, tmp
+	ldr	\rp, =ARMADA_REGS_PHYS_BASE
+	ldr	\rv, =ARMADA_REGS_VIRT_BASE
+	orr	\rp, \rp, #0x00012000
+	orr	\rv, \rv, #0x00012000
+	.endm
+
+#define UART_SHIFT	2
+#include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-armada/include/mach/gpio.h b/arch/arm/mach-armada/include/mach/gpio.h
new file mode 100644
index 0000000..e62f38a
--- /dev/null
+++ b/arch/arm/mach-armada/include/mach/gpio.h
@@ -0,0 +1,13 @@
+/*
+ * Marvell Armada SoC GPIO definitions
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <plat/gpio.h>
diff --git a/arch/arm/mach-armada/include/mach/hardware.h b/arch/arm/mach-armada/include/mach/hardware.h
new file mode 100644
index 0000000..829111b
--- /dev/null
+++ b/arch/arm/mach-armada/include/mach/hardware.h
@@ -0,0 +1,18 @@
+/*
+ * Marvell Armada SoC hardware definitions
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __ASM_ARCH_HARDWARE_H
+#define __ASM_ARCH_HARDWARE_H
+
+#include <mach/armada.h>
+
+#endif
diff --git a/arch/arm/mach-armada/include/mach/io.h b/arch/arm/mach-armada/include/mach/io.h
new file mode 100644
index 0000000..48716c1
--- /dev/null
+++ b/arch/arm/mach-armada/include/mach/io.h
@@ -0,0 +1,24 @@
+/*
+ * Basic I/O macros
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __ASM_ARCH_IO_H
+#define __ASM_ARCH_IO_H
+
+#include <mach/armada.h>
+
+#define IO_SPACE_LIMIT		0xffffffff
+
+#define __io(a)		((void __iomem *)(((a) - ARMADA_PCIE0_IO_BUS_BASE) + \
+						 ARMADA_PCIE0_IO_VIRT_BASE))
+#define __mem_pci(a)	(a)
+
+#endif
diff --git a/arch/arm/mach-armada/include/mach/irqs.h b/arch/arm/mach-armada/include/mach/irqs.h
new file mode 100644
index 0000000..48844a4
--- /dev/null
+++ b/arch/arm/mach-armada/include/mach/irqs.h
@@ -0,0 +1,96 @@
+/*
+ * IRQ definitions for Marvell Armada SoC
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __ASM_ARCH_IRQS_H
+#define __ASM_ARCH_IRQS_H
+
+/*
+ * Per-cpu Interrupts
+ */
+#define IRQ_ARMADA_DRBL_LOW	0
+#define IRQ_ARMADA_DRBL_HI	1
+#define IRQ_ARMADA_DRBL_SUM	2
+#define IRQ_ARMADA_FABRIC	3
+#define IRQ_ARMADA_SOC_ERR	4
+#define IRQ_ARMADA_LCL_TIMER0	5
+#define IRQ_ARMADA_LCL_TIMER1	6
+#define IRQ_ARMADA_LCL_WD	7
+#define IRQ_ARMADA_GE0_TH_RXTX	8
+#define IRQ_ARMADA_GE0_RXTX	9
+#define IRQ_ARMADA_GE1_TH_RXTX	10
+#define IRQ_ARMADA_GE1_RXTX	11
+#define IRQ_ARMADA_GE2_TH_RXTX	12
+#define IRQ_ARMADA_GE2_RXTX	13
+#define IRQ_ARMADA_GE3_TH_RXTX	14
+#define IRQ_ARMADA_GE3_RXTX	15
+
+/*
+ * Global interrupts
+ */
+#define IRQ_ARMADA_LCD		29
+#define IRQ_ARMADA_SPI0		30
+#define IRQ_ARMADA_I2C0		31
+#define IRQ_ARMADA_I2C1		32
+#define IRQ_ARMADA_GLBL_TIMER0	37
+#define IRQ_ARMADA_GLBL_TIMER1	38
+#define IRQ_ARMADA_GLBL_TIMER2	39
+#define IRQ_ARMADA_GLBL_TIMER3	40
+#define IRQ_ARMADA_UART0	41
+#define IRQ_ARMADA_UART1	42
+#define IRQ_ARMADA_UART2	43
+#define IRQ_ARMADA_UART3	44
+#define IRQ_ARMADA_USB0		45
+#define IRQ_ARMADA_USB1		46
+#define IRQ_ARMADA_USB2		47
+#define IRQ_ARMADA_CESA0	48
+#define IRQ_ARMADA_CESA1	49
+#define IRQ_ARMADA_RTC		50
+#define IRQ_ARMADA_XOR0_CH0	51
+#define IRQ_ARMADA_XOR0_CH1	52
+#define IRQ_ARMADA_SDIO		54
+#define IRQ_ARMADA_SATA0	55
+#define IRQ_ARMADA_TDM		56
+#define IRQ_ARMADA_SATA1	57
+#define IRQ_ARMADA_PCIE0	61
+#define IRQ_ARMADA_PCIE1	62
+#define IRQ_ARMADA_GPIO_0_7	82
+#define IRQ_ARMADA_GPIO_8_15	83
+#define IRQ_ARMADA_GPIO_16_23	84
+#define IRQ_ARMADA_GPIO_24_31	85
+#define IRQ_ARMADA_GPIO_32_39	87
+#define IRQ_ARMADA_GPIO_40_47	88
+#define IRQ_ARMADA_GPIO_48_55	89
+#define IRQ_ARMADA_GPIO_56_63	90
+#define IRQ_ARMADA_GPIO_64_66	91
+#define IRQ_ARMADA_SPI1		92
+#define IRQ_ARMADA_WD		93
+#define IRQ_ARMADA_XOR1_CH0	94
+#define IRQ_ARMADA_XOR1_CH1	95
+#define IRQ_ARMADA_PCIE2	99
+#define IRQ_ARMADA_PCIE3	103
+#define IRQ_ARMADA_DRAM		108
+#define IRQ_ARMADA_GE0_WKUP	109
+#define IRQ_ARMADA_GE1_WKUP	110
+#define IRQ_ARMADA_GE2_WKUP	111
+#define IRQ_ARMADA_GE3_WKUP	112
+#define IRQ_ARMADA_NFC		113
+
+/*
+ * ARMADA General Purpose Pins
+ */
+#define IRQ_ARMADA_GPIO_START	82
+#define NR_GPIO_IRQS		64
+
+#define NR_IRQS			(115)
+
+
+#endif
diff --git a/arch/arm/mach-armada/include/mach/system.h b/arch/arm/mach-armada/include/mach/system.h
new file mode 100644
index 0000000..f920ef0
--- /dev/null
+++ b/arch/arm/mach-armada/include/mach/system.h
@@ -0,0 +1,21 @@
+/*
+ * Marvell Armada SoC system defines
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __ASM_ARCH_SYSTEM_H
+#define __ASM_ARCH_SYSTEM_H
+
+static inline void arch_idle(void)
+{
+	cpu_do_idle();
+}
+
+#endif
diff --git a/arch/arm/mach-armada/include/mach/timex.h b/arch/arm/mach-armada/include/mach/timex.h
new file mode 100644
index 0000000..ab324a3
--- /dev/null
+++ b/arch/arm/mach-armada/include/mach/timex.h
@@ -0,0 +1,13 @@
+/*
+ * Marvell Armada SoC time definitions
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#define CLOCK_TICK_RATE		(100 * HZ)
diff --git a/arch/arm/mach-armada/include/mach/uncompress.h b/arch/arm/mach-armada/include/mach/uncompress.h
new file mode 100644
index 0000000..611ebf3
--- /dev/null
+++ b/arch/arm/mach-armada/include/mach/uncompress.h
@@ -0,0 +1,41 @@
+/*
+ * Marvell Armada SoC kernel uncompression UART routines
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <mach/armada.h>
+
+#define UART_THR ((volatile unsigned char *)(ARMADA_UART0_PHYS_BASE + 0x0))
+#define UART_LSR ((volatile unsigned char *)(ARMADA_UART0_PHYS_BASE + 0x14))
+
+#define LSR_THRE	0x20
+
+static void putc(const char c)
+{
+	int i;
+
+	for (i = 0; i < 0x1000; i++) {
+		/* Transmit fifo not full? */
+		if (*UART_LSR & LSR_THRE)
+			break;
+	}
+
+	*UART_THR = c;
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
-- 
1.7.9.5
