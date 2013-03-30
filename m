From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 29 Mar 2013 18:19:50 -0600
Subject: [PATCH 2/2] ARM: tegra: convert to multi-platform
In-Reply-To: <1364602790-10759-1-git-send-email-swarren@wwwdotorg.org>
References: <1364602790-10759-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1364602790-10759-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This allows Tegra be included in a kernel build that supports multiple
SoCs at once, which is useful for distro kernels.

This change:
* Moves Tegra's Kconfig into its own directory, as seems typical for
  multi-platform conversions.
* Stops selecting some ARM errata that are incompatible with multi-
  platform. This requires that you use a bootloader that enables the
  workaround!
* Deletes some headers and Makefile.boot that aren't needed now that we
  support multi-platform.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/Kconfig                              |   19 ---
 arch/arm/mach-tegra/Kconfig                   |   27 +++-
 arch/arm/mach-tegra/Makefile.boot             |    3 -
 arch/arm/mach-tegra/include/mach/timex.h      |   26 ----
 arch/arm/mach-tegra/include/mach/uncompress.h |  175 -------------------------
 5 files changed, 20 insertions(+), 230 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/Makefile.boot
 delete mode 100644 arch/arm/mach-tegra/include/mach/timex.h
 delete mode 100644 arch/arm/mach-tegra/include/mach/uncompress.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 59b7be7..f6dfe23 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -663,25 +663,6 @@ config ARCH_LPC32XX
 	help
 	  Support for the NXP LPC32XX family of processors
 
-config ARCH_TEGRA
-	bool "NVIDIA Tegra"
-	select ARCH_HAS_CPUFREQ
-	select ARCH_REQUIRE_GPIOLIB
-	select CLKDEV_LOOKUP
-	select CLKSRC_MMIO
-	select CLKSRC_OF
-	select COMMON_CLK
-	select GENERIC_CLOCKEVENTS
-	select HAVE_CLK
-	select HAVE_SMP
-	select MIGHT_HAVE_CACHE_L2X0
-	select SOC_BUS
-	select SPARSE_IRQ
-	select USE_OF
-	help
-	  This enables support for NVIDIA Tegra based systems (Tegra APX,
-	  Tegra 6xx and Tegra 2 series).
-
 config ARCH_PXA
 	bool "PXA2xx/PXA3xx-based"
 	depends on MMU
diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index d1c4893..df99ee9 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -1,13 +1,28 @@
-if ARCH_TEGRA
+config ARCH_TEGRA
+	bool "NVIDIA Tegra" if ARCH_MULTI_V7
+	select ARCH_HAS_CPUFREQ
+	select ARCH_REQUIRE_GPIOLIB
+	select CLKDEV_LOOKUP
+	select CLKSRC_MMIO
+	select CLKSRC_OF
+	select COMMON_CLK
+	select GENERIC_CLOCKEVENTS
+	select HAVE_CLK
+	select HAVE_SMP
+	select MIGHT_HAVE_CACHE_L2X0
+	select SOC_BUS
+	select SPARSE_IRQ
+	select USE_OF
+	help
+	  This enables support for NVIDIA Tegra based systems.
 
-comment "NVIDIA Tegra options"
+menu "NVIDIA Tegra options"
+	depends on ARCH_TEGRA
 
 config ARCH_TEGRA_2x_SOC
 	bool "Enable support for Tegra20 family"
 	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
 	select ARM_ERRATA_720789
-	select ARM_ERRATA_742230 if SMP
-	select ARM_ERRATA_751472
 	select ARM_ERRATA_754327 if SMP
 	select ARM_ERRATA_764369 if SMP
 	select ARM_GIC
@@ -26,8 +41,6 @@ config ARCH_TEGRA_2x_SOC
 
 config ARCH_TEGRA_3x_SOC
 	bool "Enable support for Tegra30 family"
-	select ARM_ERRATA_743622
-	select ARM_ERRATA_751472
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_764369 if SMP
 	select ARM_GIC
@@ -71,4 +84,4 @@ config TEGRA_AHB
 config TEGRA_EMC_SCALING_ENABLE
 	bool "Enable scaling the memory frequency"
 
