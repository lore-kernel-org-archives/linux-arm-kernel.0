From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 16 Jul 2013 17:37:12 +0100
Subject: [PATCH RFC v2 04/14] ARM: debug: provide 8250 debug uart register
 shift configuration option
In-Reply-To: <20130716163243.GY21614@n2100.arm.linux.org.uk>
References: <20130716163243.GY21614@n2100.arm.linux.org.uk>
Message-ID: <E1Uz8FU-00047a-AB@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the definition of the UART register shift out of the platform
specific header file into the Kconfig files.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig.debug                             |   28 ++++++++++++++++++-
 arch/arm/include/asm/hardware/debug-8250.S         |    4 +++
 arch/arm/include/debug/mvebu.S                     |    1 -
 arch/arm/include/debug/nspire.S                    |    1 -
 arch/arm/include/debug/pxa.S                       |    1 -
 arch/arm/include/debug/rockchip.S                  |    1 -
 arch/arm/include/debug/sunxi.S                     |    1 -
 arch/arm/mach-dove/include/mach/debug-macro.S      |    1 -
 arch/arm/mach-ebsa110/include/mach/debug-macro.S   |    1 -
 .../arm/mach-footbridge/include/mach/debug-macro.S |    1 -
 arch/arm/mach-gemini/include/mach/debug-macro.S    |    1 -
 arch/arm/mach-iop13xx/include/mach/debug-macro.S   |    1 -
 arch/arm/mach-iop32x/include/mach/debug-macro.S    |    1 -
 arch/arm/mach-iop33x/include/mach/debug-macro.S    |    1 -
 arch/arm/mach-ixp4xx/include/mach/debug-macro.S    |    1 -
 arch/arm/mach-kirkwood/include/mach/debug-macro.S  |    1 -
 arch/arm/mach-lpc32xx/include/mach/debug-macro.S   |    1 -
 arch/arm/mach-mv78xx0/include/mach/debug-macro.S   |    1 -
 arch/arm/mach-orion5x/include/mach/debug-macro.S   |    1 -
 arch/arm/mach-rpc/include/mach/debug-macro.S       |    1 -
 20 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 07ff149..5b44881 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -275,6 +275,7 @@ choice
 	config DEBUG_MMP_UART2
 		bool "Kernel low-level debugging message via MMP UART2"
 		depends on ARCH_MMP
+		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on MMP UART2.
@@ -282,6 +283,7 @@ choice
 	config DEBUG_MMP_UART3
 		bool "Kernel low-level debugging message via MMP UART3"
 		depends on ARCH_MMP
+		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on MMP UART3.
@@ -326,6 +328,7 @@ choice
 	config DEBUG_MVEBU_UART
 		bool "Kernel low-level debugging messages via MVEBU UART (old bootloaders)"
 		depends on ARCH_MVEBU
+		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on MVEBU based platforms.
@@ -344,6 +347,7 @@ choice
 	config DEBUG_MVEBU_UART_ALTERNATE
 		bool "Kernel low-level debugging messages via MVEBU UART (new bootloaders)"
 		depends on ARCH_MVEBU
+		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on MVEBU based platforms.
@@ -365,6 +369,7 @@ choice
 	config DEBUG_NSPIRE_CLASSIC_UART
 		bool "Kernel low-level debugging via TI-NSPIRE 8250 UART"
 		depends on ARCH_NSPIRE
+		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on TI-NSPIRE classic models.
@@ -453,6 +458,7 @@ choice
 	config DEBUG_PXA_UART1
 		depends on ARCH_PXA
 		bool "Use PXA UART1 for low-level debug"
+		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on PXA UART1.
@@ -477,6 +483,7 @@ choice
 		bool "Kernel low-level debugging messages via Rockchip RK29 UART0"
 		depends on ARCH_ROCKCHIP
 		select DEBUG_ROCKCHIP_UART
+		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on Rockchip based platforms.
@@ -485,6 +492,7 @@ choice
 		bool "Kernel low-level debugging messages via Rockchip RK29 UART1"
 		depends on ARCH_ROCKCHIP
 		select DEBUG_ROCKCHIP_UART
