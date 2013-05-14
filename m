From: jonathan.austin@arm.com (Jonathan Austin)
Date: Tue, 14 May 2013 13:26:58 +0100
Subject: [PATCH 3/3] ARM: vexpress: Add Cortex-R Series UART,
 selectable via DEBUG_LL
In-Reply-To: <1368534418-11287-1-git-send-email-jonathan.austin@arm.com>
References: <1368534418-11287-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <1368534418-11287-4-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cortex-R series processors on Versatile Express have a different memory
map to the RS1 and CA9X4 tiles. Most of the platform difference can be
expressed in device-trees, but the UART definitions for LL_DEBUG cannot.

This patch defines the UART location for R-Series processors on
versatile-express, allowing low-level debug and output from the decompressor.
These definitions are selectable via Kconfig

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
CC: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/Kconfig.debug            |   10 +++++++++-
 arch/arm/include/debug/vexpress.S |   10 ++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index ede909b..e2ab50a 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -476,6 +476,13 @@ choice
 		  of the tiles using the RS1 memory map, including all new A-class
 		  core tiles, FPGA-based SMMs and software models.
 
+	config DEBUG_VEXPRESS_UART0_CRX
+		bool "Use PL011 UART0 at 0xb0090000 (Cortex-R compliant tiles)"
+		depends on ARCH_VEXPRESS_NOMMU
+		help
+		  This option selects UART0 at 0xb0090000. This is appropriate for
+		  Cortex-R series tiles and SMMs, such as Cortex-R5 and Cortex-R7
+
 	config DEBUG_VT8500_UART0
 		bool "Use UART0 on VIA/Wondermedia SoCs"
 		depends on ARCH_VT8500
@@ -645,7 +652,8 @@ config DEBUG_LL_INCLUDE
 	default "debug/tegra.S" if DEBUG_TEGRA_UART
 	default "debug/ux500.S" if DEBUG_UX500_UART
 	default "debug/vexpress.S" if DEBUG_VEXPRESS_UART0_DETECT || \
-		DEBUG_VEXPRESS_UART0_CA9 || DEBUG_VEXPRESS_UART0_RS1
+		DEBUG_VEXPRESS_UART0_CA9 || DEBUG_VEXPRESS_UART0_RS1 || \
+		DEBUG_VEXPRESS_UART0_CRX
 	default "debug/vt8500.S" if DEBUG_VT8500_UART0
 	default "debug/zynq.S" if DEBUG_ZYNQ_UART0 || DEBUG_ZYNQ_UART1
 	default "mach/debug-macro.S"
diff --git a/arch/arm/include/debug/vexpress.S b/arch/arm/include/debug/vexpress.S
index dc8e882..acafb22 100644
--- a/arch/arm/include/debug/vexpress.S
+++ b/arch/arm/include/debug/vexpress.S
@@ -16,6 +16,8 @@
 #define DEBUG_LL_PHYS_BASE_RS1		0x1c000000
 #define DEBUG_LL_UART_OFFSET_RS1	0x00090000
 
+#define DEBUG_LL_UART_PHYS_CRX		0xb0090000
+
 #define DEBUG_LL_VIRT_BASE		0xf8000000
 
 #if defined(CONFIG_DEBUG_VEXPRESS_UART0_DETECT)
@@ -67,6 +69,14 @@
 
 #include <asm/hardware/debug-pl01x.S>
 
+#elif defined(CONFIG_DEBUG_VEXPRESS_UART0_CRX)
+
+		.macro	addruart,rp,tmp,tmp2
+		ldr	\rp, =DEBUG_LL_UART_PHYS_CRX
+		.endm
+
+#include <asm/hardware/debug-pl01x.S>
+
 #else /* CONFIG_DEBUG_LL_UART_NONE */
 
 		.macro	addruart, rp, rv, tmp
-- 
1.7.9.5
