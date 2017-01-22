From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 22 Jan 2017 13:24:00 +0100
Subject: [PATCH 21/22] ARM: gemini: convert to ARMv4 multiplatform
Message-ID: <20170122122400.11109-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This converts the Gemini platform to ARMv4 multiplatform, deleting
the local <mach/*> include directory, moving an idiomatic local
idling function into the .machine_init() call and getting rid of
the Makefile.boot finally.

Cc: Janos Laube <janos.dev@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                               | 23 +--------
 arch/arm/mach-gemini/Kconfig                   | 12 +++++
 arch/arm/mach-gemini/Makefile                  |  2 +-
 arch/arm/mach-gemini/Makefile.boot             |  1 -
 arch/arm/mach-gemini/board-dt.c                | 24 +++++++++
 arch/arm/mach-gemini/idle.c                    | 31 -----------
 arch/arm/mach-gemini/include/mach/hardware.h   | 71 --------------------------
 arch/arm/mach-gemini/include/mach/uncompress.h | 42 ---------------
 8 files changed, 39 insertions(+), 167 deletions(-)
 create mode 100644 arch/arm/mach-gemini/Kconfig
 delete mode 100644 arch/arm/mach-gemini/Makefile.boot
 delete mode 100644 arch/arm/mach-gemini/idle.c
 delete mode 100644 arch/arm/mach-gemini/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-gemini/include/mach/uncompress.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2e99bf1c5c53..6683d266950d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -353,27 +353,6 @@ config ARM_SINGLE_ARMV7M
 	select SPARSE_IRQ
 	select USE_OF
 
-config ARCH_GEMINI
-	bool "Cortina Systems Gemini"
-	select ARM_APPENDED_DTB # Old Redboot bootloaders deployed
-	select ARM_PATCH_PHYS_VIRT
-	select AUTO_ZRELADDR
-	select CLKSRC_MMIO
-	select CLKSRC_OF
-	select CPU_FA526
-	select GEMINI_TIMER
-	select GENERIC_CLOCKEVENTS
-	select GPIO_GEMINI
-	select GPIOLIB
-	select MULTI_IRQ_HANDLER
-	select POWER_RESET
-	select POWER_RESET_SYSCON
-	select SERIAL_OF_PLATFORM
-	select SPARSE_IRQ
-	select USE_OF
-	help
-	  Support for the Cortina Systems Gemini family SoCs
-
 config ARCH_EBSA110
 	bool "EBSA-110"
 	select ARCH_USES_GETTIMEOFFSET
@@ -754,6 +733,8 @@ source "arch/arm/mach-ep93xx/Kconfig"
 
 source "arch/arm/mach-footbridge/Kconfig"
 
+source "arch/arm/mach-gemini/Kconfig"
+
 source "arch/arm/mach-highbank/Kconfig"
 
 source "arch/arm/mach-hisi/Kconfig"
diff --git a/arch/arm/mach-gemini/Kconfig b/arch/arm/mach-gemini/Kconfig
new file mode 100644
index 000000000000..798abb16bb88
--- /dev/null
+++ b/arch/arm/mach-gemini/Kconfig
@@ -0,0 +1,12 @@
+menuconfig ARCH_GEMINI
+	bool "Cortina Systems Gemini"
+	depends on ARCH_MULTI_V4
+	select ARM_APPENDED_DTB # Old Redboot bootloaders deployed
+	select GEMINI_TIMER
+	select GPIO_GEMINI
+	select GPIOLIB
+	select POWER_RESET
+	select POWER_RESET_SYSCON
+	select SERIAL_OF_PLATFORM
+	help
+	  Support for the Cortina Systems Gemini family SoCs
diff --git a/arch/arm/mach-gemini/Makefile b/arch/arm/mach-gemini/Makefile
index 30c5acffe948..ca0db5477180 100644
--- a/arch/arm/mach-gemini/Makefile
+++ b/arch/arm/mach-gemini/Makefile
@@ -1,2 +1,2 @@
 # Makefile for Cortina systems Gemini
-obj-y			:= idle.o board-dt.o
+obj-y			:= board-dt.o
diff --git a/arch/arm/mach-gemini/Makefile.boot b/arch/arm/mach-gemini/Makefile.boot
deleted file mode 100644
index 8e3d1c6e1e38..000000000000
--- a/arch/arm/mach-gemini/Makefile.boot
+++ /dev/null
@@ -1 +0,0 @@
-# Empty on purpose
diff --git a/arch/arm/mach-gemini/board-dt.c b/arch/arm/mach-gemini/board-dt.c
index 2983246d9c63..aabed8409779 100644
--- a/arch/arm/mach-gemini/board-dt.c
+++ b/arch/arm/mach-gemini/board-dt.c
@@ -7,6 +7,8 @@
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <asm/system_misc.h>
+#include <asm/proc-fns.h>
 
 /* Can we just use CONFIG_DEBUG_UART_PHYS and CONFIG_DEBUG_UART_VIRT? */
 #define GEMINI_UART_BASE 0x42000000
