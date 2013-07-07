From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 07 Jul 2013 13:48:31 +0100
Subject: [PATCH RFC 5/9] ARM: debug: provide 8250 debug uart phys/virt
 address configuration options
In-Reply-To: <20130707124326.GP24642@n2100.arm.linux.org.uk>
References: <20130707124326.GP24642@n2100.arm.linux.org.uk>
Message-ID: <E1UvoOF-0006Ht-5f@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the definition of the UART register addresses out of the platform
specific header file into the Kconfig files.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig.debug                             |   59 ++++++++++++++++++++
 arch/arm/include/asm/hardware/debug-8250.S         |    7 ++
 arch/arm/include/debug/mvebu.S                     |   16 -----
 arch/arm/include/debug/nspire.S                    |    4 +-
 arch/arm/include/debug/pxa.S                       |   19 ------
 arch/arm/include/debug/rockchip.S                  |   29 ----------
 arch/arm/include/debug/sunxi.S                     |   14 -----
 arch/arm/mach-dove/include/mach/debug-macro.S      |   10 ---
 arch/arm/mach-ebsa110/include/mach/debug-macro.S   |    7 --
 .../arm/mach-footbridge/include/mach/debug-macro.S |    9 ---
 arch/arm/mach-gemini/include/mach/debug-macro.S    |    7 --
 arch/arm/mach-iop13xx/include/mach/debug-macro.S   |   10 ---
 arch/arm/mach-iop32x/include/mach/debug-macro.S    |    7 --
 arch/arm/mach-iop33x/include/mach/debug-macro.S    |    8 ---
 arch/arm/mach-ixp4xx/include/mach/debug-macro.S    |   13 ----
 arch/arm/mach-kirkwood/include/mach/debug-macro.S  |   10 ---
 arch/arm/mach-lpc32xx/include/mach/debug-macro.S   |   10 ---
 arch/arm/mach-mv78xx0/include/mach/debug-macro.S   |   10 ---
 arch/arm/mach-orion5x/include/mach/debug-macro.S   |   10 ---
 arch/arm/mach-rpc/include/mach/debug-macro.S       |    8 ---
 20 files changed, 67 insertions(+), 200 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index bfc310b..82ce0ba 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -869,6 +869,65 @@ config DEBUG_UART_8250
 		ARCH_IOP33X || ARCH_IXP4XX || ARCH_KIRKWOOD || \
 		ARCH_LPC32XX || ARCH_MV78XX0 || ARCH_ORION5X || ARCH_RPC
 
