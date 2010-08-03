From: jason77.wang@gmail.com (Jason Wang)
Date: Tue,  3 Aug 2010 11:44:18 +0800
Subject: [PATCH] omap: Fix DEBUG_LL uart to access phys addr when MMU isn't
	enable
Message-ID: <1280807058-8394-1-git-send-email-jason77.wang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now we use a memory address to store the debug port info, So we need
to read/write this address when we choose DEBUG_LL. When MMU isn't
enable(I.E. the begining part of init stage of the linux kernel boot),
we need to access physical address instead of virtual address,
otherwise the kernel will crash.

Signed-off-by: Jason Wang <jason77.wang@gmail.com>
---
 arch/arm/mach-omap1/include/mach/debug-macro.S |   10 +++++--
 arch/arm/mach-omap2/include/mach/debug-macro.S |   29 +++++++++++++++++------
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap1/include/mach/debug-macro.S b/arch/arm/mach-omap1/include/mach/debug-macro.S
index e8a8cf3..671408e 100644
--- a/arch/arm/mach-omap1/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap1/include/mach/debug-macro.S
@@ -33,7 +33,7 @@ omap_uart_virt:	.word	0x0
 		/* Use omap_uart_phys/virt if already configured */
 9:		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
-		ldreq	\rx, =omap_uart_phys	@ physical base address
+		ldreq	\rx, =__virt_to_phys(omap_uart_phys)	@ physical base address
 		ldrne	\rx, =omap_uart_virt	@ virtual base
 		ldr	\rx, [\rx, #0]
 		cmp	\rx, #0			@ is port configured?
@@ -68,11 +68,15 @@ omap_uart_virt:	.word	0x0
 
 		/* Store both phys and virt address for the uart */
 98:		add	\rx, \rx, #0xff000000	@ phys base
-		ldr	\tmp, =omap_uart_phys
+		mrc	p15, 0, \tmp, c1, c0
+		tst	\tmp, #1		@ MMU enabled?
+		ldreq	\tmp, =__virt_to_phys(omap_uart_phys)
+		ldrne	\tmp, =omap_uart_phys
 		str	\rx, [\tmp, #0]
 		sub	\rx, \rx, #0xff000000	@ phys base
 		add	\rx, \rx, #0xfe000000	@ virt base
-		ldr	\tmp, =omap_uart_virt
+		ldreq	\tmp, =__virt_to_phys(omap_uart_virt)
+		ldrne	\tmp, =omap_uart_virt
 		str	\rx, [\tmp, #0]
 		b	9b
 99:
diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S b/arch/arm/mach-omap2/include/mach/debug-macro.S
index 35b2440..09331bb 100644
--- a/arch/arm/mach-omap2/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
@@ -36,7 +36,7 @@ omap_uart_lsr:	.word	0
 		/* Use omap_uart_phys/virt if already configured */
 10:		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
-		ldreq	\rx, =omap_uart_phys	@ physical base address
+		ldreq	\rx, =__virt_to_phys(omap_uart_phys)	@ physical base address
 		ldrne	\rx, =omap_uart_virt	@ virtual base address
 		ldr	\rx, [\rx, #0]
 		cmp	\rx, #0			@ is port configured?
@@ -89,26 +89,36 @@ omap_uart_lsr:	.word	0
 44:		mov	\rx, #UART_OFFSET(OMAP4_UART4_BASE)
 		b	98f
 95:		ldr	\rx, =ZOOM_UART_BASE
-		ldr	\tmp, =omap_uart_phys
+		mrc	p15, 0, \tmp, c1, c0
+		tst	\tmp, #1		@ MMU enabled?
+		ldreq	\tmp, =__virt_to_phys(omap_uart_phys)
+		ldrne	\tmp, =omap_uart_phys
 		str	\rx, [\tmp, #0]
 		ldr	\rx, =ZOOM_UART_VIRT
-		ldr	\tmp, =omap_uart_virt
+		ldreq	\tmp, =__virt_to_phys(omap_uart_virt)
+		ldrne	\tmp, =omap_uart_virt
 		str	\rx, [\tmp, #0]
 		mov	\rx, #(UART_LSR << ZOOM_PORT_SHIFT)
-		ldr	\tmp, =omap_uart_lsr
+		ldreq	\tmp, =__virt_to_phys(omap_uart_lsr)
+		ldrne	\tmp, =omap_uart_lsr
 		str	\rx, [\tmp, #0]
 		b	10b
 
 		/* Store both phys and virt address for the uart */
 98:		add	\rx, \rx, #0x48000000	@ phys base
-		ldr	\tmp, =omap_uart_phys
+		mrc	p15, 0, \tmp, c1, c0
+		tst	\tmp, #1		@ MMU enabled?
+		ldreq	\tmp, =__virt_to_phys(omap_uart_phys)
+		ldrne	\tmp, =omap_uart_phys
 		str	\rx, [\tmp, #0]
 		sub	\rx, \rx, #0x48000000	@ phys base
 		add	\rx, \rx, #0xfa000000	@ virt base
-		ldr	\tmp, =omap_uart_virt
+		ldreq	\tmp, =__virt_to_phys(omap_uart_virt)
+		ldrne	\tmp, =omap_uart_virt
 		str	\rx, [\tmp, #0]
 		mov	\rx, #(UART_LSR << OMAP_PORT_SHIFT)
-		ldr	\tmp, =omap_uart_lsr
+		ldreq	\tmp, =__virt_to_phys(omap_uart_lsr)
+		ldrne	\tmp, =omap_uart_lsr
 		str	\rx, [\tmp, #0]
 
 		b	10b
@@ -120,7 +130,10 @@ omap_uart_lsr:	.word	0
 		.endm
 
 		.macro	busyuart,rd,rx
-1001:		ldr	\rd, =omap_uart_lsr
+1001:		mrc	p15, 0, \rd, c1, c0
+		tst	\rd, #1		@ MMU enabled?
+		ldreq	\rd, =__virt_to_phys(omap_uart_lsr)
+		ldrne	\rd, =omap_uart_lsr
 		ldr	\rd, [\rd, #0]
 		ldrb	\rd, [\rx, \rd]
 		and	\rd, \rd, #(UART_LSR_TEMT | UART_LSR_THRE)
-- 
1.5.6.5
