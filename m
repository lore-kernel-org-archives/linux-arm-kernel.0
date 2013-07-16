From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 16 Jul 2013 17:41:12 +0100
Subject: [PATCH RFC v2 08/14] ARM: debug: provide PL01x debug uart phys/virt
 address configuration options
In-Reply-To: <20130716163243.GY21614@n2100.arm.linux.org.uk>
References: <20130716163243.GY21614@n2100.arm.linux.org.uk>
Message-ID: <E1Uz8JM-00047w-PP@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the definition of the UART register addresses out of the platform
specific header files into the Kconfig files.

Acked-by: Ryan Mallon <rmallon@gmail.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig.debug                             |   54 ++++++++++++++++++--
 arch/arm/include/asm/hardware/debug-pl01x.S        |    7 +++
 arch/arm/include/debug/bcm2835.S                   |    9 ---
 arch/arm/include/debug/cns3xxx.S                   |    7 ---
 arch/arm/include/debug/highbank.S                  |    6 --
 arch/arm/include/debug/mxs.S                       |   14 -----
 arch/arm/include/debug/nomadik.S                   |    8 ---
 arch/arm/include/debug/nspire.S                    |   10 ----
 arch/arm/include/debug/u300.S                      |   11 ----
 arch/arm/include/debug/vexpress.S                  |   46 -----------------
 arch/arm/mach-ep93xx/include/mach/debug-macro.S    |    9 ---
 .../arm/mach-integrator/include/mach/debug-macro.S |    7 ---
 arch/arm/mach-realview/include/mach/debug-macro.S  |   17 ------
 arch/arm/mach-versatile/include/mach/debug-macro.S |    8 ---
 14 files changed, 57 insertions(+), 156 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 0e8202e..f1cde5e 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -92,6 +92,7 @@ choice
 	config DEBUG_BCM2835
 		bool "Kernel low-level debugging on BCM2835 PL011 UART"
 		depends on ARCH_BCM2835
+		select DEBUG_UART_PL01X
 
 	config DEBUG_CLPS711X_UART1
 		bool "Kernel low-level debugging messages via UART1"
@@ -110,6 +111,7 @@ choice
 	config DEBUG_CNS3XXX
 		bool "Kernel Kernel low-level debugging on Cavium Networks CNS3xxx"
 		depends on ARCH_CNS3XXX
+		select DEBUG_UART_PL01X
 		help
 		  Say Y here if you want the debug print routines to direct
                   their output to the CNS3xxx UART0.
@@ -177,6 +179,7 @@ choice
 	config DEBUG_HIGHBANK_UART
 		bool "Kernel low-level debugging messages via Highbank UART"
 		depends on ARCH_HIGHBANK
+		select DEBUG_UART_PL01X
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to the UART on Highbank based devices.
@@ -191,6 +194,7 @@ choice
 	config DEBUG_IMX23_UART
 		bool "i.MX23 Debug UART"
 		depends on SOC_IMX23
+		select DEBUG_UART_PL01X
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on i.MX23.
@@ -212,6 +216,7 @@ choice
 	config DEBUG_IMX28_UART
 		bool "i.MX28 Debug UART"
 		depends on SOC_IMX28
+		select DEBUG_UART_PL01X
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on i.MX28.
@@ -362,6 +367,7 @@ choice
 	config DEBUG_NOMADIK_UART
 		bool "Kernel low-level debugging messages via NOMADIK UART"
 		depends on ARCH_NOMADIK
+		select DEBUG_UART_PL01X
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on NOMADIK based platforms.
@@ -377,6 +383,7 @@ choice
 	config DEBUG_NSPIRE_CX_UART
 		bool "Kernel low-level debugging via TI-NSPIRE PL011 UART"
 		depends on ARCH_NSPIRE
+		select DEBUG_UART_PL01X
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on TI-NSPIRE CX models.
@@ -467,6 +474,7 @@ choice
 	config DEBUG_REALVIEW_STD_PORT
 		bool "RealView Default UART"
 		depends on ARCH_REALVIEW