+config DEBUG_UART_PHYS
+	hex "Physical base address of debug UART"
+	default 0x01c28000 if DEBUG_SUNXI_UART0
+	default 0x01c28400 if DEBUG_SUNXI_UART1
+	default 0x03010fe0 if ARCH_RPC
+	default 0x10124000 if DEBUG_RK3X_UART0
+	default 0x10126000 if DEBUG_RK3X_UART1
+	default 0x20060000 if DEBUG_RK29_UART0
+	default 0x20064000 if DEBUG_RK29_UART1 || DEBUG_RK3X_UART2
+	default 0x20068000 if DEBUG_RK29_UART2 || DEBUG_RK3X_UART3
+	default 0x40090000 if ARCH_LPC32XX
+	default 0x40100000 if DEBUG_PXA_UART1
+	default 0x42000000 if ARCH_GEMINI
+	default 0x7c0003f8 if FOOTBRIDGE
+	default 0x90020000 if DEBUG_NSPIRE_CLASSIC_UART
+	default 0xc8000000 if ARCH_IXP4XX && !CPU_BIG_ENDIAN
+	default 0xc8000003 if ARCH_IXP4XX && CPU_BIG_ENDIAN
+	default 0xd0012000 if DEBUG_MVEBU_UART
+	default 0xd4017000 if DEBUG_MMP_UART2
+	default 0xd4018000 if DEBUG_MMP_UART3
+	default 0xf0000be0 if ARCH_EBSA110
+	default 0xf1012000 if DEBUG_MVEBU_UART_ALTERNATE
+	default 0xf1012000 if ARCH_DOVE || ARCH_KIRKWOOD || ARCH_MV78XX0 || \
+				ARCH_ORION5X
+	default 0xfe800000 if ARCH_IOP32X
+	default 0xffd82340 if ARCH_IOP13XX
+	default 0xfffff700 if ARCH_IOP33X
+	depends on DEBUG_UART_8250
+
+config DEBUG_UART_VIRT
+	hex "Virtual base address of debug UART"
+	default 0xe0010fe0 if ARCH_RPC
+	default 0xf0000be0 if ARCH_EBSA110
+	default 0xf1c28000 if DEBUG_SUNXI_UART0
+	default 0xf1c28400 if DEBUG_SUNXI_UART1
+	default 0xf2100000 if DEBUG_PXA_UART1
+	default 0xf4090000 if ARCH_LPC32XX
+	default 0xf4200000 if ARCH_GEMINI
+	default 0xfd012000 if ARCH_MV78XX0
+	default 0xfde12000 if ARCH_DOVE
+	default 0xfe012000 if ARCH_ORION5X
+	default 0xfe017000 if DEBUG_MMP_UART2
+	default 0xfe018000 if DEBUG_MMP_UART3
+	default 0xfe800000 if ARCH_IOP32X
+	default 0xfeb24000 if DEBUG_RK3X_UART0
+	default 0xfeb26000 if DEBUG_RK3X_UART1
+	default 0xfec12000 if DEBUG_MVEBU_UART || DEBUG_MVEBU_UART_ALTERNATE
+	default 0xfed60000 if DEBUG_RK29_UART0
+	default 0xfed64000 if DEBUG_RK29_UART1 || DEBUG_RK3X_UART2
+	default 0xfed68000 if DEBUG_RK29_UART2 || DEBUG_RK3X_UART3
+	default 0xfed12000 if ARCH_KIRKWOOD
+	default 0xfee003f8 if FOOTBRIDGE
+	default 0xfee20000 if DEBUG_NSPIRE_CLASSIC_UART
+	default 0xfee82340 if ARCH_IOP13XX
+	default 0xfef00000 if ARCH_IXP4XX && !CPU_BIG_ENDIAN
+	default 0xfef00003 if ARCH_IXP4XX && CPU_BIG_ENDIAN
+	default 0xfefff700 if ARCH_IOP33X
+	depends on DEBUG_UART_8250
+
 config DEBUG_UART_8250_SHIFT
 	int "Register offset shift for the 8250 debug UART"
 	depends on DEBUG_UART_8250
diff --git a/arch/arm/include/asm/hardware/debug-8250.S b/arch/arm/include/asm/hardware/debug-8250.S
index a0e6e17..4c62f2d 100644
--- a/arch/arm/include/asm/hardware/debug-8250.S
+++ b/arch/arm/include/asm/hardware/debug-8250.S
@@ -9,6 +9,13 @@
  */
 #include <linux/serial_reg.h>
 
+#ifdef CONFIG_DEBUG_UART_PHYS
+		.macro	addruart, rp, rv, tmp
+		ldr	\rp, =CONFIG_DEBUG_UART_PHYS
+		ldr	\rv, =CONFIG_DEBUG_UART_VIRT
+		.endm
+#endif
+
 #ifndef UART_SHIFT
 #define UART_SHIFT CONFIG_DEBUG_UART_8250_SHIFT
 #endif
diff --git a/arch/arm/include/debug/mvebu.S b/arch/arm/include/debug/mvebu.S
index 0d0d820..6309be5 100644
--- a/arch/arm/include/debug/mvebu.S
+++ b/arch/arm/include/debug/mvebu.S
@@ -10,20 +10,4 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
 */
