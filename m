From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  4 Jun 2016 10:10:13 +0300
Subject: [PATCH 21/22] ARM: clps711x: Switch to MULTIPLATFORM
In-Reply-To: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
References: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
Message-ID: <1465024214-22120-22-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch CLPS711X to multiplatform.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/Kconfig                                 |  14 --
 arch/arm/Makefile                                |   1 -
 arch/arm/mach-clps711x/Kconfig                   |  23 ++-
 arch/arm/mach-clps711x/Makefile                  |   2 +-
 arch/arm/mach-clps711x/include/mach/clps711x.h   | 204 -----------------------
 arch/arm/mach-clps711x/include/mach/hardware.h   |  53 ------
 arch/arm/mach-clps711x/include/mach/uncompress.h |  55 ------
 7 files changed, 12 insertions(+), 340 deletions(-)
 delete mode 100644 arch/arm/mach-clps711x/include/mach/clps711x.h
 delete mode 100644 arch/arm/mach-clps711x/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-clps711x/include/mach/uncompress.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 90542db..7a13e5a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -353,20 +353,6 @@ config ARM_SINGLE_ARMV7M
 	select SPARSE_IRQ
 	select USE_OF
 
-
-config ARCH_CLPS711X
-	bool "Cirrus Logic CLPS711x/EP721x/EP731x-based"
-	select ARCH_REQUIRE_GPIOLIB
-	select AUTO_ZRELADDR
-	select CLKSRC_MMIO
-	select COMMON_CLK
-	select CPU_ARM720T
-	select GENERIC_CLOCKEVENTS
-	select MFD_SYSCON
-	select SOC_BUS
-	help
-	  Support for Cirrus Logic 711x/721x/731x based boards.
-
 config ARCH_GEMINI
 	bool "Cortina Systems Gemini"
 	select ARCH_REQUIRE_GPIOLIB
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 274e8a6..10f16b3 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -140,7 +140,6 @@ head-y		:= arch/arm/kernel/head$(MMUEXT).o
 # Text offset. This list is sorted numerically by address in order to
 # provide a means to avoid/resolve conflicts in multi-arch kernels.
 textofs-y	:= 0x00008000
-textofs-$(CONFIG_ARCH_CLPS711X) := 0x00028000
 # We don't want the htc bootloader to corrupt kernel during resume
 textofs-$(CONFIG_PM_H1940)      := 0x00108000
 # SA1111 DMA bug: we don't want the kernel to live in precious DMA-able memory
diff --git a/arch/arm/mach-clps711x/Kconfig b/arch/arm/mach-clps711x/Kconfig
index 0a170e1..3b56197 100644
--- a/arch/arm/mach-clps711x/Kconfig
+++ b/arch/arm/mach-clps711x/Kconfig
@@ -1,16 +1,15 @@
-if ARCH_CLPS711X
-
-menu "CLPS711X/EP721X/EP731X Implementations"
-
-config MACH_CLPS711X_DT
-	bool "Device-tree support"
+menuconfig ARCH_CLPS711X
+	bool "Cirrus Logic EP721x/EP731x-based"
+	depends on ARCH_MULTI_V4T
+	select ARCH_REQUIRE_GPIOLIB
+	select AUTO_ZRELADDR
+	select CLKSRC_MMIO
 	select CLKSRC_OF
+	select COMMON_CLK
+	select CPU_ARM720T
+	select GENERIC_CLOCKEVENTS
+	select MFD_SYSCON
 	select OF_IRQ
 	select USE_OF
 	help
