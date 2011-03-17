From: ithamar.adema@team-embedded.nl (Ithamar R. Adema)
Date: Thu, 17 Mar 2011 16:54:16 +0100
Subject: [PATCH 1/9] lpc2k: Core support
In-Reply-To: <1300377264-10843-1-git-send-email-ithamar.adema@team-embedded.nl>
References: <1300377264-10843-1-git-send-email-ithamar.adema@team-embedded.nl>
Message-ID: <1300377264-10843-2-git-send-email-ithamar.adema@team-embedded.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Core files (including IRQ handling) for NXP LPC2K architecture.

Signed-off-by: Ithamar R. Adema <ithamar.adema@team-embedded.nl>
---
 arch/arm/Kconfig                               |   14 +++++++
 arch/arm/Makefile                              |    1 +
 arch/arm/mach-lpc2k/Kconfig                    |    5 ++
 arch/arm/mach-lpc2k/Makefile                   |    1 +
 arch/arm/mach-lpc2k/Makefile.boot              |    3 +
 arch/arm/mach-lpc2k/include/mach/debug-macro.S |   19 +++++++++
 arch/arm/mach-lpc2k/include/mach/entry-macro.S |   33 ++++++++++++++++
 arch/arm/mach-lpc2k/include/mach/hardware.h    |   23 +++++++++++
 arch/arm/mach-lpc2k/include/mach/io.h          |   18 ++++++++
 arch/arm/mach-lpc2k/include/mach/irqs.h        |   49 +++++++++++++++++++++++
 arch/arm/mach-lpc2k/include/mach/memory.h      |   15 +++++++
 arch/arm/mach-lpc2k/include/mach/system.h      |   23 +++++++++++
 arch/arm/mach-lpc2k/include/mach/timex.h       |   15 +++++++
 arch/arm/mach-lpc2k/include/mach/uncompress.h  |   50 ++++++++++++++++++++++++
 arch/arm/mach-lpc2k/irq.c                      |   17 ++++++++
 15 files changed, 286 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-lpc2k/Kconfig
 create mode 100644 arch/arm/mach-lpc2k/Makefile
 create mode 100644 arch/arm/mach-lpc2k/Makefile.boot
 create mode 100644 arch/arm/mach-lpc2k/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-lpc2k/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-lpc2k/include/mach/hardware.h
 create mode 100644 arch/arm/mach-lpc2k/include/mach/io.h
 create mode 100644 arch/arm/mach-lpc2k/include/mach/irqs.h
 create mode 100644 arch/arm/mach-lpc2k/include/mach/memory.h
 create mode 100644 arch/arm/mach-lpc2k/include/mach/system.h
 create mode 100644 arch/arm/mach-lpc2k/include/mach/timex.h
 create mode 100644 arch/arm/mach-lpc2k/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-lpc2k/irq.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e34bf02..331540d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -490,6 +490,18 @@ config ARCH_LOKI
 	help
 	  Support for the Marvell Loki (88RC8480) SoC.
 
+config ARCH_LPC2K
+	bool "NXP LPC2K Family"
+	depends on !MMU
+	select CPU_ARM7TDMI
+	select ARM_VIC
+	select GENERIC_TIME
+	select GENERIC_CLOCKEVENTS
+	help
+	  Support for NXP LPC2K family of SoCs. These SoCs are based on
+	  an ARM7TDMI-S core, and have optional on-chip flash and SRAM,
+	  also UART, I2C, SPI, SSP, CAN, RTC, and other peripherals.
+
 config ARCH_LPC32XX
 	bool "NXP LPC32XX"
 	select CPU_ARM926T
@@ -928,6 +940,8 @@ source "arch/arm/mach-ks8695/Kconfig"
 
 source "arch/arm/mach-loki/Kconfig"
 
+source "arch/arm/mach-lpc2k/Kconfig"
+
 source "arch/arm/mach-lpc32xx/Kconfig"
 
 source "arch/arm/mach-msm/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 5c7114b..601f52a 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -151,6 +151,7 @@ machine-$(CONFIG_ARCH_IXP4XX)		:= ixp4xx
 machine-$(CONFIG_ARCH_KIRKWOOD)		:= kirkwood
 machine-$(CONFIG_ARCH_KS8695)		:= ks8695
 machine-$(CONFIG_ARCH_LOKI) 		:= loki
