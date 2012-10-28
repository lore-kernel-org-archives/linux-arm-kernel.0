From: stigge@antcom.de (Roland Stigge)
Date: Sun, 28 Oct 2012 21:35:21 +0100
Subject: [PATCH 2/3] ARM: LPC32xx: Relocate calls to irq_set_chained_handler()
In-Reply-To: <1351456522-22309-1-git-send-email-stigge@antcom.de>
References: <1351456522-22309-1-git-send-email-stigge@antcom.de>
Message-ID: <1351456522-22309-2-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the issue of an access to a yet uninitialized data structure
at the point where irq_set_chained_handler() was called by moving the
respective calls to the end of lpc32xx_init_irq().

The call path was:

irq_set_chained_handler()
-> __irq_set_handler()
-> irq_startup()
-> irq_enable()
-> desc->irq_data.chip->irq_unmask()

at which point lpc32xx_unmask_irq() effectively read desc->irq_data.hwirq which
was only later initialized.

Signed-off-by: Roland Stigge <stigge@antcom.de>
---
 arch/arm/mach-lpc32xx/irq.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.orig/arch/arm/mach-lpc32xx/irq.c
+++ linux-2.6/arch/arm/mach-lpc32xx/irq.c
@@ -447,10 +447,6 @@ void __init lpc32xx_init_irq(void)
 	__raw_writel(0, LPC32XX_INTC_MASK(LPC32XX_SIC1_BASE));
 	__raw_writel(0, LPC32XX_INTC_MASK(LPC32XX_SIC2_BASE));
 
-	/* MIC SUBIRQx interrupts will route handling to the chain handlers */
-	irq_set_chained_handler(IRQ_LPC32XX_SUB1IRQ, lpc32xx_sic1_handler);
-	irq_set_chained_handler(IRQ_LPC32XX_SUB2IRQ, lpc32xx_sic2_handler);
-
 	/* Initially disable all wake events */
 	__raw_writel(0, LPC32XX_CLKPWR_P01_ER);
 	__raw_writel(0, LPC32XX_CLKPWR_INT_ER);
@@ -479,4 +475,8 @@ void __init lpc32xx_init_irq(void)
 						   NULL);
 	if (!lpc32xx_mic_domain)
 		panic("Unable to add MIC irq domain\n");
+
+	/* MIC SUBIRQx interrupts will route handling to the chain handlers */
+	irq_set_chained_handler(IRQ_LPC32XX_SUB1IRQ, lpc32xx_sic1_handler);
+	irq_set_chained_handler(IRQ_LPC32XX_SUB2IRQ, lpc32xx_sic2_handler);
 }
