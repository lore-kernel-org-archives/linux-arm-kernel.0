From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Mon, 12 Jul 2010 11:03:12 +0800
Subject: [RFC,PATCH 1/2] arm: don't check MMU status in every addruart macro
In-Reply-To: <1278903792.387175.713057245098.0.gpush@pororo>
Message-ID: <1278903792.387860.948595132082.1.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than checking the MMU status in every instance of addruart, do it
once in kernel/debug.S, and change the existing addruart macros to
expect the uart status in the macro argument register.

This will also allow us to retreive the address of a uart for the MMU
state that we're not current in.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 arch/arm/kernel/debug.S                             |    9 +++++++--
 arch/arm/mach-aaec2000/include/mach/debug-macro.S   |    1 -
 arch/arm/mach-at91/include/mach/debug-macro.S       |    1 -
 arch/arm/mach-clps711x/include/mach/debug-macro.S   |    1 -
 arch/arm/mach-cns3xxx/include/mach/debug-macro.S    |    1 -
 arch/arm/mach-davinci/include/mach/debug-macro.S    |    1 -
 arch/arm/mach-dove/include/mach/debug-macro.S       |    1 -
 arch/arm/mach-ep93xx/include/mach/debug-macro.S     |    1 -
 arch/arm/mach-footbridge/include/mach/debug-macro.S |    2 --
 arch/arm/mach-gemini/include/mach/debug-macro.S     |    1 -
 arch/arm/mach-h720x/include/mach/debug-macro.S      |    1 -
 arch/arm/mach-integrator/include/mach/debug-macro.S |    1 -
 arch/arm/mach-iop13xx/include/mach/debug-macro.S    |    1 -
 arch/arm/mach-iop33x/include/mach/debug-macro.S     |    1 -
 arch/arm/mach-ixp2000/include/mach/debug-macro.S    |    1 -
 arch/arm/mach-ixp23xx/include/mach/debug-macro.S    |    1 -
 arch/arm/mach-ixp4xx/include/mach/debug-macro.S     |    1 -
 arch/arm/mach-kirkwood/include/mach/debug-macro.S   |    1 -
 arch/arm/mach-ks8695/include/mach/debug-macro.S     |    1 -
 arch/arm/mach-l7200/include/mach/debug-macro.S      |    1 -
 arch/arm/mach-lh7a40x/include/mach/debug-macro.S    |    1 -
 arch/arm/mach-loki/include/mach/debug-macro.S       |    1 -
 arch/arm/mach-mmp/include/mach/debug-macro.S        |    1 -
 arch/arm/mach-msm/include/mach/debug-macro.S        |    1 -
 arch/arm/mach-mv78xx0/include/mach/debug-macro.S    |    1 -
 arch/arm/mach-netx/include/mach/debug-macro.S       |    1 -
 arch/arm/mach-nomadik/include/mach/debug-macro.S    |    1 -
 arch/arm/mach-ns9xxx/include/mach/debug-macro.S     |    1 -
 arch/arm/mach-omap1/include/mach/debug-macro.S      |    7 +++----
 arch/arm/mach-omap2/include/mach/debug-macro.S      |    7 +++----
 arch/arm/mach-orion5x/include/mach/debug-macro.S    |    1 -
 arch/arm/mach-pnx4008/include/mach/debug-macro.S    |    1 -
 arch/arm/mach-pxa/include/mach/debug-macro.S        |    1 -
 arch/arm/mach-realview/include/mach/debug-macro.S   |    1 -
 arch/arm/mach-rpc/include/mach/debug-macro.S        |    1 -
 arch/arm/mach-s3c2410/include/mach/debug-macro.S    |    1 -
 arch/arm/mach-s3c24a0/include/mach/debug-macro.S    |    1 -
 arch/arm/mach-s3c64xx/include/mach/debug-macro.S    |    1 -
 arch/arm/mach-s5p6440/include/mach/debug-macro.S    |    1 -
 arch/arm/mach-s5p6442/include/mach/debug-macro.S    |    1 -
 arch/arm/mach-s5pc100/include/mach/debug-macro.S    |    1 -
 arch/arm/mach-s5pv210/include/mach/debug-macro.S    |    1 -
 arch/arm/mach-sa1100/include/mach/debug-macro.S     |    1 -
 arch/arm/mach-u300/include/mach/debug-macro.S       |    1 -
 arch/arm/mach-ux500/include/mach/debug-macro.S      |    1 -
 arch/arm/mach-versatile/include/mach/debug-macro.S  |    1 -
 arch/arm/mach-vexpress/include/mach/debug-macro.S   |    1 -
 arch/arm/plat-mxc/include/mach/debug-macro.S        |    1 -
 arch/arm/plat-spear/include/plat/debug-macro.S      |    1 -
 arch/arm/plat-stmp3xxx/include/mach/debug-macro.S   |    1 -
 50 files changed, 13 insertions(+), 58 deletions(-)

