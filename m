From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Wed, 01 Sep 2010 09:07:50 +0800
Subject: [PATCH 2/3] arm: return both physical and virtual addresses from
	addruart
In-Reply-To: <1283303270.565454.673065645961.0.gpush@pororo>
Message-ID: <1283303270.566757.315468531956.2.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than checking the MMU status in every instance of addruart, do it
once in kernel/debug.S, and change the existing addruart macros to
return both physical and virtual addresses. The main debug code can then
select the appropriate address to use.

This will also allow us to retreive the address of a uart for the MMU
state that we're not current in.

Updated with fixes for OMAP from Jason Wang <jason77.wang@gmail.com>
and Tony Lindgren <tony@atomide.com>, and fix for versatile express from
Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Jason Wang <jason77.wang@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Tested-by: Kevin Hilman <khilman@deeprootsystems.com>

---
 arch/arm/kernel/debug.S                             |   22 +-
 arch/arm/mach-aaec2000/include/mach/debug-macro.S   |   10 
 arch/arm/mach-at91/include/mach/debug-macro.S       |    8 
 arch/arm/mach-clps711x/include/mach/debug-macro.S   |   12 -
 arch/arm/mach-cns3xxx/include/mach/debug-macro.S    |   10 
 arch/arm/mach-davinci/include/mach/debug-macro.S    |   46 ++--
 arch/arm/mach-dove/include/mach/debug-macro.S       |   11 -
 arch/arm/mach-ebsa110/include/mach/debug-macro.S    |    7 
 arch/arm/mach-ep93xx/include/mach/debug-macro.S     |   11 -
 arch/arm/mach-footbridge/include/mach/debug-macro.S |   22 --
 arch/arm/mach-gemini/include/mach/debug-macro.S     |    8 
 arch/arm/mach-h720x/include/mach/debug-macro.S      |   10 
 arch/arm/mach-integrator/include/mach/debug-macro.S |   10 
 arch/arm/mach-iop13xx/include/mach/debug-macro.S    |   16 -
 arch/arm/mach-iop32x/include/mach/debug-macro.S     |    7 
 arch/arm/mach-iop33x/include/mach/debug-macro.S     |   12 -
 arch/arm/mach-ixp2000/include/mach/debug-macro.S    |   14 -
 arch/arm/mach-ixp23xx/include/mach/debug-macro.S    |   11 -
 arch/arm/mach-ixp4xx/include/mach/debug-macro.S     |   16 -
 arch/arm/mach-kirkwood/include/mach/debug-macro.S   |   11 -
 arch/arm/mach-ks8695/include/mach/debug-macro.S     |    8 
 arch/arm/mach-l7200/include/mach/debug-macro.S      |   38 +++
 arch/arm/mach-lh7a40x/include/mach/debug-macro.S    |   10 
 arch/arm/mach-loki/include/mach/debug-macro.S       |   11 -
 arch/arm/mach-mmp/include/mach/debug-macro.S        |   11 -
 arch/arm/mach-msm/include/mach/debug-macro.S        |   10 
 arch/arm/mach-mv78xx0/include/mach/debug-macro.S    |   11 -
 arch/arm/mach-netx/include/mach/debug-macro.S       |   10 
 arch/arm/mach-nomadik/include/mach/debug-macro.S    |   12 -
 arch/arm/mach-ns9xxx/include/mach/debug-macro.S     |    8 
 arch/arm/mach-omap1/include/mach/debug-macro.S      |   68 +++---
 arch/arm/mach-omap2/include/mach/debug-macro.S      |  127 +++++-------
 arch/arm/mach-orion5x/include/mach/debug-macro.S    |   11 -
 arch/arm/mach-pnx4008/include/mach/debug-macro.S    |   10 
 arch/arm/mach-pxa/include/mach/debug-macro.S        |   10 
 arch/arm/mach-realview/include/mach/debug-macro.S   |   10 
 arch/arm/mach-rpc/include/mach/debug-macro.S        |   12 -
 arch/arm/mach-s3c2410/include/mach/debug-macro.S    |   11 -
 arch/arm/mach-s3c24a0/include/mach/debug-macro.S    |   11 -
 arch/arm/mach-s3c64xx/include/mach/debug-macro.S    |   11 -
 arch/arm/mach-s5p6440/include/mach/debug-macro.S    |   11 -
 arch/arm/mach-s5p6442/include/mach/debug-macro.S    |   11 -
 arch/arm/mach-s5pc100/include/mach/debug-macro.S    |   11 -
 arch/arm/mach-s5pv210/include/mach/debug-macro.S    |   11 -
 arch/arm/mach-sa1100/include/mach/debug-macro.S     |   36 +--
 arch/arm/mach-shark/include/mach/debug-macro.S      |    7 
 arch/arm/mach-tegra/include/mach/debug-macro.S      |   26 +-
 arch/arm/mach-u300/include/mach/debug-macro.S       |   11 -
 arch/arm/mach-ux500/include/mach/debug-macro.S      |    8 
 arch/arm/mach-versatile/include/mach/debug-macro.S  |   12 -
 arch/arm/mach-vexpress/include/mach/debug-macro.S   |   10 
 arch/arm/plat-mxc/include/mach/debug-macro.S        |    8 
 arch/arm/plat-spear/include/plat/debug-macro.S      |    8 
 arch/arm/plat-stmp3xxx/include/mach/debug-macro.S   |   11 -
 54 files changed, 432 insertions(+), 433 deletions(-)

diff --git a/arch/arm/kernel/debug.S b/arch/arm/kernel/debug.S
index f913952..a0f0752 100644
--- a/arch/arm/kernel/debug.S
+++ b/arch/arm/kernel/debug.S
@@ -22,7 +22,7 @@
 #if defined(CONFIG_DEBUG_ICEDCC)
 		@@ debug using ARM EmbeddedICE DCC channel
 
-		.macro	addruart, rx, tmp
+		.macro	addruart, rp, rv
 		.endm
 
 #if defined(CONFIG_CPU_V6)
@@ -121,6 +121,22 @@ wait:		mrc	p14, 0, pc, c0, c1, 0
 #include <mach/debug-macro.S>
 #endif	/* CONFIG_DEBUG_ICEDCC */
 
+#ifdef CONFIG_MMU
+		.macro	addruart_current, rx, tmp1, tmp2
+		addruart	\tmp1, \tmp2
+		mrc		p15, 0, \rx, c1, c0
+		tst		\rx, #1
+		moveq		\rx, \tmp1
+		movne		\rx, \tmp2
+		.endm
+
+#else /* !CONFIG_MMU */
+		.macro	addruart_current, rx, tmp1, tmp2
+		addruart	\rx, \tmp1
+		.endm
+
+#endif /* CONFIG_MMU */
+
 /*
  * Useful debugging routines
  */
@@ -155,7 +171,7 @@ ENDPROC(printhex2)
 		.ltorg
 
 ENTRY(printascii)
-		addruart r3, r1
+		addruart_current r3, r1, r2
 		b	2f
 1:		waituart r2, r3
 		senduart r1, r3
@@ -171,7 +187,7 @@ ENTRY(printascii)
 ENDPROC(printascii)
 
 ENTRY(printch)
-		addruart r3, r1
+		addruart_current r3, r1, r2
 		mov	r1, r0
 		mov	r0, #0
 		b	1b
diff --git a/arch/arm/mach-aaec2000/include/mach/debug-macro.S b/arch/arm/mach-aaec2000/include/mach/debug-macro.S
index a9cac36..bc7ad55 100644
--- a/arch/arm/mach-aaec2000/include/mach/debug-macro.S
+++ b/arch/arm/mach-aaec2000/include/mach/debug-macro.S
@@ -10,12 +10,10 @@
  */
 
 #include "hardware.h"
-		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1			@ MMU enabled?
-		moveq	\rx, #0x80000000		@ physical
-		movne	\rx, #io_p2v(0x80000000)	@ virtual
-		orr	\rx, \rx, #0x00000800
+		.macro	addruart, rp, rv
+		mov	\rp, 0x00000800
+		orr	\rv, \rp, #io_p2v(0x80000000)	@ virtual
+		orr	\rp, \rp, #0x80000000		@ physical
 		.endm
 
 		.macro	senduart,rd,rx
diff --git a/arch/arm/mach-at91/include/mach/debug-macro.S b/arch/arm/mach-at91/include/mach/debug-macro.S
index 9e750a1..0f959fa 100644
--- a/arch/arm/mach-at91/include/mach/debug-macro.S
+++ b/arch/arm/mach-at91/include/mach/debug-macro.S
@@ -14,11 +14,9 @@
 #include <mach/hardware.h>
 #include <mach/at91_dbgu.h>
 
-	.macro	addruart, rx, tmp
-	mrc	p15, 0, \rx, c1, c0
-	tst	\rx, #1						@ MMU enabled?
-	ldreq	\rx, =(AT91_BASE_SYS + AT91_DBGU)		@ System peripherals (phys address)
-	ldrne	\rx, =(AT91_VA_BASE_SYS	+ AT91_DBGU)		@ System peripherals (virt address)
+	.macro	addruart, rp, rv
+	ldr	\rp, =(AT91_BASE_SYS + AT91_DBGU)		@ System peripherals (phys address)
+	ldr	\rv, =(AT91_VA_BASE_SYS	+ AT91_DBGU)		@ System peripherals (virt address)
 	.endm
 
 	.macro	senduart,rd,rx
diff --git a/arch/arm/mach-clps711x/include/mach/debug-macro.S b/arch/arm/mach-clps711x/include/mach/debug-macro.S
index 072cc6b..507c687 100644
--- a/arch/arm/mach-clps711x/include/mach/debug-macro.S
+++ b/arch/arm/mach-clps711x/include/mach/debug-macro.S
@@ -14,16 +14,14 @@
 #include <mach/hardware.h>
 #include <asm/hardware/clps7111.h>
 
-		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1			@ MMU enabled?
-		moveq	\rx, #CLPS7111_PHYS_BASE
-		movne	\rx, #CLPS7111_VIRT_BASE
+		.macro	addruart, rp, rv
 #ifndef CONFIG_DEBUG_CLPS711X_UART2
-		add	\rx, \rx, #0x0000	@ UART1
+		mov	\rp, #0x0000	@ UART1
 #else
