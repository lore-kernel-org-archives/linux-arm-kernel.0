From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 28 Jun 2011 16:17:30 -0400 (EDT)
Subject: [PATCH] ARM: mach-s3c24a0: delete
Message-ID: <alpine.LFD.2.00.1106281613380.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Commit bcae8aeb32 "[ARM] S3C24A0: Initial architecture support files"
brought in a bunch of files while explicitly leaving out the corresponding
Kconfig entry, stating that the series is not complete.

More than 2.5 years later, the support for this has not seen any progress.
This is therefore dead code.  If someone wants to revive this code, it is
always possible to retrieve it from the Git repository.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Makefile                                |    1 -
 arch/arm/mach-s3c24a0/include/mach/debug-macro.S |   27 -----
 arch/arm/mach-s3c24a0/include/mach/io.h          |   18 ----
 arch/arm/mach-s3c24a0/include/mach/irqs.h        |  117 ----------------------
 arch/arm/mach-s3c24a0/include/mach/map.h         |   86 ----------------
 arch/arm/mach-s3c24a0/include/mach/memory.h      |   21 ----
 arch/arm/mach-s3c24a0/include/mach/regs-clock.h  |   88 ----------------
 arch/arm/mach-s3c24a0/include/mach/regs-irq.h    |   25 -----
 arch/arm/mach-s3c24a0/include/mach/system.h      |   25 -----
 arch/arm/mach-s3c24a0/include/mach/tick.h        |   15 ---
 arch/arm/mach-s3c24a0/include/mach/timex.h       |   18 ----
 arch/arm/mach-s3c24a0/include/mach/vmalloc.h     |   17 ---
 12 files changed, 0 insertions(+), 458 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index f5b2b39..64d2591 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -173,7 +173,6 @@ machine-$(CONFIG_ARCH_PXA)		:= pxa
 machine-$(CONFIG_ARCH_REALVIEW)		:= realview
 machine-$(CONFIG_ARCH_RPC)		:= rpc
 machine-$(CONFIG_ARCH_S3C2410)		:= s3c2410 s3c2400 s3c2412 s3c2416 s3c2440 s3c2443
-machine-$(CONFIG_ARCH_S3C24A0)		:= s3c24a0
 machine-$(CONFIG_ARCH_S3C64XX)		:= s3c64xx
 machine-$(CONFIG_ARCH_S5P64X0)		:= s5p64x0
 machine-$(CONFIG_ARCH_S5PC100)		:= s5pc100