-	  Select this if you want to experiment device-tree with
-	  ARMv4T Cirrus Logic chips.
-
-endmenu
-
-endif
+	  Select this if you use ARMv4T Cirrus Logic chips.
diff --git a/arch/arm/mach-clps711x/Makefile b/arch/arm/mach-clps711x/Makefile
index d79d998..bd0b7b5 100644
--- a/arch/arm/mach-clps711x/Makefile
+++ b/arch/arm/mach-clps711x/Makefile
@@ -1 +1 @@
-obj-$(CONFIG_MACH_CLPS711X_DT)	+= board-dt.o
+obj-y += board-dt.o
diff --git a/arch/arm/mach-clps711x/include/mach/clps711x.h b/arch/arm/mach-clps711x/include/mach/clps711x.h
deleted file mode 100644
index eb052a1..0000000
--- a/arch/arm/mach-clps711x/include/mach/clps711x.h
+++ /dev/null
@@ -1,204 +0,0 @@
-/*
- *  This file contains the hardware definitions of the Cirrus Logic
- *  ARM7 CLPS711X internal registers.
- *
- *  Copyright (C) 2000 Deep Blue Solutions Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-#ifndef __MACH_CLPS711X_H
-#define __MACH_CLPS711X_H
-
-#include <linux/mfd/syscon/clps711x.h>
-
-#define CLPS711X_PHYS_BASE	(0x80000000)
-
-#define PADR		(0x0000)
-#define PBDR		(0x0001)
-#define PCDR		(0x0002)
-#define PDDR		(0x0003)
-#define PADDR		(0x0040)
-#define PBDDR		(0x0041)
-#define PCDDR		(0x0042)
-#define PDDDR		(0x0043)
-#define PEDR		(0x0083)
-#define PEDDR		(0x00c3)
-#define SYSCON1		(0x0100)
-#define SYSFLG1		(0x0140)
-#define MEMCFG1		(0x0180)
-#define MEMCFG2		(0x01c0)
-#define DRFPR		(0x0200)
-#define LCDCON		(0x02c0)
-#define TC1D		(0x0300)
-#define TC2D		(0x0340)
-#define RTCDR		(0x0380)
-#define RTCMR		(0x03c0)
-#define PMPCON		(0x0400)
-#define CODR		(0x0440)
-#define UARTDR1		(0x0480)
-#define UBRLCR1		(0x04c0)
-#define SYNCIO		(0x0500)
-#define PALLSW		(0x0540)
-#define PALMSW		(0x0580)
-#define STFCLR		(0x05c0)
-#define HALT		(0x0800)
-#define STDBY		(0x0840)
-
-#define FBADDR		(0x1000)
-#define SYSCON2		(0x1100)
-#define SYSFLG2		(0x1140)
-#define UARTDR2		(0x1480)
-#define UBRLCR2		(0x14c0)
-#define SS2DR		(0x1500)
-#define SS2POP		(0x16c0)
-
-#define DAIR		(0x2000)
-#define DAIDR0		(0x2040)
-#define DAIDR1		(0x2080)
-#define DAIDR2		(0x20c0)
-#define DAISR		(0x2100)
-#define SYSCON3		(0x2200)
-#define LEDFLSH		(0x22c0)
-#define SDCONF		(0x2300)
-#define SDRFPR		(0x2340)
-#define UNIQID		(0x2440)
-#define DAI64FS		(0x2600)
-#define PLLW		(0x2610)
-#define PLLR		(0xa5a8)
-#define RANDID0		(0x2700)
-#define RANDID1		(0x2704)
-#define RANDID2		(0x2708)
-#define RANDID3		(0x270c)
-
-#define LCDCON_GSEN		(1 << 30)
-#define LCDCON_GSMD		(1 << 31)
-
-/* common bits: UARTDR1 / UARTDR2 */
-#define UARTDR_FRMERR		(1 << 8)
-#define UARTDR_PARERR		(1 << 9)
-#define UARTDR_OVERR		(1 << 10)
-
-/* common bits: UBRLCR1 / UBRLCR2 */
-#define UBRLCR_BAUD_MASK	((1 << 12) - 1)
-#define UBRLCR_BREAK		(1 << 12)
-#define UBRLCR_PRTEN		(1 << 13)
-#define UBRLCR_EVENPRT		(1 << 14)
-#define UBRLCR_XSTOP		(1 << 15)
-#define UBRLCR_FIFOEN		(1 << 16)
-#define UBRLCR_WRDLEN5		(0 << 17)
-#define UBRLCR_WRDLEN6		(1 << 17)
-#define UBRLCR_WRDLEN7		(2 << 17)
-#define UBRLCR_WRDLEN8		(3 << 17)
-#define UBRLCR_WRDLEN_MASK	(3 << 17)
-
-#define SYNCIO_FRMLEN(x)	(((x) & 0x1f) << 8)
-#define SYNCIO_SMCKEN		(1 << 13)
-#define SYNCIO_TXFRMEN		(1 << 14)
-
-#define DAIR_RESERVED		(0x0404)
-#define DAIR_DAIEN		(1 << 16)
-#define DAIR_ECS		(1 << 17)
-#define DAIR_LCTM		(1 << 19)
-#define DAIR_LCRM		(1 << 20)
-#define DAIR_RCTM		(1 << 21)
-#define DAIR_RCRM		(1 << 22)
-#define DAIR_LBM		(1 << 23)
-
-#define DAIDR2_FIFOEN		(1 << 15)
-#define DAIDR2_FIFOLEFT		(0x0d << 16)
-#define DAIDR2_FIFORIGHT	(0x11 << 16)
-
-#define DAISR_RCTS		(1 << 0)
-#define DAISR_RCRS		(1 << 1)
-#define DAISR_LCTS		(1 << 2)
-#define DAISR_LCRS		(1 << 3)
-#define DAISR_RCTU		(1 << 4)
-#define DAISR_RCRO		(1 << 5)
-#define DAISR_LCTU		(1 << 6)
-#define DAISR_LCRO		(1 << 7)
-#define DAISR_RCNF		(1 << 8)
-#define DAISR_RCNE		(1 << 9)
-#define DAISR_LCNF		(1 << 10)
-#define DAISR_LCNE		(1 << 11)
-#define DAISR_FIFO		(1 << 12)
-
-#define DAI64FS_I2SF64		(1 << 0)
-#define DAI64FS_AUDIOCLKEN	(1 << 1)
-#define DAI64FS_AUDIOCLKSRC	(1 << 2)
-#define DAI64FS_MCLK256EN	(1 << 3)
-#define DAI64FS_LOOPBACK	(1 << 5)
-
-#define SDCONF_ACTIVE		(1 << 10)
-#define SDCONF_CLKCTL		(1 << 9)
-#define SDCONF_WIDTH_4		(0 << 7)
-#define SDCONF_WIDTH_8		(1 << 7)
-#define SDCONF_WIDTH_16		(2 << 7)
-#define SDCONF_WIDTH_32		(3 << 7)
-#define SDCONF_SIZE_16		(0 << 5)
-#define SDCONF_SIZE_64		(1 << 5)
-#define SDCONF_SIZE_128		(2 << 5)
-#define SDCONF_SIZE_256		(3 << 5)
-#define SDCONF_CASLAT_2		(2)
-#define SDCONF_CASLAT_3		(3)
-
-#define MEMCFG_BUS_WIDTH_32	(1)
-#define MEMCFG_BUS_WIDTH_16	(0)
-#define MEMCFG_BUS_WIDTH_8	(3)
-
-#define MEMCFG_SQAEN		(1 << 6)
-#define MEMCFG_CLKENB		(1 << 7)
-
-#define MEMCFG_WAITSTATE_8_3	(0 << 2)
-#define MEMCFG_WAITSTATE_7_3	(1 << 2)
-#define MEMCFG_WAITSTATE_6_3	(2 << 2)
-#define MEMCFG_WAITSTATE_5_3	(3 << 2)
-#define MEMCFG_WAITSTATE_4_2	(4 << 2)
-#define MEMCFG_WAITSTATE_3_2	(5 << 2)
-#define MEMCFG_WAITSTATE_2_2	(6 << 2)
-#define MEMCFG_WAITSTATE_1_2	(7 << 2)
-#define MEMCFG_WAITSTATE_8_1	(8 << 2)
-#define MEMCFG_WAITSTATE_7_1	(9 << 2)
-#define MEMCFG_WAITSTATE_6_1	(10 << 2)
-#define MEMCFG_WAITSTATE_5_1	(11 << 2)
-#define MEMCFG_WAITSTATE_4_0	(12 << 2)
-#define MEMCFG_WAITSTATE_3_0	(13 << 2)
-#define MEMCFG_WAITSTATE_2_0	(14 << 2)
-#define MEMCFG_WAITSTATE_1_0	(15 << 2)
-
-/* INTSR1 Interrupts */
-#define IRQ_CSINT		(4)
-#define IRQ_EINT1		(5)
-#define IRQ_EINT2		(6)
-#define IRQ_EINT3		(7)
-#define IRQ_TC1OI		(8)
-#define IRQ_TC2OI		(9)
-#define IRQ_RTCMI		(10)
-#define IRQ_TINT		(11)
-#define IRQ_UTXINT1		(12)
-#define IRQ_URXINT1		(13)
-#define IRQ_UMSINT		(14)
-#define IRQ_SSEOTI		(15)
-
-/* INTSR2 Interrupts */
-#define IRQ_KBDINT		(16 + 0)
-#define IRQ_SS2RX		(16 + 1)
-#define IRQ_SS2TX		(16 + 2)
-#define IRQ_UTXINT2		(16 + 12)
-#define IRQ_URXINT2		(16 + 13)
-
-/* INTSR3 Interrupts */
-#define IRQ_DAIINT		(32 + 0)
-
-#endif /* __MACH_CLPS711X_H */
diff --git a/arch/arm/mach-clps711x/include/mach/hardware.h b/arch/arm/mach-clps711x/include/mach/hardware.h
deleted file mode 100644
index cfd0e2c..0000000
--- a/arch/arm/mach-clps711x/include/mach/hardware.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/*
- *  arch/arm/mach-clps711x/include/mach/hardware.h
- *
- *  This file contains the hardware definitions of the Prospector P720T.
- *
- *  Copyright (C) 2000 Deep Blue Solutions Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-#ifndef __MACH_HARDWARE_H
-#define __MACH_HARDWARE_H
-
-#include <mach/clps711x.h>
-
-#define CLPS711X_VIRT_BASE	IOMEM(0xfeff4000)
-
-#ifndef __ASSEMBLY__
-#define clps_readb(off)		readb(CLPS711X_VIRT_BASE + (off))
-#define clps_readw(off)		readw(CLPS711X_VIRT_BASE + (off))
-#define clps_readl(off)		readl(CLPS711X_VIRT_BASE + (off))
-#define clps_writeb(val,off)	writeb(val, CLPS711X_VIRT_BASE + (off))
-#define clps_writew(val,off)	writew(val, CLPS711X_VIRT_BASE + (off))
-#define clps_writel(val,off)	writel(val, CLPS711X_VIRT_BASE + (off))
-#endif
-
-#define CS0_PHYS_BASE		(0x00000000)
-#define CS1_PHYS_BASE		(0x10000000)
-#define CS2_PHYS_BASE		(0x20000000)
-#define CS3_PHYS_BASE		(0x30000000)
-#define CS4_PHYS_BASE		(0x40000000)
-#define CS5_PHYS_BASE		(0x50000000)
-#define CS6_PHYS_BASE		(0x60000000)
-#define CS7_PHYS_BASE		(0x70000000)
-
-#define CLPS711X_SRAM_BASE	CS6_PHYS_BASE
-#define CLPS711X_SRAM_SIZE	(48 * 1024)
-
-#define CLPS711X_SDRAM0_BASE	(0xc0000000)
-#define CLPS711X_SDRAM1_BASE	(0xd0000000)
-
-#endif
diff --git a/arch/arm/mach-clps711x/include/mach/uncompress.h b/arch/arm/mach-clps711x/include/mach/uncompress.h
deleted file mode 100644
index 5f02d06..0000000
--- a/arch/arm/mach-clps711x/include/mach/uncompress.h
+++ /dev/null
@@ -1,55 +0,0 @@
-/*
- *  arch/arm/mach-clps711x/include/mach/uncompress.h
- *
- *  Copyright (C) 2000 Deep Blue Solutions Ltd
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-#include <mach/clps711x.h>
-
-#ifdef CONFIG_DEBUG_CLPS711X_UART2
-#define SYSFLGx	SYSFLG2
-#define UARTDRx	UARTDR2
-#else
-#define SYSFLGx	SYSFLG1
-#define UARTDRx	UARTDR1
-#endif
-
-#define phys_reg(x)	(*(volatile u32 *)(CLPS711X_PHYS_BASE + (x)))
-
-/*
- * The following code assumes the serial port has already been
- * initialized by the bootloader.  If you didn't setup a port in
- * your bootloader then nothing will appear (which might be desired).
- *
- * This does not append a newline
- */
-static inline void putc(int c)
-{
-	while (phys_reg(SYSFLGx) & SYSFLG_UTXFF)
-		barrier();
-	phys_reg(UARTDRx) = c;
-}
-
-static inline void flush(void)
-{
-	while (phys_reg(SYSFLGx) & SYSFLG_UBUSY)
-		barrier();
-}
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
-- 
2.4.9
