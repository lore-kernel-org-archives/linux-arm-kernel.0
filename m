From: stigge@antcom.de (Roland Stigge)
Date: Sun, 28 Oct 2012 21:35:20 +0100
Subject: [PATCH 1/3] ARM: LPC32xx: Remove superfluous irq_alloc_descs()
Message-ID: <1351456522-22309-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes the call to irq_alloc_descs() which always returns an error
since the descriptors are always preallocated already.

Signed-off-by: Roland Stigge <stigge@antcom.de>
---
 arch/arm/mach-lpc32xx/irq.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

--- linux-2.6.orig/arch/arm/mach-lpc32xx/irq.c
+++ linux-2.6/arch/arm/mach-lpc32xx/irq.c
@@ -412,7 +412,6 @@ static const struct of_device_id mic_of_
 void __init lpc32xx_init_irq(void)
 {
 	unsigned int i;
-	int irq_base;
 
 	/* Setup MIC */
 	__raw_writel(0, LPC32XX_INTC_MASK(LPC32XX_MIC_BASE));
@@ -475,15 +474,8 @@ void __init lpc32xx_init_irq(void)
 
 	of_irq_init(mic_of_match);
 
-	irq_base = irq_alloc_descs(-1, 0, NR_IRQS, 0);
-	if (irq_base < 0) {
-		pr_warn("Cannot allocate irq_descs, assuming pre-allocated\n");
-		irq_base = 0;
-	}
-
 	lpc32xx_mic_domain = irq_domain_add_legacy(lpc32xx_mic_np, NR_IRQS,
-						   irq_base, 0,
-						   &irq_domain_simple_ops,
+						   0, 0, &irq_domain_simple_ops,
 						   NULL);
 	if (!lpc32xx_mic_domain)
 		panic("Unable to add MIC irq domain\n");