-
-#ifdef CONFIG_DEBUG_MVEBU_UART_ALTERNATE
-#define ARMADA_370_XP_REGS_PHYS_BASE	0xf1000000
-#else
-#define ARMADA_370_XP_REGS_PHYS_BASE	0xd0000000
-#endif
-
-#define ARMADA_370_XP_REGS_VIRT_BASE	0xfec00000
-
-	.macro	addruart, rp, rv, tmp
-	ldr	\rp, =ARMADA_370_XP_REGS_PHYS_BASE
-	ldr	\rv, =ARMADA_370_XP_REGS_VIRT_BASE
-	orr	\rp, \rp, #0x00012000
-	orr	\rv, \rv, #0x00012000
-	.endm
-
 #include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/include/debug/nspire.S b/arch/arm/include/debug/nspire.S
index 8874636..3e9329a 100644
--- a/arch/arm/include/debug/nspire.S
+++ b/arch/arm/include/debug/nspire.S
@@ -8,7 +8,7 @@
  * published by the Free Software Foundation.
  *
  */
-
+#ifdef CONFIG_DEBUG_NSPIRE_CX_UART
 #define NSPIRE_EARLY_UART_PHYS_BASE	   0x90020000
 #define NSPIRE_EARLY_UART_VIRT_BASE	   0xfee20000
 
@@ -17,8 +17,6 @@
 	ldr \rv, =(NSPIRE_EARLY_UART_VIRT_BASE)		@ virtual base address
 .endm
 
-
-#ifdef CONFIG_DEBUG_NSPIRE_CX_UART
 #include <asm/hardware/debug-pl01x.S>
 #endif
 
diff --git a/arch/arm/include/debug/pxa.S b/arch/arm/include/debug/pxa.S
index f10fba50..09e54f3 100644
--- a/arch/arm/include/debug/pxa.S
+++ b/arch/arm/include/debug/pxa.S
@@ -10,23 +10,4 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
 */
-
-#if defined(CONFIG_DEBUG_PXA_UART1)
-#define PXA_UART_REG_PHYS_BASE	0x40100000
-#define PXA_UART_REG_VIRT_BASE	0xf2100000
-#elif defined(CONFIG_DEBUG_MMP_UART2)
-#define PXA_UART_REG_PHYS_BASE	0xd4017000
-#define PXA_UART_REG_VIRT_BASE	0xfe017000
-#elif defined(CONFIG_DEBUG_MMP_UART3)
-#define PXA_UART_REG_PHYS_BASE	0xd4018000
-#define PXA_UART_REG_VIRT_BASE	0xfe018000
-#else
-#error "Select uart for DEBUG_LL"
-#endif
-
-	.macro	addruart, rp, rv, tmp
-	ldr	\rp, =PXA_UART_REG_PHYS_BASE
-	ldr	\rv, =PXA_UART_REG_VIRT_BASE
-	.endm
-
 #include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/include/debug/rockchip.S b/arch/arm/include/debug/rockchip.S
index 80ae8ca..3ad0238 100644
--- a/arch/arm/include/debug/rockchip.S
+++ b/arch/arm/include/debug/rockchip.S
@@ -9,33 +9,4 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
 */