+		select DEBUG_UART_PL01X
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to the serial port on RealView EB, PB11MP, PBA8
@@ -475,6 +483,7 @@ choice
 	config DEBUG_REALVIEW_PB1176_PORT
 		bool "RealView PB1176 UART"
 		depends on MACH_REALVIEW_PB1176
+		select DEBUG_UART_PL01X
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to the standard serial port on the RealView
@@ -706,6 +715,7 @@ choice
 	config DEBUG_U300_UART
 		bool "Kernel low-level debugging messages via U300 UART0"
 		depends on ARCH_U300
+		select DEBUG_UART_PL01X
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to the uart port on U300 devices.
@@ -731,6 +741,7 @@ choice
 	config DEBUG_VEXPRESS_UART0_CA9
 		bool "Use PL011 UART0 at 0x10009000 (V2P-CA9 core tile)"
 		depends on ARCH_VEXPRESS
+		select DEBUG_UART_PL01X
 		help
 		  This option selects UART0 at 0x10009000. Except for custom models,
 		  this applies only to the V2P-CA9 tile.
@@ -738,6 +749,7 @@ choice
 	config DEBUG_VEXPRESS_UART0_RS1
 		bool "Use PL011 UART0 at 0x1c090000 (RS1 complaint tiles)"
 		depends on ARCH_VEXPRESS
+		select DEBUG_UART_PL01X
 		help
 		  This option selects UART0 at 0x1c090000. This applies to most
 		  of the tiles using the RS1 memory map, including all new A-class
@@ -746,6 +758,7 @@ choice
 	config DEBUG_VEXPRESS_UART0_CRX
 		bool "Use PL011 UART0 at 0xb0090000 (Cortex-R compliant tiles)"
 		depends on ARCH_VEXPRESS && !MMU
+		select DEBUG_UART_PL01X
 		help
 		  This option selects UART0 at 0xb0090000. This is appropriate for
 		  Cortex-R series tiles and SMMs, such as Cortex-R5 and Cortex-R7
@@ -865,6 +878,11 @@ config DEBUG_LL_INCLUDE
 	default "debug/zynq.S" if DEBUG_ZYNQ_UART0 || DEBUG_ZYNQ_UART1
 	default "mach/debug-macro.S"
 
+config DEBUG_UART_PL01X
+	def_bool ARCH_EP93XX || \
+		ARCH_INTEGRATOR || \
+		ARCH_VERSATILE
+
 config DEBUG_UART_8250
 	def_bool ARCH_DOVE || ARCH_EBSA110 || \
 		(FOOTBRIDGE && !DEBUG_DC21285_PORT) || \
@@ -877,17 +895,30 @@ config DEBUG_UART_PHYS
 	default 0x01c28000 if DEBUG_SUNXI_UART0
 	default 0x01c28400 if DEBUG_SUNXI_UART1
 	default 0x03010fe0 if ARCH_RPC
+	default 0x10009000 if DEBUG_REALVIEW_STD_PORT || DEBUG_CNS3XXX || \
+				DEBUG_VEXPRESS_UART0_CA9
+	default 0x1010c000 if DEBUG_REALVIEW_PB1176_PORT
 	default 0x10124000 if DEBUG_RK3X_UART0
 	default 0x10126000 if DEBUG_RK3X_UART1
+	default 0x101f1000 if ARCH_VERSATILE
+	default 0x101fb000 if DEBUG_NOMADIK_UART
+	default 0x16000000 if ARCH_INTEGRATOR
+	default 0x1c090000 if DEBUG_VEXPRESS_UART0_RS1
 	default 0x20060000 if DEBUG_RK29_UART0
 	default 0x20064000 if DEBUG_RK29_UART1 || DEBUG_RK3X_UART2
 	default 0x20068000 if DEBUG_RK29_UART2 || DEBUG_RK3X_UART3
+	default 0x20201000 if DEBUG_BCM2835
 	default 0x40090000 if ARCH_LPC32XX
 	default 0x40100000 if DEBUG_PXA_UART1
 	default 0x42000000 if ARCH_GEMINI
 	default 0x7c0003f8 if FOOTBRIDGE
 	default 0x80230000 if DEBUG_PICOXCELL_UART
