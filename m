From: stigge@antcom.de (Roland Stigge)
Date: Sun, 28 Oct 2012 21:35:22 +0100
Subject: [PATCH 3/3] ARM: LPC32xx: Cleanup irq.c
In-Reply-To: <1351456522-22309-1-git-send-email-stigge@antcom.de>
References: <1351456522-22309-1-git-send-email-stigge@antcom.de>
Message-ID: <1351456522-22309-3-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes the IRQ mask initialization which is already done some lines
above.

This was actually a bug: The init was supposed to set the bits for the
(chained) SUB IRQs. But this is already fixed by the previous patch, doing this
implicitely via irq_set_chained_handler().

Signed-off-by: Roland Stigge <stigge@antcom.de>
---
 arch/arm/mach-lpc32xx/irq.c |    5 -----
 1 file changed, 5 deletions(-)

--- linux-2.6.orig/arch/arm/mach-lpc32xx/irq.c
+++ linux-2.6/arch/arm/mach-lpc32xx/irq.c
@@ -442,11 +442,6 @@ void __init lpc32xx_init_irq(void)
 	lpc32xx_set_default_mappings(SIC1_APR_DEFAULT, SIC1_ATR_DEFAULT, 32);
 	lpc32xx_set_default_mappings(SIC2_APR_DEFAULT, SIC2_ATR_DEFAULT, 64);
 
-	/* mask all interrupts except SUBIRQ */
-	__raw_writel(0, LPC32XX_INTC_MASK(LPC32XX_MIC_BASE));
-	__raw_writel(0, LPC32XX_INTC_MASK(LPC32XX_SIC1_BASE));
-	__raw_writel(0, LPC32XX_INTC_MASK(LPC32XX_SIC2_BASE));
-
 	/* Initially disable all wake events */
 	__raw_writel(0, LPC32XX_CLKPWR_P01_ER);
 	__raw_writel(0, LPC32XX_CLKPWR_INT_ER);