diff --git a/arch/arm/kernel/debug.S b/arch/arm/kernel/debug.S
index a38b487..e1d0ab9 100644
--- a/arch/arm/kernel/debug.S
+++ b/arch/arm/kernel/debug.S
@@ -130,6 +130,11 @@ wait:		mrc	p14, 0, pc, c0, c1, 0
 #include <mach/debug-macro.S>
 #endif	/* CONFIG_DEBUG_ICEDCC */
 
+		.macro	__addruart, rx, tmp
+		mrc	p15, 0, \rx, c1, c0
+		addruart \rx,\tmp
+		.endm
+
 /*
  * Useful debugging routines
  */
@@ -164,7 +169,7 @@ ENDPROC(printhex2)
 		.ltorg
 
 ENTRY(printascii)
-		addruart r3, r1
+		__addruart r3, r1
 		b	2f
 1:		waituart r2, r3
 		senduart r1, r3
@@ -180,7 +185,7 @@ ENTRY(printascii)
 ENDPROC(printascii)
 
 ENTRY(printch)
-		addruart r3, r1
+		__addruart r3, r1
 		mov	r1, r0
 		mov	r0, #0
 		b	1b
diff --git a/arch/arm/mach-aaec2000/include/mach/debug-macro.S b/arch/arm/mach-aaec2000/include/mach/debug-macro.S
index a9cac36..7a8f904 100644
--- a/arch/arm/mach-aaec2000/include/mach/debug-macro.S
+++ b/arch/arm/mach-aaec2000/include/mach/debug-macro.S
@@ -11,7 +11,6 @@
 
 #include "hardware.h"
 		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx, #0x80000000		@ physical
 		movne	\rx, #io_p2v(0x80000000)	@ virtual
diff --git a/arch/arm/mach-at91/include/mach/debug-macro.S b/arch/arm/mach-at91/include/mach/debug-macro.S
index 9e750a1..0a7c233 100644
--- a/arch/arm/mach-at91/include/mach/debug-macro.S
+++ b/arch/arm/mach-at91/include/mach/debug-macro.S
@@ -15,7 +15,6 @@
 #include <mach/at91_dbgu.h>
 
 	.macro	addruart, rx, tmp
-	mrc	p15, 0, \rx, c1, c0
 	tst	\rx, #1						@ MMU enabled?
 	ldreq	\rx, =(AT91_BASE_SYS + AT91_DBGU)		@ System peripherals (phys address)
 	ldrne	\rx, =(AT91_VA_BASE_SYS	+ AT91_DBGU)		@ System peripherals (virt address)
diff --git a/arch/arm/mach-clps711x/include/mach/debug-macro.S b/arch/arm/mach-clps711x/include/mach/debug-macro.S
index fedd807..7e7d996 100644
--- a/arch/arm/mach-clps711x/include/mach/debug-macro.S
+++ b/arch/arm/mach-clps711x/include/mach/debug-macro.S
@@ -14,7 +14,6 @@
 #include <asm/hardware/clps7111.h>
 
 		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx, #CLPS7111_PHYS_BASE
 		movne	\rx, #CLPS7111_VIRT_BASE
diff --git a/arch/arm/mach-cns3xxx/include/mach/debug-macro.S b/arch/arm/mach-cns3xxx/include/mach/debug-macro.S
index d16ce7e..02501e8 100644
--- a/arch/arm/mach-cns3xxx/include/mach/debug-macro.S
+++ b/arch/arm/mach-cns3xxx/include/mach/debug-macro.S
@@ -11,7 +11,6 @@
  */
 
 		.macro	addruart,rx
-		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx,      #0x10000000
 		movne	\rx,      #0xf0000000	@ virtual base
diff --git a/arch/arm/mach-davinci/include/mach/debug-macro.S b/arch/arm/mach-davinci/include/mach/debug-macro.S
index 3cd93a8..56ae184 100644
--- a/arch/arm/mach-davinci/include/mach/debug-macro.S
+++ b/arch/arm/mach-davinci/include/mach/debug-macro.S
@@ -20,7 +20,6 @@
 #define UART_SHIFT	2
 
 		.macro addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx, #0x01000000	@ physical base address
 		movne	\rx, #0xfe000000	@ virtual base
diff --git a/arch/arm/mach-dove/include/mach/debug-macro.S b/arch/arm/mach-dove/include/mach/debug-macro.S
index 1521d13..2ab3f88 100644
--- a/arch/arm/mach-dove/include/mach/debug-macro.S
+++ b/arch/arm/mach-dove/include/mach/debug-macro.S
@@ -9,7 +9,6 @@
 #include <mach/bridge-regs.h>
 
 	.macro	addruart, rx, tmp
