From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 07 Jul 2013 13:46:30 +0100
Subject: [PATCH RFC 3/9] ARM: debug: provide 8250 debug uart flow control
 configuration option
In-Reply-To: <20130707124326.GP24642@n2100.arm.linux.org.uk>
References: <20130707124326.GP24642@n2100.arm.linux.org.uk>
Message-ID: <E1UvoMI-0006Hj-8e@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the definition out of the machine class debug-macro.S header
into the Kconfig files.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig.debug                             |    9 +++++++++
 arch/arm/include/asm/hardware/debug-8250.S         |    2 +-
 arch/arm/mach-ebsa110/include/mach/debug-macro.S   |    1 -
 .../arm/mach-footbridge/include/mach/debug-macro.S |    1 -
 arch/arm/mach-gemini/include/mach/debug-macro.S    |    1 -
 arch/arm/mach-rpc/include/mach/debug-macro.S       |    1 -
 6 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index f9c1fc9..434a22c 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -856,6 +856,15 @@ config DEBUG_LL_INCLUDE
 	default "debug/zynq.S" if DEBUG_ZYNQ_UART0 || DEBUG_ZYNQ_UART1
 	default "mach/debug-macro.S"
 
+config DEBUG_UART_8250
+	def_bool y
+	depends on ARCH_EBSA110 || (FOOTBRIDGE && !DEBUG_DC21285_PORT) || \
+		ARCH_GEMINI || ARCH_RPC
+
+config DEBUG_UART_8250_FLOW_CONTROL
+	def_bool y if ARCH_EBSA110 || FOOTBRIDGE || ARCH_GEMINI || ARCH_RPC
+	depends on DEBUG_UART_8250
+
 config DEBUG_UNCOMPRESS
 	bool
 	default y if ARCH_MULTIPLATFORM && DEBUG_LL && \
diff --git a/arch/arm/include/asm/hardware/debug-8250.S b/arch/arm/include/asm/hardware/debug-8250.S
index 22c6892..bca3045 100644
--- a/arch/arm/include/asm/hardware/debug-8250.S
+++ b/arch/arm/include/asm/hardware/debug-8250.S
@@ -21,7 +21,7 @@
 		.endm
 
 		.macro	waituart,rd,rx
-#ifdef FLOW_CONTROL
+#ifdef CONFIG_DEBUG_UART_8250_FLOW_CONTROL
 1001:		ldrb	\rd, [\rx, #UART_MSR << UART_SHIFT]
 		tst	\rd, #UART_MSR_CTS
 		beq	1001b
diff --git a/arch/arm/mach-ebsa110/include/mach/debug-macro.S b/arch/arm/mach-ebsa110/include/mach/debug-macro.S
index bb02c05..9b66e79 100644
--- a/arch/arm/mach-ebsa110/include/mach/debug-macro.S
+++ b/arch/arm/mach-ebsa110/include/mach/debug-macro.S
@@ -18,5 +18,4 @@
 		.endm
 
 #define UART_SHIFT	2
-#define FLOW_CONTROL
 #include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-footbridge/include/mach/debug-macro.S b/arch/arm/mach-footbridge/include/mach/debug-macro.S
index c169f0c..18130fe 100644
--- a/arch/arm/mach-footbridge/include/mach/debug-macro.S
+++ b/arch/arm/mach-footbridge/include/mach/debug-macro.S
@@ -23,7 +23,6 @@
 		.endm
 
 #define UART_SHIFT	0
-#define FLOW_CONTROL
 #include <asm/hardware/debug-8250.S>
 
 #else
diff --git a/arch/arm/mach-gemini/include/mach/debug-macro.S b/arch/arm/mach-gemini/include/mach/debug-macro.S
index 8376707..cdee448 100644
--- a/arch/arm/mach-gemini/include/mach/debug-macro.S
+++ b/arch/arm/mach-gemini/include/mach/debug-macro.S
@@ -17,5 +17,4 @@
 	.endm
 
 #define UART_SHIFT	2
-#define FLOW_CONTROL
 #include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-rpc/include/mach/debug-macro.S b/arch/arm/mach-rpc/include/mach/debug-macro.S
index 6d28cc9..a92753d 100644
--- a/arch/arm/mach-rpc/include/mach/debug-macro.S
+++ b/arch/arm/mach-rpc/include/mach/debug-macro.S
@@ -19,5 +19,4 @@
 		.endm
 
 #define UART_SHIFT	2
-#define FLOW_CONTROL
 #include <asm/hardware/debug-8250.S>
-- 
1.7.4.4