-	default 0x90020000 if DEBUG_NSPIRE_CLASSIC_UART
+	default 0x80070000 if DEBUG_IMX23_UART
+	default 0x80074000 if DEBUG_IMX28_UART
+	default 0x808c0000 if ARCH_EP93XX
+	default 0x90020000 if DEBUG_NSPIRE_CLASSIC_UART || DEBUG_NSPIRE_CX_UART
+	default 0xb0090000 if DEBUG_VEXPRESS_UART0_CRX
+	default 0xc0013000 if DEBUG_U300_UART
 	default 0xc8000000 if ARCH_IXP4XX && !CPU_BIG_ENDIAN
 	default 0xc8000003 if ARCH_IXP4XX && CPU_BIG_ENDIAN
 	default 0xd0012000 if DEBUG_MVEBU_UART
@@ -900,23 +931,34 @@ config DEBUG_UART_PHYS
 	default 0xfe800000 if ARCH_IOP32X
 	default 0xffc02000 if DEBUG_SOCFPGA_UART
 	default 0xffd82340 if ARCH_IOP13XX
+	default 0xfff36000 if DEBUG_HIGHBANK_UART
 	default 0xfffff700 if ARCH_IOP33X
-	depends on DEBUG_UART_8250
+	depends on DEBUG_UART_8250 || DEBUG_UART_PL01X
 
 config DEBUG_UART_VIRT
 	hex "Virtual base address of debug UART"
 	default 0xe0010fe0 if ARCH_RPC
 	default 0xf0000be0 if ARCH_EBSA110
+	default 0xf0009000 if DEBUG_CNS3XXX
+	default 0xf01fb000 if DEBUG_NOMADIK_UART
+	default 0xf0201000 if DEBUG_BCM2835
+	default 0xf11f1000 if ARCH_VERSATILE
+	default 0xf1600000 if ARCH_INTEGRATOR
 	default 0xf1c28000 if DEBUG_SUNXI_UART0
 	default 0xf1c28400 if DEBUG_SUNXI_UART1
 	default 0xf2100000 if DEBUG_PXA_UART1
 	default 0xf4090000 if ARCH_LPC32XX
 	default 0xf4200000 if ARCH_GEMINI
+	default 0xf8009000 if DEBUG_VEXPRESS_UART0_CA9
+	default 0xf8090000 if DEBUG_VEXPRESS_UART0_RS1
+	default 0xfb009000 if DEBUG_REALVIEW_STD_PORT
+	default 0xfb10c000 if DEBUG_REALVIEW_PB1176_PORT
 	default 0xfd012000 if ARCH_MV78XX0
 	default 0xfde12000 if ARCH_DOVE
 	default 0xfe012000 if ARCH_ORION5X
 	default 0xfe017000 if DEBUG_MMP_UART2
 	default 0xfe018000 if DEBUG_MMP_UART3
+	default 0xfe100000 if DEBUG_IMX23_UART || DEBUG_IMX28_UART
 	default 0xfe230000 if DEBUG_PICOXCELL_UART
 	default 0xfe800000 if ARCH_IOP32X
 	default 0xfeb24000 if DEBUG_RK3X_UART0
@@ -927,13 +969,17 @@ config DEBUG_UART_VIRT
 	default 0xfed68000 if DEBUG_RK29_UART2 || DEBUG_RK3X_UART3
 	default 0xfec02000 if DEBUG_SOCFPGA_UART
 	default 0xfed12000 if ARCH_KIRKWOOD
+	default 0xfedc0000 if ARCH_EP93XX
 	default 0xfee003f8 if FOOTBRIDGE
-	default 0xfee20000 if DEBUG_NSPIRE_CLASSIC_UART
+	default 0xfee20000 if DEBUG_NSPIRE_CLASSIC_UART || DEBUG_NSPIRE_CX_UART
+	default 0xfee36000 if DEBUG_HIGHBANK_UART
 	default 0xfee82340 if ARCH_IOP13XX
 	default 0xfef00000 if ARCH_IXP4XX && !CPU_BIG_ENDIAN
 	default 0xfef00003 if ARCH_IXP4XX && CPU_BIG_ENDIAN
 	default 0xfefff700 if ARCH_IOP33X
