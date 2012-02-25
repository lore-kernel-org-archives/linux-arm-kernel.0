From: stigge@antcom.de (Roland Stigge)
Date: Sat, 25 Feb 2012 16:35:15 +0100
Subject: [PATCH v2 3/6] ARM: LPC32xx: Fix interrupt controller init
In-Reply-To: <1330184118-10270-1-git-send-email-stigge@antcom.de>
References: <1330184118-10270-1-git-send-email-stigge@antcom.de>
Message-ID: <1330184118-10270-4-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the initialization of the interrupt controller of the LPC32xx
by correctly setting up SIC1 and SIC2 instead of (wrongly) using the same value
as for the Main Interrupt Controller (MIC).

Signed-off-by: Roland Stigge <stigge@antcom.de>

---
 arch/arm/mach-lpc32xx/irq.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- linux-2.6.orig/arch/arm/mach-lpc32xx/irq.c
+++ linux-2.6/arch/arm/mach-lpc32xx/irq.c
@@ -384,13 +384,15 @@ void __init lpc32xx_init_irq(void)
 
 	/* Setup SIC1 */
 	__raw_writel(0, LPC32XX_INTC_MASK(LPC32XX_SIC1_BASE));
-	__raw_writel(MIC_APR_DEFAULT, LPC32XX_INTC_POLAR(LPC32XX_SIC1_BASE));
-	__raw_writel(MIC_ATR_DEFAULT, LPC32XX_INTC_ACT_TYPE(LPC32XX_SIC1_BASE));
+	__raw_writel(SIC1_APR_DEFAULT, LPC32XX_INTC_POLAR(LPC32XX_SIC1_BASE));
+	__raw_writel(SIC1_ATR_DEFAULT,
+				LPC32XX_INTC_ACT_TYPE(LPC32XX_SIC1_BASE));
 
 	/* Setup SIC2 */
 	__raw_writel(0, LPC32XX_INTC_MASK(LPC32XX_SIC2_BASE));
-	__raw_writel(MIC_APR_DEFAULT, LPC32XX_INTC_POLAR(LPC32XX_SIC2_BASE));
-	__raw_writel(MIC_ATR_DEFAULT, LPC32XX_INTC_ACT_TYPE(LPC32XX_SIC2_BASE));
+	__raw_writel(SIC2_APR_DEFAULT, LPC32XX_INTC_POLAR(LPC32XX_SIC2_BASE));
+	__raw_writel(SIC2_ATR_DEFAULT,
+				LPC32XX_INTC_ACT_TYPE(LPC32XX_SIC2_BASE));
 
 	/* Configure supported IRQ's */
 	for (i = 0; i < NR_IRQS; i++) {