-endif
+endmenu
diff --git a/arch/arm/mach-tegra/Makefile.boot b/arch/arm/mach-tegra/Makefile.boot
deleted file mode 100644
index 2943381..0000000
--- a/arch/arm/mach-tegra/Makefile.boot
+++ /dev/null
@@ -1,3 +0,0 @@
-zreladdr-$(CONFIG_ARCH_TEGRA_2x_SOC)	+= 0x00008000
-params_phys-$(CONFIG_ARCH_TEGRA_2x_SOC)	:= 0x00000100
-initrd_phys-$(CONFIG_ARCH_TEGRA_2x_SOC)	:= 0x00800000
diff --git a/arch/arm/mach-tegra/include/mach/timex.h b/arch/arm/mach-tegra/include/mach/timex.h
deleted file mode 100644
index a44ccbd..0000000
--- a/arch/arm/mach-tegra/include/mach/timex.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * arch/arm/mach-tegra/include/mach/timex.h
- *
- * Copyright (C) 2010 Google, Inc.
- *
- * Author:
- *	Colin Cross <ccross@google.com>
- *	Erik Gilling <konkers@google.com>
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#ifndef __MACH_TEGRA_TIMEX_H
-#define __MACH_TEGRA_TIMEX_H
-
-#define CLOCK_TICK_RATE		1000000
-
-#endif
diff --git a/arch/arm/mach-tegra/include/mach/uncompress.h b/arch/arm/mach-tegra/include/mach/uncompress.h
deleted file mode 100644
index 0838641..0000000
--- a/arch/arm/mach-tegra/include/mach/uncompress.h
+++ /dev/null
@@ -1,175 +0,0 @@
-/*
- * arch/arm/mach-tegra/include/mach/uncompress.h
- *
- * Copyright (C) 2010 Google, Inc.
- * Copyright (C) 2011 Google, Inc.
- * Copyright (C) 2011-2012 NVIDIA CORPORATION. All Rights Reserved.
- *
- * Author:
- *	Colin Cross <ccross@google.com>
- *	Erik Gilling <konkers@google.com>
- *	Doug Anderson <dianders@chromium.org>
- *	Stephen Warren <swarren@nvidia.com>
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#ifndef __MACH_TEGRA_UNCOMPRESS_H
-#define __MACH_TEGRA_UNCOMPRESS_H
-
-#include <linux/types.h>
-#include <linux/serial_reg.h>
-
-#include "../../iomap.h"
-
-#define BIT(x) (1 << (x))
-#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
-
-#define DEBUG_UART_SHIFT 2
-
-volatile u8 *uart;
-
-static void putc(int c)
-{
-	if (uart == NULL)
-		return;
-
-	while (!(uart[UART_LSR << DEBUG_UART_SHIFT] & UART_LSR_THRE))
-		barrier();
-	uart[UART_TX << DEBUG_UART_SHIFT] = c;
-}
-
-static inline void flush(void)
-{
-}
-
-static const struct {
-	u32 base;
-	u32 reset_reg;
-	u32 clock_reg;
-	u32 bit;
-} uarts[] = {
-	{
-		TEGRA_UARTA_BASE,
-		TEGRA_CLK_RESET_BASE + 0x04,
-		TEGRA_CLK_RESET_BASE + 0x10,
-		6,
-	},
-	{
-		TEGRA_UARTB_BASE,
-		TEGRA_CLK_RESET_BASE + 0x04,
-		TEGRA_CLK_RESET_BASE + 0x10,
-		7,
-	},
-	{
-		TEGRA_UARTC_BASE,
-		TEGRA_CLK_RESET_BASE + 0x08,
-		TEGRA_CLK_RESET_BASE + 0x14,
-		23,
-	},
-	{
-		TEGRA_UARTD_BASE,
-		TEGRA_CLK_RESET_BASE + 0x0c,
-		TEGRA_CLK_RESET_BASE + 0x18,
-		1,
-	},
-	{
-		TEGRA_UARTE_BASE,
-		TEGRA_CLK_RESET_BASE + 0x0c,
-		TEGRA_CLK_RESET_BASE + 0x18,
-		2,
-	},
-};
-
-static inline bool uart_clocked(int i)
-{
-	if (*(u8 *)uarts[i].reset_reg & BIT(uarts[i].bit))
-		return false;
-
-	if (!(*(u8 *)uarts[i].clock_reg & BIT(uarts[i].bit)))
-		return false;
-
-	return true;
-}
-
-#ifdef CONFIG_TEGRA_DEBUG_UART_AUTO_ODMDATA
-int auto_odmdata(void)
-{
-	volatile u32 *pmc = (volatile u32 *)TEGRA_PMC_BASE;
-	u32 odmdata = pmc[0xa0 / 4];
-
-	/*
-	 * Bits 19:18 are the console type: 0=default, 1=none, 2==DCC, 3==UART
-	 * Some boards apparently swap the last two values, but we don't have
-	 * any way of catering for that here, so we just accept either. If this
-	 * doesn't make sense for your board, just don't enable this feature.
-	 *
-	 * Bits 17:15 indicate the UART to use, 0/1/2/3/4 are UART A/B/C/D/E.
-	 */
-
-	switch  ((odmdata >> 18) & 3) {
-	case 2:
-	case 3:
-		break;
-	default:
-		return -1;
-	}
-
-	return (odmdata >> 15) & 7;
-}
-#endif
-
-/*
- * Setup before decompression.  This is where we do UART selection for
- * earlyprintk and init the uart_base register.
- */
-static inline void arch_decomp_setup(void)
-{
-	int uart_id;
-	volatile u32 *apb_misc = (volatile u32 *)TEGRA_APB_MISC_BASE;
-	u32 chip, div;
-
-#if defined(CONFIG_TEGRA_DEBUG_UART_AUTO_ODMDATA)
-	uart_id = auto_odmdata();
-#elif defined(CONFIG_TEGRA_DEBUG_UARTA)
-	uart_id = 0;
-#elif defined(CONFIG_TEGRA_DEBUG_UARTB)
-	uart_id = 1;
-#elif defined(CONFIG_TEGRA_DEBUG_UARTC)
-	uart_id = 2;
-#elif defined(CONFIG_TEGRA_DEBUG_UARTD)
-	uart_id = 3;
-#elif defined(CONFIG_TEGRA_DEBUG_UARTE)
-	uart_id = 4;
-#endif
-
-	if (uart_id < 0 || uart_id >= ARRAY_SIZE(uarts) ||
-	    !uart_clocked(uart_id))
-		uart = NULL;
-	else
-		uart = (volatile u8 *)uarts[uart_id].base;
-
-	if (uart == NULL)
-		return;
-
-	chip = (apb_misc[0x804 / 4] >> 8) & 0xff;
-	if (chip == 0x20)
-		div = 0x0075;
-	else
-		div = 0x00dd;
-
-	uart[UART_LCR << DEBUG_UART_SHIFT] |= UART_LCR_DLAB;
-	uart[UART_DLL << DEBUG_UART_SHIFT] = div & 0xff;
-	uart[UART_DLM << DEBUG_UART_SHIFT] = div >> 8;
-	uart[UART_LCR << DEBUG_UART_SHIFT] = 3;
-}
-
-#endif
-- 
1.7.10.4
