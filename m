From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Mar 2013 12:41:18 +0100
Subject: [PATCH 7/8] ARM: sirf: enable multiplatform support
In-Reply-To: <1363779679-16880-1-git-send-email-arnd@arndb.de>
References: <1363779679-16880-1-git-send-email-arnd@arndb.de>
Message-ID: <1363779679-16880-8-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the prerequisites are there now, so we can move sirf into multiplatform.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                                | 17 ----------
 arch/arm/mach-prima2/Kconfig                    | 12 ++++++++
 arch/arm/mach-prima2/Makefile                   |  2 ++
 arch/arm/mach-prima2/common.h                   |  3 ++
 arch/arm/mach-prima2/include/mach/clkdev.h      | 15 ---------
 arch/arm/mach-prima2/include/mach/entry-macro.S | 22 -------------
 arch/arm/mach-prima2/include/mach/hardware.h    | 15 ---------
 arch/arm/mach-prima2/include/mach/map.h         | 18 -----------
 arch/arm/mach-prima2/include/mach/timex.h       | 14 ---------
 arch/arm/mach-prima2/include/mach/uart.h        | 29 -----------------
 arch/arm/mach-prima2/include/mach/uncompress.h  | 41 -------------------------
 arch/arm/mach-prima2/lluart.c                   |  2 +-
 arch/arm/mach-prima2/platsmp.c                  |  1 -
 13 files changed, 18 insertions(+), 173 deletions(-)
 delete mode 100644 arch/arm/mach-prima2/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-prima2/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-prima2/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-prima2/include/mach/map.h
 delete mode 100644 arch/arm/mach-prima2/include/mach/timex.h
 delete mode 100644 arch/arm/mach-prima2/include/mach/uart.h
 delete mode 100644 arch/arm/mach-prima2/include/mach/uncompress.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c674b32..1bcec63 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -49,7 +49,6 @@ config ARM
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UID16
-	select HAVE_VIRT_TO_BUS
 	select KTIME_SCALAR
 	select PERF_USE_VMALLOC
 	select RTC_LIB
@@ -415,22 +414,6 @@ config ARCH_GEMINI
 	help
 	  Support for the Cortina Systems Gemini family SoCs
 
-config ARCH_SIRF
-	bool "CSR SiRF"
-	select ARCH_REQUIRE_GPIOLIB
-	select AUTO_ZRELADDR
-	select COMMON_CLK
-	select GENERIC_CLOCKEVENTS
-	select GENERIC_IRQ_CHIP
-	select MIGHT_HAVE_CACHE_L2X0
-	select NO_IOPORT
-	select PINCTRL
-	select PINCTRL_SIRF
-	select USE_OF
-	select SPARSE_IRQ
-	help
-	  Support for CSR SiRFprimaII/Marco/Polo platforms
-
 config ARCH_EBSA110
 	bool "EBSA-110"
 	select ARCH_USES_GETTIMEOFFSET
diff --git a/arch/arm/mach-prima2/Kconfig b/arch/arm/mach-prima2/Kconfig
index b3be799..587c0bd 100644
--- a/arch/arm/mach-prima2/Kconfig
+++ b/arch/arm/mach-prima2/Kconfig
@@ -1,3 +1,15 @@
+config ARCH_SIRF
+	bool "CSR SiRF" if ARCH_MULTI_V7
+	select ARCH_REQUIRE_GPIOLIB
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_IRQ_CHIP
+	select MIGHT_HAVE_CACHE_L2X0
+	select NO_IOPORT
+	select PINCTRL
+	select PINCTRL_SIRF
+	help
+	  Support for CSR SiRFprimaII/Marco/Polo platforms
+
 if ARCH_SIRF
 
 menu "CSR SiRF atlas6/primaII/Marco/Polo Specific Features"
diff --git a/arch/arm/mach-prima2/Makefile b/arch/arm/mach-prima2/Makefile
index 4e1d3d2..f9ee89b 100644
--- a/arch/arm/mach-prima2/Makefile
+++ b/arch/arm/mach-prima2/Makefile
@@ -7,3 +7,5 @@ obj-$(CONFIG_SUSPEND) += pm.o sleep.o
 obj-$(CONFIG_SIRF_IRQ) += irq.o
 obj-$(CONFIG_SMP) += platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)  += hotplug.o