diff --git a/arch/arm/mach-s3c24a0/include/mach/debug-macro.S b/arch/arm/mach-s3c24a0/include/mach/debug-macro.S
deleted file mode 100644
index 0c5a738..0000000
--- a/arch/arm/mach-s3c24a0/include/mach/debug-macro.S
+++ /dev/null
@@ -1,27 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/debug-macro.S
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-/* pull in the relevant register and map files. */
-
-#include <mach/map.h>
-#include <plat/regs-serial.h>
-
-	.macro addruart, rp, rv
-		ldr	\rp, = S3C24XX_PA_UART
-		ldr	\rv, = S3C24XX_VA_UART
-#if CONFIG_DEBUG_S3C_UART != 0
-		add	\rp, \rp, #(S3C2410_UART1_OFF * CONFIG_DEBUG_S3C_UART)
-		add	\rv, \rv, #(S3C2410_UART1_OFF * CONFIG_DEBUG_S3C_UART)
-#endif
-	.endm
-
-/* include the reset of the code which will do the work, we're only
- * compiling for a single cpu processor type so the default of s3c2440
- * will be fine with us.
- */
-
-#include <plat/debug-macro.S>
diff --git a/arch/arm/mach-s3c24a0/include/mach/io.h b/arch/arm/mach-s3c24a0/include/mach/io.h
deleted file mode 100644
index 4326c30..0000000
--- a/arch/arm/mach-s3c24a0/include/mach/io.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* arch/arm/mach-s3c24a0/include/mach/io.h
- *
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben-linux@fluff.org>
- *
- * Default IO routines for S3C24A0
- */
-
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H
-
-/* No current ISA/PCI bus support. */
-#define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
-#define IO_SPACE_LIMIT (0xFFFFFFFF)
-
-#endif
diff --git a/arch/arm/mach-s3c24a0/include/mach/irqs.h b/arch/arm/mach-s3c24a0/include/mach/irqs.h
deleted file mode 100644
index 83ce2a7..0000000
--- a/arch/arm/mach-s3c24a0/include/mach/irqs.h
+++ /dev/null
@@ -1,117 +0,0 @@
-/* linux/arch/arm/mach-s3c24a0/include/mach/irqs.h
- *
- * Copyright (c) 2003-2005 Simtec Electronics
- *   Ben Dooks <ben@simtec.co.uk>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-
-#ifndef __ASM_ARCH_24A0_IRQS_H
-#define __ASM_ARCH_24A0_IRQS_H __FILE__
-
-#define IRQ_EINT0t2	S3C2410_IRQ(0)	/* 16 */
-/* for generic entry-macro.S */
-#define IRQ_EINT0	IRQ_EINT0t2
-
-#define IRQ_EINT3t6	S3C2410_IRQ(1)
-#define IRQ_EINT7t10	S3C2410_IRQ(2)
-#define IRQ_EINT11t14	S3C2410_IRQ(3)
-#define IRQ_EINT15t18	S3C2410_IRQ(4)	/* 20 */
-#define IRQ_TICK	S3C2410_IRQ(5)
-#define IRQ_DCTQ	S3C2410_IRQ(6)
-#define IRQ_MC		S3C2410_IRQ(7)
-#define IRQ_ME		S3C2410_IRQ(8)	/* 24 */
-#define IRQ_KEYPAD	S3C2410_IRQ(9)
-#define IRQ_TIMER0	S3C2410_IRQ(10)
-#define IRQ_TIMER1	S3C2410_IRQ(11)
-#define IRQ_TIMER2	S3C2410_IRQ(12)
-#define IRQ_TIMER3_4	S3C2410_IRQ(13)
-#define IRQ_OS_TIMER	IRQ_TIMER3_4
-#define IRQ_LCD		S3C2410_IRQ(14)
-#define IRQ_CAM_C	S3C2410_IRQ(15)
-#define IRQ_WDT_BATFLT	S3C2410_IRQ(16)	/* 32 */
-#define IRQ_UART0	S3C2410_IRQ(17)
-#define IRQ_CAM_P	S3C2410_IRQ(18)
-#define IRQ_MODEM	S3C2410_IRQ(19)
-#define IRQ_DMA		S3C2410_IRQ(20)
-#define IRQ_SDI		S3C2410_IRQ(21)
-#define IRQ_SPI0	S3C2410_IRQ(22)
-#define IRQ_UART1	S3C2410_IRQ(23)
-#define IRQ_AC97_NFLASH	S3C2410_IRQ(24)	/* 40 */
-#define IRQ_USBD	S3C2410_IRQ(25)
-#define IRQ_USBH	S3C2410_IRQ(26)
-#define IRQ_IIC		S3C2410_IRQ(27)
-#define IRQ_IRDA_MSTICK	S3C2410_IRQ(28)	/* 44 */
-#define IRQ_VLX_SPI1	S3C2410_IRQ(29)
-#define IRQ_RTC		S3C2410_IRQ(30)	/* 46 */
-#define IRQ_ADC_PEN     S3C2410_IRQ(31)
-
-/* interrupts generated from the external interrupts sources */
-#define IRQ_EINT00	S3C2410_IRQ(32)	/* 48 */
-#define IRQ_EINT1	S3C2410_IRQ(33)
-#define IRQ_EINT2	S3C2410_IRQ(34)
-#define IRQ_EINT3	S3C2410_IRQ(35)
-#define IRQ_EINT4	S3C2410_IRQ(36)
-#define IRQ_EINT5	S3C2410_IRQ(37)
-#define IRQ_EINT6	S3C2410_IRQ(38)
-#define IRQ_EINT7	S3C2410_IRQ(39)
-#define IRQ_EINT8	S3C2410_IRQ(40)
-#define IRQ_EINT9	S3C2410_IRQ(41)
-#define IRQ_EINT10	S3C2410_IRQ(42)
-#define IRQ_EINT11	S3C2410_IRQ(43)
-#define IRQ_EINT12	S3C2410_IRQ(44)
-#define IRQ_EINT13	S3C2410_IRQ(45)
-#define IRQ_EINT14	S3C2410_IRQ(46)
-#define IRQ_EINT15	S3C2410_IRQ(47)
-#define IRQ_EINT16	S3C2410_IRQ(48)
-#define IRQ_EINT17	S3C2410_IRQ(49)
-#define IRQ_EINT18	S3C2410_IRQ(50)
-
-#define IRQ_EINT_BIT(x) ((x) - IRQ_EINT00)
-
-/* SUB IRQS */
-#define IRQ_S3CUART_RX0		S3C2410_IRQ(51)	/* 67 */
-#define IRQ_S3CUART_TX0		S3C2410_IRQ(52)
-#define IRQ_S3CUART_ERR0	S3C2410_IRQ(53)
-
-#define IRQ_S3CUART_RX1		S3C2410_IRQ(54)
-#define IRQ_S3CUART_TX1		S3C2410_IRQ(55)
-#define IRQ_S3CUART_ERR1	S3C2410_IRQ(56)
-
-#define IRQ_S3CUART_RX2		(0x0)
-#define IRQ_S3CUART_TX2		(0x0)
-#define IRQ_S3CUART_ERR2	(0x0)
-
-
-#define IRQ_IRDA	S3C2410_IRQ(57)
-#define IRQ_MSTICK	S3C2410_IRQ(58)
-#define IRQ_RESERVED0	S3C2410_IRQ(59)
-#define IRQ_RESERVED1	S3C2410_IRQ(60)
-#define IRQ_RESERVED2	S3C2410_IRQ(61)
-#define IRQ_TIMER3	S3C2410_IRQ(62)
-#define IRQ_TIMER4	S3C2410_IRQ(63)
-#define IRQ_WDT		S3C2410_IRQ(64)
-#define IRQ_BATFLT	S3C2410_IRQ(65)
-#define IRQ_POST	S3C2410_IRQ(66)
-#define IRQ_DISP_FIFO	S3C2410_IRQ(67)
-#define IRQ_PENUP	S3C2410_IRQ(68)
-#define IRQ_PENDN	S3C2410_IRQ(69)
-#define IRQ_ADC		S3C2410_IRQ(70)
-#define IRQ_DISP_FRAME	S3C2410_IRQ(71)
-#define IRQ_NFLASH	S3C2410_IRQ(72)
-#define IRQ_AC97	S3C2410_IRQ(73)
-#define IRQ_SPI1	S3C2410_IRQ(74)
-#define IRQ_VLX		S3C2410_IRQ(75)
-#define IRQ_DMA0	S3C2410_IRQ(76)
-#define IRQ_DMA1	S3C2410_IRQ(77)
-#define IRQ_DMA2	S3C2410_IRQ(78)
-#define IRQ_DMA3	S3C2410_IRQ(79)
-
-#define IRQ_TC		(0x0)
-
-#define NR_IRQS		(IRQ_DMA3+1)
-
-#endif /* __ASM_ARCH_24A0_IRQS_H */
diff --git a/arch/arm/mach-s3c24a0/include/mach/map.h b/arch/arm/mach-s3c24a0/include/mach/map.h
deleted file mode 100644
index d88c8b2..0000000
--- a/arch/arm/mach-s3c24a0/include/mach/map.h
+++ /dev/null
@@ -1,86 +0,0 @@
-/* linux/arch/arm/mach-s3c24a0/include/mach/map.h
- *
- * Copyright 2003-2007  Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C24A0 - Memory map definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_24A0_MAP_H
-#define __ASM_ARCH_24A0_MAP_H __FILE__
-
-#include <plat/map-base.h>
-#include <plat/map.h>
-
-#define S3C24A0_PA_IO_BASE	(0x40000000)
-#define S3C24A0_PA_CLKPWR	(0x40000000)
-#define S3C24A0_PA_IRQ		(0x40200000)
-#define S3C24A0_PA_DMA		(0x40400000)
-#define S3C24A0_PA_MEMCTRL	(0x40C00000)
-#define S3C24A0_PA_NAND		(0x40C00000)
-#define S3C24A0_PA_SROM		(0x40C20000)
-#define S3C24A0_PA_SDRAM	(0x40C40000)
-#define S3C24A0_PA_BUSM		(0x40CE0000)
-#define S3C24A0_PA_USBHOST	(0x41000000)
-#define S3C24A0_PA_MODEMIF	(0x41180000)
-#define S3C24A0_PA_IRDA		(0x41800000)
-#define S3C24A0_PA_TIMER	(0x44000000)
-#define S3C24A0_PA_WATCHDOG	(0x44100000)
-#define S3C24A0_PA_RTC		(0x44200000)
-#define S3C24A0_PA_UART		(0x44400000)
-#define S3C24A0_PA_UART0	(S3C24A0_PA_UART)
-#define S3C24A0_PA_UART1	(S3C24A0_PA_UART + 0x4000)
-#define S3C24A0_PA_SPI		(0x44500000)
-#define S3C24A0_PA_IIC		(0x44600000)
-#define S3C24A0_PA_IIS		(0x44700000)
-#define S3C24A0_PA_GPIO		(0x44800000)
-#define S3C24A0_PA_KEYIF	(0x44900000)
-#define S3C24A0_PA_USBDEV	(0x44A00000)
-#define S3C24A0_PA_AC97		(0x45000000)
-#define S3C24A0_PA_ADC		(0x45800000)
-#define S3C24A0_PA_SDI		(0x46000000)
-#define S3C24A0_PA_MS		(0x46100000)
-#define S3C24A0_PA_LCD		(0x4A000000)
-#define S3C24A0_PA_VPOST	(0x4A100000)
-
-/* physical addresses of all the chip-select areas */
-
-#define S3C24A0_CS0	(0x00000000)
-#define S3C24A0_CS1	(0x04000000)
-#define S3C24A0_CS2	(0x08000000)
-#define S3C24A0_CS3	(0x0C000000)
-#define S3C24A0_CS4	(0x10000000)
-#define S3C24A0_CS5	(0x40000000)
-
-#define S3C24A0_SDRAM_PA	(S3C24A0_CS4)
-
-/* Use a single interface for common resources between S3C24XX cpus */
-
-#define S3C24XX_PA_IRQ		S3C24A0_PA_IRQ
-#define S3C24XX_PA_MEMCTRL	S3C24A0_PA_MEMCTRL
-#define S3C24XX_PA_USBHOST	S3C24A0_PA_USBHOST
-#define S3C24XX_PA_DMA		S3C24A0_PA_DMA
-#define S3C24XX_PA_CLKPWR	S3C24A0_PA_CLKPWR
-#define S3C24XX_PA_LCD		S3C24A0_PA_LCD
-#define S3C24XX_PA_UART		S3C24A0_PA_UART
-#define S3C24XX_PA_TIMER	S3C24A0_PA_TIMER
-#define S3C24XX_PA_USBDEV	S3C24A0_PA_USBDEV
-#define S3C24XX_PA_WATCHDOG	S3C24A0_PA_WATCHDOG
-#define S3C24XX_PA_IIS		S3C24A0_PA_IIS
-#define S3C24XX_PA_GPIO		S3C24A0_PA_GPIO
-#define S3C24XX_PA_RTC		S3C24A0_PA_RTC
-#define S3C24XX_PA_ADC		S3C24A0_PA_ADC
-#define S3C24XX_PA_SPI		S3C24A0_PA_SPI
-#define S3C24XX_PA_SDI		S3C24A0_PA_SDI
-#define S3C24XX_PA_NAND		S3C24A0_PA_NAND
-
-#define S3C_PA_UART		S3C24A0_PA_UART
-#define S3C_PA_IIC		S3C24A0_PA_IIC
-#define S3C_PA_NAND		S3C24XX_PA_NAND
-
-#endif /* __ASM_ARCH_24A0_MAP_H */
diff --git a/arch/arm/mach-s3c24a0/include/mach/memory.h b/arch/arm/mach-s3c24a0/include/mach/memory.h
deleted file mode 100644
index 7d208a7..0000000
--- a/arch/arm/mach-s3c24a0/include/mach/memory.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* linux/arch/arm/mach-s3c24a0/include/mach/memory.h
- *  from linux/include/asm-arm/arch-rpc/memory.h
- *
- *  Copyright (C) 1996,1997,1998 Russell King.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_24A0_MEMORY_H
-#define __ASM_ARCH_24A0_MEMORY_H __FILE__
-
-#define PLAT_PHYS_OFFSET UL(0x10000000)
-
-#define __virt_to_bus(x) __virt_to_phys(x)
-#define __bus_to_virt(x) __phys_to_virt(x)
-#define __pfn_to_bus(x) __pfn_to_phys(x)
-#define __bus_to_pfn(x)	__phys_to_pfn(x)
-
-#endif
diff --git a/arch/arm/mach-s3c24a0/include/mach/regs-clock.h b/arch/arm/mach-s3c24a0/include/mach/regs-clock.h
deleted file mode 100644
index be0af51..0000000
--- a/arch/arm/mach-s3c24a0/include/mach/regs-clock.h
+++ /dev/null
@@ -1,88 +0,0 @@
-/* linux/arch/arm/mach-s3c24a0/include/mach/regs-clock.h
- *
- * Copyright (c) 2003-2006 Simtec Electronics <linux@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * S3C24A0 clock register definitions
-*/
-
-#ifndef __ASM_ARCH_24A0_REGS_CLOCK_H
-#define __ASM_ARCH_24A0_REGS_CLOCK_H __FILE__
-
-#define S3C24A0_MPLLCON		S3C2410_CLKREG(0x10)
-#define S3C24A0_UPLLCON		S3C2410_CLKREG(0x14)
-#define S3C24A0_CLKCON		S3C2410_CLKREG(0x20)
-#define S3C24A0_CLKSRC		S3C2410_CLKREG(0x24)
-#define S3C24A0_CLKDIVN		S3C2410_CLKREG(0x28)
-
-/* CLKCON register bits */
-
-#define S3C24A0_CLKCON_VLX	(1<<29)
-#define S3C24A0_CLKCON_VPOST	(1<<28)
-#define S3C24A0_CLKCON_WDT	(1<<27)	/* reserved */
-#define S3C24A0_CLKCON_MPEGDCTQ	(1<<26)
-#define S3C24A0_CLKCON_VPOSTIF	(1<<25)
-#define S3C24A0_CLKCON_MPEG4IF	(1<<24)
-#define S3C24A0_CLKCON_CAM_UPLL	(1<<23)
-#define S3C24A0_CLKCON_LCDC	(1<<22)
-#define S3C24A0_CLKCON_CAM_HCLK	(1<<21)
-#define S3C24A0_CLKCON_MPEG4	(1<<20)
-#define S3C24A0_CLKCON_KEYPAD	(1<<19)
-#define S3C24A0_CLKCON_ADC	(1<<18)
-#define S3C24A0_CLKCON_SDI	(1<<17)
-#define S3C24A0_CLKCON_MS	(1<<16) /* memory stick */
-#define S3C24A0_CLKCON_USBD	(1<<15)
-#define S3C24A0_CLKCON_GPIO	(1<<14)
-#define S3C24A0_CLKCON_IIS	(1<<13)
-#define S3C24A0_CLKCON_IIC	(1<<12)
-#define S3C24A0_CLKCON_SPI	(1<<11)
-#define S3C24A0_CLKCON_UART1	(1<<10)
-#define S3C24A0_CLKCON_UART0	(1<<9)
-#define S3C24A0_CLKCON_PWMT	(1<<8)
-#define S3C24A0_CLKCON_USBH	(1<<7)
-#define S3C24A0_CLKCON_AC97	(1<<6)
-#define S3C24A0_CLKCON_IrDA	(1<<4)
-#define S3C24A0_CLKCON_IDLE	(1<<2)
-#define S3C24A0_CLKCON_MON	(1<<1)
-#define S3C24A0_CLKCON_STOP	(1<<0)
-
-/* CLKSRC register bits */
-
-#define S3C24A0_CLKSRC_OSC	(1<<8)  /* CLKSRC */
-#define S3C24A0_CLKSRC_UPLL	(1<<7)
-#define S3C24A0_CLKSRC_MPLL	(1<<5)
-#define S3C24A0_CLKSRC_EXT	(1<<4)
-
-/* Use a single interface with the common code, for s3c24xx */
-
-#define S3C2410_MPLLCON		S3C24A0_MPLLCON
-#define S3C2410_UPLLCON		S3C24A0_UPLLCON
-#define S3C2410_CLKCON		S3C24A0_CLKCON
-#define S3C2410_CLKSLOW		S3C24A0_CLKSRC
-#define S3C2410_CLKDIVN		S3C24A0_CLKDIVN
-
-#define S3C2410_CLKCON_IDLE	S3C24A0_CLKCON_IDLE
-#define S3C2410_CLKCON_POWER	S3C24A0_CLKCON_STOP
-#define S3C2410_CLKCON_LCDC	S3C24A0_CLKCON_LCDC
-#define S3C2410_CLKCON_USBH	S3C24A0_CLKCON_USBH
-#define S3C2410_CLKCON_USBD	S3C24A0_CLKCON_USBD
-#define S3C2410_CLKCON_PWMT	S3C24A0_CLKCON_PWMT
-#define S3C2410_CLKCON_SDI	S3C24A0_CLKCON_SDI
-#define S3C2410_CLKCON_UART0	S3C24A0_CLKCON_UART0
-#define S3C2410_CLKCON_UART1	S3C24A0_CLKCON_UART1
-#define S3C2410_CLKCON_GPIO	S3C24A0_CLKCON_GPIO
-#define S3C2410_CLKCON_ADC	S3C24A0_CLKCON_ADC
-#define S3C2410_CLKCON_IIC	S3C24A0_CLKCON_IIC
-#define S3C2410_CLKCON_IIS	S3C24A0_CLKCON_IIS
-#define S3C2410_CLKCON_SPI	S3C24A0_CLKCON_SPI
-
-#define S3C2410_CLKSLOW_UCLK_OFF	S3C24A0_CLKSRC_UPLL
-#define S3C2410_CLKSLOW_MPLL_OFF	S3C24A0_CLKSRC_MPLL
-#define S3C2410_CLKSLOW_SLOW		(0xFF)
-#define S3C2410_CLKSLOW_GET_SLOWVAL(x)	(0x1)
-
-#endif /* __ASM_ARCH_24A0_REGS_CLOCK_H */
diff --git a/arch/arm/mach-s3c24a0/include/mach/regs-irq.h b/arch/arm/mach-s3c24a0/include/mach/regs-irq.h
deleted file mode 100644
index 6086f6f..0000000
--- a/arch/arm/mach-s3c24a0/include/mach/regs-irq.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* linux/arch/arm/mach-s3c24a0/include/mach/regs-irq.h
- *
- * Copyright (c) 2003 Simtec Electronics <linux@simtec.co.uk>
- *		      http://www.simtec.co.uk/products/SWLINUX/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-
-#ifndef ___ASM_ARCH_24A0_REGS_IRQ_H
-#define ___ASM_ARCH_24A0_REGS_IRQ_H __FILE__
-
-
-#define S3C2410_EINTMASK	S3C2410_EINTREG(0x034)
-#define S3C2410_EINTPEND	S3C2410_EINTREG(0X038)
-
-#define S3C24XX_EINTMASK	S3C24XX_EINTREG(0x034)
-#define S3C24XX_EINTPEND	S3C24XX_EINTREG(0X038)
-
-#endif /* __ASM_ARCH_24A0_REGS_IRQ_H */
-
-
-
diff --git a/arch/arm/mach-s3c24a0/include/mach/system.h b/arch/arm/mach-s3c24a0/include/mach/system.h
deleted file mode 100644
index bd1bd19..0000000
--- a/arch/arm/mach-s3c24a0/include/mach/system.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* linux/arch/arm/mach-s3c24a0/include/mach/system.h
- *
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C24A0 - System function defines and includes
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <mach/hardware.h>
-#include <asm/io.h>
-
-#include <mach/map.h>
-
-static void arch_idle(void)
-{
-	/* currently no specific idle support. */
-}
-
-void (*s3c24xx_reset_hook)(void);
-
-#include <asm/plat-s3c24xx/system-reset.h>
diff --git a/arch/arm/mach-s3c24a0/include/mach/tick.h b/arch/arm/mach-s3c24a0/include/mach/tick.h
deleted file mode 100644
index 9dea8ba..0000000
--- a/arch/arm/mach-s3c24a0/include/mach/tick.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* linux/arch/arm/mach-s3c24a0/include/mach/tick.h
- *
- * Copyright 2008 Simtec Electronics
- *      Ben Dooks <ben@simtec.co.uk>
- *      http://armlinux.simtec.co.uk/
- *
- * S3C24A0 - timer tick support
- */
-
-#define SUBSRC_TIMER4	(1 << (IRQ_TIMER4 - IRQ_S3CUART_RX0))
-
-static inline int s3c24xx_ostimer_pending(void)
-{
-	return __raw_readl(S3C2410_SUBSRCPND) & SUBSRC_TIMER4;
-}
diff --git a/arch/arm/mach-s3c24a0/include/mach/timex.h b/arch/arm/mach-s3c24a0/include/mach/timex.h
deleted file mode 100644
index 9857342..0000000
--- a/arch/arm/mach-s3c24a0/include/mach/timex.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* linux/arch/arm/mach-s3c24a0/include/mach/timex.h
- *
- * Copyright (c) 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C2410 - time parameters
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_TIMEX_H
-#define __ASM_ARCH_TIMEX_H
-
-#define CLOCK_TICK_RATE 12000000
-
-#endif /* __ASM_ARCH_TIMEX_H */
diff --git a/arch/arm/mach-s3c24a0/include/mach/vmalloc.h b/arch/arm/mach-s3c24a0/include/mach/vmalloc.h
deleted file mode 100644
index 6480b15..0000000
--- a/arch/arm/mach-s3c24a0/include/mach/vmalloc.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* linux/include/asm-arm/arch-s3c24ao/vmalloc.h
- *
- * Copyright 2008 Simtec Electronics <linux@simtec.co.uk>
-
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * S3C24A0 vmalloc definition
-*/
-
-#ifndef __ASM_ARCH_VMALLOC_H
-#define __ASM_ARCH_VMALLOC_H
-
-#define VMALLOC_END	0xF6000000UL
-
-#endif /* __ASM_ARCH_VMALLOC_H */
