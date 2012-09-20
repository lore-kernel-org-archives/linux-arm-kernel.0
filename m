From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 20 Sep 2012 14:45:43 +0800
Subject: [PATCH v2 30/34] ARM: imx: move debug macros to include/debug
In-Reply-To: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
References: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1348123547-31082-31-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move imx debug-macro.S over to common debug macro directory.  It
removes the inclusion to hardware.h by hard-coding the physical
address of uart port and copying IMX_IO_P2V from hardware.h.

Since we will need a common solution, which might use a fixed virtual
address for uart port across platforms, we make a copy of IMX_IO_P2V
here as a temporary solution to enable low-level debug for imx
multi-platform build.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig.debug                             |    8 +++++
 .../mach/debug-macro.S => include/debug/imx.S}     |   33 +++++++++++++-------
 2 files changed, 30 insertions(+), 11 deletions(-)
 rename arch/arm/{mach-imx/include/mach/debug-macro.S => include/debug/imx.S} (59%)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index a7eb282..c813a05 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -398,6 +398,14 @@ endchoice
 config DEBUG_LL_INCLUDE
 	string
 	default "debug/icedcc.S" if DEBUG_ICEDCC
+	default "debug/imx.S" if DEBUG_IMX1_UART || \
+				 DEBUG_IMX25_UART || \
+				 DEBUG_IMX21_IMX27_UART || \
+				 DEBUG_IMX31_IMX35_UART || \
+				 DEBUG_IMX51_UART || \
+				 DEBUG_IMX50_IMX53_UART ||\
+				 DEBUG_IMX6Q_UART2 || \
+				 DEBUG_IMX6Q_UART4
 	default "debug/highbank.S" if DEBUG_HIGHBANK_UART
 	default "debug/mvebu.S" if DEBUG_MVEBU_UART
 	default "debug/picoxcell.S" if DEBUG_PICOXCELL_UART
diff --git a/arch/arm/mach-imx/include/mach/debug-macro.S b/arch/arm/include/debug/imx.S
similarity index 59%
rename from arch/arm/mach-imx/include/mach/debug-macro.S
rename to arch/arm/include/debug/imx.S
index 761e45f..0b65d79 100644
--- a/arch/arm/mach-imx/include/mach/debug-macro.S
+++ b/arch/arm/include/debug/imx.S
@@ -10,27 +10,38 @@
  * published by the Free Software Foundation.
  *
  */
-#include <mach/hardware.h>
-
 #ifdef CONFIG_DEBUG_IMX1_UART
-#define UART_PADDR	MX1_UART1_BASE_ADDR
+#define UART_PADDR	0x00206000
 #elif defined (CONFIG_DEBUG_IMX25_UART)
-#define UART_PADDR	MX25_UART1_BASE_ADDR
+#define UART_PADDR	0x43f90000
 #elif defined (CONFIG_DEBUG_IMX21_IMX27_UART)
-#define UART_PADDR	MX2x_UART1_BASE_ADDR
+#define UART_PADDR	0x1000a000
 #elif defined (CONFIG_DEBUG_IMX31_IMX35_UART)
-#define UART_PADDR	MX3x_UART1_BASE_ADDR
+#define UART_PADDR	0x43f90000
 #elif defined (CONFIG_DEBUG_IMX51_UART)
-#define UART_PADDR	MX51_UART1_BASE_ADDR
+#define UART_PADDR	0x73fbc000
 #elif defined (CONFIG_DEBUG_IMX50_IMX53_UART)
-#define UART_PADDR	MX53_UART1_BASE_ADDR
+#define UART_PADDR	0x53fbc000
 #elif defined (CONFIG_DEBUG_IMX6Q_UART2)
-#define UART_PADDR	MX6Q_UART2_BASE_ADDR
+#define UART_PADDR	0x021e8000
 #elif defined (CONFIG_DEBUG_IMX6Q_UART4)
-#define UART_PADDR	MX6Q_UART4_BASE_ADDR
+#define UART_PADDR	0x021f0000
 #endif
 
-#define UART_VADDR	IMX_IO_ADDRESS(UART_PADDR)
+/*
+ * FIXME: This is a copy of IMX_IO_P2V in hardware.h, and needs to
+ * stay sync with that.  It's hard to maintain, and should be fixed
+ * globally for multi-platform build to use a fixed virtual address
+ * for low-level debug uart port across platforms.
+ */
+#define IMX_IO_P2V(x)	(						\
+			(((x) & 0x80000000) >> 7) |			\
+			(0xf4000000 +					\
+			(((x) & 0x50000000) >> 6) +			\
+			(((x) & 0x0b000000) >> 4) +			\
+			(((x) & 0x000fffff))))
+
+#define UART_VADDR	IMX_IO_P2V(UART_PADDR)
 
 		.macro	addruart, rp, rv, tmp
 		ldr	\rp, =UART_PADDR	@ physical
-- 
1.7.9.5