-		add	\rx, \rx, #0x1000	@ UART2
+		mov	\rp, #0x1000	@ UART2
 #endif
+		orr	\rv, \rp, #CLPS7111_VIRT_BASE
+		orr	\rp, \rp, #CLPS7111_PHYS_BASE
 		.endm
 
 		.macro	senduart,rd,rx
diff --git a/arch/arm/mach-cns3xxx/include/mach/debug-macro.S b/arch/arm/mach-cns3xxx/include/mach/debug-macro.S
index d16ce7e..56d8286 100644
--- a/arch/arm/mach-cns3xxx/include/mach/debug-macro.S
+++ b/arch/arm/mach-cns3xxx/include/mach/debug-macro.S
@@ -10,12 +10,10 @@
  * published by the Free Software Foundation.
  */
 
-		.macro	addruart,rx
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1			@ MMU enabled?
-		moveq	\rx,      #0x10000000
-		movne	\rx,      #0xf0000000	@ virtual base
-		orr	\rx, \rx, #0x00009000
+		.macro	addruart,rp,rv
+		mov	\rp, #0x00009000
+		orr	\rv, \rp, #0xf0000000	@ virtual base
+		orr	\rp, \rp, #0x10000000
 		.endm
 
 #include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/mach-davinci/include/mach/debug-macro.S b/arch/arm/mach-davinci/include/mach/debug-macro.S
index f761dfd..9f1befc 100644
--- a/arch/arm/mach-davinci/include/mach/debug-macro.S
+++ b/arch/arm/mach-davinci/include/mach/debug-macro.S
@@ -29,35 +29,39 @@ davinci_uart_phys:	.word	0
 davinci_uart_virt:	.word	0
 		.popsection
 
-		.macro addruart, rx, tmp
+		.macro addruart, rp, rv
 
 		/* Use davinci_uart_phys/virt if already configured */