@@ -27,6 +29,27 @@ static void __init gemini_map_io(void)
 	iotable_init(gemini_io_desc, ARRAY_SIZE(gemini_io_desc));
 }
 
+static void gemini_idle(void)
+{
+	/*
+	 * Because of broken hardware we have to enable interrupts or the CPU
+	 * will never wakeup... Acctualy it is not very good to enable
+	 * interrupts first since scheduler can miss a tick, but there is
+	 * no other way around this. Platforms that needs it for power saving
+	 * should enable it in init code, since by default it is
+	 * disabled.
+	 */
+
+	/* FIXME: Enabling interrupts here is racy! */
+	local_irq_enable();
+	cpu_do_idle();
+}
+
+static void __init gemini_init_machine(void)
+{
+	arm_pm_idle = gemini_idle;
+}
+
 static const char *gemini_board_compat[] = {
 	"cortina,gemini",
 	NULL,
@@ -34,5 +57,6 @@ static const char *gemini_board_compat[] = {
 
 DT_MACHINE_START(GEMINI_DT, "Gemini (Device Tree)")
 	.map_io		= gemini_map_io,
+	.init_machine	= gemini_init_machine,
 	.dt_compat	= gemini_board_compat,
 MACHINE_END
diff --git a/arch/arm/mach-gemini/idle.c b/arch/arm/mach-gemini/idle.c
deleted file mode 100644
index ddf8ec9d203b..000000000000
--- a/arch/arm/mach-gemini/idle.c
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- * arch/arm/mach-gemini/idle.c
- */
-
-#include <linux/init.h>
-#include <asm/system_misc.h>
-#include <asm/proc-fns.h>
-
-static void gemini_idle(void)
-{
-	/*
-	 * Because of broken hardware we have to enable interrupts or the CPU
-	 * will never wakeup... Acctualy it is not very good to enable
-	 * interrupts first since scheduler can miss a tick, but there is
-	 * no other way around this. Platforms that needs it for power saving
-	 * should enable it in init code, since by default it is
-	 * disabled.
-	 */
-
-	/* FIXME: Enabling interrupts here is racy! */
-	local_irq_enable();
-	cpu_do_idle();
-}
-
-static int __init gemini_idle_init(void)
-{
-	arm_pm_idle = gemini_idle;
-	return 0;
-}
-
-arch_initcall(gemini_idle_init);
diff --git a/arch/arm/mach-gemini/include/mach/hardware.h b/arch/arm/mach-gemini/include/mach/hardware.h
deleted file mode 100644
index f0390f184742..000000000000
--- a/arch/arm/mach-gemini/include/mach/hardware.h
+++ /dev/null
@@ -1,71 +0,0 @@
-/*
- *  This file contains the hardware definitions for Gemini.
- *
- *  Copyright (C) 2001-2006 Storlink, Corp.
- *  Copyright (C) 2008-2009 Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-#ifndef __MACH_HARDWARE_H
-#define __MACH_HARDWARE_H
-
-/*
- * Memory Map definitions
- */
-#ifdef CONFIG_GEMINI_MEM_SWAP
-# define GEMINI_DRAM_BASE	0x00000000
-# define GEMINI_SRAM_BASE	0x70000000
-#else
-# define GEMINI_SRAM_BASE	0x00000000
-# define GEMINI_DRAM_BASE	0x10000000
-#endif
-#define GEMINI_FLASH_BASE	0x30000000
-#define GEMINI_GLOBAL_BASE	0x40000000
-#define GEMINI_WAQTCHDOG_BASE	0x41000000
-#define GEMINI_UART_BASE	0x42000000
-#define GEMINI_TIMER_BASE	0x43000000
-#define GEMINI_LCD_BASE		0x44000000
-#define GEMINI_RTC_BASE		0x45000000
-#define GEMINI_SATA_BASE	0x46000000
-#define GEMINI_LPC_HOST_BASE	0x47000000
-#define GEMINI_LPC_IO_BASE	0x47800000
-#define GEMINI_INTERRUPT_BASE	0x48000000
-/* TODO: Different interrupt controllers when SMP
- * #define GEMINI_INTERRUPT0_BASE	0x48000000
- * #define GEMINI_INTERRUPT1_BASE	0x49000000
- */
-#define GEMINI_SSP_CTRL_BASE	0x4A000000
-#define GEMINI_POWER_CTRL_BASE	0x4B000000
-#define GEMINI_CIR_BASE		0x4C000000
-#define GEMINI_GPIO_BASE(x)	(0x4D000000 + (x) * 0x1000000)
-#define GEMINI_PCI_IO_BASE	0x50000000
-#define GEMINI_PCI_MEM_BASE	0x58000000
-#define GEMINI_TOE_BASE		0x60000000
-#define GEMINI_GMAC0_BASE	0x6000A000
-#define GEMINI_GMAC1_BASE	0x6000E000
-#define GEMINI_SECURITY_BASE	0x62000000
-#define GEMINI_IDE0_BASE	0x63000000
-#define GEMINI_IDE1_BASE	0x63400000
-#define GEMINI_RAID_BASE	0x64000000
-#define GEMINI_FLASH_CTRL_BASE	0x65000000
-#define GEMINI_DRAM_CTRL_BASE	0x66000000
-#define GEMINI_GENERAL_DMA_BASE	0x67000000
-#define GEMINI_USB0_BASE	0x68000000
-#define GEMINI_USB1_BASE	0x69000000
-#define GEMINI_BIG_ENDIAN_BASE	0x80000000
-
-
-/*
- * UART Clock when System clk is 150MHz
- */
-#define UART_CLK	48000000
-
-/*
- * macro to get at IO space when running virtually
- */
-#define IO_ADDRESS(x)	IOMEM((((x) & 0xFFF00000) >> 4) | ((x) & 0x000FFFFF) | 0xF0000000)
-
-#endif
diff --git a/arch/arm/mach-gemini/include/mach/uncompress.h b/arch/arm/mach-gemini/include/mach/uncompress.h
deleted file mode 100644
index 02e225673acb..000000000000
--- a/arch/arm/mach-gemini/include/mach/uncompress.h
+++ /dev/null
@@ -1,42 +0,0 @@
-/*
- * Copyright (C) 2008-2009 Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
- *
- * Based on mach-pxa/include/mach/uncompress.h:
- * Copyright:	(C) 2001 MontaVista Software Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#ifndef __MACH_UNCOMPRESS_H
-#define __MACH_UNCOMPRESS_H
-
-#include <linux/serial_reg.h>
-#include <mach/hardware.h>
-
-static volatile unsigned long * const UART = (unsigned long *)GEMINI_UART_BASE;
-
-/*
- * The following code assumes the serial port has already been
- * initialized by the bootloader.  If you didn't setup a port in
- * your bootloader then nothing will appear (which might be desired).
- */
-static inline void putc(char c)
-{
-	while (!(UART[UART_LSR] & UART_LSR_THRE))
-		barrier();
-	UART[UART_TX] = c;
-}
-
-static inline void flush(void)
-{
-}
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
-
-#endif /* __MACH_UNCOMPRESS_H */
-- 
2.9.3