+machine-$(CONFIG_ARCH_LPC2K)		:= lpc2k
 machine-$(CONFIG_ARCH_LPC32XX)		:= lpc32xx
 machine-$(CONFIG_ARCH_MMP)		:= mmp
 machine-$(CONFIG_ARCH_MSM)		:= msm
diff --git a/arch/arm/mach-lpc2k/Kconfig b/arch/arm/mach-lpc2k/Kconfig
new file mode 100644
index 0000000..fad47b8
--- /dev/null
+++ b/arch/arm/mach-lpc2k/Kconfig
@@ -0,0 +1,5 @@
+if ARCH_LPC2K
+
+comment "LPC2K machines"
+
+endif
diff --git a/arch/arm/mach-lpc2k/Makefile b/arch/arm/mach-lpc2k/Makefile
new file mode 100644
index 0000000..546666b
--- /dev/null
+++ b/arch/arm/mach-lpc2k/Makefile
@@ -0,0 +1 @@
+obj-y	:= irq.o
diff --git a/arch/arm/mach-lpc2k/Makefile.boot b/arch/arm/mach-lpc2k/Makefile.boot
new file mode 100644
index 0000000..8b6b745
--- /dev/null
+++ b/arch/arm/mach-lpc2k/Makefile.boot
@@ -0,0 +1,3 @@
+   zreladdr-y	:= 0xa0008000
+params_phys-y	:= 0xa0000100
+initrd_phys-y	:= 0xa1800000
diff --git a/arch/arm/mach-lpc2k/include/mach/debug-macro.S b/arch/arm/mach-lpc2k/include/mach/debug-macro.S
new file mode 100644
index 0000000..0f581d3
--- /dev/null
+++ b/arch/arm/mach-lpc2k/include/mach/debug-macro.S
@@ -0,0 +1,19 @@
+/*
+ * Copyright 2011 Team Embedded VOF
+ *     Ithamar R. Adema <ihamar.adema@team-embedded.nl>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+
+#include <mach/hardware.h>
+
+	.macro	addruart, rp, rv
+	ldr	\rp, =APB_UART0_BASE
+	ldr	\rv, =APB_UART0_BASE
+	.endm
+
+#define UART_SHIFT	2
+#include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-lpc2k/include/mach/entry-macro.S b/arch/arm/mach-lpc2k/include/mach/entry-macro.S
new file mode 100644
index 0000000..f6c7a46
--- /dev/null
+++ b/arch/arm/mach-lpc2k/include/mach/entry-macro.S
@@ -0,0 +1,33 @@
+/*
+ * Copyright 2011 Team Embedded VOF
+ *     Ithamar R. Adema <ihamar.adema@team-embedded.nl>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <mach/hardware.h>
+
+        .macro  disable_fiq
+        .endm
+
+		.macro	get_irqnr_preamble, base, tmp
+		ldr	\base, =APH_VIC_BASE
+		.endm
+
+		.macro	arch_ret_to_user, tmp1, tmp2
+		.endm
+
+		.macro get_irqnr_and_base, irqnr, irqstat, base, tmp
+		ldr	\irqstat, [\base, #0]
+		mov     \irqnr, #0
+1001:
+		tst     \irqstat, #1
+		bne     1002f
+		add     \irqnr, \irqnr, #1
+		mov     \irqstat, \irqstat, lsr #1
+		cmp     \irqnr, #32
+		bcc     1001b
+1002:
+		.endm
diff --git a/arch/arm/mach-lpc2k/include/mach/hardware.h b/arch/arm/mach-lpc2k/include/mach/hardware.h
new file mode 100644
index 0000000..7663e97
--- /dev/null
+++ b/arch/arm/mach-lpc2k/include/mach/hardware.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright 2011 Team Embedded VOF
+ *     Ithamar R. Adema <ihamar.adema@team-embedded.nl>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef MACH_LPC2K_HARDWARE_H
+#define MACH_LPC2K_HARDWARE_H
+
+#include <asm/sizes.h>
+
+/* Default memory size if no ATAGS found */
+#define MEM_SIZE	(SZ_32M)
+
+#define APB_TIMER0_BASE		0xe0004000
+#define APB_TIMER1_BASE		0xe0008000
+#define APB_UART0_BASE		0xe000c000
+#define APH_VIC_BASE		0xfffff000
+
+#endif /* MACH_LPC2K_HARDWARE_H */
diff --git a/arch/arm/mach-lpc2k/include/mach/io.h b/arch/arm/mach-lpc2k/include/mach/io.h
new file mode 100644
index 0000000..e1a2b7f
--- /dev/null
+++ b/arch/arm/mach-lpc2k/include/mach/io.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright 2011 Team Embedded VOF
+ *     Ithamar R. Adema <ihamar.adema@team-embedded.nl>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef MACH_LPC2K_IO_H
+#define MACH_LPC2K_IO_H
+
+#define IO_SPACE_LIMIT	0xffffffff
+
+#define __mem_pci(a)	(a)
+#define __io(a)		__typesafe_io(a)
+
+#endif /* MACH_LPC2K_IO_H */
diff --git a/arch/arm/mach-lpc2k/include/mach/irqs.h b/arch/arm/mach-lpc2k/include/mach/irqs.h
new file mode 100644
index 0000000..87b80dd
--- /dev/null
+++ b/arch/arm/mach-lpc2k/include/mach/irqs.h
@@ -0,0 +1,49 @@
+/*
+ * Copyright 2011 Team Embedded VOF
+ *     Ithamar R. Adema <ihamar.adema@team-embedded.nl>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef MACH_LPC2K_IRQS_H
+#define MACH_LPC2K_IRQS_H
+
+/* VIC */
+#define IRQ_LPC2K_WDINT		0
+#define IRQ_LPC2K_RSV0		1
+#define IRQ_LPC2K_DBGRX		2
+#define IRQ_LPC2K_DBGTX		3
+#define IRQ_LPC2K_TIMER0	4
+#define IRQ_LPC2K_TIMER1	5
+#define IRQ_LPC2K_UART0		6
+#define IRQ_LPC2K_UART1		7
+#define IRQ_LPC2K_PWM0		8
+#define IRQ_LPC2K_I2C0		9
+#define IRQ_LPC2K_SPI0		10
+#define IRQ_LPC2K_SPI1		11
+#define IRQ_LPC2K_PLL		12
+#define IRQ_LPC2K_RTC		13
+#define IRQ_LPC2K_EINT0		14
+#define IRQ_LPC2K_EINT1		15
+#define IRQ_LPC2K_EINT2		16
+#define IRQ_LPC2K_EINT3		17
+#define IRQ_LPC2K_ADC		18
+#define IRQ_LPC2K_I2C1		19
+#define IRQ_LPC2K_BOD		20
+#define IRQ_LPC2K_ETH		21
+#define IRQ_LPC2K_USB		22
+#define IRQ_LPC2K_CAN		23
+#define IRQ_LPC2K_MCI		24
+#define IRQ_LPC2K_DMA		25
+#define IRQ_LPC2K_TIMER2	26
+#define IRQ_LPC2K_TIMER3	27
+#define IRQ_LPC2K_UART2		28
+#define IRQ_LPC2K_UART3		29
+#define IRQ_LPC2K_I2C2		30
+#define IRQ_LPC2K_I2S		31
+
+#define NR_IRQS			32
+
+#endif /* MACH_LPC2K_IRQS_H */
diff --git a/arch/arm/mach-lpc2k/include/mach/memory.h b/arch/arm/mach-lpc2k/include/mach/memory.h
new file mode 100644
index 0000000..6432147
--- /dev/null
+++ b/arch/arm/mach-lpc2k/include/mach/memory.h
@@ -0,0 +1,15 @@
+/*
+ * Copyright 2011 Team Embedded VOF
+ *     Ithamar R. Adema <ihamar.adema@team-embedded.nl>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef MACH_LPC2K_MEMORY_H
+#define MACH_LPC2K_MEMORY_H
+
+#define PHYS_OFFSET	0xa0000000
+
+#endif /* MACH_LPC2K_MEMORY_H */
diff --git a/arch/arm/mach-lpc2k/include/mach/system.h b/arch/arm/mach-lpc2k/include/mach/system.h
new file mode 100644
index 0000000..fbbea43
--- /dev/null
+++ b/arch/arm/mach-lpc2k/include/mach/system.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright 2011 Team Embedded VOF
+ *     Ithamar R. Adema <ihamar.adema@team-embedded.nl>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef MACH_LPC2K_SYSTEM_H
+#define MACH_LPC2K_SYSTEM_H
+
+static void arch_idle(void)
+{
+	cpu_do_idle();
+}
+
+static inline void arch_reset(char mode, const char *cmd)
+{
+	cpu_reset(0);
+}
+
+#endif /* MACH_LPC2K_SYSTEM_H */
diff --git a/arch/arm/mach-lpc2k/include/mach/timex.h b/arch/arm/mach-lpc2k/include/mach/timex.h
new file mode 100644
index 0000000..ba7c8dc
--- /dev/null
+++ b/arch/arm/mach-lpc2k/include/mach/timex.h
@@ -0,0 +1,15 @@
+/*
+ * Copyright 2011 Team Embedded VOF
+ *     Ithamar R. Adema <ihamar.adema@team-embedded.nl>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef MACH_LPC2K_TIMEX_H
+#define MACH_LPC2K_TIMEX_H
+
+#define CLOCK_TICK_RATE		(HZ * 100UL)
+
+#endif /* MACH_LPC2K_TIMEX_H */
diff --git a/arch/arm/mach-lpc2k/include/mach/uncompress.h b/arch/arm/mach-lpc2k/include/mach/uncompress.h
new file mode 100644
index 0000000..1724d72
--- /dev/null
+++ b/arch/arm/mach-lpc2k/include/mach/uncompress.h
@@ -0,0 +1,50 @@
+/*
+ * Copyright 2011 Team Embedded VOF
+ *     Ithamar R. Adema <ihamar.adema@team-embedded.nl>
+ *
+ * based on uncompress.h from mach-loki.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/serial_reg.h>
+#include <mach/hardware.h>
+
+#define SERIAL_BASE	((unsigned char *)APB_UART0_BASE)
+
+static void putc(const char c)
+{
+	unsigned char *base = SERIAL_BASE;
+	int i;
+
+	for (i = 0; i < 0x1000; i++) {
+		if (base[UART_LSR << 2] & UART_LSR_THRE)
+			break;
+		barrier();
+	}
+
+	base[UART_TX << 2] = c;
+}
+
+static void flush(void)
+{
+	unsigned char *base = SERIAL_BASE;
+	unsigned char mask;
+	int i;
+
+	mask = UART_LSR_TEMT | UART_LSR_THRE;
+
+	for (i = 0; i < 0x1000; i++) {
+		if ((base[UART_LSR << 2] & mask) == mask)
+			break;
+		barrier();
+	}
+}
+
+/*
+ * nothing to do
+ */
+#define arch_decomp_setup()
+#define arch_decomp_wdog()
diff --git a/arch/arm/mach-lpc2k/irq.c b/arch/arm/mach-lpc2k/irq.c
new file mode 100644
index 0000000..58d291d
--- /dev/null
+++ b/arch/arm/mach-lpc2k/irq.c
@@ -0,0 +1,17 @@
+/*
+ * Copyright (C) 2011 Team Embeded VOF
+ *     Ithamar R. Adema <ihamar.adema@team-embedded.nl>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <asm/hardware/vic.h>
+#include <mach/hardware.h>
+
+void __init lpc2k_init_irq(void)
+{
+	vic_init((void __iomem *)APH_VIC_BASE, 0, ~0, 0);
+}
-- 
1.7.1