-	mrc	p15, 0, \rx, c1, c0
 	tst	\rx, #1					@ MMU enabled?
 	ldreq	\rx, =DOVE_SB_REGS_PHYS_BASE
 	ldrne	\rx, =DOVE_SB_REGS_VIRT_BASE
diff --git a/arch/arm/mach-ep93xx/include/mach/debug-macro.S b/arch/arm/mach-ep93xx/include/mach/debug-macro.S
index 5cd2244..0b774f7 100644
--- a/arch/arm/mach-ep93xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-ep93xx/include/mach/debug-macro.S
@@ -12,7 +12,6 @@
 #include <mach/ep93xx-regs.h>
 
 		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1				@ MMU enabled?
 		ldreq	\rx, =EP93XX_APB_PHYS_BASE	@ Physical base
 		ldrne	\rx, =EP93XX_APB_VIRT_BASE	@ virtual base
diff --git a/arch/arm/mach-footbridge/include/mach/debug-macro.S b/arch/arm/mach-footbridge/include/mach/debug-macro.S
index 60dda13..3bc7b4c 100644
--- a/arch/arm/mach-footbridge/include/mach/debug-macro.S
+++ b/arch/arm/mach-footbridge/include/mach/debug-macro.S
@@ -16,7 +16,6 @@
 #ifndef CONFIG_DEBUG_DC21285_PORT
 	/* For NetWinder debugging */
 		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx, #0x7c000000	@ physical
 		movne	\rx, #0xff000000	@ virtual
@@ -33,7 +32,6 @@
 		.equ	dc21285_low,  ARMCSR_BASE & 0x00ffffff
 
 		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx, #0x42000000
 		movne	\rx, #dc21285_high
diff --git a/arch/arm/mach-gemini/include/mach/debug-macro.S b/arch/arm/mach-gemini/include/mach/debug-macro.S
index ad47704..a232a6c 100644
--- a/arch/arm/mach-gemini/include/mach/debug-macro.S
+++ b/arch/arm/mach-gemini/include/mach/debug-macro.S
@@ -12,7 +12,6 @@
 #include <mach/hardware.h>
 
 	.macro	addruart, rx, tmp
-	mrc	p15, 0, \rx, c1, c0
 	tst	\rx, #1					@ MMU enabled?
 	ldreq	\rx, =GEMINI_UART_BASE			@ physical
 	ldrne	\rx, =IO_ADDRESS(GEMINI_UART_BASE)	@ virtual
diff --git a/arch/arm/mach-h720x/include/mach/debug-macro.S b/arch/arm/mach-h720x/include/mach/debug-macro.S
index a9ee8f0..229c7dc 100644
--- a/arch/arm/mach-h720x/include/mach/debug-macro.S
+++ b/arch/arm/mach-h720x/include/mach/debug-macro.S
@@ -15,7 +15,6 @@
 		.equ    io_phys, IO_START
 
 		.macro  addruart, rx, tmp
-		mrc     p15, 0, \rx, c1, c0
 		tst     \rx, #1  	       @ MMU enabled?
 		moveq   \rx, #io_phys	       @ physical base address
 		movne   \rx, #io_virt	       @ virtual address
diff --git a/arch/arm/mach-integrator/include/mach/debug-macro.S b/arch/arm/mach-integrator/include/mach/debug-macro.S
index 87a6888..79ae58e 100644
--- a/arch/arm/mach-integrator/include/mach/debug-macro.S
+++ b/arch/arm/mach-integrator/include/mach/debug-macro.S
@@ -12,7 +12,6 @@
 */
 
 		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx, #0x16000000	@ physical base address
 		movne	\rx, #0xf0000000	@ virtual base
diff --git a/arch/arm/mach-iop13xx/include/mach/debug-macro.S b/arch/arm/mach-iop13xx/include/mach/debug-macro.S
index c9d6ba4..0430c46 100644
--- a/arch/arm/mach-iop13xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-iop13xx/include/mach/debug-macro.S
@@ -12,7 +12,6 @@
  */
 
 	.macro	addruart, rx, tmp
-	mrc	p15, 0, \rx, c1, c0
 	tst	\rx, #1			@ mmu enabled?
 	moveq	\rx, #0xff000000	@ physical
 	orreq	\rx, \rx, #0x00d80000
diff --git a/arch/arm/mach-iop33x/include/mach/debug-macro.S b/arch/arm/mach-iop33x/include/mach/debug-macro.S
index addb2da..91f9a0a 100644
--- a/arch/arm/mach-iop33x/include/mach/debug-macro.S
+++ b/arch/arm/mach-iop33x/include/mach/debug-macro.S
@@ -12,7 +12,6 @@
  */
 
 		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ mmu enabled?
 		moveq	\rx, #0xff000000	@ physical
 		movne	\rx, #0xfe000000	@ virtual
