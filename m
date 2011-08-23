From: will.deacon@arm.com (Will Deacon)
Date: Tue, 23 Aug 2011 22:30:42 +0100
Subject: [PATCH v2 5/5] arm/imx: use Kconfig choice for low-level debug UART
	selection
In-Reply-To: <1314135042-19908-1-git-send-email-will.deacon@arm.com>
References: <1314135042-19908-1-git-send-email-will.deacon@arm.com>
Message-ID: <1314135042-19908-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

Now that the DEBUG_LL UART can be selected by a Kconfig choice,
simplify the #ifdefery in debug-macro.S and add entries to the
top-level Kconfig.debug instead.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig.debug                       |   56 ++++++++++++++++++++++++++
 arch/arm/mach-mxs/include/mach/debug-macro.S |   12 +-----
 arch/arm/plat-mxc/include/mach/debug-macro.S |   38 +++---------------
 3 files changed, 64 insertions(+), 42 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 007cf85..965d59a 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -99,6 +99,62 @@ choice
 		  Saying N will cause the debug messages to appear on the first
 		  serial port.
 
+	config DEBUG_IMX1_UART
+		bool "i.MX1 Debug UART"
+		depends on SOC_IMX1
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on i.MX1.
+
+	config DEBUG_IMX23_UART
+		bool "i.MX23 Debug UART"
+		depends on SOC_IMX23
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on i.MX23.
+
+	config DEBUG_IMX25_UART
+		bool "i.MX25 Debug UART"
+		depends on SOC_IMX25
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on i.MX25.
+
+	config DEBUG_IMX21_IMX27_UART
+		bool "i.MX21 and i.MX27 Debug UART"
+		depends on SOC_IMX21 || SOC_IMX27
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on i.MX21 or i.MX27.
+
+	config DEBUG_IMX28_UART
+		bool "i.MX28 Debug UART"
+		depends on SOC_IMX28
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on i.MX28.
+
+	config DEBUG_IMX31_IMX35_UART
+		bool "i.MX31 and i.MX35 Debug UART"
+		depends on SOC_IMX31 || SOC_IMX35
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on i.MX31 or i.MX35.
+
+	config DEBUG_IMX51_UART
+		bool "i.MX51 Debug UART"
+		depends on SOC_IMX51
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on i.MX51.
+
+	config DEBUG_IMX50_IMX53_UART
+		bool "i.MX50 and i.MX53 Debug UART"
+		depends on SOC_IMX50 || SOC_IMX53
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on i.MX50 or i.MX53.
+
 	config DEBUG_S3C_UART0
 		depends on PLAT_SAMSUNG
 		bool "Use S3C UART 0 for low-level debug"
diff --git a/arch/arm/mach-mxs/include/mach/debug-macro.S b/arch/arm/mach-mxs/include/mach/debug-macro.S
index 79650a1..6d98704 100644
--- a/arch/arm/mach-mxs/include/mach/debug-macro.S
+++ b/arch/arm/mach-mxs/include/mach/debug-macro.S
@@ -14,17 +14,9 @@
 #include <mach/mx23.h>
 #include <mach/mx28.h>
 
-#ifdef CONFIG_SOC_IMX23
-#ifdef UART_PADDR
-#error "CONFIG_DEBUG_LL is incompatible with multiple archs"
-#endif
+#ifdef CONFIG_DEBUG_IMX23_UART
 #define UART_PADDR	MX23_DUART_BASE_ADDR
-#endif
-
-#ifdef CONFIG_SOC_IMX28
-#ifdef UART_PADDR
-#error "CONFIG_DEBUG_LL is incompatible with multiple archs"
-#endif
+#elif defined (CONFIG_DEBUG_IMX28_UART)
 #define UART_PADDR	MX28_DUART_BASE_ADDR
 #endif
 
diff --git a/arch/arm/plat-mxc/include/mach/debug-macro.S b/arch/arm/plat-mxc/include/mach/debug-macro.S
index e4dde91..07cfdbe 100644
--- a/arch/arm/plat-mxc/include/mach/debug-macro.S
+++ b/arch/arm/plat-mxc/include/mach/debug-macro.S
@@ -12,43 +12,17 @@
  */
 #include <mach/hardware.h>
 
-#ifdef CONFIG_SOC_IMX1
+#ifdef CONFIG_DEBUG_IMX1_UART
 #define UART_PADDR	MX1_UART1_BASE_ADDR
-#endif
-
-#ifdef CONFIG_SOC_IMX25
-#ifdef UART_PADDR
-#error "CONFIG_DEBUG_LL is incompatible with multiple archs"
-#endif
+#elif defined (CONFIG_DEBUG_IMX25_UART)
 #define UART_PADDR	MX25_UART1_BASE_ADDR
-#endif
-
-#if defined(CONFIG_SOC_IMX21) || defined (CONFIG_SOC_IMX27)
-#ifdef UART_PADDR
-#error "CONFIG_DEBUG_LL is incompatible with multiple archs"
-#endif
+#elif defined (CONFIG_DEBUG_IMX21_IMX27_UART)
 #define UART_PADDR	MX2x_UART1_BASE_ADDR
-#endif
-
-#if defined(CONFIG_SOC_IMX31) || defined(CONFIG_SOC_IMX35)
-#ifdef UART_PADDR
-#error "CONFIG_DEBUG_LL is incompatible with multiple archs"
-#endif
+#elif defined (CONFIG_DEBUG_IMX31_IMX35_UART)
 #define UART_PADDR	MX3x_UART1_BASE_ADDR
-#endif
-
-#ifdef CONFIG_SOC_IMX51
-#ifdef UART_PADDR
-#error "CONFIG_DEBUG_LL is incompatible with multiple archs"
-#endif
+#elif defined (CONFIG_DEBUG_IMX51_UART)
 #define UART_PADDR	MX51_UART1_BASE_ADDR
-#endif
-
-/* iMX50/53 have same addresses, but not iMX51 */
-#if defined(CONFIG_SOC_IMX50) || defined(CONFIG_SOC_IMX53)
-#ifdef UART_PADDR
-#error "CONFIG_DEBUG_LL is incompatible with multiple archs"
-#endif
+#elif defined (CONFIG_DEBUG_IMX50_IMX53_UART)
 #define UART_PADDR	MX53_UART1_BASE_ADDR
 #endif
 
-- 
1.7.0.4
