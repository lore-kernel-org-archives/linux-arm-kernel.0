From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 22 Nov 2015 22:40:03 -0500 (EST)
Subject: ARM: mach-dove: fix legacy get_irqnr_and_base
Message-ID: <alpine.LFD.2.20.1511222234010.22569@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 5d6bed2a9c ("ARM: dove: fix legacy dove IRQ numbers") shifted
IRQ numbers by one but didn't update the get_irqnr_and_base macro
accordingly.  This macro is involved when CONFIG_MULTI_IRQ_HANDLER
is not defined.

Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/arch/arm/mach-dove/include/mach/entry-macro.S b/arch/arm/mach-dove/include/mach/entry-macro.S
index 72d622baaa..df1d44bdc3 100644
--- a/arch/arm/mach-dove/include/mach/entry-macro.S
+++ b/arch/arm/mach-dove/include/mach/entry-macro.S
@@ -18,13 +18,13 @@
 	@ check low interrupts
 	ldr	\irqstat, [\base, #IRQ_CAUSE_LOW_OFF]
 	ldr	\tmp, [\base, #IRQ_MASK_LOW_OFF]
-	mov	\irqnr, #31
+	mov	\irqnr, #32
 	ands	\irqstat, \irqstat, \tmp
 
 	@ if no low interrupts set, check high interrupts
 	ldreq	\irqstat, [\base, #IRQ_CAUSE_HIGH_OFF]
 	ldreq	\tmp, [\base, #IRQ_MASK_HIGH_OFF]
-	moveq	\irqnr, #63
+	moveq	\irqnr, #64
 	andeqs	\irqstat, \irqstat, \tmp
 
 	@ find first active interrupt source