diff --git a/arch/arm/mach-ixp2000/include/mach/debug-macro.S b/arch/arm/mach-ixp2000/include/mach/debug-macro.S
index 6a82768..d355129 100644
--- a/arch/arm/mach-ixp2000/include/mach/debug-macro.S
+++ b/arch/arm/mach-ixp2000/include/mach/debug-macro.S
@@ -12,7 +12,6 @@
 */
 
 		.macro  addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx, #0xc0000000	@ Physical base
 		movne	\rx, #0xfe000000	@ virtual base
diff --git a/arch/arm/mach-ixp23xx/include/mach/debug-macro.S b/arch/arm/mach-ixp23xx/include/mach/debug-macro.S
index a82e375..c24d1bd 100644
--- a/arch/arm/mach-ixp23xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-ixp23xx/include/mach/debug-macro.S
@@ -13,7 +13,6 @@
 #include <mach/ixp23xx.h>
 
 		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1				@ mmu enabled?
 		ldreq	\rx, =IXP23XX_PERIPHERAL_PHYS 	@ physical
 		ldrne	\rx, =IXP23XX_PERIPHERAL_VIRT	@ virtual
diff --git a/arch/arm/mach-ixp4xx/include/mach/debug-macro.S b/arch/arm/mach-ixp4xx/include/mach/debug-macro.S
index 893873e..245685b 100644
--- a/arch/arm/mach-ixp4xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-ixp4xx/include/mach/debug-macro.S
@@ -11,7 +11,6 @@
 */
 
                 .macro  addruart, rx, tmp
-                mrc     p15, 0, \rx, c1, c0
                 tst     \rx, #1                 @ MMU enabled?
                 moveq   \rx, #0xc8000000
                 movne   \rx, #0xff000000
diff --git a/arch/arm/mach-kirkwood/include/mach/debug-macro.S b/arch/arm/mach-kirkwood/include/mach/debug-macro.S
index d060677..fbda2e6 100644
--- a/arch/arm/mach-kirkwood/include/mach/debug-macro.S
+++ b/arch/arm/mach-kirkwood/include/mach/debug-macro.S
@@ -9,7 +9,6 @@
 #include <mach/bridge-regs.h>
 
 	.macro	addruart, rx, tmp
-	mrc	p15, 0, \rx, c1, c0
 	tst	\rx, #1					@ MMU enabled?
 	ldreq	\rx, =KIRKWOOD_REGS_PHYS_BASE
 	ldrne	\rx, =KIRKWOOD_REGS_VIRT_BASE
diff --git a/arch/arm/mach-ks8695/include/mach/debug-macro.S b/arch/arm/mach-ks8695/include/mach/debug-macro.S
index cf2095d..8587635 100644
--- a/arch/arm/mach-ks8695/include/mach/debug-macro.S
+++ b/arch/arm/mach-ks8695/include/mach/debug-macro.S
@@ -15,7 +15,6 @@
 #include <mach/regs-uart.h>
 
 	.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1				@ MMU enabled?
 		ldreq	\rx, =KS8695_UART_PA		@ physical base address
 		ldrne	\rx, =KS8695_UART_VA		@ virtual base address
diff --git a/arch/arm/mach-l7200/include/mach/debug-macro.S b/arch/arm/mach-l7200/include/mach/debug-macro.S
index b69ed34..912e924 100644
--- a/arch/arm/mach-l7200/include/mach/debug-macro.S
+++ b/arch/arm/mach-l7200/include/mach/debug-macro.S
@@ -15,7 +15,6 @@
 		.equ	io_phys, IO_START
 
 		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx, #io_phys		@ physical base address
 		movne	\rx, #io_virt		@ virtual address
diff --git a/arch/arm/mach-lh7a40x/include/mach/debug-macro.S b/arch/arm/mach-lh7a40x/include/mach/debug-macro.S
index c0dcbbb..60d7d70 100644
--- a/arch/arm/mach-lh7a40x/include/mach/debug-macro.S
+++ b/arch/arm/mach-lh7a40x/include/mach/debug-macro.S
@@ -15,7 +15,6 @@
 	@ board.
 
 		.macro  addruart, rx, tmp
-		mrc     p15, 0, \rx, c1, c0
 		tst     \rx, #1                 @ MMU enabled?
 		mov     \rx, #0x00000700        @ offset from base
 		orreq   \rx, \rx, #0x80000000   @ physical base
