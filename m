From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 5 Apr 2013 16:22:55 +0200
Subject: [PATCH 13/14] ARM: ux500: move to multiplatform
In-Reply-To: <1365171776-8463-1-git-send-email-linus.walleij@stericsson.com>
References: <1365171776-8463-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1365171776-8463-14-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

Nothing is holding us up any more, and we can make ux500 coexist
with the rest of the platforms. The timex.h and uncompress.h
headers are no longer needed now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                              | 15 -------
 arch/arm/mach-ux500/Kconfig                   | 14 +++++++
 arch/arm/mach-ux500/include/mach/timex.h      |  6 ---
 arch/arm/mach-ux500/include/mach/uncompress.h | 58 ---------------------------
 4 files changed, 14 insertions(+), 79 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/include/mach/timex.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/uncompress.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5b71469..65badde 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -901,21 +901,6 @@ config ARCH_U300
 	help
 	  Support for ST-Ericsson U300 series mobile platforms.
 
-config ARCH_U8500
-	bool "ST-Ericsson U8500 Series"
-	depends on MMU
-	select ARCH_HAS_CPUFREQ
-	select ARCH_REQUIRE_GPIOLIB
-	select ARM_AMBA
-	select CLKDEV_LOOKUP
-	select CPU_V7
-	select GENERIC_CLOCKEVENTS
-	select HAVE_SMP
-	select MIGHT_HAVE_CACHE_L2X0
-	select SPARSE_IRQ
-	help
-	  Support for ST-Ericsson's Ux500 architecture
-
 config ARCH_NOMADIK
 	bool "STMicroelectronics Nomadik"
 	select ARCH_REQUIRE_GPIOLIB
diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 3e5bbd0..eeea3bf 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -1,3 +1,17 @@
+config ARCH_U8500
+	bool "ST-Ericsson U8500 Series" if ARCH_MULTI_V7
+	depends on MMU
+	select ARCH_HAS_CPUFREQ
+	select ARCH_REQUIRE_GPIOLIB
+	select ARM_AMBA
+	select CLKDEV_LOOKUP
+	select CPU_V7
+	select GENERIC_CLOCKEVENTS
+	select HAVE_SMP
+	select MIGHT_HAVE_CACHE_L2X0
+	help
+	  Support for ST-Ericsson's Ux500 architecture
+
 if ARCH_U8500
 
 config UX500_SOC_COMMON
diff --git a/arch/arm/mach-ux500/include/mach/timex.h b/arch/arm/mach-ux500/include/mach/timex.h
deleted file mode 100644
index d0942c1..0000000
--- a/arch/arm/mach-ux500/include/mach/timex.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __ASM_ARCH_TIMEX_H
-#define __ASM_ARCH_TIMEX_H
-
-#define CLOCK_TICK_RATE		110000000
-
-#endif
diff --git a/arch/arm/mach-ux500/include/mach/uncompress.h b/arch/arm/mach-ux500/include/mach/uncompress.h
deleted file mode 100644
index 533a004..0000000
--- a/arch/arm/mach-ux500/include/mach/uncompress.h
+++ /dev/null
@@ -1,58 +0,0 @@
-/*
- *  Copyright (C) 2009 ST-Ericsson
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
-#ifndef __ASM_ARCH_UNCOMPRESS_H
-#define __ASM_ARCH_UNCOMPRESS_H
-
-#include <asm/setup.h>
-#include <asm/mach-types.h>
-#include <linux/io.h>
-#include <linux/amba/serial.h>
-/* TODO: This goes away in multiplatform boot, this file gets deleted */
-#include "../../db8500-regs.h"
-
-void __iomem *ux500_uart_base;
-
-static void putc(const char c)
-{
-	/* Do nothing if the UART is not enabled. */
-	if (!(__raw_readb(ux500_uart_base + UART011_CR) & 0x1))
-		return;
-
-	if (c == '\n')
-		putc('\r');
-
-	while (__raw_readb(ux500_uart_base + UART01x_FR) & (1 << 5))
-		barrier();
-	__raw_writeb(c, ux500_uart_base + UART01x_DR);
-}
-
-static void flush(void)
-{
-	if (!(__raw_readb(ux500_uart_base + UART011_CR) & 0x1))
-		return;
-	while (__raw_readb(ux500_uart_base + UART01x_FR) & (1 << 3))
-		barrier();
-}
-
-static inline void arch_decomp_setup(void)
-{
-	/* Use machine_is_foo() macro if you need to switch base someday */
-	ux500_uart_base = (void __iomem *)U8500_UART2_BASE;
-}
-
-#endif /* __ASM_ARCH_UNCOMPRESS_H */
-- 
1.7.11.3
