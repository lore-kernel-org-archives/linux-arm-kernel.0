From: khilman@ti.com (Kevin Hilman)
Date: Tue, 19 Apr 2011 17:06:23 -0700
Subject: [PATCH] davinci: fix DEBUG_LL code for p2v changes
Message-ID: <1303257983-24546-1-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixup davinci UART low-level debug code for new ARM generic p2v changes.

Based on OMAP changes by Tony Lindgren

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-davinci/include/mach/debug-macro.S |   13 ++++++++-----
 arch/arm/mach-davinci/include/mach/serial.h      |    2 +-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/debug-macro.S b/arch/arm/mach-davinci/include/mach/debug-macro.S
index 9f1befc..f8b7ea4 100644
--- a/arch/arm/mach-davinci/include/mach/debug-macro.S
+++ b/arch/arm/mach-davinci/include/mach/debug-macro.S
@@ -24,6 +24,9 @@
 
 #define UART_SHIFT	2
 
+#define davinci_uart_v2p(x)	((x) - PAGE_OFFSET + PLAT_PHYS_OFFSET)
+#define davinci_uart_p2v(x)	((x) - PLAT_PHYS_OFFSET + PAGE_OFFSET)
+
 		.pushsection .data
 davinci_uart_phys:	.word	0
 davinci_uart_virt:	.word	0
@@ -34,7 +37,7 @@ davinci_uart_virt:	.word	0
 		/* Use davinci_uart_phys/virt if already configured */
 10:		mrc	p15, 0, \rp, c1, c0
 		tst	\rp, #1			@ MMU enabled?
-		ldreq	\rp, =__virt_to_phys(davinci_uart_phys)
+		ldreq	\rp, =davinci_uart_v2p(davinci_uart_phys)
 		ldrne	\rp, =davinci_uart_phys
 		add	\rv, \rp, #4		@ davinci_uart_virt
 		ldr	\rp, [\rp, #0]
@@ -48,18 +51,18 @@ davinci_uart_virt:	.word	0
 		tst	\rp, #1			@ MMU enabled?
 
 		/* Copy uart phys address from decompressor uart info */
-		ldreq	\rv, =__virt_to_phys(davinci_uart_phys)
+		ldreq	\rv, =davinci_uart_v2p(davinci_uart_phys)
 		ldrne	\rv, =davinci_uart_phys
 		ldreq	\rp, =DAVINCI_UART_INFO
-		ldrne	\rp, =__phys_to_virt(DAVINCI_UART_INFO)
+		ldrne	\rp, =davinci_uart_p2v(DAVINCI_UART_INFO)
 		ldr	\rp, [\rp, #0]
 		str	\rp, [\rv]
 
 		/* Copy uart virt address from decompressor uart info */
-		ldreq	\rv, =__virt_to_phys(davinci_uart_virt)
+		ldreq	\rv, =davinci_uart_v2p(davinci_uart_virt)
 		ldrne	\rv, =davinci_uart_virt
 		ldreq	\rp, =DAVINCI_UART_INFO
-		ldrne	\rp, =__phys_to_virt(DAVINCI_UART_INFO)
+		ldrne	\rp, =davinci_uart_p2v(DAVINCI_UART_INFO)
 		ldr	\rp, [\rp, #4]
 		str	\rp, [\rv]
 
diff --git a/arch/arm/mach-davinci/include/mach/serial.h b/arch/arm/mach-davinci/include/mach/serial.h
index 8051110..c9e6ce1 100644
--- a/arch/arm/mach-davinci/include/mach/serial.h
+++ b/arch/arm/mach-davinci/include/mach/serial.h
@@ -22,7 +22,7 @@
  *
  * This area sits just below the page tables (see arch/arm/kernel/head.S).
  */
-#define DAVINCI_UART_INFO	(PHYS_OFFSET + 0x3ff8)
+#define DAVINCI_UART_INFO	(PLAT_PHYS_OFFSET + 0x3ff8)
 
 #define DAVINCI_UART0_BASE	(IO_PHYS + 0x20000)
 #define DAVINCI_UART1_BASE	(IO_PHYS + 0x20400)
-- 
1.7.4