diff --git a/arch/arm/mach-loki/include/mach/debug-macro.S b/arch/arm/mach-loki/include/mach/debug-macro.S
index 3136c91..2cbbdec 100644
--- a/arch/arm/mach-loki/include/mach/debug-macro.S
+++ b/arch/arm/mach-loki/include/mach/debug-macro.S
@@ -9,7 +9,6 @@
 #include <mach/loki.h>
 
 	.macro	addruart, rx, tmp
-	mrc	p15, 0, \rx, c1, c0
 	tst	\rx, #1					@ MMU enabled?
 	ldreq	\rx, =LOKI_REGS_PHYS_BASE
 	ldrne	\rx, =LOKI_REGS_VIRT_BASE
diff --git a/arch/arm/mach-mmp/include/mach/debug-macro.S b/arch/arm/mach-mmp/include/mach/debug-macro.S
index 76deff2..6d57a05 100644
--- a/arch/arm/mach-mmp/include/mach/debug-macro.S
+++ b/arch/arm/mach-mmp/include/mach/debug-macro.S
@@ -12,7 +12,6 @@
 #include <mach/addr-map.h>
 
 		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1				@ MMU enabled?
 		ldreq	\rx, =APB_PHYS_BASE		@ physical
 		ldrne	\rx, =APB_VIRT_BASE		@ virtual
diff --git a/arch/arm/mach-msm/include/mach/debug-macro.S b/arch/arm/mach-msm/include/mach/debug-macro.S
index 528750f..121d803 100644
--- a/arch/arm/mach-msm/include/mach/debug-macro.S
+++ b/arch/arm/mach-msm/include/mach/debug-macro.S
@@ -22,7 +22,6 @@
 #ifdef CONFIG_MSM_DEBUG_UART
 	.macro	addruart, rx, tmp
 	@ see if the MMU is enabled and select appropriate base address
-	mrc	p15, 0, \rx, c1, c0
 	tst	\rx, #1
 	ldreq	\rx, =MSM_DEBUG_UART_PHYS
 	ldrne	\rx, =MSM_DEBUG_UART_BASE
diff --git a/arch/arm/mach-mv78xx0/include/mach/debug-macro.S b/arch/arm/mach-mv78xx0/include/mach/debug-macro.S
index cd81689..96c04ea 100644
--- a/arch/arm/mach-mv78xx0/include/mach/debug-macro.S
+++ b/arch/arm/mach-mv78xx0/include/mach/debug-macro.S
@@ -9,7 +9,6 @@
 #include <mach/mv78xx0.h>
 
 	.macro	addruart, rx, tmp
-	mrc	p15, 0, \rx, c1, c0
 	tst	\rx, #1					@ MMU enabled?
 	ldreq	\rx, =MV78XX0_REGS_PHYS_BASE
 	ldrne	\rx, =MV78XX0_REGS_VIRT_BASE
diff --git a/arch/arm/mach-netx/include/mach/debug-macro.S b/arch/arm/mach-netx/include/mach/debug-macro.S
index e96339e..c7d2a9e 100644
--- a/arch/arm/mach-netx/include/mach/debug-macro.S
+++ b/arch/arm/mach-netx/include/mach/debug-macro.S
@@ -14,7 +14,6 @@
 #include "hardware.h"
 
 		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx, #0x00100000		@ physical
 		movne	\rx, #io_p2v(0x00100000)	@ virtual
diff --git a/arch/arm/mach-nomadik/include/mach/debug-macro.S b/arch/arm/mach-nomadik/include/mach/debug-macro.S
index 4f92acf..04ae6e3 100644
--- a/arch/arm/mach-nomadik/include/mach/debug-macro.S
+++ b/arch/arm/mach-nomadik/include/mach/debug-macro.S
@@ -11,7 +11,6 @@
 */
 
 		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx, #0x10000000	@ physical base address
 		movne	\rx, #0xf0000000	@ virtual base
diff --git a/arch/arm/mach-ns9xxx/include/mach/debug-macro.S b/arch/arm/mach-ns9xxx/include/mach/debug-macro.S
index 0859336..864de81 100644
--- a/arch/arm/mach-ns9xxx/include/mach/debug-macro.S
+++ b/arch/arm/mach-ns9xxx/include/mach/debug-macro.S
@@ -12,7 +12,6 @@
 #include <mach/regs-board-a9m9750dev.h>
 
 		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1
 		ldreq	\rx, =NS9XXX_CSxSTAT_PHYS(0)
 		ldrne	\rx, =io_p2v(NS9XXX_CSxSTAT_PHYS(0))