+
+CFLAGS_hotplug.o += -march=armv7-a
diff --git a/arch/arm/mach-prima2/common.h b/arch/arm/mach-prima2/common.h
index 54262cf..81135cd 100644
--- a/arch/arm/mach-prima2/common.h
+++ b/arch/arm/mach-prima2/common.h
@@ -13,6 +13,9 @@
 #include <asm/mach/time.h>
 #include <asm/exception.h>
 
+#define SIRFSOC_VA_BASE		_AC(0xFEC00000, UL)
+#define SIRFSOC_VA(x)		(SIRFSOC_VA_BASE + ((x) & 0x00FFF000))
+
 extern struct smp_operations   sirfsoc_smp_ops;
 extern void sirfsoc_secondary_startup(void);
 extern void sirfsoc_cpu_die(unsigned int cpu);
diff --git a/arch/arm/mach-prima2/include/mach/clkdev.h b/arch/arm/mach-prima2/include/mach/clkdev.h
deleted file mode 100644
index 6693251..0000000
--- a/arch/arm/mach-prima2/include/mach/clkdev.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/*
- * arch/arm/mach-prima2/include/mach/clkdev.h
- *
- * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
- *
- * Licensed under GPLv2 or later.
- */
-
-#ifndef __MACH_CLKDEV_H
-#define __MACH_CLKDEV_H
-
-#define __clk_get(clk) ({ 1; })
-#define __clk_put(clk) do { } while (0)
-
-#endif
diff --git a/arch/arm/mach-prima2/include/mach/entry-macro.S b/arch/arm/mach-prima2/include/mach/entry-macro.S
deleted file mode 100644
index 86434e7..0000000
--- a/arch/arm/mach-prima2/include/mach/entry-macro.S
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * arch/arm/mach-prima2/include/mach/entry-macro.S
- *
- * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
- *
- * Licensed under GPLv2 or later.
- */
-
-#include <mach/hardware.h>
-
-#define SIRFSOC_INT_ID 0x38
-
-	.macro  get_irqnr_preamble, base, tmp
-	ldr     \base, =sirfsoc_intc_base
-	ldr     \base, [\base]
-	.endm
-
-	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
-	ldr \irqnr, [\base, #SIRFSOC_INT_ID]	@ Get the highest priority irq
-	cmp \irqnr, #0x40			@ the irq num can't be larger than 0x3f
-	movges \irqnr, #0
-	.endm
diff --git a/arch/arm/mach-prima2/include/mach/hardware.h b/arch/arm/mach-prima2/include/mach/hardware.h
deleted file mode 100644
index 105b969..0000000
--- a/arch/arm/mach-prima2/include/mach/hardware.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/*
- * arch/arm/mach-prima2/include/mach/hardware.h
- *
- * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
- *
- * Licensed under GPLv2 or later.
- */
-
-#ifndef __MACH_HARDWARE_H__
-#define __MACH_HARDWARE_H__
-
-#include <asm/sizes.h>
-#include <mach/map.h>
-
-#endif
diff --git a/arch/arm/mach-prima2/include/mach/map.h b/arch/arm/mach-prima2/include/mach/map.h
deleted file mode 100644
index 6f24353..0000000
--- a/arch/arm/mach-prima2/include/mach/map.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * memory & I/O static mapping definitions for CSR SiRFprimaII
- *
- * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
- *
- * Licensed under GPLv2 or later.
- */
-
-#ifndef __MACH_PRIMA2_MAP_H__
-#define __MACH_PRIMA2_MAP_H__
-
-#include <linux/const.h>
-
-#define SIRFSOC_VA_BASE		_AC(0xFEC00000, UL)
-
-#define SIRFSOC_VA(x)		(SIRFSOC_VA_BASE + ((x) & 0x00FFF000))
-
-#endif
diff --git a/arch/arm/mach-prima2/include/mach/timex.h b/arch/arm/mach-prima2/include/mach/timex.h
deleted file mode 100644
index d6f98a7..0000000
--- a/arch/arm/mach-prima2/include/mach/timex.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * arch/arm/mach-prima2/include/mach/timex.h
- *
- * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
- *
- * Licensed under GPLv2 or later.
- */
-
-#ifndef __MACH_TIMEX_H__
-#define __MACH_TIMEX_H__
-
-#define CLOCK_TICK_RATE  1000000
-
-#endif
diff --git a/arch/arm/mach-prima2/include/mach/uart.h b/arch/arm/mach-prima2/include/mach/uart.h
deleted file mode 100644
index c10510d..0000000
--- a/arch/arm/mach-prima2/include/mach/uart.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * arch/arm/mach-prima2/include/mach/uart.h
- *
- * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
- *
- * Licensed under GPLv2 or later.
- */
-
-#ifndef __MACH_PRIMA2_SIRFSOC_UART_H
-#define __MACH_PRIMA2_SIRFSOC_UART_H
-
-/* UART-1: used as serial debug port */
-#if defined(CONFIG_DEBUG_SIRFPRIMA2_UART1)
-#define SIRFSOC_UART1_PA_BASE          0xb0060000
-#elif defined(CONFIG_DEBUG_SIRFMARCO_UART1)
-#define SIRFSOC_UART1_PA_BASE          0xcc060000
-#else
-#define SIRFSOC_UART1_PA_BASE          0
-#endif
-#define SIRFSOC_UART1_VA_BASE          SIRFSOC_VA(0x060000)
-#define SIRFSOC_UART1_SIZE		SZ_4K
-
-#define SIRFSOC_UART_TXFIFO_STATUS	0x0114
-#define SIRFSOC_UART_TXFIFO_DATA	0x0118
-
-#define SIRFSOC_UART1_TXFIFO_FULL                       (1 << 5)
-#define SIRFSOC_UART1_TXFIFO_EMPTY			(1 << 6)
-
-#endif
diff --git a/arch/arm/mach-prima2/include/mach/uncompress.h b/arch/arm/mach-prima2/include/mach/uncompress.h
deleted file mode 100644
index d1513a3..0000000
--- a/arch/arm/mach-prima2/include/mach/uncompress.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * arch/arm/mach-prima2/include/mach/uncompress.h
- *
- * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
- *
- * Licensed under GPLv2 or later.
- */
-
-#ifndef __ASM_ARCH_UNCOMPRESS_H
-#define __ASM_ARCH_UNCOMPRESS_H
-
-#include <linux/io.h>
-#include <mach/hardware.h>
-#include <mach/uart.h>
-
-void arch_decomp_setup(void)
-{
-}
-
-static __inline__ void putc(char c)
-{
-	/*
-	 * during kernel decompression, all mappings are flat:
-	 *  virt_addr == phys_addr
-	 */
-	if (!SIRFSOC_UART1_PA_BASE)
-		return;
-
-	while (__raw_readl((void __iomem *)SIRFSOC_UART1_PA_BASE + SIRFSOC_UART_TXFIFO_STATUS)
-		& SIRFSOC_UART1_TXFIFO_FULL)
-		barrier();
-
-	__raw_writel(c, (void __iomem *)SIRFSOC_UART1_PA_BASE + SIRFSOC_UART_TXFIFO_DATA);
-}
-
-static inline void flush(void)
-{
-}
-
-#endif
-
diff --git a/arch/arm/mach-prima2/lluart.c b/arch/arm/mach-prima2/lluart.c
index 7222481..99c0c92 100644
--- a/arch/arm/mach-prima2/lluart.c
+++ b/arch/arm/mach-prima2/lluart.c
@@ -9,7 +9,7 @@
 #include <linux/kernel.h>
 #include <asm/page.h>
 #include <asm/mach/map.h>
-#include <mach/map.h>
+#include "common.h"
 
 #if defined(CONFIG_DEBUG_SIRFPRIMA2_UART1)
 #define SIRFSOC_UART1_PA_BASE          0xb0060000
diff --git a/arch/arm/mach-prima2/platsmp.c b/arch/arm/mach-prima2/platsmp.c
index 4b78831..d52e322 100644
--- a/arch/arm/mach-prima2/platsmp.c
+++ b/arch/arm/mach-prima2/platsmp.c
@@ -18,7 +18,6 @@
 #include <asm/smp_scu.h>
 #include <asm/cacheflush.h>
 #include <asm/cputype.h>
-#include <mach/map.h>
 
 #include "common.h"
 
-- 
1.8.1.2
