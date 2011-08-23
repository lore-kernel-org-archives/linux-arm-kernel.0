From: will.deacon@arm.com (Will Deacon)
Date: Tue, 23 Aug 2011 22:30:41 +0100
Subject: [PATCH v2 4/5] ARM: realview: use Kconfig choice for debug UART
	selection
In-Reply-To: <1314135042-19908-1-git-send-email-will.deacon@arm.com>
References: <1314135042-19908-1-git-send-email-will.deacon@arm.com>
Message-ID: <1314135042-19908-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the DEBUG_LL UART can be selected by a Kconfig choice, simplify
the #ifdefery in debug-macro.S and add entries to the top-level
Kconfig.debug instead.

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig.debug                            |   16 ++++++++++++++++
 arch/arm/mach-realview/include/mach/debug-macro.S |   17 ++---------------
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 875bd34..007cf85 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -132,6 +132,22 @@ choice
 		  The uncompressor code port configuration is now handled
 		  by CONFIG_S3C_LOWLEVEL_UART_PORT.
 
+	config DEBUG_REALVIEW_STD_PORT
+		bool "RealView Default UART"
+		depends on ARCH_REALVIEW
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to the serial port on RealView EB, PB11MP, PBA8
+		  and PBX platforms.
+
+	config DEBUG_REALVIEW_PB1176_PORT
+		bool "RealView PB1176 UART"
+		depends on MACH_REALVIEW_PB1176
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to the standard serial port on the RealView
+		  PB1176 platform.
+
 endchoice
 
 config EARLY_PRINTK
diff --git a/arch/arm/mach-realview/include/mach/debug-macro.S b/arch/arm/mach-realview/include/mach/debug-macro.S
index 90b687c..0f38722 100644
--- a/arch/arm/mach-realview/include/mach/debug-macro.S
+++ b/arch/arm/mach-realview/include/mach/debug-macro.S
@@ -10,23 +10,10 @@
  * published by the Free Software Foundation.
  */
 
-#if defined(CONFIG_MACH_REALVIEW_EB) || \
-    defined(CONFIG_MACH_REALVIEW_PB11MP) || \
-    defined(CONFIG_MACH_REALVIEW_PBA8) || \
-    defined(CONFIG_MACH_REALVIEW_PBX)
-#ifndef DEBUG_LL_UART_OFFSET
+#ifdef CONFIG_DEBUG_REALVIEW_STD_PORT
 #define DEBUG_LL_UART_OFFSET	0x00009000
-#elif DEBUG_LL_UART_OFFSET != 0x00009000
-#warning "DEBUG_LL_UART_OFFSET already defined to a different value"
-#endif
-#endif
-
-#ifdef CONFIG_MACH_REALVIEW_PB1176
-#ifndef DEBUG_LL_UART_OFFSET
+#elif defined(CONFIG_DEBUG_REALVIEW_PB1176_PORT)
 #define DEBUG_LL_UART_OFFSET	0x0010c000
-#elif DEBUG_LL_UART_OFFSET != 0x0010c000
-#warning "DEBUG_LL_UART_OFFSET already defined to a different value"
-#endif
 #endif
 
 #ifndef DEBUG_LL_UART_OFFSET
-- 
1.7.0.4