diff --git a/arch/arm/mach-omap1/include/mach/debug-macro.S b/arch/arm/mach-omap1/include/mach/debug-macro.S
index e8a8cf3..4b9371c 100644
--- a/arch/arm/mach-omap1/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap1/include/mach/debug-macro.S
@@ -31,8 +31,8 @@ omap_uart_virt:	.word	0x0
 		.macro	addruart, rx, tmp
 
 		/* Use omap_uart_phys/virt if already configured */
-9:		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1			@ MMU enabled?
+9:		mov	\tmp,\rx
+		tst	\tmp, #1			@ MMU enabled?
 		ldreq	\rx, =omap_uart_phys	@ physical base address
 		ldrne	\rx, =omap_uart_virt	@ virtual base
 		ldr	\rx, [\rx, #0]
@@ -40,8 +40,7 @@ omap_uart_virt:	.word	0x0
 		bne	99f			@ already configured
 
 		/* Check the debug UART configuration set in uncompress.h */
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1			@ MMU enabled?
+		tst	\tmp, #1			@ MMU enabled?
 		ldreq	\rx, =OMAP_UART_INFO
 		ldrne	\rx, =__phys_to_virt(OMAP_UART_INFO)
 		ldr	\rx, [\rx, #0]
diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S b/arch/arm/mach-omap2/include/mach/debug-macro.S
index 35b2440..d483f08 100644
--- a/arch/arm/mach-omap2/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
@@ -34,8 +34,8 @@ omap_uart_lsr:	.word	0
 		.macro	addruart, rx, tmp
 
 		/* Use omap_uart_phys/virt if already configured */
-10:		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1			@ MMU enabled?
+10:		mov	\tmp, \rx
+		tst	\tmp, #1			@ MMU enabled?
 		ldreq	\rx, =omap_uart_phys	@ physical base address
 		ldrne	\rx, =omap_uart_virt	@ virtual base address
 		ldr	\rx, [\rx, #0]
@@ -43,8 +43,7 @@ omap_uart_lsr:	.word	0
 		bne	99f			@ already configured
 
 		/* Check the debug UART configuration set in uncompress.h */
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1			@ MMU enabled?
+		tst	\tmp, #1			@ MMU enabled?
 		ldreq	\rx, =OMAP_UART_INFO
 		ldrne	\rx, =__phys_to_virt(OMAP_UART_INFO)
 		ldr	\rx, [\rx, #0]
diff --git a/arch/arm/mach-orion5x/include/mach/debug-macro.S b/arch/arm/mach-orion5x/include/mach/debug-macro.S
index 91e0e39..6ba020c 100644
--- a/arch/arm/mach-orion5x/include/mach/debug-macro.S
+++ b/arch/arm/mach-orion5x/include/mach/debug-macro.S
@@ -11,7 +11,6 @@
 #include <mach/orion5x.h>
 
 	.macro  addruart, rx, tmp
-	mrc	p15, 0, \rx, c1, c0
 	tst	\rx, #1					@ MMU enabled?
 	ldreq	\rx, =ORION5X_REGS_PHYS_BASE
 	ldrne	\rx, =ORION5X_REGS_VIRT_BASE
diff --git a/arch/arm/mach-pnx4008/include/mach/debug-macro.S b/arch/arm/mach-pnx4008/include/mach/debug-macro.S
index 6ca8bd3..7596b02 100644
--- a/arch/arm/mach-pnx4008/include/mach/debug-macro.S
+++ b/arch/arm/mach-pnx4008/include/mach/debug-macro.S
@@ -12,7 +12,6 @@
 */
 
 		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		mov	\rx, #0x00090000
 		addeq	\rx, \rx, #0x40000000
diff --git a/arch/arm/mach-pxa/include/mach/debug-macro.S b/arch/arm/mach-pxa/include/mach/debug-macro.S
index 01cf813..645f927 100644
--- a/arch/arm/mach-pxa/include/mach/debug-macro.S
+++ b/arch/arm/mach-pxa/include/mach/debug-macro.S
@@ -14,7 +14,6 @@
 #include "hardware.h"
 
 		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx, #0x40000000		@ physical
 		movne	\rx, #io_p2v(0x40000000)	@ virtual
diff --git a/arch/arm/mach-realview/include/mach/debug-macro.S b/arch/arm/mach-realview/include/mach/debug-macro.S
index 8662228..801f68b 100644
--- a/arch/arm/mach-realview/include/mach/debug-macro.S
+++ b/arch/arm/mach-realview/include/mach/debug-macro.S
@@ -34,7 +34,6 @@
 #endif
 
 		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx,      #0x10000000
 		movne	\rx,      #0xfb000000	@ virtual base
diff --git a/arch/arm/mach-rpc/include/mach/debug-macro.S b/arch/arm/mach-rpc/include/mach/debug-macro.S
index 6fc8d66..088335c 100644
--- a/arch/arm/mach-rpc/include/mach/debug-macro.S
+++ b/arch/arm/mach-rpc/include/mach/debug-macro.S
@@ -12,7 +12,6 @@
 */
 
 		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx, #0x03000000
 		movne	\rx, #0xe0000000
diff --git a/arch/arm/mach-s3c2410/include/mach/debug-macro.S b/arch/arm/mach-s3c2410/include/mach/debug-macro.S
index 0eef78b..6db8f51 100644
--- a/arch/arm/mach-s3c2410/include/mach/debug-macro.S
+++ b/arch/arm/mach-s3c2410/include/mach/debug-macro.S
@@ -20,7 +20,6 @@
 #define SHIFT_2440TXF (14-9)
 
 	.macro addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1
 		ldreq	\rx, = S3C24XX_PA_UART
 		ldrne	\rx, = S3C24XX_VA_UART
diff --git a/arch/arm/mach-s3c24a0/include/mach/debug-macro.S b/arch/arm/mach-s3c24a0/include/mach/debug-macro.S
index 239476b..bcc7875 100644
--- a/arch/arm/mach-s3c24a0/include/mach/debug-macro.S
+++ b/arch/arm/mach-s3c24a0/include/mach/debug-macro.S
@@ -11,7 +11,6 @@
 #include <plat/regs-serial.h>
 
 	.macro addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1
 		ldreq	\rx, = S3C24XX_PA_UART
 		ldrne	\rx, = S3C24XX_VA_UART
diff --git a/arch/arm/mach-s3c64xx/include/mach/debug-macro.S b/arch/arm/mach-s3c64xx/include/mach/debug-macro.S
index f9ab5d2..4dbe876 100644
--- a/arch/arm/mach-s3c64xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-s3c64xx/include/mach/debug-macro.S
@@ -22,7 +22,6 @@
 	 */
 
 	.macro addruart, rx, rtmp
-		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1
 		ldreq	\rx, = S3C_PA_UART
 		ldrne	\rx, = (S3C_VA_UART + S3C_PA_UART & 0xfffff)
diff --git a/arch/arm/mach-s5p6440/include/mach/debug-macro.S b/arch/arm/mach-s5p6440/include/mach/debug-macro.S
index 1347d7f..88e5b94 100644
--- a/arch/arm/mach-s5p6440/include/mach/debug-macro.S
+++ b/arch/arm/mach-s5p6440/include/mach/debug-macro.S
@@ -20,7 +20,6 @@
 	 */
 
 	.macro addruart, rx, rtmp
-		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1
 		ldreq	\rx, = S3C_PA_UART
 		ldrne	\rx, = S3C_VA_UART
diff --git a/arch/arm/mach-s5p6442/include/mach/debug-macro.S b/arch/arm/mach-s5p6442/include/mach/debug-macro.S
index bb65361..6877b67 100644
--- a/arch/arm/mach-s5p6442/include/mach/debug-macro.S
+++ b/arch/arm/mach-s5p6442/include/mach/debug-macro.S
@@ -16,7 +16,6 @@
 #include <plat/regs-serial.h>
 
 	.macro addruart, rx, rtmp
-		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1
 		ldreq	\rx, = S3C_PA_UART
 		ldrne	\rx, = S3C_VA_UART
diff --git a/arch/arm/mach-s5pc100/include/mach/debug-macro.S b/arch/arm/mach-s5pc100/include/mach/debug-macro.S
index 70e02e9..9be36b2 100644
--- a/arch/arm/mach-s5pc100/include/mach/debug-macro.S
+++ b/arch/arm/mach-s5pc100/include/mach/debug-macro.S
@@ -23,7 +23,6 @@
 	 */
 
 	.macro addruart, rx, rtmp
-		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1
 		ldreq	\rx, = S3C_PA_UART
 		ldrne	\rx, = S3C_VA_UART
diff --git a/arch/arm/mach-s5pv210/include/mach/debug-macro.S b/arch/arm/mach-s5pv210/include/mach/debug-macro.S
index 7872f5c..53c18de 100644
--- a/arch/arm/mach-s5pv210/include/mach/debug-macro.S
+++ b/arch/arm/mach-s5pv210/include/mach/debug-macro.S
@@ -22,7 +22,6 @@
 	 */
 
 	.macro addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1
 		ldreq	\rx, = S3C_PA_UART
 		ldrne	\rx, = S3C_VA_UART
diff --git a/arch/arm/mach-sa1100/include/mach/debug-macro.S b/arch/arm/mach-sa1100/include/mach/debug-macro.S
index 336adcc..c8426cc 100644
--- a/arch/arm/mach-sa1100/include/mach/debug-macro.S
+++ b/arch/arm/mach-sa1100/include/mach/debug-macro.S
@@ -13,7 +13,6 @@
 #include <mach/hardware.h>
 
 		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx, #0x80000000	@ physical base address
 		movne	\rx, #0xf8000000	@ virtual address
diff --git a/arch/arm/mach-u300/include/mach/debug-macro.S b/arch/arm/mach-u300/include/mach/debug-macro.S
index 92c1242..fb17f1e 100644
--- a/arch/arm/mach-u300/include/mach/debug-macro.S
+++ b/arch/arm/mach-u300/include/mach/debug-macro.S
@@ -12,7 +12,6 @@
 
 	.macro	addruart, rx, tmp
 	/* If we move the address using MMU, use this. */
-	mrc	p15, 0, \rx, c1, c0
 	tst	\rx, #1			@ MMU enabled?
 	ldreq	\rx,	  = U300_SLOW_PER_PHYS_BASE @ MMU off, physical address
 	ldrne	\rx,	  = U300_SLOW_PER_VIRT_BASE @ MMU on, virtual address
diff --git a/arch/arm/mach-ux500/include/mach/debug-macro.S b/arch/arm/mach-ux500/include/mach/debug-macro.S
index c5203b7..c17a27f 100644
--- a/arch/arm/mach-ux500/include/mach/debug-macro.S
+++ b/arch/arm/mach-ux500/include/mach/debug-macro.S
@@ -19,7 +19,6 @@
 #define UART_BASE	UX500_UART(CONFIG_UX500_DEBUG_UART)
 
 	.macro	addruart, rx, tmp
-	mrc	p15, 0, \rx, c1, c0
 	tst	\rx, #1					@ MMU enabled?
 	ldreq	\rx, =UART_BASE				@ no, physical address
 	ldrne	\rx, =IO_ADDRESS(UART_BASE)		@ yes, virtual address
diff --git a/arch/arm/mach-versatile/include/mach/debug-macro.S b/arch/arm/mach-versatile/include/mach/debug-macro.S
index 6fea719..1a500ff 100644
--- a/arch/arm/mach-versatile/include/mach/debug-macro.S
+++ b/arch/arm/mach-versatile/include/mach/debug-macro.S
@@ -12,7 +12,6 @@
 */
 
 		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx,      #0x10000000
 		movne	\rx,      #0xf1000000	@ virtual base
diff --git a/arch/arm/mach-vexpress/include/mach/debug-macro.S b/arch/arm/mach-vexpress/include/mach/debug-macro.S
index 5167e2a..b67863b 100644
--- a/arch/arm/mach-vexpress/include/mach/debug-macro.S
+++ b/arch/arm/mach-vexpress/include/mach/debug-macro.S
@@ -13,7 +13,6 @@
 #define DEBUG_LL_UART_OFFSET	0x00009000
 
 		.macro	addruart,rx,tmp
-		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx,      #0x10000000
 		movne	\rx,      #0xf8000000	@ virtual base
diff --git a/arch/arm/plat-mxc/include/mach/debug-macro.S b/arch/arm/plat-mxc/include/mach/debug-macro.S
index 0b6e11e..30a57b9 100644
--- a/arch/arm/plat-mxc/include/mach/debug-macro.S
+++ b/arch/arm/plat-mxc/include/mach/debug-macro.S
@@ -63,7 +63,6 @@
 #define UART_VADDR	MXC91231_IO_ADDRESS(MXC91231_UART2_BASE_ADDR)
 #endif
 		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		ldreq	\rx, =UART_PADDR	@ physical
 		ldrne	\rx, =UART_VADDR	@ virtual
diff --git a/arch/arm/plat-spear/include/plat/debug-macro.S b/arch/arm/plat-spear/include/plat/debug-macro.S
index 1670734..2fa1522 100644
--- a/arch/arm/plat-spear/include/plat/debug-macro.S
+++ b/arch/arm/plat-spear/include/plat/debug-macro.S
@@ -15,7 +15,6 @@
 #include <mach/spear.h>
 
 		.macro	addruart, rx
-		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1					@ MMU enabled?
 		moveq	\rx, =SPEAR_DBG_UART_BASE		@ Physical base
 		movne	\rx, =VA_SPEAR_DBG_UART_BASE		@ Virtual base
diff --git a/arch/arm/plat-stmp3xxx/include/mach/debug-macro.S b/arch/arm/plat-stmp3xxx/include/mach/debug-macro.S
index 1b9348b..2a3ebca 100644
--- a/arch/arm/plat-stmp3xxx/include/mach/debug-macro.S
+++ b/arch/arm/plat-stmp3xxx/include/mach/debug-macro.S
@@ -17,7 +17,6 @@
  */
 
 		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx, #0x80000000	@ physical base address
 		addeq	\rx, \rx, #0x00070000
