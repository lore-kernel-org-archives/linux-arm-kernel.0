From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Mar 2013 12:41:16 +0100
Subject: [PATCH 5/8] ARM: sirf: move debug-macro.S to include/debug/sirf.S
In-Reply-To: <1363779679-16880-1-git-send-email-arnd@arndb.de>
References: <1363779679-16880-1-git-send-email-arnd@arndb.de>
Message-ID: <1363779679-16880-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new style ll_debug implementation for multiplatform requires the
platform glue to be in include/debug, so let's move it there to
separate the debugging logic from the platform code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig.debug                                  |  1 +
 .../include/mach/debug-macro.S => include/debug/sirf.S} | 17 +++++++++++++++--
 arch/arm/mach-prima2/lluart.c                           | 12 +++++++++++-
 3 files changed, 27 insertions(+), 3 deletions(-)
 rename arch/arm/{mach-prima2/include/mach/debug-macro.S => include/debug/sirf.S} (53%)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index acdddda..a69334d 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -592,6 +592,7 @@ config DEBUG_LL_INCLUDE
 	default "debug/mvebu.S" if DEBUG_MVEBU_UART
 	default "debug/omap2plus.S" if DEBUG_OMAP2PLUS_UART
 	default "debug/picoxcell.S" if DEBUG_PICOXCELL_UART
+	default "debug/sirf.S" if DEBUG_SIRFPRIMA2_UART1 || DEBUG_SIRFMARCO_UART1
 	default "debug/socfpga.S" if DEBUG_SOCFPGA_UART
 	default "debug/sunxi.S" if DEBUG_SUNXI_UART0 || DEBUG_SUNXI_UART1
 	default "debug/vexpress.S" if DEBUG_VEXPRESS_UART0_DETECT || \
diff --git a/arch/arm/mach-prima2/include/mach/debug-macro.S b/arch/arm/include/debug/sirf.S
similarity index 53%
rename from arch/arm/mach-prima2/include/mach/debug-macro.S
rename to arch/arm/include/debug/sirf.S
index cd97492..dbf250c 100644
--- a/arch/arm/mach-prima2/include/mach/debug-macro.S
+++ b/arch/arm/include/debug/sirf.S
@@ -6,8 +6,21 @@
  * Licensed under GPLv2 or later.
  */
 
-#include <mach/hardware.h>
-#include <mach/uart.h>
+#if defined(CONFIG_DEBUG_SIRFPRIMA2_UART1)
+#define SIRFSOC_UART1_PA_BASE          0xb0060000
+#elif defined(CONFIG_DEBUG_SIRFMARCO_UART1)
+#define SIRFSOC_UART1_PA_BASE          0xcc060000
+#else
+#define SIRFSOC_UART1_PA_BASE          0
+#endif
+
+#define SIRFSOC_UART1_VA_BASE		0xFEC60000
+
+#define SIRFSOC_UART_TXFIFO_STATUS	0x0114
+#define SIRFSOC_UART_TXFIFO_DATA	0x0118
+
+#define SIRFSOC_UART1_TXFIFO_FULL                       (1 << 5)
+#define SIRFSOC_UART1_TXFIFO_EMPTY			(1 << 6)
 
 	.macro	addruart, rp, rv, tmp
 	ldr	\rp, =SIRFSOC_UART1_PA_BASE		@ physical
diff --git a/arch/arm/mach-prima2/lluart.c b/arch/arm/mach-prima2/lluart.c
index a89f9b3..7222481 100644
--- a/arch/arm/mach-prima2/lluart.c
+++ b/arch/arm/mach-prima2/lluart.c
@@ -10,7 +10,17 @@
 #include <asm/page.h>
 #include <asm/mach/map.h>
 #include <mach/map.h>
-#include <mach/uart.h>
+
+#if defined(CONFIG_DEBUG_SIRFPRIMA2_UART1)
+#define SIRFSOC_UART1_PA_BASE          0xb0060000
+#elif defined(CONFIG_DEBUG_SIRFMARCO_UART1)
+#define SIRFSOC_UART1_PA_BASE          0xcc060000
+#else
+#define SIRFSOC_UART1_PA_BASE          0
+#endif
+
+#define SIRFSOC_UART1_VA_BASE          SIRFSOC_VA(0x060000)
+#define SIRFSOC_UART1_SIZE		SZ_4K
 
 void __init sirfsoc_map_lluart(void)
 {
-- 
1.8.1.2