-
-#if defined(CONFIG_DEBUG_RK29_UART0)
-#define ROCKCHIP_UART_DEBUG_PHYS_BASE 0x20060000
-#define ROCKCHIP_UART_DEBUG_VIRT_BASE 0xfed60000
-#elif defined(CONFIG_DEBUG_RK29_UART1)
-#define ROCKCHIP_UART_DEBUG_PHYS_BASE 0x20064000
-#define ROCKCHIP_UART_DEBUG_VIRT_BASE 0xfed64000
-#elif defined(CONFIG_DEBUG_RK29_UART2)
-#define ROCKCHIP_UART_DEBUG_PHYS_BASE 0x20068000
-#define ROCKCHIP_UART_DEBUG_VIRT_BASE 0xfed68000
-#elif defined(CONFIG_DEBUG_RK3X_UART0)
-#define ROCKCHIP_UART_DEBUG_PHYS_BASE 0x10124000
-#define ROCKCHIP_UART_DEBUG_VIRT_BASE 0xfeb24000
-#elif defined(CONFIG_DEBUG_RK3X_UART1)
-#define ROCKCHIP_UART_DEBUG_PHYS_BASE 0x10126000
-#define ROCKCHIP_UART_DEBUG_VIRT_BASE 0xfeb26000
-#elif defined(CONFIG_DEBUG_RK3X_UART2)
-#define ROCKCHIP_UART_DEBUG_PHYS_BASE 0x20064000
-#define ROCKCHIP_UART_DEBUG_VIRT_BASE 0xfed64000
-#elif defined(CONFIG_DEBUG_RK3X_UART3)
-#define ROCKCHIP_UART_DEBUG_PHYS_BASE 0x20068000
-#define ROCKCHIP_UART_DEBUG_VIRT_BASE 0xfed68000
-#endif
-
-	.macro	addruart, rp, rv, tmp
-	ldr	\rp, =ROCKCHIP_UART_DEBUG_PHYS_BASE
-	ldr	\rv, =ROCKCHIP_UART_DEBUG_VIRT_BASE
-	.endm
-
 #include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/include/debug/sunxi.S b/arch/arm/include/debug/sunxi.S
index 65d0981..4c3d89c 100644
--- a/arch/arm/include/debug/sunxi.S
+++ b/arch/arm/include/debug/sunxi.S
@@ -9,18 +9,4 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
 */
-
-#if defined(CONFIG_DEBUG_SUNXI_UART0)
-#define SUNXI_UART_DEBUG_PHYS_BASE 0x01c28000
-#define SUNXI_UART_DEBUG_VIRT_BASE 0xf1c28000
-#elif defined(CONFIG_DEBUG_SUNXI_UART1)
-#define SUNXI_UART_DEBUG_PHYS_BASE 0x01c28400
-#define SUNXI_UART_DEBUG_VIRT_BASE 0xf1c28400
-#endif
-
-	.macro	addruart, rp, rv, tmp
-	ldr	\rp, =SUNXI_UART_DEBUG_PHYS_BASE
-	ldr	\rv, =SUNXI_UART_DEBUG_VIRT_BASE
-	.endm
-
 #include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-dove/include/mach/debug-macro.S b/arch/arm/mach-dove/include/mach/debug-macro.S
index 182a610..9b85a81 100644
--- a/arch/arm/mach-dove/include/mach/debug-macro.S
+++ b/arch/arm/mach-dove/include/mach/debug-macro.S
@@ -5,14 +5,4 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
 */
-
-#include <mach/bridge-regs.h>
-
-	.macro	addruart, rp, rv, tmp
-	ldr	\rp, =DOVE_SB_REGS_PHYS_BASE
-	ldr	\rv, =DOVE_SB_REGS_VIRT_BASE
-	orr	\rp, \rp, #0x00012000
-	orr	\rv, \rv, #0x00012000
-	.endm
-
 #include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-ebsa110/include/mach/debug-macro.S b/arch/arm/mach-ebsa110/include/mach/debug-macro.S
index 984f0fa..0cea548 100644
--- a/arch/arm/mach-ebsa110/include/mach/debug-macro.S
+++ b/arch/arm/mach-ebsa110/include/mach/debug-macro.S
@@ -10,11 +10,4 @@
  * published by the Free Software Foundation.
  *
 **/
-
-		.macro	addruart, rp, rv, tmp
-		mov	\rp, #0xf0000000
-		orr	\rp, \rp, #0x00000be0
-		mov	\rp, \rv
-		.endm
-
 #include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-footbridge/include/mach/debug-macro.S b/arch/arm/mach-footbridge/include/mach/debug-macro.S