+		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on Rockchip based platforms.
@@ -493,6 +501,7 @@ choice
 		bool "Kernel low-level debugging messages via Rockchip RK29 UART2"
 		depends on ARCH_ROCKCHIP
 		select DEBUG_ROCKCHIP_UART
+		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on Rockchip based platforms.
@@ -501,6 +510,7 @@ choice
 		bool "Kernel low-level debugging messages via Rockchip RK3X UART0"
 		depends on ARCH_ROCKCHIP
 		select DEBUG_ROCKCHIP_UART
+		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on Rockchip based platforms.
@@ -509,6 +519,7 @@ choice
 		bool "Kernel low-level debugging messages via Rockchip RK3X UART1"
 		depends on ARCH_ROCKCHIP
 		select DEBUG_ROCKCHIP_UART
+		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on Rockchip based platforms.
@@ -517,6 +528,7 @@ choice
 		bool "Kernel low-level debugging messages via Rockchip RK3X UART2"
 		depends on ARCH_ROCKCHIP
 		select DEBUG_ROCKCHIP_UART
+		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on Rockchip based platforms.
@@ -525,6 +537,7 @@ choice
 		bool "Kernel low-level debugging messages via Rockchip RK3X UART3"
 		depends on ARCH_ROCKCHIP
 		select DEBUG_ROCKCHIP_UART
+		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on Rockchip based platforms.
@@ -587,6 +600,7 @@ choice
 	config DEBUG_SUNXI_UART0
 		bool "Kernel low-level debugging messages via sunXi UART0"
 		depends on ARCH_SUNXI
+		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on Allwinner A1X based platforms on the UART0.
@@ -594,6 +608,7 @@ choice
 	config DEBUG_SUNXI_UART1
 		bool "Kernel low-level debugging messages via sunXi UART1"
 		depends on ARCH_SUNXI
+		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on Allwinner A1X based platforms on the UART1.
@@ -857,8 +872,17 @@ config DEBUG_LL_INCLUDE
 	default "mach/debug-macro.S"
 
 config DEBUG_UART_8250
-	def_bool ARCH_EBSA110 || (FOOTBRIDGE && !DEBUG_DC21285_PORT) || \
-		ARCH_GEMINI || ARCH_RPC
+	def_bool ARCH_DOVE || ARCH_EBSA110 || \
+		(FOOTBRIDGE && !DEBUG_DC21285_PORT) || \
+		ARCH_GEMINI || ARCH_IOP13XX || ARCH_IOP32X || \
+		ARCH_IOP33X || ARCH_IXP4XX || ARCH_KIRKWOOD || \
+		ARCH_LPC32XX || ARCH_MV78XX0 || ARCH_ORION5X || ARCH_RPC
+
+config DEBUG_UART_8250_SHIFT
+	int "Register offset shift for the 8250 debug UART"
+	depends on DEBUG_UART_8250
+	default 0 if FOOTBRIDGE || ARCH_IOP32X
+	default 2
 
 config DEBUG_UART_8250_FLOW_CONTROL
 	bool "Enable flow control for 8250 UART"
diff --git a/arch/arm/include/asm/hardware/debug-8250.S b/arch/arm/include/asm/hardware/debug-8250.S
index bca3045..a0e6e17 100644
--- a/arch/arm/include/asm/hardware/debug-8250.S
+++ b/arch/arm/include/asm/hardware/debug-8250.S
@@ -9,6 +9,10 @@
  */
 #include <linux/serial_reg.h>
 
