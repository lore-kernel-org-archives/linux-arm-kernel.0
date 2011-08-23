From: will.deacon@arm.com (Will Deacon)
Date: Tue, 23 Aug 2011 22:30:40 +0100
Subject: [PATCH v2 3/5] ARM: plat-samsung: use Kconfig choice for debug UART
	selection
In-Reply-To: <1314135042-19908-1-git-send-email-will.deacon@arm.com>
References: <1314135042-19908-1-git-send-email-will.deacon@arm.com>
Message-ID: <1314135042-19908-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the DEBUG_LL UART can be selected by a Kconfig choice, convert
the Samsung UART selection to use a set of bools rather than an int.

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig.debug        |   45 ++++++++++++++++++++++++++++++-----------
 arch/arm/plat-samsung/Kconfig |    7 ++++++
 2 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 60d1846..875bd34 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -99,6 +99,39 @@ choice
 		  Saying N will cause the debug messages to appear on the first
 		  serial port.
 
+	config DEBUG_S3C_UART0
+		depends on PLAT_SAMSUNG
+		bool "Use S3C UART 0 for low-level debug"
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to UART 0. The port must have been initialised
+		  by the boot-loader before use.
+
+		  The uncompressor code port configuration is now handled
+		  by CONFIG_S3C_LOWLEVEL_UART_PORT.
+
+	config DEBUG_S3C_UART1
+		depends on PLAT_SAMSUNG
+		bool "Use S3C UART 1 for low-level debug"
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to UART 1. The port must have been initialised
+		  by the boot-loader before use.
+
+		  The uncompressor code port configuration is now handled
+		  by CONFIG_S3C_LOWLEVEL_UART_PORT.
+
+	config DEBUG_S3C_UART2
+		depends on PLAT_SAMSUNG
+		bool "Use S3C UART 2 for low-level debug"
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to UART 2. The port must have been initialised
+		  by the boot-loader before use.
+
+		  The uncompressor code port configuration is now handled
+		  by CONFIG_S3C_LOWLEVEL_UART_PORT.
+
 endchoice
 
 config EARLY_PRINTK
@@ -129,16 +162,4 @@ config OC_ETM
 	  buffer driver that will allow you to collect traces of the
 	  kernel code.
 
-config DEBUG_S3C_UART
-	depends on PLAT_SAMSUNG
-	int "S3C UART to use for low-level debug"
-	default "0"
-	help
-	  Choice for UART for kernel low-level using S3C UARTS,
-	  should be between zero and two. The port must have been
-	  initialised by the boot-loader before use.
-
-	  The uncompressor code port configuration is now handled
-	  by CONFIG_S3C_LOWLEVEL_UART_PORT.
-
 endmenu
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index b3e1065..49b14b1 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -367,4 +367,11 @@ config SAMSUNG_PD
 	help
 	  Say Y here if you want to control Power Domain by Runtime PM.
 
+config DEBUG_S3C_UART
+	depends on PLAT_SAMSUNG
+	int
+	default "0" if DEBUG_S3C_UART0
+	default "1" if DEBUG_S3C_UART1
+	default "2" if DEBUG_S3C_UART2
+
 endif
-- 
1.7.0.4
