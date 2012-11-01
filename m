From: alban.bedel@avionic-design.de (Alban Bedel)
Date: Thu,  1 Nov 2012 13:23:46 +0100
Subject: [PATCH] lpc32xx: irq - Set the chain handlers after setting up the
 IRQ domain
Message-ID: <1351772626-12615-1-git-send-email-alban.bedel@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alban Bedel <alban.bedel@avionic-design.de>
---
 arch/arm/mach-lpc32xx/irq.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/irq.c b/arch/arm/mach-lpc32xx/irq.c
index 3c63327..b92dc25 100644
--- a/arch/arm/mach-lpc32xx/irq.c
+++ b/arch/arm/mach-lpc32xx/irq.c
@@ -448,10 +448,6 @@ void __init lpc32xx_init_irq(void)
 	__raw_writel(0, LPC32XX_INTC_MASK(LPC32XX_SIC1_BASE));
 	__raw_writel(0, LPC32XX_INTC_MASK(LPC32XX_SIC2_BASE));
 
-	/* MIC SUBIRQx interrupts will route handling to the chain handlers */
-	irq_set_chained_handler(IRQ_LPC32XX_SUB1IRQ, lpc32xx_sic1_handler);
-	irq_set_chained_handler(IRQ_LPC32XX_SUB2IRQ, lpc32xx_sic2_handler);
-
 	/* Initially disable all wake events */
 	__raw_writel(0, LPC32XX_CLKPWR_P01_ER);
 	__raw_writel(0, LPC32XX_CLKPWR_INT_ER);
@@ -485,6 +481,12 @@ void __init lpc32xx_init_irq(void)
 						   irq_base, 0,
 						   &irq_domain_simple_ops,
 						   NULL);
-	if (!lpc32xx_mic_domain)
+	if (!lpc32xx_mic_domain) {
 		panic("Unable to add MIC irq domain\n");
+		return;
+	}
+
+	/* MIC SUBIRQx interrupts will route handling to the chain handlers */
+	irq_set_chained_handler(IRQ_LPC32XX_SUB1IRQ, lpc32xx_sic1_handler);
+	irq_set_chained_handler(IRQ_LPC32XX_SUB2IRQ, lpc32xx_sic2_handler);
 }
-- 
1.7.0.4