-10:		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1			@ MMU enabled?
-		ldreq	\rx, =__virt_to_phys(davinci_uart_phys)
-		ldrne	\rx, =davinci_uart_virt
-		ldr	\rx, [\rx]
-		cmp	\rx, #0			@ is port configured?
+10:		mrc	p15, 0, \rp, c1, c0
+		tst	\rp, #1			@ MMU enabled?
+		ldreq	\rp, =__virt_to_phys(davinci_uart_phys)
+		ldrne	\rp, =davinci_uart_phys
+		add	\rv, \rp, #4		@ davinci_uart_virt
+		ldr	\rp, [\rp, #0]
+		ldr	\rv, [\rv, #0]
+		cmp	\rp, #0			@ is port configured?
+		cmpne	\rv, #0
 		bne	99f			@ already configured
 
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1			@ MMU enabled?
+		/* Check the debug UART address set in uncompress.h */
+		mrc	p15, 0, \rp, c1, c0
+		tst	\rp, #1			@ MMU enabled?
 
 		/* Copy uart phys address from decompressor uart info */
-		ldreq	\tmp, =__virt_to_phys(davinci_uart_phys)
-		ldrne	\tmp, =davinci_uart_phys
-		ldreq	\rx, =DAVINCI_UART_INFO
-		ldrne	\rx, =__phys_to_virt(DAVINCI_UART_INFO)
-		ldr	\rx, [\rx, #0]
-		str	\rx, [\tmp]
+		ldreq	\rv, =__virt_to_phys(davinci_uart_phys)
+		ldrne	\rv, =davinci_uart_phys
+		ldreq	\rp, =DAVINCI_UART_INFO
+		ldrne	\rp, =__phys_to_virt(DAVINCI_UART_INFO)
+		ldr	\rp, [\rp, #0]
+		str	\rp, [\rv]
 
 		/* Copy uart virt address from decompressor uart info */
-		ldreq	\tmp, =__virt_to_phys(davinci_uart_virt)
-		ldrne	\tmp, =davinci_uart_virt
-		ldreq	\rx, =DAVINCI_UART_INFO
-		ldrne	\rx, =__phys_to_virt(DAVINCI_UART_INFO)
-		ldr	\rx, [\rx, #4]
-		str	\rx, [\tmp]
+		ldreq	\rv, =__virt_to_phys(davinci_uart_virt)
+		ldrne	\rv, =davinci_uart_virt
+		ldreq	\rp, =DAVINCI_UART_INFO
+		ldrne	\rp, =__phys_to_virt(DAVINCI_UART_INFO)
+		ldr	\rp, [\rp, #4]
+		str	\rp, [\rv]
 
 		b	10b
 99:
diff --git a/arch/arm/mach-dove/include/mach/debug-macro.S b/arch/arm/mach-dove/include/mach/debug-macro.S
index 1521d13..da8bf2b 100644
--- a/arch/arm/mach-dove/include/mach/debug-macro.S
+++ b/arch/arm/mach-dove/include/mach/debug-macro.S
@@ -8,12 +8,11 @@
 
 #include <mach/bridge-regs.h>
 
-	.macro	addruart, rx, tmp
-	mrc	p15, 0, \rx, c1, c0
-	tst	\rx, #1					@ MMU enabled?
-	ldreq	\rx, =DOVE_SB_REGS_PHYS_BASE
-	ldrne	\rx, =DOVE_SB_REGS_VIRT_BASE
-	orr	\rx, \rx, #0x00012000
+	.macro	addruart, rp, rv
+	ldr	\rp, =DOVE_SB_REGS_PHYS_BASE
+	ldr	\rv, =DOVE_SB_REGS_VIRT_BASE
+	orr	\rp, \rp, #0x00012000
+	orr	\rv, \rv, #0x00012000
 	.endm
 
 #define UART_SHIFT	2
diff --git a/arch/arm/mach-ebsa110/include/mach/debug-macro.S b/arch/arm/mach-ebsa110/include/mach/debug-macro.S
index ebbd89f..7ef5690 100644
--- a/arch/arm/mach-ebsa110/include/mach/debug-macro.S
+++ b/arch/arm/mach-ebsa110/include/mach/debug-macro.S
@@ -11,9 +11,10 @@
  *
 **/
 
-		.macro	addruart, rx, tmp
-		mov	\rx, #0xf0000000
-		orr	\rx, \rx, #0x00000be0
+		.macro	addruart, rp, rv
+		mov	\rp, #0xf0000000
+		orr	\rp, \rp, #0x00000be0
+		mov	\rp, \rv
 		.endm
 
 #define UART_SHIFT	2
diff --git a/arch/arm/mach-ep93xx/include/mach/debug-macro.S b/arch/arm/mach-ep93xx/include/mach/debug-macro.S
index 5cd2244..b25bc90 100644
--- a/arch/arm/mach-ep93xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-ep93xx/include/mach/debug-macro.S
@@ -11,12 +11,11 @@
  */
 #include <mach/ep93xx-regs.h>
 
-		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1				@ MMU enabled?
-		ldreq	\rx, =EP93XX_APB_PHYS_BASE	@ Physical base
-		ldrne	\rx, =EP93XX_APB_VIRT_BASE	@ virtual base
-		orr	\rx, \rx, #0x000c0000
+		.macro	addruart, rp, rv
+		ldr	\rp, =EP93XX_APB_PHYS_BASE	@ Physical base
+		ldr	\rv, =EP93XX_APB_VIRT_BASE	@ virtual base
+		orr	\rp, \rp, #0x000c0000
+		orr	\rv, \rv, #0x000c0000
 		.endm
 
 #include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/mach-footbridge/include/mach/debug-macro.S b/arch/arm/mach-footbridge/include/mach/debug-macro.S
index 60dda13..3c9e0c4 100644
--- a/arch/arm/mach-footbridge/include/mach/debug-macro.S
+++ b/arch/arm/mach-footbridge/include/mach/debug-macro.S
@@ -15,12 +15,10 @@
 
 #ifndef CONFIG_DEBUG_DC21285_PORT
 	/* For NetWinder debugging */
-		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1			@ MMU enabled?
-		moveq	\rx, #0x7c000000	@ physical
-		movne	\rx, #0xff000000	@ virtual
-		orr	\rx, \rx, #0x000003f8
+		.macro	addruart, rp, rv
+		mov	\rp, #0x000003f8
+		orr	\rv, \rp, #0x7c000000	@ physical
+		orr	\rp, \rp, #0xff000000	@ virtual
 		.endm
 
 #define UART_SHIFT	0
@@ -32,14 +30,14 @@
 		.equ	dc21285_high, ARMCSR_BASE & 0xff000000
 		.equ	dc21285_low,  ARMCSR_BASE & 0x00ffffff
 
-		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1			@ MMU enabled?
-		moveq	\rx, #0x42000000
-		movne	\rx, #dc21285_high
+		.macro	addruart, rp, rv
 		.if	dc21285_low
-		orrne	\rx, \rx, #dc21285_low
+		mov	\rp, #dc21285_low
+		.else
+		mov	\rp, #0
 		.endif
+		orr	\rv, \rp, #0x42000000
+		orr	\rp, \rp, #dc21285_high
 		.endm
 
 		.macro	senduart,rd,rx
diff --git a/arch/arm/mach-gemini/include/mach/debug-macro.S b/arch/arm/mach-gemini/include/mach/debug-macro.S
index ad47704..f40e006 100644
--- a/arch/arm/mach-gemini/include/mach/debug-macro.S
+++ b/arch/arm/mach-gemini/include/mach/debug-macro.S
@@ -11,11 +11,9 @@
  */
 #include <mach/hardware.h>
 
-	.macro	addruart, rx, tmp
-	mrc	p15, 0, \rx, c1, c0
-	tst	\rx, #1					@ MMU enabled?
-	ldreq	\rx, =GEMINI_UART_BASE			@ physical
-	ldrne	\rx, =IO_ADDRESS(GEMINI_UART_BASE)	@ virtual
+	.macro	addruart, rp, rv
+	ldr	\rp, =GEMINI_UART_BASE			@ physical
+	ldr	\rv, =IO_ADDRESS(GEMINI_UART_BASE)	@ virtual
 	.endm
 
 #define UART_SHIFT	2
diff --git a/arch/arm/mach-h720x/include/mach/debug-macro.S b/arch/arm/mach-h720x/include/mach/debug-macro.S
index 27cafd1..c2093e8 100644
--- a/arch/arm/mach-h720x/include/mach/debug-macro.S
+++ b/arch/arm/mach-h720x/include/mach/debug-macro.S
@@ -16,12 +16,10 @@
 		.equ    io_virt, IO_VIRT
 		.equ    io_phys, IO_PHYS
 
-		.macro  addruart, rx, tmp
-		mrc     p15, 0, \rx, c1, c0
-		tst     \rx, #1  	       @ MMU enabled?
-		moveq   \rx, #io_phys	       @ physical base address
-		movne   \rx, #io_virt	       @ virtual address
-		add     \rx, \rx, #0x00020000   @ UART1
+		.macro  addruart, rp, rv
+		mov     \rp, #0x00020000	@ UART1
+		add     \rv, \rp, #io_virt	@ virtual address
+		add     \rp, \rp, #io_phys	@ physical base address
 		.endm
 
 		.macro  senduart,rd,rx
diff --git a/arch/arm/mach-integrator/include/mach/debug-macro.S b/arch/arm/mach-integrator/include/mach/debug-macro.S
index 87a6888..a1f598f 100644
--- a/arch/arm/mach-integrator/include/mach/debug-macro.S
+++ b/arch/arm/mach-integrator/include/mach/debug-macro.S
@@ -11,12 +11,10 @@
  *
 */
 
-		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1			@ MMU enabled?
-		moveq	\rx, #0x16000000	@ physical base address
-		movne	\rx, #0xf0000000	@ virtual base
-		addne	\rx, \rx, #0x16000000 >> 4
+		.macro	addruart, rp, rv
+		mov	\rp, #0x16000000	@ physical base address
+		mov	\rv, #0xf0000000	@ virtual base
+		add	\rv, \rv, #0x16000000 >> 4
 		.endm
 
 #include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/mach-iop13xx/include/mach/debug-macro.S b/arch/arm/mach-iop13xx/include/mach/debug-macro.S
index c9d6ba4..e664466 100644
--- a/arch/arm/mach-iop13xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-iop13xx/include/mach/debug-macro.S
@@ -11,15 +11,13 @@
  * published by the Free Software Foundation.
  */
 
-	.macro	addruart, rx, tmp
-	mrc	p15, 0, \rx, c1, c0
-	tst	\rx, #1			@ mmu enabled?
-	moveq	\rx, #0xff000000	@ physical
-	orreq	\rx, \rx, #0x00d80000
-	movne	\rx, #0xfe000000	@ virtual
-	orrne	\rx, \rx, #0x00e80000
-	orr	\rx, \rx, #0x00002300
-	orr	\rx, \rx, #0x00000040
+	.macro	addruart, rp, rv
+	mov	\rp, #0x00002300
+	orr	\rp, \rp, #0x00000040
+	orr	\rv, \rp, #0xfe000000	@ virtual
+	orr	\rv, \rv, #0x00e80000
+	orr	\rp, \rp, #0xff000000	@ physical
+	orr	\rp, \rp, #0x00d80000
 	.endm
 
 #define UART_SHIFT	2
diff --git a/arch/arm/mach-iop32x/include/mach/debug-macro.S b/arch/arm/mach-iop32x/include/mach/debug-macro.S
index 736afe1..ff9e76c 100644
--- a/arch/arm/mach-iop32x/include/mach/debug-macro.S
+++ b/arch/arm/mach-iop32x/include/mach/debug-macro.S
@@ -11,9 +11,10 @@
  * published by the Free Software Foundation.
  */
 
-		.macro	addruart, rx, tmp
-		mov	\rx, #0xfe000000	@ physical as well as virtual
-		orr	\rx, \rx, #0x00800000	@ location of the UART
+		.macro	addruart, rp, rv
+		mov	\rp, #0xfe000000	@ physical as well as virtual
+		orr	\rp, \rp, #0x00800000	@ location of the UART
+		mov	\rv, \rp
 		.endm
 
 #define UART_SHIFT	0
diff --git a/arch/arm/mach-iop33x/include/mach/debug-macro.S b/arch/arm/mach-iop33x/include/mach/debug-macro.S
index addb2da..40c500d 100644
--- a/arch/arm/mach-iop33x/include/mach/debug-macro.S
+++ b/arch/arm/mach-iop33x/include/mach/debug-macro.S
@@ -11,13 +11,11 @@
  * published by the Free Software Foundation.
  */
 
-		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1			@ mmu enabled?
-		moveq	\rx, #0xff000000	@ physical
-		movne	\rx, #0xfe000000	@ virtual
-		orr	\rx, \rx, #0x00ff0000
-		orr	\rx, \rx, #0x0000f700
+		.macro	addruart, rp, rv
+		mov	\rp, #0x00ff0000
+		orr	\rp, \rp, #0x0000f700
+		orr	\rv, #0xfe000000	@ virtual
+		orr	\rp, #0xff000000	@ physical
 		.endm
 
 #define UART_SHIFT	2
diff --git a/arch/arm/mach-ixp2000/include/mach/debug-macro.S b/arch/arm/mach-ixp2000/include/mach/debug-macro.S
index 6a82768..0ef533b 100644
--- a/arch/arm/mach-ixp2000/include/mach/debug-macro.S
+++ b/arch/arm/mach-ixp2000/include/mach/debug-macro.S
@@ -11,16 +11,14 @@
  *
 */
 
-		.macro  addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1			@ MMU enabled?
-		moveq	\rx, #0xc0000000	@ Physical base
-		movne	\rx, #0xfe000000	@ virtual base
-		orrne	\rx, \rx, #0x00f00000
-		orr	\rx, \rx, #0x00030000
+		.macro  addruart, rp, rv
+		mov	\rp, #0x00030000
 #ifdef	__ARMEB__
-		orr	\rx, \rx, #0x00000003
+		orr	\rp, \rp, #0x00000003
 #endif
+		orr	\rv, \rp, #0xfe000000	@ virtual base
+		orr	\rv, \rv, #0x00f00000
+		orr	\rp, \rp, #0xc0000000	@ Physical base
 		.endm
 
 #define UART_SHIFT	2
diff --git a/arch/arm/mach-ixp23xx/include/mach/debug-macro.S b/arch/arm/mach-ixp23xx/include/mach/debug-macro.S
index a82e375..f7c6eef 100644
--- a/arch/arm/mach-ixp23xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-ixp23xx/include/mach/debug-macro.S
@@ -12,13 +12,12 @@
  */
 #include <mach/ixp23xx.h>
 
-		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1				@ mmu enabled?
-		ldreq	\rx, =IXP23XX_PERIPHERAL_PHYS 	@ physical
-		ldrne	\rx, =IXP23XX_PERIPHERAL_VIRT	@ virtual
+		.macro	addruart, rp, rv
+		ldr	\rp, =IXP23XX_PERIPHERAL_PHYS 	@ physical
+		ldr	\rv, =IXP23XX_PERIPHERAL_VIRT	@ virtual
 #ifdef __ARMEB__
-		orr	\rx, \rx, #0x00000003
+		orr	\rp, \rp, #0x00000003
+		orr	\rv, \rv, #0x00000003
 #endif
 		.endm
 
diff --git a/arch/arm/mach-ixp4xx/include/mach/debug-macro.S b/arch/arm/mach-ixp4xx/include/mach/debug-macro.S
index 3fc66d6..b974a49 100644
--- a/arch/arm/mach-ixp4xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-ixp4xx/include/mach/debug-macro.S
@@ -10,16 +10,16 @@
  * published by the Free Software Foundation.
 */
 
-                .macro  addruart, rx, tmp
-                mrc     p15, 0, \rx, c1, c0
-                tst     \rx, #1                 @ MMU enabled?
-                moveq   \rx, #0xc8000000
-                movne   \rx, #0xff000000
-		orrne	\rx, \rx, #0x00b00000
+                .macro  addruart, rp, rv
 #ifdef __ARMEB__
-                add     \rx,\rx,#3              @ Uart regs are at off set of 3 if
-						@ byte writes used - Big Endian.
+                mov     \rp, #3         @ Uart regs are at off set of 3 if
+					@ byte writes used - Big Endian.
+#else
+		mov	\rp, #0
 #endif
+                orr     \rv, \rp, #0xff000000	@ virtual
+		orr	\rv, \rv, #0x00b00000
+                orr     \rp, \rp, #0xc8000000	@ physical
                 .endm
 
 #define UART_SHIFT	2
diff --git a/arch/arm/mach-kirkwood/include/mach/debug-macro.S b/arch/arm/mach-kirkwood/include/mach/debug-macro.S
index d060677..db06ae4 100644
--- a/arch/arm/mach-kirkwood/include/mach/debug-macro.S
+++ b/arch/arm/mach-kirkwood/include/mach/debug-macro.S
@@ -8,12 +8,11 @@
 
 #include <mach/bridge-regs.h>
 
-	.macro	addruart, rx, tmp
-	mrc	p15, 0, \rx, c1, c0
-	tst	\rx, #1					@ MMU enabled?
-	ldreq	\rx, =KIRKWOOD_REGS_PHYS_BASE
-	ldrne	\rx, =KIRKWOOD_REGS_VIRT_BASE
-	orr	\rx, \rx, #0x00012000
+	.macro	addruart, rp, rv
+	ldr	\rp, =KIRKWOOD_REGS_PHYS_BASE
+	ldr	\rv, =KIRKWOOD_REGS_VIRT_BASE
+	orr	\rp, \rp, #0x00012000
+	orr	\rv, \rv, #0x00012000
 	.endm
 
 #define UART_SHIFT	2
diff --git a/arch/arm/mach-ks8695/include/mach/debug-macro.S b/arch/arm/mach-ks8695/include/mach/debug-macro.S
index cf2095d..bf516ad 100644
--- a/arch/arm/mach-ks8695/include/mach/debug-macro.S
+++ b/arch/arm/mach-ks8695/include/mach/debug-macro.S
@@ -14,11 +14,9 @@
 #include <mach/hardware.h>
 #include <mach/regs-uart.h>
 
-	.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1				@ MMU enabled?
-		ldreq	\rx, =KS8695_UART_PA		@ physical base address
-		ldrne	\rx, =KS8695_UART_VA		@ virtual base address
+	.macro	addruart, rp, rv
+		ldr	\rp, =KS8695_UART_PA		@ physical base address
+		ldr	\rv, =KS8695_UART_VA		@ virtual base address
 	.endm
 
 	.macro	senduart, rd, rx
diff --git a/arch/arm/mach-l7200/include/mach/debug-macro.S b/arch/arm/mach-l7200/include/mach/debug-macro.S
new file mode 100644
index 0000000..b0a2db7
--- /dev/null
+++ b/arch/arm/mach-l7200/include/mach/debug-macro.S
@@ -0,0 +1,38 @@
+/* arch/arm/mach-l7200/include/mach/debug-macro.S
+ *
+ * Debugging macro include header
+ *
+ *  Copyright (C) 1994-1999 Russell King
+ *  Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+*/
+
+		.equ	io_virt, IO_BASE
+		.equ	io_phys, IO_START
+
+		.macro	addruart, rp, rv
+		mov	\rp, #0x00044000	@ UART1
+@		mov	\rp, #0x00045000	@ UART2
+		add	\rv, \rp, #io_virt	@ virtual address
+		add	\rp, \rp, #io_phys	@ physical base address
+		.endm
+
+		.macro	senduart,rd,rx
+		str	\rd, [\rx, #0x0]	@ UARTDR
+		.endm
+
+		.macro	waituart,rd,rx
+1001:		ldr	\rd, [\rx, #0x18]	@ UARTFLG
+		tst	\rd, #1 << 5		@ UARTFLGUTXFF - 1 when full
+		bne	1001b
+		.endm
+
+		.macro	busyuart,rd,rx
+1001:		ldr	\rd, [\rx, #0x18]	@ UARTFLG
+		tst	\rd, #1 << 3		@ UARTFLGUBUSY - 1 when busy
+		bne	1001b
+		.endm
diff --git a/arch/arm/mach-lh7a40x/include/mach/debug-macro.S b/arch/arm/mach-lh7a40x/include/mach/debug-macro.S
index c0dcbbb..cff3362 100644
--- a/arch/arm/mach-lh7a40x/include/mach/debug-macro.S
+++ b/arch/arm/mach-lh7a40x/include/mach/debug-macro.S
@@ -14,12 +14,10 @@
 	@ It is not known if this will be appropriate for every 40x
 	@ board.
 
-		.macro  addruart, rx, tmp
-		mrc     p15, 0, \rx, c1, c0
-		tst     \rx, #1                 @ MMU enabled?
-		mov     \rx, #0x00000700        @ offset from base
-		orreq   \rx, \rx, #0x80000000   @ physical base
-		orrne   \rx, \rx, #0xf8000000   @ virtual base
+		.macro  addruart, rp, rv
+		mov     \rp, #0x00000700        @ offset from base
+		orr     \rv, \rp, #0xf8000000   @ virtual base
+		orr     \rp, \rp, #0x80000000   @ physical base
 		.endm
 
 		.macro  senduart,rd,rx
diff --git a/arch/arm/mach-loki/include/mach/debug-macro.S b/arch/arm/mach-loki/include/mach/debug-macro.S
index 3136c91..cc90d99 100644
--- a/arch/arm/mach-loki/include/mach/debug-macro.S
+++ b/arch/arm/mach-loki/include/mach/debug-macro.S
@@ -8,12 +8,11 @@
 
 #include <mach/loki.h>
 
-	.macro	addruart, rx, tmp
-	mrc	p15, 0, \rx, c1, c0
-	tst	\rx, #1					@ MMU enabled?
-	ldreq	\rx, =LOKI_REGS_PHYS_BASE
-	ldrne	\rx, =LOKI_REGS_VIRT_BASE
-	orr	\rx, \rx, #0x00012000
+	.macro	addruart, rp, rv
+	ldr	\rp, =LOKI_REGS_PHYS_BASE
+	ldr	\rv, =LOKI_REGS_VIRT_BASE
+	orr	\rp, \rp, #0x00012000
+	orr	\rv, \rv, #0x00012000
 	.endm
 
 #define UART_SHIFT	2
diff --git a/arch/arm/mach-mmp/include/mach/debug-macro.S b/arch/arm/mach-mmp/include/mach/debug-macro.S
index 76deff2..7e2ebd3 100644
--- a/arch/arm/mach-mmp/include/mach/debug-macro.S
+++ b/arch/arm/mach-mmp/include/mach/debug-macro.S
@@ -11,12 +11,11 @@
 
 #include <mach/addr-map.h>
 
-		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1				@ MMU enabled?
-		ldreq	\rx, =APB_PHYS_BASE		@ physical
-		ldrne	\rx, =APB_VIRT_BASE		@ virtual
-		orr	\rx, \rx, #0x00017000
+		.macro	addruart, rp, rv
+		ldr	\rp, =APB_PHYS_BASE		@ physical
+		ldr	\rv, =APB_VIRT_BASE		@ virtual
+		orr	\rp, \rp, #0x00017000
+		orr	\rv, \rv, #0x00017000
 		.endm
 
 #define UART_SHIFT	2
diff --git a/arch/arm/mach-msm/include/mach/debug-macro.S b/arch/arm/mach-msm/include/mach/debug-macro.S
index 528750f..3c35b0d 100644
--- a/arch/arm/mach-msm/include/mach/debug-macro.S
+++ b/arch/arm/mach-msm/include/mach/debug-macro.S
@@ -20,12 +20,10 @@
 #include <mach/msm_iomap.h>
 
 #ifdef CONFIG_MSM_DEBUG_UART
-	.macro	addruart, rx, tmp
+	.macro	addruart, rp, rv
 	@ see if the MMU is enabled and select appropriate base address
-	mrc	p15, 0, \rx, c1, c0
-	tst	\rx, #1
-	ldreq	\rx, =MSM_DEBUG_UART_PHYS
-	ldrne	\rx, =MSM_DEBUG_UART_BASE
+	ldr	\rp, =MSM_DEBUG_UART_PHYS
+	ldr	\rv, =MSM_DEBUG_UART_BASE
 	.endm
 
 	.macro	senduart,rd,rx
@@ -40,7 +38,7 @@
 	beq	1001b
 	.endm
 #else
-	.macro	addruart, rx, tmp
+	.macro	addruart, rp, rv
 	.endm
 
 	.macro	senduart,rd,rx
diff --git a/arch/arm/mach-mv78xx0/include/mach/debug-macro.S b/arch/arm/mach-mv78xx0/include/mach/debug-macro.S
index cd81689..0489142 100644
--- a/arch/arm/mach-mv78xx0/include/mach/debug-macro.S
+++ b/arch/arm/mach-mv78xx0/include/mach/debug-macro.S
@@ -8,12 +8,11 @@
 
 #include <mach/mv78xx0.h>
 
-	.macro	addruart, rx, tmp
-	mrc	p15, 0, \rx, c1, c0
-	tst	\rx, #1					@ MMU enabled?
-	ldreq	\rx, =MV78XX0_REGS_PHYS_BASE
-	ldrne	\rx, =MV78XX0_REGS_VIRT_BASE
-	orr	\rx, \rx, #0x00012000
+	.macro	addruart, rp, rv
+	ldr	\rp, =MV78XX0_REGS_PHYS_BASE
+	ldr	\rv, =MV78XX0_REGS_VIRT_BASE
+	orr	\rp, \rp, #0x00012000
+	orr	\rv, \rv, #0x00012000
 	.endm
 
 #define UART_SHIFT	2
diff --git a/arch/arm/mach-netx/include/mach/debug-macro.S b/arch/arm/mach-netx/include/mach/debug-macro.S
index e96339e..56a9152 100644
--- a/arch/arm/mach-netx/include/mach/debug-macro.S
+++ b/arch/arm/mach-netx/include/mach/debug-macro.S
@@ -13,12 +13,10 @@
 
 #include "hardware.h"
 
-		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1			@ MMU enabled?
-		moveq	\rx, #0x00100000		@ physical
-		movne	\rx, #io_p2v(0x00100000)	@ virtual
-		orr	\rx, \rx, #0x00000a00
+		.macro	addruart, rp, rv
+		mov	\rp, #0x00000a00
+		orr	\rv, \rp, #io_p2v(0x00100000)	@ virtual
+		orr	\rp, \rp, #0x00100000		@ physical
 		.endm
 
 		.macro	senduart,rd,rx
diff --git a/arch/arm/mach-nomadik/include/mach/debug-macro.S b/arch/arm/mach-nomadik/include/mach/debug-macro.S
index 4f92acf..e7151b4 100644
--- a/arch/arm/mach-nomadik/include/mach/debug-macro.S
+++ b/arch/arm/mach-nomadik/include/mach/debug-macro.S
@@ -10,13 +10,11 @@
  *
 */
 
-		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1			@ MMU enabled?
-		moveq	\rx, #0x10000000	@ physical base address
-		movne	\rx, #0xf0000000	@ virtual base
-		add	\rx, \rx, #0x00100000
-		add	\rx, \rx, #0x000fb000
+		.macro	addruart, rp, rv
+		mov	\rp, #0x00100000
+		add	\rp, \rp, #0x000fb000
+		add	\rv, \rp, #0xf0000000	@ virtual base
+		add	\rp, \rp, #0x10000000	@ physical base address
 		.endm
 
 #include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/mach-ns9xxx/include/mach/debug-macro.S b/arch/arm/mach-ns9xxx/include/mach/debug-macro.S
index 5c934bd..5a2acbd 100644
--- a/arch/arm/mach-ns9xxx/include/mach/debug-macro.S
+++ b/arch/arm/mach-ns9xxx/include/mach/debug-macro.S
@@ -12,11 +12,9 @@
 
 #include <mach/regs-board-a9m9750dev.h>
 
-		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1
-		ldreq	\rx, =NS9XXX_CSxSTAT_PHYS(0)
-		ldrne	\rx, =io_p2v(NS9XXX_CSxSTAT_PHYS(0))
+		.macro	addruart, rp, rv
+		ldr	\rp, =NS9XXX_CSxSTAT_PHYS(0)
+		ldr	\rv, =io_p2v(NS9XXX_CSxSTAT_PHYS(0))
 		.endm
 
 #define UART_SHIFT	2
diff --git a/arch/arm/mach-omap1/include/mach/debug-macro.S b/arch/arm/mach-omap1/include/mach/debug-macro.S
index 671408e..6a0fa04 100644
--- a/arch/arm/mach-omap1/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap1/include/mach/debug-macro.S
@@ -28,56 +28,58 @@ omap_uart_virt:	.word	0x0
 		 * the desired UART phys and virt addresses temporarily into
 		 * the omap_uart_phys and omap_uart_virt above.
 		 */
-		.macro	addruart, rx, tmp
+		.macro	addruart, rp, rv
 
 		/* Use omap_uart_phys/virt if already configured */
-9:		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1			@ MMU enabled?
-		ldreq	\rx, =__virt_to_phys(omap_uart_phys)	@ physical base address
-		ldrne	\rx, =omap_uart_virt	@ virtual base
-		ldr	\rx, [\rx, #0]
-		cmp	\rx, #0			@ is port configured?
+9:		mrc	p15, 0, \rp, c1, c0
+		tst	\rp, #1			@ MMU enabled?
+		ldreq	\rp, =__virt_to_phys(omap_uart_phys)	@ MMU not enabled
+		ldrne	\rp, =omap_uart_phys	@ MMU enabled
+		add	\rv, \rp, #4		@ omap_uart_virt
+		ldr	\rp, [\rp, #0]
+		ldr	\rv, [\rv, #0]
+		cmp	\rp, #0			@ is port configured?
+		cmpne	\rv, #0
 		bne	99f			@ already configured
 
 		/* Check the debug UART configuration set in uncompress.h */
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1			@ MMU enabled?
-		ldreq	\rx, =OMAP_UART_INFO
-		ldrne	\rx, =__phys_to_virt(OMAP_UART_INFO)
-		ldr	\rx, [\rx, #0]
+		mrc	p15, 0, \rp, c1, c0
+		tst	\rp, #1			@ MMU enabled?
+		ldreq	\rp, =OMAP_UART_INFO	@ MMU not enabled
+		ldrne	\rp, =__phys_to_virt(OMAP_UART_INFO)	@ MMU enabled
+		ldr	\rp, [\rp, #0]
 
 		/* Select the UART to use based on the UART1 scratchpad value */
-10:		cmp	\rx, #0			@ no port configured?
+10:		cmp	\rp, #0			@ no port configured?
 		beq	11f			@ if none, try to use UART1
-		cmp	\rx, #OMAP1UART1
+		cmp	\rp, #OMAP1UART1
 		beq	11f			@ configure OMAP1UART1
-		cmp	\rx, #OMAP1UART2
+		cmp	\rp, #OMAP1UART2
 		beq	12f			@ configure OMAP1UART2
-		cmp	\rx, #OMAP1UART3
+		cmp	\rp, #OMAP1UART3
 		beq	13f			@ configure OMAP2UART3
 
 		/* Configure the UART offset from the phys/virt base */
-11:		mov	\rx, #0x00fb0000	@ OMAP1UART1
+11:		mov	\rp, #0x00fb0000	@ OMAP1UART1
 		b	98f
-12:		mov	\rx, #0x00fb0000	@ OMAP1UART1
-		orr	\rx, \rx, #0x00000800	@ OMAP1UART2
+12:		mov	\rp, #0x00fb0000	@ OMAP1UART1
+		orr	\rp, \rp, #0x00000800	@ OMAP1UART2
 		b	98f
-13:		mov	\rx, #0x00fb0000	@ OMAP1UART1
-		orr	\rx, \rx, #0x00000800	@ OMAP1UART2
-		orr	\rx, \rx, #0x00009000	@ OMAP1UART3
+13:		mov	\rp, #0x00fb0000	@ OMAP1UART1
+		orr	\rp, \rp, #0x00000800	@ OMAP1UART2
+		orr	\rp, \rp, #0x00009000	@ OMAP1UART3
 
 		/* Store both phys and virt address for the uart */
-98:		add	\rx, \rx, #0xff000000	@ phys base
-		mrc	p15, 0, \tmp, c1, c0
-		tst	\tmp, #1		@ MMU enabled?
-		ldreq	\tmp, =__virt_to_phys(omap_uart_phys)
-		ldrne	\tmp, =omap_uart_phys
-		str	\rx, [\tmp, #0]
-		sub	\rx, \rx, #0xff000000	@ phys base
-		add	\rx, \rx, #0xfe000000	@ virt base
-		ldreq	\tmp, =__virt_to_phys(omap_uart_virt)
-		ldrne	\tmp, =omap_uart_virt
-		str	\rx, [\tmp, #0]
+98:		add	\rp, \rp, #0xff000000	@ phys base
+		mrc	p15, 0, \rv, c1, c0
+		tst	\rv, #1			@ MMU enabled?
+		ldreq	\rv, =__virt_to_phys(omap_uart_phys)	@ MMU not enabled
+		ldrne	\rv, =omap_uart_phys	@ MMU enabled
+		str	\rp, [\rv, #0]
+		sub	\rp, \rp, #0xff000000	@ phys base
+		add	\rp, \rp, #0xfe000000	@ virt base
+		add	\rv, \rv, #4		@ omap_uart_lsr
+		str	\rp, [\rv, #0]
 		b	9b
 99:
 		.endm
diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S b/arch/arm/mach-omap2/include/mach/debug-macro.S
index 09331bb..6a4d413 100644
--- a/arch/arm/mach-omap2/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
@@ -31,95 +31,94 @@ omap_uart_lsr:	.word	0
 		 * the desired UART phys and virt addresses temporarily into
 		 * the omap_uart_phys and omap_uart_virt above.
 		 */
-		.macro	addruart, rx, tmp
+		.macro	addruart, rp, rv
 
 		/* Use omap_uart_phys/virt if already configured */
-10:		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1			@ MMU enabled?
-		ldreq	\rx, =__virt_to_phys(omap_uart_phys)	@ physical base address
-		ldrne	\rx, =omap_uart_virt	@ virtual base address
-		ldr	\rx, [\rx, #0]
-		cmp	\rx, #0			@ is port configured?
+10:		mrc	p15, 0, \rp, c1, c0
+		tst	\rp, #1			@ MMU enabled?
+		ldreq	\rp, =__virt_to_phys(omap_uart_phys)	@ MMU not enabled
+		ldrne	\rp, =omap_uart_phys	@ MMU enabled
+		add	\rv, \rp, #4		@ omap_uart_virt
+		ldr	\rp, [\rp, #0]
+		ldr	\rv, [\rv, #0]
+		cmp	\rp, #0			@ is port configured?
+		cmpne	\rv, #0
 		bne	99f			@ already configured
 
 		/* Check the debug UART configuration set in uncompress.h */
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1			@ MMU enabled?
-		ldreq	\rx, =OMAP_UART_INFO
-		ldrne	\rx, =__phys_to_virt(OMAP_UART_INFO)
-		ldr	\rx, [\rx, #0]
+		mrc	p15, 0, \rp, c1, c0
+		tst	\rp, #1			@ MMU enabled?
+		ldreq	\rp, =OMAP_UART_INFO	@ MMU not enabled
+		ldrne	\rp, =__phys_to_virt(OMAP_UART_INFO)	@ MMU enabled
+		ldr	\rp, [\rp, #0]
 
 		/* Select the UART to use based on the UART1 scratchpad value */
-		cmp	\rx, #0			@ no port configured?
+		cmp	\rp, #0			@ no port configured?
 		beq	21f			@ if none, try to use UART1
-		cmp	\rx, #OMAP2UART1	@ OMAP2/3/4UART1
+		cmp	\rp, #OMAP2UART1	@ OMAP2/3/4UART1
 		beq	21f			@ configure OMAP2/3/4UART1
-		cmp	\rx, #OMAP2UART2	@ OMAP2/3/4UART2
+		cmp	\rp, #OMAP2UART2	@ OMAP2/3/4UART2
 		beq	22f			@ configure OMAP2/3/4UART2
-		cmp	\rx, #OMAP2UART3	@ only on 24xx
+		cmp	\rp, #OMAP2UART3	@ only on 24xx
 		beq	23f			@ configure OMAP2UART3
-		cmp	\rx, #OMAP3UART3	@ only on 34xx
+		cmp	\rp, #OMAP3UART3	@ only on 34xx
 		beq	33f			@ configure OMAP3UART3
-		cmp	\rx, #OMAP4UART3	@ only on 44xx
+		cmp	\rp, #OMAP4UART3	@ only on 44xx
 		beq	43f			@ configure OMAP4UART3
-		cmp	\rx, #OMAP3UART4	@ only on 36xx
+		cmp	\rp, #OMAP3UART4	@ only on 36xx
 		beq	34f			@ configure OMAP3UART4
-		cmp	\rx, #OMAP4UART4	@ only on 44xx
+		cmp	\rp, #OMAP4UART4	@ only on 44xx
 		beq	44f			@ configure OMAP4UART4
-		cmp	\rx, #ZOOM_UART		@ only on zoom2/3
+		cmp	\rp, #ZOOM_UART		@ only on zoom2/3
 		beq	95f			@ configure ZOOM_UART
 
 		/* Configure the UART offset from the phys/virt base */
-21:		mov	\rx, #UART_OFFSET(OMAP2_UART1_BASE)	@ omap2/3/4
+21:		mov	\rp, #UART_OFFSET(OMAP2_UART1_BASE)	@ omap2/3/4
 		b	98f
-22:		mov	\rx, #UART_OFFSET(OMAP2_UART2_BASE)	@ omap2/3/4
+22:		mov	\rp, #UART_OFFSET(OMAP2_UART2_BASE)	@ omap2/3/4
 		b	98f
-23:		mov	\rx, #UART_OFFSET(OMAP2_UART3_BASE)
+23:		mov	\rp, #UART_OFFSET(OMAP2_UART3_BASE)
 		b	98f
-33:		mov	\rx, #UART_OFFSET(OMAP3_UART1_BASE)
-		add	\rx, \rx, #0x00fb0000
-		add	\rx, \rx, #0x00006000		@ OMAP3_UART3_BASE
+33:		mov	\rp, #UART_OFFSET(OMAP3_UART1_BASE)
+		add	\rp, \rp, #0x00fb0000
+		add	\rp, \rp, #0x00006000		@ OMAP3_UART3_BASE
 		b	98f
-34:		mov	\rx, #UART_OFFSET(OMAP3_UART1_BASE)
-		add	\rx, \rx, #0x00fb0000
-		add	\rx, \rx, #0x00028000		@ OMAP3_UART4_BASE
+34:		mov	\rp, #UART_OFFSET(OMAP3_UART1_BASE)
+		add	\rp, \rp, #0x00fb0000
+		add	\rp, \rp, #0x00028000		@ OMAP3_UART4_BASE
 		b	98f
-43:		mov	\rx, #UART_OFFSET(OMAP4_UART3_BASE)
+43:		mov	\rp, #UART_OFFSET(OMAP4_UART3_BASE)
 		b	98f
-44:		mov	\rx, #UART_OFFSET(OMAP4_UART4_BASE)
+44:		mov	\rp, #UART_OFFSET(OMAP4_UART4_BASE)
 		b	98f
-95:		ldr	\rx, =ZOOM_UART_BASE
-		mrc	p15, 0, \tmp, c1, c0
-		tst	\tmp, #1		@ MMU enabled?
-		ldreq	\tmp, =__virt_to_phys(omap_uart_phys)
-		ldrne	\tmp, =omap_uart_phys
-		str	\rx, [\tmp, #0]
-		ldr	\rx, =ZOOM_UART_VIRT
-		ldreq	\tmp, =__virt_to_phys(omap_uart_virt)
-		ldrne	\tmp, =omap_uart_virt
-		str	\rx, [\tmp, #0]
-		mov	\rx, #(UART_LSR << ZOOM_PORT_SHIFT)
-		ldreq	\tmp, =__virt_to_phys(omap_uart_lsr)
-		ldrne	\tmp, =omap_uart_lsr
-		str	\rx, [\tmp, #0]
+95:		ldr	\rp, =ZOOM_UART_BASE
+		mrc	p15, 0, \rv, c1, c0
+		tst	\rv, #1			@ MMU enabled?
+		ldreq	\rv, =__virt_to_phys(omap_uart_phys)	@ MMU not enabled
+		ldrne	\rv, =omap_uart_phys	@ MMU enabled
+		str	\rp, [\rv, #0]
+		ldr	\rp, =ZOOM_UART_VIRT
+		add	\rv, \rv, #4		@ omap_uart_virt
+		str	\rp, [\rv, #0]
+		mov	\rp, #(UART_LSR << ZOOM_PORT_SHIFT)
+		add	\rv, \rv, #4		@ omap_uart_lsr
+		str	\rp, [\rv, #0]
 		b	10b
 
 		/* Store both phys and virt address for the uart */
-98:		add	\rx, \rx, #0x48000000	@ phys base
-		mrc	p15, 0, \tmp, c1, c0
-		tst	\tmp, #1		@ MMU enabled?
-		ldreq	\tmp, =__virt_to_phys(omap_uart_phys)
-		ldrne	\tmp, =omap_uart_phys
-		str	\rx, [\tmp, #0]
-		sub	\rx, \rx, #0x48000000	@ phys base
-		add	\rx, \rx, #0xfa000000	@ virt base
-		ldreq	\tmp, =__virt_to_phys(omap_uart_virt)
-		ldrne	\tmp, =omap_uart_virt
-		str	\rx, [\tmp, #0]
-		mov	\rx, #(UART_LSR << OMAP_PORT_SHIFT)
-		ldreq	\tmp, =__virt_to_phys(omap_uart_lsr)
-		ldrne	\tmp, =omap_uart_lsr
-		str	\rx, [\tmp, #0]
+98:		add	\rp, \rp, #0x48000000	@ phys base
+		mrc	p15, 0, \rv, c1, c0
+		tst	\rv, #1			@ MMU enabled?
+		ldreq	\rv, =__virt_to_phys(omap_uart_phys)	@ MMU not enabled
+		ldrne	\rv, =omap_uart_phys	@ MMU enabled
+		str	\rp, [\rv, #0]
+		sub	\rp, \rp, #0x48000000	@ phys base
+		add	\rp, \rp, #0xfa000000	@ virt base
+		add	\rv, \rv, #4		@ omap_uart_virt
+		str	\rp, [\rv, #0]
+		mov	\rp, #(UART_LSR << OMAP_PORT_SHIFT)
+		add	\rv, \rv, #4		@ omap_uart_lsr
+		str	\rp, [\rv, #0]
 
 		b	10b
 99:
@@ -131,9 +130,9 @@ omap_uart_lsr:	.word	0
 
 		.macro	busyuart,rd,rx
 1001:		mrc	p15, 0, \rd, c1, c0
-		tst	\rd, #1		@ MMU enabled?
-		ldreq	\rd, =__virt_to_phys(omap_uart_lsr)
-		ldrne	\rd, =omap_uart_lsr
+		tst	\rd, #1			@ MMU enabled?
+		ldreq	\rd, =__virt_to_phys(omap_uart_lsr)	@ MMU not enabled
+		ldrne	\rd, =omap_uart_lsr	@ MMU enabled
 		ldr	\rd, [\rd, #0]
 		ldrb	\rd, [\rx, \rd]
 		and	\rd, \rd, #(UART_LSR_TEMT | UART_LSR_THRE)
diff --git a/arch/arm/mach-orion5x/include/mach/debug-macro.S b/arch/arm/mach-orion5x/include/mach/debug-macro.S
index 91e0e39..5e3bf5b 100644
--- a/arch/arm/mach-orion5x/include/mach/debug-macro.S
+++ b/arch/arm/mach-orion5x/include/mach/debug-macro.S
@@ -10,12 +10,11 @@
 
 #include <mach/orion5x.h>
 
-	.macro  addruart, rx, tmp
-	mrc	p15, 0, \rx, c1, c0
-	tst	\rx, #1					@ MMU enabled?
-	ldreq	\rx, =ORION5X_REGS_PHYS_BASE
-	ldrne	\rx, =ORION5X_REGS_VIRT_BASE
-	orr	\rx, \rx, #0x00012000
+	.macro  addruart, rp, rv
+	ldr	\rp, =ORION5X_REGS_PHYS_BASE
+	ldr	\rv, =ORION5X_REGS_VIRT_BASE
+	orr	\rp, \rp, #0x00012000
+	orr	\rv, \rv, #0x00012000
 	.endm
 
 #define UART_SHIFT	2
diff --git a/arch/arm/mach-pnx4008/include/mach/debug-macro.S b/arch/arm/mach-pnx4008/include/mach/debug-macro.S
index 6ca8bd3..931afeb 100644
--- a/arch/arm/mach-pnx4008/include/mach/debug-macro.S
+++ b/arch/arm/mach-pnx4008/include/mach/debug-macro.S
@@ -11,12 +11,10 @@
  *
 */
 
-		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1			@ MMU enabled?
-		mov	\rx, #0x00090000
-		addeq	\rx, \rx, #0x40000000
-		addne	\rx, \rx, #0xf4000000
+		.macro	addruart, rp, rv
+		mov	\rp, #0x00090000
+		add	\rv, \rp, #0xf4000000	@ virtual
+		add	\rp, \rp, #0x40000000	@ physical
 		.endm
 
 #define UART_SHIFT	2
diff --git a/arch/arm/mach-pxa/include/mach/debug-macro.S b/arch/arm/mach-pxa/include/mach/debug-macro.S
index 01cf813..7d5c751 100644
--- a/arch/arm/mach-pxa/include/mach/debug-macro.S
+++ b/arch/arm/mach-pxa/include/mach/debug-macro.S
@@ -13,12 +13,10 @@
 
 #include "hardware.h"
 
-		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1			@ MMU enabled?
-		moveq	\rx, #0x40000000		@ physical
-		movne	\rx, #io_p2v(0x40000000)	@ virtual
-		orr	\rx, \rx, #0x00100000
+		.macro	addruart, rp, rv
+		mov	\rp, #0x00100000
+		orr	\rv, \rp, #io_p2v(0x40000000)	@ virtual
+		orr	\rp, \rp, #0x40000000		@ physical
 		.endm
 
 #define UART_SHIFT	2
diff --git a/arch/arm/mach-realview/include/mach/debug-macro.S b/arch/arm/mach-realview/include/mach/debug-macro.S
index 8662228..90b687c 100644
--- a/arch/arm/mach-realview/include/mach/debug-macro.S
+++ b/arch/arm/mach-realview/include/mach/debug-macro.S
@@ -33,12 +33,10 @@
 #error "Unknown RealView platform"
 #endif
 
-		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1			@ MMU enabled?
-		moveq	\rx,      #0x10000000
-		movne	\rx,      #0xfb000000	@ virtual base
-		orr	\rx, \rx, #DEBUG_LL_UART_OFFSET
+		.macro	addruart, rp, rv
+		mov	\rp, #DEBUG_LL_UART_OFFSET
+		orr	\rv, \rp, #0xfb000000	@ virtual base
+		orr	\rp, \rp, #0x10000000	@ physical base
 		.endm
 
 #include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/mach-rpc/include/mach/debug-macro.S b/arch/arm/mach-rpc/include/mach/debug-macro.S
index 6fc8d66..85effff 100644
--- a/arch/arm/mach-rpc/include/mach/debug-macro.S
+++ b/arch/arm/mach-rpc/include/mach/debug-macro.S
@@ -11,13 +11,11 @@
  *
 */
 
-		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1			@ MMU enabled?
-		moveq	\rx, #0x03000000
-		movne	\rx, #0xe0000000
-		orr	\rx, \rx, #0x00010000
-		orr	\rx, \rx, #0x00000fe0
+		.macro	addruart, rp, rv
+		mov	\rp, #0x00010000
+		orr	\rp, \rp, #0x00000fe0
+		orr	\rv, \rp, #0xe0000000	@ virtual
+		orr	\rp, \rp, #0x03000000	@ physical
 		.endm
 
 #define UART_SHIFT	2
diff --git a/arch/arm/mach-s3c2410/include/mach/debug-macro.S b/arch/arm/mach-s3c2410/include/mach/debug-macro.S
index 0eef78b..5882dea 100644
--- a/arch/arm/mach-s3c2410/include/mach/debug-macro.S
+++ b/arch/arm/mach-s3c2410/include/mach/debug-macro.S
@@ -19,13 +19,12 @@
 #define S3C2410_UART1_OFF (0x4000)
 #define SHIFT_2440TXF (14-9)
 
-	.macro addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1
-		ldreq	\rx, = S3C24XX_PA_UART
-		ldrne	\rx, = S3C24XX_VA_UART
+	.macro addruart, rp, rv
+		ldr	\rp, = S3C24XX_PA_UART
+		ldr	\rv, = S3C24XX_VA_UART
 #if CONFIG_DEBUG_S3C_UART != 0
-		add	\rx, \rx, #(S3C2410_UART1_OFF * CONFIG_DEBUG_S3C_UART)
+		add	\rp, \rp, #(S3C2410_UART1_OFF * CONFIG_DEBUG_S3C_UART)
+		add	\rv, \rv, #(S3C2410_UART1_OFF * CONFIG_DEBUG_S3C_UART)
 #endif
 	.endm
 
diff --git a/arch/arm/mach-s3c24a0/include/mach/debug-macro.S b/arch/arm/mach-s3c24a0/include/mach/debug-macro.S
index 239476b..0c5a738 100644
--- a/arch/arm/mach-s3c24a0/include/mach/debug-macro.S
+++ b/arch/arm/mach-s3c24a0/include/mach/debug-macro.S
@@ -10,13 +10,12 @@
 #include <mach/map.h>
 #include <plat/regs-serial.h>
 
-	.macro addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1
-		ldreq	\rx, = S3C24XX_PA_UART
-		ldrne	\rx, = S3C24XX_VA_UART
+	.macro addruart, rp, rv
+		ldr	\rp, = S3C24XX_PA_UART
+		ldr	\rv, = S3C24XX_VA_UART
 #if CONFIG_DEBUG_S3C_UART != 0
-		add	\rx, \rx, #(S3C2410_UART1_OFF * CONFIG_DEBUG_S3C_UART)
+		add	\rp, \rp, #(S3C2410_UART1_OFF * CONFIG_DEBUG_S3C_UART)
+		add	\rv, \rv, #(S3C2410_UART1_OFF * CONFIG_DEBUG_S3C_UART)
 #endif
 	.endm
 
diff --git a/arch/arm/mach-s3c64xx/include/mach/debug-macro.S b/arch/arm/mach-s3c64xx/include/mach/debug-macro.S
index f9ab5d2..a29e705 100644
--- a/arch/arm/mach-s3c64xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-s3c64xx/include/mach/debug-macro.S
@@ -21,13 +21,12 @@
 	 * aligned and add in the offset when we load the value here.
 	 */
 
-	.macro addruart, rx, rtmp
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1
-		ldreq	\rx, = S3C_PA_UART
-		ldrne	\rx, = (S3C_VA_UART + S3C_PA_UART & 0xfffff)
+	.macro addruart, rp, rv
+		ldr	\rp, = S3C_PA_UART
+		ldr	\rv, = (S3C_VA_UART + S3C_PA_UART & 0xfffff)
 #if CONFIG_DEBUG_S3C_UART != 0
-		add	\rx, \rx, #(0x400 * CONFIG_DEBUG_S3C_UART)
+		add	\rp, \rp, #(0x400 * CONFIG_DEBUG_S3C_UART)
+		add	\rv, \rv, #(0x400 * CONFIG_DEBUG_S3C_UART)
 #endif
 	.endm
 
diff --git a/arch/arm/mach-s5p6440/include/mach/debug-macro.S b/arch/arm/mach-s5p6440/include/mach/debug-macro.S
index 1347d7f..f4c20ee 100644
--- a/arch/arm/mach-s5p6440/include/mach/debug-macro.S
+++ b/arch/arm/mach-s5p6440/include/mach/debug-macro.S
@@ -19,13 +19,12 @@
 	 * aligned and add in the offset when we load the value here.
 	 */
 
-	.macro addruart, rx, rtmp
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1
-		ldreq	\rx, = S3C_PA_UART
-		ldrne	\rx, = S3C_VA_UART
+	.macro addruart, rp, rv
+		ldr	\rp, = S3C_PA_UART
+		ldr	\rv, = S3C_VA_UART
 #if CONFIG_DEBUG_S3C_UART != 0
-		add	\rx, \rx, #(0x400 * CONFIG_DEBUG_S3C_UART)
+		add	\rp, \rp, #(0x400 * CONFIG_DEBUG_S3C_UART)
+		add	\rv, \rv, #(0x400 * CONFIG_DEBUG_S3C_UART)
 #endif
 	.endm
 
diff --git a/arch/arm/mach-s5p6442/include/mach/debug-macro.S b/arch/arm/mach-s5p6442/include/mach/debug-macro.S
index bb65361..e221320 100644
--- a/arch/arm/mach-s5p6442/include/mach/debug-macro.S
+++ b/arch/arm/mach-s5p6442/include/mach/debug-macro.S
@@ -15,13 +15,12 @@
 #include <mach/map.h>
 #include <plat/regs-serial.h>
 
-	.macro addruart, rx, rtmp
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1
-		ldreq	\rx, = S3C_PA_UART
-		ldrne	\rx, = S3C_VA_UART
+	.macro addruart, rp, rv
+		ldr	\rp, = S3C_PA_UART
+		ldr	\rv, = S3C_VA_UART
 #if CONFIG_DEBUG_S3C_UART != 0
-		add	\rx, \rx, #(0x400 * CONFIG_DEBUG_S3C_UART)
+		add	\rp, \rp, #(0x400 * CONFIG_DEBUG_S3C_UART)
+		add	\rv, \rv, #(0x400 * CONFIG_DEBUG_S3C_UART)
 #endif
 	.endm
 
diff --git a/arch/arm/mach-s5pc100/include/mach/debug-macro.S b/arch/arm/mach-s5pc100/include/mach/debug-macro.S
index 70e02e9..b2ba95d 100644
--- a/arch/arm/mach-s5pc100/include/mach/debug-macro.S
+++ b/arch/arm/mach-s5pc100/include/mach/debug-macro.S
@@ -22,13 +22,12 @@
 	 * aligned and add in the offset when we load the value here.
 	 */
 
-	.macro addruart, rx, rtmp
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1
-		ldreq	\rx, = S3C_PA_UART
-		ldrne	\rx, = S3C_VA_UART
+	.macro addruart, rp, rv
+		ldr	\rp, = S3C_PA_UART
+		ldr	\rv, = S3C_VA_UART
 #if CONFIG_DEBUG_S3C_UART != 0
-		add	\rx, \rx, #(0x400 * CONFIG_DEBUG_S3C_UART)
+		add	\rp, \rp, #(0x400 * CONFIG_DEBUG_S3C_UART)
+		add	\rv, \rv, #(0x400 * CONFIG_DEBUG_S3C_UART)
 #endif
 	.endm
 
diff --git a/arch/arm/mach-s5pv210/include/mach/debug-macro.S b/arch/arm/mach-s5pv210/include/mach/debug-macro.S
index 7872f5c..169fe65 100644
--- a/arch/arm/mach-s5pv210/include/mach/debug-macro.S
+++ b/arch/arm/mach-s5pv210/include/mach/debug-macro.S
@@ -21,13 +21,12 @@
 	 * aligned and add in the offset when we load the value here.
 	 */
 
-	.macro addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1
-		ldreq	\rx, = S3C_PA_UART
-		ldrne	\rx, = S3C_VA_UART
+	.macro addruart, rp, rv
+		ldr	\rp, = S3C_PA_UART
+		ldr	\rv, = S3C_VA_UART
 #if CONFIG_DEBUG_S3C_UART != 0
-		add	\rx, \rx, #(0x400 * CONFIG_DEBUG_S3C_UART)
+		add	\rp, \rp, #(0x400 * CONFIG_DEBUG_S3C_UART)
+		add	\rv, \rv, #(0x400 * CONFIG_DEBUG_S3C_UART)
 #endif
 	.endm
 
diff --git a/arch/arm/mach-sa1100/include/mach/debug-macro.S b/arch/arm/mach-sa1100/include/mach/debug-macro.S
index 336adcc..0cd0fc9 100644
--- a/arch/arm/mach-sa1100/include/mach/debug-macro.S
+++ b/arch/arm/mach-sa1100/include/mach/debug-macro.S
@@ -12,33 +12,37 @@
 */
 #include <mach/hardware.h>
 
-		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1			@ MMU enabled?
-		moveq	\rx, #0x80000000	@ physical base address
-		movne	\rx, #0xf8000000	@ virtual address
+		.macro	addruart, rp, rv
+		mrc	p15, 0, \rp, c1, c0
+		tst	\rp, #1			@ MMU enabled?
+		moveq	\rp, #0x80000000	@ physical base address
+		movne	\rp, #0xf8000000	@ virtual address
 
 		@ We probe for the active serial port here, coherently with
 		@ the comment in arch/arm/mach-sa1100/include/mach/uncompress.h.
 		@ We assume r1 can be clobbered.
 
 		@ see if Ser3 is active
-		add	\rx, \rx, #0x00050000
-		ldr	r1, [\rx, #UTCR3]
-		tst	r1, #UTCR3_TXE
+		add	\rp, \rp, #0x00050000
+		ldr	\rv, [\rp, #UTCR3]
+		tst	\rv, #UTCR3_TXE
 
 		@ if Ser3 is inactive, then try Ser1
-		addeq	\rx, \rx, #(0x00010000 - 0x00050000)
-		ldreq	r1, [\rx, #UTCR3]
-		tsteq	r1, #UTCR3_TXE
+		addeq	\rp, \rp, #(0x00010000 - 0x00050000)
+		ldreq	\rv, [\rp, #UTCR3]
+		tsteq	\rv, #UTCR3_TXE
 
 		@ if Ser1 is inactive, then try Ser2
-		addeq	\rx, \rx, #(0x00030000 - 0x00010000)
-		ldreq	r1, [\rx, #UTCR3]
-		tsteq	r1, #UTCR3_TXE
+		addeq	\rp, \rp, #(0x00030000 - 0x00010000)
+		ldreq	\rv, [\rp, #UTCR3]
+		tsteq	\rv, #UTCR3_TXE
+
+		@ clear top bits, and generate both phys and virt addresses
+		lsl	\rp, \rp, #8
+		lsr	\rp, \rp, #8
+		orr	\rv, \rp, #0xf8000000	@ virtual
+		orr	\rp, \rp, #0x80000000	@ physical
 
-		@ if all ports are inactive, then there is nothing we can do
-		moveq	pc, lr
 		.endm
 
 		.macro	senduart,rd,rx
diff --git a/arch/arm/mach-shark/include/mach/debug-macro.S b/arch/arm/mach-shark/include/mach/debug-macro.S
index 5ea24d4..a473f55 100644
--- a/arch/arm/mach-shark/include/mach/debug-macro.S
+++ b/arch/arm/mach-shark/include/mach/debug-macro.S
@@ -11,9 +11,10 @@
  *
 */
 
-		.macro	addruart, rx, tmp
-		mov	\rx, #0xe0000000
-		orr	\rx, \rx, #0x000003f8
+		.macro	addruart, rp, rv
+		mov	\rp, #0xe0000000
+		orr	\rp, \rp, #0x000003f8
+		mov	\rv, \rp
 		.endm
 
 		.macro	senduart,rd,rx
diff --git a/arch/arm/mach-tegra/include/mach/debug-macro.S b/arch/arm/mach-tegra/include/mach/debug-macro.S
index 55a3956..8ea3bff 100644
--- a/arch/arm/mach-tegra/include/mach/debug-macro.S
+++ b/arch/arm/mach-tegra/include/mach/debug-macro.S
@@ -20,24 +20,28 @@
 
 #include <mach/io.h>
 
-	.macro  addruart,rx, tmp
-        mrc     p15, 0, \rx, c1, c0
-        tst     \rx, #1                 @ MMU enabled?
-        ldreq   \rx, =IO_APB_PHYS       @ physical
-        ldrne   \rx, =IO_APB_VIRT        @ virtual
+	.macro  addruart, rp, rv
+        ldreq   \rp, =IO_APB_PHYS       @ physical
+        ldrne   \rv, =IO_APB_VIRT        @ virtual
 #if defined(CONFIG_TEGRA_DEBUG_UART_NONE)
 #error "A debug UART must be selected in the kernel config to use DEBUG_LL"
 #elif defined(CONFIG_TEGRA_DEBUG_UARTA)
-        orr     \rx, \rx, #0x6000
+        orr     \rp, \rp, #0x6000
+        orr     \rv, \rv, #0x6000
 #elif defined(CONFIG_TEGRA_DEBUG_UARTB)
-	ldr	\tmp, =0x6040
-        orr     \rx, \rx, \tmp
+        orr     \rp, \rp, #0x6000
+	orr	\rp, \rp, #0x40
+        orr     \rv, \rv, #0x6000
+	orr	\rv, \rv, #0x40
 #elif defined(CONFIG_TEGRA_DEBUG_UARTC)
-        orr     \rx, \rx, #0x6200
+        orr     \rp, \rp, #0x6200
+        orr     \rv, \rv, #0x6200
 #elif defined(CONFIG_TEGRA_DEBUG_UARTD)
-        orr     \rx, \rx, #0x6300
+        orr     \rp, \rp, #0x6300
+        orr     \rv, \rv, #0x6300
 #elif defined(CONFIG_TEGRA_DEBUG_UARTE)
-        orr     \rx, \rx, #0x6400
+        orr     \rp, \rp, #0x6400
+        orr     \rv, \rv, #0x6400
 #endif
 	.endm
 
diff --git a/arch/arm/mach-u300/include/mach/debug-macro.S b/arch/arm/mach-u300/include/mach/debug-macro.S
index 92c1242..df71570 100644
--- a/arch/arm/mach-u300/include/mach/debug-macro.S
+++ b/arch/arm/mach-u300/include/mach/debug-macro.S
@@ -10,13 +10,12 @@
  */
 #include <mach/hardware.h>
 
-	.macro	addruart, rx, tmp
+	.macro	addruart, rp, rv
 	/* If we move the address using MMU, use this. */
-	mrc	p15, 0, \rx, c1, c0
-	tst	\rx, #1			@ MMU enabled?
-	ldreq	\rx,	  = U300_SLOW_PER_PHYS_BASE @ MMU off, physical address
-	ldrne	\rx,	  = U300_SLOW_PER_VIRT_BASE @ MMU on, virtual address
-	orr	\rx, \rx, #0x00003000
+	ldr	\rp,	  = U300_SLOW_PER_PHYS_BASE @ MMU off, physical address
+	ldr	\rv,	  = U300_SLOW_PER_VIRT_BASE @ MMU on, virtual address
+	orr	\rp, \rp, #0x00003000
+	orr	\rv, \rv, #0x00003000
 	.endm
 
 #include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/mach-ux500/include/mach/debug-macro.S b/arch/arm/mach-ux500/include/mach/debug-macro.S
index c5203b7..be7c0f1 100644
--- a/arch/arm/mach-ux500/include/mach/debug-macro.S
+++ b/arch/arm/mach-ux500/include/mach/debug-macro.S
@@ -18,11 +18,9 @@
 #define UX500_UART(n)	__UX500_UART(n)
 #define UART_BASE	UX500_UART(CONFIG_UX500_DEBUG_UART)
 
-	.macro	addruart, rx, tmp
-	mrc	p15, 0, \rx, c1, c0
-	tst	\rx, #1					@ MMU enabled?
-	ldreq	\rx, =UART_BASE				@ no, physical address
-	ldrne	\rx, =IO_ADDRESS(UART_BASE)		@ yes, virtual address
+	.macro	addruart, rp, rv
+	ldr	\rp, =UART_BASE				@ no, physical address
+	ldr	\rv, =IO_ADDRESS(UART_BASE)		@ yes, virtual address
 	.endm
 
 #include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/mach-versatile/include/mach/debug-macro.S b/arch/arm/mach-versatile/include/mach/debug-macro.S
index 6fea719..eb2cf7d 100644
--- a/arch/arm/mach-versatile/include/mach/debug-macro.S
+++ b/arch/arm/mach-versatile/include/mach/debug-macro.S
@@ -11,13 +11,11 @@
  *
 */
 
-		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1			@ MMU enabled?
-		moveq	\rx,      #0x10000000
-		movne	\rx,      #0xf1000000	@ virtual base
-		orr	\rx, \rx, #0x001F0000
-		orr	\rx, \rx, #0x00001000
+		.macro	addruart, rp, rv
+		mov	\rp,      #0x001F0000
+		orr	\rp, \rp, #0x00001000
+		orr	\rv, \rp, #0xf1000000	@ virtual base
+		orr	\rp, \rp,  #0x10000000	@ physical base
 		.endm
 
 #include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/mach-vexpress/include/mach/debug-macro.S b/arch/arm/mach-vexpress/include/mach/debug-macro.S
index 5167e2a..050d65e 100644
--- a/arch/arm/mach-vexpress/include/mach/debug-macro.S
+++ b/arch/arm/mach-vexpress/include/mach/debug-macro.S
@@ -12,12 +12,10 @@
 
 #define DEBUG_LL_UART_OFFSET	0x00009000
 
-		.macro	addruart,rx,tmp
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1			@ MMU enabled?
-		moveq	\rx,      #0x10000000
-		movne	\rx,      #0xf8000000	@ virtual base
-		orr	\rx, \rx, #DEBUG_LL_UART_OFFSET
+		.macro	addruart,rp,rv
+		mov	\rp, #DEBUG_LL_UART_OFFSET
+		orr	\rv, \rp, #0xf8000000	@ virtual base
+		orr	\rp, \rp, #0x10000000	@ physical base
 		.endm
 
 #include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/plat-mxc/include/mach/debug-macro.S b/arch/arm/plat-mxc/include/mach/debug-macro.S
index 2560640..d56213f 100644
--- a/arch/arm/plat-mxc/include/mach/debug-macro.S
+++ b/arch/arm/plat-mxc/include/mach/debug-macro.S
@@ -62,11 +62,9 @@
 #define UART_PADDR	MXC91231_UART2_BASE_ADDR
 #define UART_VADDR	MXC91231_IO_ADDRESS(MXC91231_UART2_BASE_ADDR)
 #endif
-		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1			@ MMU enabled?
-		ldreq	\rx, =UART_PADDR	@ physical
-		ldrne	\rx, =UART_VADDR	@ virtual
+		.macro	addruart, rp, rv
+		ldr	\rp, =UART_PADDR	@ physical
+		ldr	\rv, =UART_VADDR	@ virtual
 		.endm
 
 		.macro	senduart,rd,rx
diff --git a/arch/arm/plat-spear/include/plat/debug-macro.S b/arch/arm/plat-spear/include/plat/debug-macro.S
index 37fa593..e91270e 100644
--- a/arch/arm/plat-spear/include/plat/debug-macro.S
+++ b/arch/arm/plat-spear/include/plat/debug-macro.S
@@ -14,11 +14,9 @@
 #include <linux/amba/serial.h>
 #include <mach/spear.h>
 
-		.macro	addruart, rx
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1					@ MMU enabled?
-		moveq	\rx, #SPEAR_DBG_UART_BASE		@ Physical base
-		movne	\rx, #VA_SPEAR_DBG_UART_BASE		@ Virtual base
+		.macro	addruart, rp, rv
+		mov	\rp, #SPEAR_DBG_UART_BASE		@ Physical base
+		mov	\rv, #VA_SPEAR_DBG_UART_BASE		@ Virtual base
 		.endm
 
 		.macro	senduart, rd, rx
diff --git a/arch/arm/plat-stmp3xxx/include/mach/debug-macro.S b/arch/arm/plat-stmp3xxx/include/mach/debug-macro.S
index 1b9348b..d3a0985 100644
--- a/arch/arm/plat-stmp3xxx/include/mach/debug-macro.S
+++ b/arch/arm/plat-stmp3xxx/include/mach/debug-macro.S
@@ -16,13 +16,10 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-		.macro	addruart, rx, tmp
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1			@ MMU enabled?
-		moveq	\rx, #0x80000000	@ physical base address
-		addeq	\rx, \rx, #0x00070000
-		movne	\rx, #0xf0000000	@ virtual base
-		addne	\rx, \rx, #0x00070000
+		.macro	addruart, rp, rv
+		mov	\rp,      #0x00070000
+		add	\rv, \rp, #0xf0000000	@ virtual base
+		add	\rp, \rp, #0x80000000	@ physical base
 		.endm
 
 		.macro	senduart,rd,rx