index a209936..553c47d 100644
--- a/arch/arm/mach-footbridge/include/mach/debug-macro.S
+++ b/arch/arm/mach-footbridge/include/mach/debug-macro.S
@@ -14,16 +14,7 @@
 #include <asm/hardware/dec21285.h>
 
 #ifndef CONFIG_DEBUG_DC21285_PORT
-	/* For NetWinder debugging */
-		.macro	addruart, rp, rv, tmp
-		mov	\rp, #0x000003f8
-		orr	\rv, \rp, #0xfe000000	@ virtual
-		orr	\rv, \rv, #0x00e00000	@ virtual
-		orr	\rp, \rp, #0x7c000000	@ physical
-		.endm
-
 #include <asm/hardware/debug-8250.S>
-
 #else
 #include <mach/hardware.h>
 	/* For EBSA285 debugging */
diff --git a/arch/arm/mach-gemini/include/mach/debug-macro.S b/arch/arm/mach-gemini/include/mach/debug-macro.S
index 2d94ea4..9dabd4b 100644
--- a/arch/arm/mach-gemini/include/mach/debug-macro.S
+++ b/arch/arm/mach-gemini/include/mach/debug-macro.S
@@ -9,11 +9,4 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#include <mach/hardware.h>
-
-	.macro	addruart, rp, rv, tmp
-	ldr	\rp, =GEMINI_UART_BASE			@ physical
-	ldr	\rv, =IO_ADDRESS(GEMINI_UART_BASE)	@ virtual
-	.endm
-
 #include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-iop13xx/include/mach/debug-macro.S b/arch/arm/mach-iop13xx/include/mach/debug-macro.S
index 4a776ca..90b5e64 100644
--- a/arch/arm/mach-iop13xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-iop13xx/include/mach/debug-macro.S
@@ -10,14 +10,4 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
-	.macro	addruart, rp, rv, tmp
-	mov	\rp, #0x00002300
-	orr	\rp, \rp, #0x00000040
-	orr	\rv, \rp, #0xfe000000	@ virtual
-	orr	\rv, \rv, #0x00e80000
-	orr	\rp, \rp, #0xff000000	@ physical
-	orr	\rp, \rp, #0x00d80000
-	.endm
-
 #include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-iop32x/include/mach/debug-macro.S b/arch/arm/mach-iop32x/include/mach/debug-macro.S
index a090573..7ea745e 100644
--- a/arch/arm/mach-iop32x/include/mach/debug-macro.S
+++ b/arch/arm/mach-iop32x/include/mach/debug-macro.S
@@ -10,11 +10,4 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
-		.macro	addruart, rp, rv, tmp
-		mov	\rp, #0xfe000000	@ physical as well as virtual
-		orr	\rp, \rp, #0x00800000	@ location of the UART
-		mov	\rv, \rp
-		.endm
-
 #include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-iop33x/include/mach/debug-macro.S b/arch/arm/mach-iop33x/include/mach/debug-macro.S
index 894bf7c..52781ae 100644
--- a/arch/arm/mach-iop33x/include/mach/debug-macro.S
+++ b/arch/arm/mach-iop33x/include/mach/debug-macro.S
@@ -10,12 +10,4 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
-		.macro	addruart, rp, rv, tmp
-		mov	\rp, #0x00ff0000
-		orr	\rp, \rp, #0x0000f700
-		orr	\rv, #0xfe000000	@ virtual
-		orr	\rp, #0xff000000	@ physical
-		.endm
-
 #include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-ixp4xx/include/mach/debug-macro.S b/arch/arm/mach-ixp4xx/include/mach/debug-macro.S
index 403bd35..ff706fa 100644
--- a/arch/arm/mach-ixp4xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-ixp4xx/include/mach/debug-macro.S
@@ -9,17 +9,4 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
 */
