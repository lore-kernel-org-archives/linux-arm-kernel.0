From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 16 Jul 2013 17:43:13 +0100
Subject: [PATCH RFC v2 10/14] ARM: debug: provide generic option choices for
 8250 and PL01x ports
In-Reply-To: <20130716163243.GY21614@n2100.arm.linux.org.uk>
References: <20130716163243.GY21614@n2100.arm.linux.org.uk>
Message-ID: <E1Uz8LJ-000485-0g@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide generic option choices for 8250 and PL01x UART ports; these can
now be selected by UART type rather than asking about the platform.
This means that a kernel configuration user can manually choose the
various parameters of the debug UART without resorting to the platform
having to encode the possible settings.

These two generic options are preferred over further debug entries for
these ports; the existing options which refer back to the 8250 and PL01x
ports are now considered deprecated.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig.debug |   44 +++++++++++++++++++++++++++++++++++++-------
 1 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 6bab4b0..ecb3b32 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -770,6 +770,32 @@ choice
 		  This option selects UART0 on VIA/Wondermedia System-on-a-chip
 		  devices, including VT8500, WM8505, WM8650 and WM8850.
 
+	config DEBUG_LL_UART_8250
+		bool "Kernel low-level debugging via 8250 UART"
+		help
+		  Say Y here if you wish the debug print routes to direct
+		  their output to an 8250 UART.  You can use this option
+		  to provide the parameters for the 8250 UART rather than
+		  selecting one of the platform specific options above if
+		  you know the parameters for the port.
+
+		  This option is preferred over the platform specific
+		  options; the platform specific options are deprecated
+		  and will be soon removed.
+
+	config DEBUG_LL_UART_PL01X
+		bool "Kernel low-level debugging via ARM Ltd PL01x Primecell UART"
+		help
+		  Say Y here if you wish the debug print routes to direct
+		  their output to a PL01x Primecell UART.  You can use
+		  this option to provide the parameters for the UART
+		  rather than selecting one of the platform specific
+		  options above if you know the parameters for the port.
+
+		  This option is preferred over the platform specific
+		  options; the platform specific options are deprecated
+		  and will be soon removed.
+
 	config DEBUG_LL_UART_NONE
 		bool "No low-level debugging UART"
 		depends on !ARCH_MULTIPLATFORM
@@ -845,8 +871,8 @@ config DEBUG_STI_UART
 
 config DEBUG_LL_INCLUDE
 	string
-	default "debug/8250.S" if DEBUG_UART_8250
-	default "debug/pl01x.S" if DEBUG_UART_PL01X
+	default "debug/8250.S" if DEBUG_LL_UART_8250 || DEBUG_UART_8250
+	default "debug/pl01x.S" if DEBUG_LL_UART_PL01X || DEBUG_UART_PL01X
 	default "debug/exynos.S" if DEBUG_EXYNOS_UART
 	default "debug/icedcc.S" if DEBUG_ICEDCC
 	default "debug/imx.S" if DEBUG_IMX1_UART || \
@@ -870,11 +896,13 @@ config DEBUG_LL_INCLUDE
 	default "debug/zynq.S" if DEBUG_ZYNQ_UART0 || DEBUG_ZYNQ_UART1
 	default "mach/debug-macro.S"
 
+# Compatibility options for PL01x
 config DEBUG_UART_PL01X
 	def_bool ARCH_EP93XX || \
 		ARCH_INTEGRATOR || \
 		ARCH_VERSATILE
 
+# Compatibility options for 8250
 config DEBUG_UART_8250
 	def_bool ARCH_DOVE || ARCH_EBSA110 || \
 		(FOOTBRIDGE && !DEBUG_DC21285_PORT) || \
@@ -925,7 +953,8 @@ config DEBUG_UART_PHYS
 	default 0xffd82340 if ARCH_IOP13XX
 	default 0xfff36000 if DEBUG_HIGHBANK_UART
 	default 0xfffff700 if ARCH_IOP33X
-	depends on DEBUG_UART_8250 || DEBUG_UART_PL01X
+	depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
+		DEBUG_UART_8250 || DEBUG_UART_PL01X
 
 config DEBUG_UART_VIRT
 	hex "Virtual base address of debug UART"
@@ -971,23 +1000,24 @@ config DEBUG_UART_VIRT
 	default 0xfefff700 if ARCH_IOP33X
 	default 0xff003000 if DEBUG_U300_UART
 	default DEBUG_UART_PHYS if !MMU
-	depends on DEBUG_UART_8250 || DEBUG_UART_PL01X
+	depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
+		DEBUG_UART_8250 || DEBUG_UART_PL01X
 
 config DEBUG_UART_8250_SHIFT
 	int "Register offset shift for the 8250 debug UART"
-	depends on DEBUG_UART_8250
+	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
 	default 0 if FOOTBRIDGE || ARCH_IOP32X
 	default 2
 
 config DEBUG_UART_8250_WORD
 	bool "Use 32-bit accesses for 8250 UART"
-	depends on DEBUG_UART_8250
+	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
 	depends on DEBUG_UART_8250_SHIFT >= 2
 	default y if DEBUG_PICOXCELL_UART || DEBUG_SOCFPGA_UART
 
 config DEBUG_UART_8250_FLOW_CONTROL
 	bool "Enable flow control for 8250 UART"
-	depends on DEBUG_UART_8250
+	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
 	default y if ARCH_EBSA110 || FOOTBRIDGE || ARCH_GEMINI || ARCH_RPC
 
 config DEBUG_UNCOMPRESS
-- 
1.7.4.4
