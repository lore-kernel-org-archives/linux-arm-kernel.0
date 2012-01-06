From: swarren@nvidia.com (Stephen Warren)
Date: Fri,  6 Jan 2012 13:43:19 -0700
Subject: [PATCH V2 1/4] ARM: tegra: Introduce define DEBUG_UART_SHIFT
Message-ID: <1325882602-7573-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Doug Anderson <dianders@chromium.org>

This removes the need for the variable "shift" in all functions in
uncompress.h.

Signed-off-by: Doug Anderson <dianders@chromium.org>
[swarren: Extracted from a larger patch by Doug]
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This patch series depends on patch "[PATCH V2] arm/tegra: Support Tegra30
in decompressor UART setup" for context.

This series allows a Tegra zImage to automatically select the UART to use
for the zImage decompressor and early printk, based on information from
the bootloader. The code scans each UART, looking for one that is clocked,
is out of reset, and that the bootloader has written 'D' (for 'D'ebug) to
the scratch register.

At present, the ChromiumOS branch of U-Boot sets up UARTs in this way. If
this patch is accepted into the kernel, I'll upstream the U-Boot change to
mainline U-Boot.

This is important, since different boards use different UARTs, and it's
nice not to have to configure the kernel differently when switching
boards.

 arch/arm/mach-tegra/include/mach/uncompress.h |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-tegra/include/mach/uncompress.h b/arch/arm/mach-tegra/include/mach/uncompress.h
index 39bd5e5..9797279 100644
--- a/arch/arm/mach-tegra/include/mach/uncompress.h
+++ b/arch/arm/mach-tegra/include/mach/uncompress.h
@@ -2,10 +2,12 @@
  * arch/arm/mach-tegra/include/mach/uncompress.h
  *
  * Copyright (C) 2010 Google, Inc.
+ * Copyright (C) 2011 Google, Inc.
  *
  * Author:
  *	Colin Cross <ccross@google.com>
  *	Erik Gilling <konkers@google.com>
+ *	Doug Anderson <dianders@chromium.org>
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, and
@@ -26,17 +28,18 @@
 
 #include <mach/iomap.h>
 
+#define DEBUG_UART_SHIFT 2
+
 static void putc(int c)
 {
 	volatile u8 *uart = (volatile u8 *)TEGRA_DEBUG_UART_BASE;
-	int shift = 2;
 
 	if (uart == NULL)
 		return;
 
-	while (!(uart[UART_LSR << shift] & UART_LSR_THRE))
+	while (!(uart[UART_LSR << DEBUG_UART_SHIFT] & UART_LSR_THRE))
 		barrier();
-	uart[UART_TX << shift] = c;
+	uart[UART_TX << DEBUG_UART_SHIFT] = c;
 }
 
 static inline void flush(void)
@@ -48,7 +51,6 @@ static inline void arch_decomp_setup(void)
 	volatile u32 *apb_misc = (volatile u32 *)TEGRA_APB_MISC_BASE;
 	u32 chip, div;
 	volatile u8 *uart = (volatile u8 *)TEGRA_DEBUG_UART_BASE;
-	int shift = 2;
 
 	if (uart == NULL)
 		return;
@@ -59,10 +61,10 @@ static inline void arch_decomp_setup(void)
 	else
 		div = 0x00dd;
 
-	uart[UART_LCR << shift] |= UART_LCR_DLAB;
-	uart[UART_DLL << shift] = div & 0xff;
-	uart[UART_DLM << shift] = div >> 8;
-	uart[UART_LCR << shift] = 3;
+	uart[UART_LCR << DEBUG_UART_SHIFT] |= UART_LCR_DLAB;
+	uart[UART_DLL << DEBUG_UART_SHIFT] = div & 0xff;
+	uart[UART_DLM << DEBUG_UART_SHIFT] = div >> 8;
+	uart[UART_LCR << DEBUG_UART_SHIFT] = 3;
 }
 
 static inline void arch_decomp_wdog(void)
-- 
1.7.0.4