-
-                .macro  addruart, rp, rv, tmp
-#ifdef __ARMEB__
-                mov     \rp, #3         @ Uart regs are at off set of 3 if
-					@ byte writes used - Big Endian.
-#else
-		mov	\rp, #0
-#endif
-		orr	\rv, \rp, #0xfe000000	@ virtual
-		orr	\rv, \rv, #0x00f00000
-                orr     \rp, \rp, #0xc8000000	@ physical
-                .endm
-
 #include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-kirkwood/include/mach/debug-macro.S b/arch/arm/mach-kirkwood/include/mach/debug-macro.S
index 51eee02..011ec25 100644
--- a/arch/arm/mach-kirkwood/include/mach/debug-macro.S
+++ b/arch/arm/mach-kirkwood/include/mach/debug-macro.S
@@ -5,14 +5,4 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
 */
-
-#include <mach/bridge-regs.h>
-
-	.macro	addruart, rp, rv, tmp
-	ldr	\rp, =KIRKWOOD_REGS_PHYS_BASE
-	ldr	\rv, =KIRKWOOD_REGS_VIRT_BASE
-	orr	\rp, \rp, #0x00012000
-	orr	\rv, \rv, #0x00012000
-	.endm
-
 #include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-lpc32xx/include/mach/debug-macro.S b/arch/arm/mach-lpc32xx/include/mach/debug-macro.S
index 11f986e..c7bb4bc 100644
--- a/arch/arm/mach-lpc32xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-lpc32xx/include/mach/debug-macro.S
@@ -15,14 +15,4 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  */
-
-/*
- * Debug output is hardcoded to standard UART 5
-*/
-
-	.macro	addruart, rp, rv, tmp
-	ldreq	\rp, =0x40090000
-	ldrne	\rv, =0xF4090000
-	.endm
-
 #include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-mv78xx0/include/mach/debug-macro.S b/arch/arm/mach-mv78xx0/include/mach/debug-macro.S
index 0fce467..c8284a2 100644
--- a/arch/arm/mach-mv78xx0/include/mach/debug-macro.S
+++ b/arch/arm/mach-mv78xx0/include/mach/debug-macro.S
@@ -5,14 +5,4 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
 */
-
-#include <mach/mv78xx0.h>
-
-	.macro	addruart, rp, rv, tmp
-	ldr	\rp, =MV78XX0_REGS_PHYS_BASE
-	ldr	\rv, =MV78XX0_REGS_VIRT_BASE
-	orr	\rp, \rp, #0x00012000
-	orr	\rv, \rv, #0x00012000
-	.endm
-
 #include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-orion5x/include/mach/debug-macro.S b/arch/arm/mach-orion5x/include/mach/debug-macro.S
index 52f29ef..7489963 100644
--- a/arch/arm/mach-orion5x/include/mach/debug-macro.S
+++ b/arch/arm/mach-orion5x/include/mach/debug-macro.S
@@ -7,14 +7,4 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
 */
-
-#include <mach/orion5x.h>
-
-	.macro  addruart, rp, rv, tmp
-	ldr	\rp, =ORION5X_REGS_PHYS_BASE
-	ldr	\rv, =ORION5X_REGS_VIRT_BASE
-	orr	\rp, \rp, #0x00012000
-	orr	\rv, \rv, #0x00012000
-	.endm
-
 #include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-rpc/include/mach/debug-macro.S b/arch/arm/mach-rpc/include/mach/debug-macro.S
index fcb5450..88a575e 100644
--- a/arch/arm/mach-rpc/include/mach/debug-macro.S
+++ b/arch/arm/mach-rpc/include/mach/debug-macro.S
@@ -10,12 +10,4 @@
  * published by the Free Software Foundation.
  *
 */
-
-		.macro	addruart, rp, rv, tmp
-		mov	\rp, #0x00010000
-		orr	\rp, \rp, #0x00000fe0
-		orr	\rv, \rp, #0xe0000000	@ virtual
-		orr	\rp, \rp, #0x03000000	@ physical
-		.endm
-
 #include <asm/hardware/debug-8250.S>
-- 
1.7.4.4