-	depends on DEBUG_UART_8250
+	default 0xff003000 if DEBUG_U300_UART
+	default DEBUG_UART_PHYS if !MMU
+	depends on DEBUG_UART_8250 || DEBUG_UART_PL01X
 
 config DEBUG_UART_8250_SHIFT
 	int "Register offset shift for the 8250 debug UART"
diff --git a/arch/arm/include/asm/hardware/debug-pl01x.S b/arch/arm/include/asm/hardware/debug-pl01x.S
index f9fd083..9d1e286 100644
--- a/arch/arm/include/asm/hardware/debug-pl01x.S
+++ b/arch/arm/include/asm/hardware/debug-pl01x.S
@@ -12,6 +12,13 @@
 */
 #include <linux/amba/serial.h>
 
+#ifdef CONFIG_DEBUG_UART_PHYS
+		.macro	addruart, rp, rv, tmp
+		ldr	\rp, =CONFIG_DEBUG_UART_PHYS
+		ldr	\rv, =CONFIG_DEBUG_UART_VIRT
+		.endm
+#endif
+
 		.macro	senduart,rd,rx
 		strb	\rd, [\rx, #UART01x_DR]
 		.endm
diff --git a/arch/arm/include/debug/bcm2835.S b/arch/arm/include/debug/bcm2835.S
index aed9199..726e069 100644
--- a/arch/arm/include/debug/bcm2835.S
+++ b/arch/arm/include/debug/bcm2835.S
@@ -10,13 +10,4 @@
  * published by the Free Software Foundation.
  *
  */
-
-#define BCM2835_DEBUG_PHYS 0x20201000
-#define BCM2835_DEBUG_VIRT 0xf0201000
-
-	.macro	addruart, rp, rv, tmp
-	ldr	\rp, =BCM2835_DEBUG_PHYS
-	ldr	\rv, =BCM2835_DEBUG_VIRT
-	.endm
-
 #include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/include/debug/cns3xxx.S b/arch/arm/include/debug/cns3xxx.S
index d04c150..2d5fb51 100644
--- a/arch/arm/include/debug/cns3xxx.S
+++ b/arch/arm/include/debug/cns3xxx.S
@@ -9,11 +9,4 @@
  * it under the terms of the GNU General Public License, Version 2, as
  * published by the Free Software Foundation.
  */
-
-		.macro	addruart,rp,rv,tmp
-		mov	\rp, #0x00009000
-		orr	\rv, \rp, #0xf0000000	@ virtual base
-		orr	\rp, \rp, #0x10000000
-		.endm
-
 #include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/include/debug/highbank.S b/arch/arm/include/debug/highbank.S
index 8cad432..3c6f63f 100644
--- a/arch/arm/include/debug/highbank.S
+++ b/arch/arm/include/debug/highbank.S
@@ -8,10 +8,4 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
-		.macro	addruart,rp,rv,tmp
-		ldr	\rv, =0xfee36000
-		ldr	\rp, =0xfff36000
-		.endm
-
 #include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/include/debug/mxs.S b/arch/arm/include/debug/mxs.S
index d869515..8a10ed2 100644
--- a/arch/arm/include/debug/mxs.S
+++ b/arch/arm/include/debug/mxs.S
@@ -10,18 +10,4 @@
  * published by the Free Software Foundation.
  *
  */
-
-#ifdef CONFIG_DEBUG_IMX23_UART
-#define UART_PADDR	0x80070000
-#elif defined (CONFIG_DEBUG_IMX28_UART)
-#define UART_PADDR	0x80074000
-#endif
-
-#define UART_VADDR	0xfe100000
-
-		.macro	addruart, rp, rv, tmp
-		ldr	\rp, =UART_PADDR	@ physical
-		ldr	\rv, =UART_VADDR	@ virtual
-		.endm
-
 #include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/include/debug/nomadik.S b/arch/arm/include/debug/nomadik.S
index 7354179..a6d238e 100644
--- a/arch/arm/include/debug/nomadik.S
+++ b/arch/arm/include/debug/nomadik.S
@@ -9,12 +9,4 @@
  * published by the Free Software Foundation.
  *
 */
-
-		.macro	addruart, rp, rv, tmp
-		mov	\rp, #0x00100000
-		add	\rp, \rp, #0x000fb000
-		add	\rv, \rp, #0xf0000000	@ virtual base
-		add	\rp, \rp, #0x10000000	@ physical base address
-		.endm
-
 #include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/include/debug/nspire.S b/arch/arm/include/debug/nspire.S
index 9c2fbec..fc17e50 100644
--- a/arch/arm/include/debug/nspire.S
+++ b/arch/arm/include/debug/nspire.S
@@ -8,14 +8,4 @@
  * published by the Free Software Foundation.
  *
  */
-#ifdef CONFIG_DEBUG_NSPIRE_CX_UART
-#define NSPIRE_EARLY_UART_PHYS_BASE	   0x90020000
-#define NSPIRE_EARLY_UART_VIRT_BASE	   0xfee20000
-
-.macro	addruart, rp, rv, tmp
-	ldr \rp, =(NSPIRE_EARLY_UART_PHYS_BASE)		@ physical base address
-	ldr \rv, =(NSPIRE_EARLY_UART_VIRT_BASE)		@ virtual base address
-.endm
-
 #include <asm/hardware/debug-pl01x.S>
-#endif
diff --git a/arch/arm/include/debug/u300.S b/arch/arm/include/debug/u300.S
index 6f04f08..58b9d62 100644
--- a/arch/arm/include/debug/u300.S
+++ b/arch/arm/include/debug/u300.S
@@ -4,15 +4,4 @@
  * Debugging macro include header.
  * Author: Linus Walleij <linus.walleij@stericsson.com>
  */
-#define U300_SLOW_PER_PHYS_BASE		0xc0010000
-#define U300_SLOW_PER_VIRT_BASE		0xff000000
-
-	.macro	addruart, rp, rv, tmp
-	/* If we move the address using MMU, use this. */
-	ldr	\rp,	  = U300_SLOW_PER_PHYS_BASE @ MMU off, physical address
-	ldr	\rv,	  = U300_SLOW_PER_VIRT_BASE @ MMU on, virtual address
-	orr	\rp, \rp, #0x00003000
-	orr	\rv, \rv, #0x00003000
-	.endm
-
 #include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/include/debug/vexpress.S b/arch/arm/include/debug/vexpress.S
index acafb22..114bf4c 100644
--- a/arch/arm/include/debug/vexpress.S
+++ b/arch/arm/include/debug/vexpress.S
@@ -48,50 +48,4 @@
 		.endm
 
 #include <asm/hardware/debug-pl01x.S>
-
-#elif defined(CONFIG_DEBUG_VEXPRESS_UART0_CA9)
-
-		.macro	addruart,rp,rv,tmp
-		mov	\rp, #DEBUG_LL_UART_OFFSET
-		orr	\rv, \rp, #DEBUG_LL_VIRT_BASE
-		orr	\rp, \rp, #DEBUG_LL_PHYS_BASE
-		.endm
-
-#include <asm/hardware/debug-pl01x.S>
-
-#elif defined(CONFIG_DEBUG_VEXPRESS_UART0_RS1)
-
-		.macro	addruart,rp,rv,tmp
-		mov	\rp, #DEBUG_LL_UART_OFFSET_RS1
-		orr	\rv, \rp, #DEBUG_LL_VIRT_BASE
-		orr	\rp, \rp, #DEBUG_LL_PHYS_BASE_RS1
-		.endm
-
-#include <asm/hardware/debug-pl01x.S>
-
-#elif defined(CONFIG_DEBUG_VEXPRESS_UART0_CRX)
-
-		.macro	addruart,rp,tmp,tmp2
-		ldr	\rp, =DEBUG_LL_UART_PHYS_CRX
-		.endm
-
-#include <asm/hardware/debug-pl01x.S>
-
-#else /* CONFIG_DEBUG_LL_UART_NONE */
-
-		.macro	addruart, rp, rv, tmp
-		/* Safe dummy values */
-		mov	\rp, #0
-		mov	\rv, #DEBUG_LL_VIRT_BASE
-		.endm
-
-		.macro	senduart,rd,rx
-		.endm
-
-		.macro	waituart,rd,rx
-		.endm
-
-		.macro	busyuart,rd,rx
-		.endm
-
 #endif
diff --git a/arch/arm/mach-ep93xx/include/mach/debug-macro.S b/arch/arm/mach-ep93xx/include/mach/debug-macro.S
index af54e43..a1bfe4c 100644
--- a/arch/arm/mach-ep93xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-ep93xx/include/mach/debug-macro.S
@@ -9,13 +9,4 @@
  * the Free Software Foundation; either version 2 of the License, or (at
  * your option) any later version.
  */
-#include <mach/ep93xx-regs.h>
-
-		.macro	addruart, rp, rv, tmp
-		ldr	\rp, =EP93XX_APB_PHYS_BASE	@ Physical base
-		ldr	\rv, =EP93XX_APB_VIRT_BASE	@ virtual base
-		orr	\rp, \rp, #0x000c0000
-		orr	\rv, \rv, #0x000c0000
-		.endm
-
 #include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/mach-integrator/include/mach/debug-macro.S b/arch/arm/mach-integrator/include/mach/debug-macro.S
index 411b116..03ee0fd 100644
--- a/arch/arm/mach-integrator/include/mach/debug-macro.S
+++ b/arch/arm/mach-integrator/include/mach/debug-macro.S
@@ -10,11 +10,4 @@
  * published by the Free Software Foundation.
  *
 */
-
-		.macro	addruart, rp, rv, tmp
-		mov	\rp, #0x16000000	@ physical base address
-		mov	\rv, #0xf0000000	@ virtual base
-		add	\rv, \rv, #0x16000000 >> 4
-		.endm
-
 #include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/mach-realview/include/mach/debug-macro.S b/arch/arm/mach-realview/include/mach/debug-macro.S
index 8cc372d..99488f4 100644
--- a/arch/arm/mach-realview/include/mach/debug-macro.S
+++ b/arch/arm/mach-realview/include/mach/debug-macro.S
@@ -9,21 +9,4 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
-#ifdef CONFIG_DEBUG_REALVIEW_STD_PORT
-#define DEBUG_LL_UART_OFFSET	0x00009000
-#elif defined(CONFIG_DEBUG_REALVIEW_PB1176_PORT)
-#define DEBUG_LL_UART_OFFSET	0x0010c000
-#endif
-
-#ifndef DEBUG_LL_UART_OFFSET
-#error "Unknown RealView platform"
-#endif
-
-		.macro	addruart, rp, rv, tmp
-		mov	\rp, #DEBUG_LL_UART_OFFSET
-		orr	\rv, \rp, #0xfb000000	@ virtual base
-		orr	\rp, \rp, #0x10000000	@ physical base
-		.endm
-
 #include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/mach-versatile/include/mach/debug-macro.S b/arch/arm/mach-versatile/include/mach/debug-macro.S
index d0fbd7f..c256977 100644
--- a/arch/arm/mach-versatile/include/mach/debug-macro.S
+++ b/arch/arm/mach-versatile/include/mach/debug-macro.S
@@ -10,12 +10,4 @@
  * published by the Free Software Foundation.
  *
 */
-
-		.macro	addruart, rp, rv, tmp
-		mov	\rp,      #0x001F0000
-		orr	\rp, \rp, #0x00001000
-		orr	\rv, \rp, #0xf1000000	@ virtual base
-		orr	\rp, \rp,  #0x10000000	@ physical base
-		.endm
-
 #include <asm/hardware/debug-pl01x.S>
-- 
1.7.4.4