+#ifndef UART_SHIFT
+#define UART_SHIFT CONFIG_DEBUG_UART_8250_SHIFT
+#endif
+
 		.macro	senduart,rd,rx
 		strb	\rd, [\rx, #UART_TX << UART_SHIFT]
 		.endm
diff --git a/arch/arm/include/debug/mvebu.S b/arch/arm/include/debug/mvebu.S
index 6517311..0d0d820 100644
--- a/arch/arm/include/debug/mvebu.S
+++ b/arch/arm/include/debug/mvebu.S
@@ -26,5 +26,4 @@
 	orr	\rv, \rv, #0x00012000
 	.endm
 
-#define UART_SHIFT	2
 #include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/include/debug/nspire.S b/arch/arm/include/debug/nspire.S
index 886fd27..8874636 100644
--- a/arch/arm/include/debug/nspire.S
+++ b/arch/arm/include/debug/nspire.S
@@ -23,6 +23,5 @@
 #endif
 
 #ifdef CONFIG_DEBUG_NSPIRE_CLASSIC_UART
-#define UART_SHIFT 2
 #include <asm/hardware/debug-8250.S>
 #endif
diff --git a/arch/arm/include/debug/pxa.S b/arch/arm/include/debug/pxa.S
index e1e795a..f10fba50 100644
--- a/arch/arm/include/debug/pxa.S
+++ b/arch/arm/include/debug/pxa.S
@@ -29,5 +29,4 @@
 	ldr	\rv, =PXA_UART_REG_VIRT_BASE
 	.endm
 
-#define UART_SHIFT	2
 #include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/include/debug/rockchip.S b/arch/arm/include/debug/rockchip.S
index cfd883e..80ae8ca 100644
--- a/arch/arm/include/debug/rockchip.S
+++ b/arch/arm/include/debug/rockchip.S
@@ -38,5 +38,4 @@
 	ldr	\rv, =ROCKCHIP_UART_DEBUG_VIRT_BASE
 	.endm
 
-#define UART_SHIFT	2
 #include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/include/debug/sunxi.S b/arch/arm/include/debug/sunxi.S
index 04eb56d..65d0981 100644
--- a/arch/arm/include/debug/sunxi.S
+++ b/arch/arm/include/debug/sunxi.S
@@ -23,5 +23,4 @@
 	ldr	\rv, =SUNXI_UART_DEBUG_VIRT_BASE
 	.endm
 
-#define UART_SHIFT	2
 #include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-dove/include/mach/debug-macro.S b/arch/arm/mach-dove/include/mach/debug-macro.S
index 5929cbc..182a610 100644
--- a/arch/arm/mach-dove/include/mach/debug-macro.S
+++ b/arch/arm/mach-dove/include/mach/debug-macro.S
@@ -15,5 +15,4 @@
 	orr	\rv, \rv, #0x00012000
 	.endm
 
-#define UART_SHIFT	2
 #include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-ebsa110/include/mach/debug-macro.S b/arch/arm/mach-ebsa110/include/mach/debug-macro.S
index 9b66e79..984f0fa 100644
--- a/arch/arm/mach-ebsa110/include/mach/debug-macro.S
+++ b/arch/arm/mach-ebsa110/include/mach/debug-macro.S
@@ -17,5 +17,4 @@
 		mov	\rp, \rv
 		.endm
 
-#define UART_SHIFT	2
 #include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-footbridge/include/mach/debug-macro.S b/arch/arm/mach-footbridge/include/mach/debug-macro.S
index 18130fe..a209936 100644
--- a/arch/arm/mach-footbridge/include/mach/debug-macro.S
+++ b/arch/arm/mach-footbridge/include/mach/debug-macro.S
@@ -22,7 +22,6 @@
 		orr	\rp, \rp, #0x7c000000	@ physical
 		.endm
 
-#define UART_SHIFT	0
 #include <asm/hardware/debug-8250.S>
 
 #else
diff --git a/arch/arm/mach-gemini/include/mach/debug-macro.S b/arch/arm/mach-gemini/include/mach/debug-macro.S
index cdee448..2d94ea4 100644
--- a/arch/arm/mach-gemini/include/mach/debug-macro.S
+++ b/arch/arm/mach-gemini/include/mach/debug-macro.S
@@ -16,5 +16,4 @@
 	ldr	\rv, =IO_ADDRESS(GEMINI_UART_BASE)	@ virtual
 	.endm
 
-#define UART_SHIFT	2
 #include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-iop13xx/include/mach/debug-macro.S b/arch/arm/mach-iop13xx/include/mach/debug-macro.S
index d869a6f..4a776ca 100644
--- a/arch/arm/mach-iop13xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-iop13xx/include/mach/debug-macro.S
@@ -20,5 +20,4 @@
 	orr	\rp, \rp, #0x00d80000
 	.endm
 
-#define UART_SHIFT	2
 #include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-iop32x/include/mach/debug-macro.S b/arch/arm/mach-iop32x/include/mach/debug-macro.S
index 363bdf9..a090573 100644
--- a/arch/arm/mach-iop32x/include/mach/debug-macro.S
+++ b/arch/arm/mach-iop32x/include/mach/debug-macro.S
@@ -17,5 +17,4 @@
 		mov	\rv, \rp
 		.endm
 
-#define UART_SHIFT	0
 #include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-iop33x/include/mach/debug-macro.S b/arch/arm/mach-iop33x/include/mach/debug-macro.S
index 361be1f..894bf7c 100644
--- a/arch/arm/mach-iop33x/include/mach/debug-macro.S
+++ b/arch/arm/mach-iop33x/include/mach/debug-macro.S
@@ -18,5 +18,4 @@
 		orr	\rp, #0xff000000	@ physical
 		.endm
 
-#define UART_SHIFT	2
 #include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-ixp4xx/include/mach/debug-macro.S b/arch/arm/mach-ixp4xx/include/mach/debug-macro.S
index ff686cb..403bd35 100644
--- a/arch/arm/mach-ixp4xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-ixp4xx/include/mach/debug-macro.S
@@ -22,5 +22,4 @@
                 orr     \rp, \rp, #0xc8000000	@ physical
                 .endm
 
-#define UART_SHIFT	2
 #include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-kirkwood/include/mach/debug-macro.S b/arch/arm/mach-kirkwood/include/mach/debug-macro.S
index f785d40..51eee02 100644
--- a/arch/arm/mach-kirkwood/include/mach/debug-macro.S
+++ b/arch/arm/mach-kirkwood/include/mach/debug-macro.S
@@ -15,5 +15,4 @@
 	orr	\rv, \rv, #0x00012000
 	.endm
 
-#define UART_SHIFT	2
 #include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-lpc32xx/include/mach/debug-macro.S b/arch/arm/mach-lpc32xx/include/mach/debug-macro.S
index 351bd6c..11f986e 100644
--- a/arch/arm/mach-lpc32xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-lpc32xx/include/mach/debug-macro.S
@@ -25,5 +25,4 @@
 	ldrne	\rv, =0xF4090000
 	.endm
 
-#define UART_SHIFT	2
 #include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-mv78xx0/include/mach/debug-macro.S b/arch/arm/mach-mv78xx0/include/mach/debug-macro.S
index a7df02b..0fce467 100644
--- a/arch/arm/mach-mv78xx0/include/mach/debug-macro.S
+++ b/arch/arm/mach-mv78xx0/include/mach/debug-macro.S
@@ -15,5 +15,4 @@
 	orr	\rv, \rv, #0x00012000
 	.endm
 
-#define UART_SHIFT	2
 #include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-orion5x/include/mach/debug-macro.S b/arch/arm/mach-orion5x/include/mach/debug-macro.S
index f340ed8..52f29ef 100644
--- a/arch/arm/mach-orion5x/include/mach/debug-macro.S
+++ b/arch/arm/mach-orion5x/include/mach/debug-macro.S
@@ -17,5 +17,4 @@
 	orr	\rv, \rv, #0x00012000
 	.endm
 
-#define UART_SHIFT	2
 #include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-rpc/include/mach/debug-macro.S b/arch/arm/mach-rpc/include/mach/debug-macro.S
index a92753d..fcb5450 100644
--- a/arch/arm/mach-rpc/include/mach/debug-macro.S
+++ b/arch/arm/mach-rpc/include/mach/debug-macro.S
@@ -18,5 +18,4 @@
 		orr	\rp, \rp, #0x03000000	@ physical
 		.endm
 
-#define UART_SHIFT	2
 #include <asm/hardware/debug-8250.S>
-- 
1.7.4.4
