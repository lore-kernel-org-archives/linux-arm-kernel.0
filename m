From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 May 2016 10:35:36 +0200
Subject: [PATCH] ARM: lpc32xx: fix NR_IRQS confict
Message-ID: <1463646968-1047336-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the change to sparse IRQs, the lpc32xx platform gets a warning about
conflicting macros:

In file included from arch/arm/mach-lpc32xx/irq.c:31:0:
arch/arm/mach-lpc32xx/include/mach/irqs.h:115:0: warning: "NR_IRQS" redefined
 #define NR_IRQS    96
arch/arm/include/asm/irq.h:9:0: note: this is the location of the previous definition
 #define NR_IRQS NR_IRQS_LEGACY

In the irq controller driver, we surely need the local number instead of
the generic NR_IRQS definition, so I'm renaming that one to LPC32XX_NR_IRQS.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 8cb17b5ed017 ("irqchip: Add LPC32xx interrupt controller driver")
---
 arch/arm/mach-lpc32xx/include/mach/irqs.h | 2 +-
 arch/arm/mach-lpc32xx/irq.c               | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/include/mach/irqs.h b/arch/arm/mach-lpc32xx/include/mach/irqs.h
index 9e3b90df32e1..00190535df90 100644
--- a/arch/arm/mach-lpc32xx/include/mach/irqs.h
+++ b/arch/arm/mach-lpc32xx/include/mach/irqs.h
@@ -112,6 +112,6 @@
 #define IRQ_LPC32XX_GPI_06		LPC32XX_SIC2_IRQ(28)
 #define IRQ_LPC32XX_SYSCLK		LPC32XX_SIC2_IRQ(31)
 
-#define NR_IRQS				96
+#define LPC32XX_NR_IRQS			96
 
 #endif
diff --git a/arch/arm/mach-lpc32xx/irq.c b/arch/arm/mach-lpc32xx/irq.c
index 2ae431e8bc1b..e30f5e6b8573 100644
--- a/arch/arm/mach-lpc32xx/irq.c
+++ b/arch/arm/mach-lpc32xx/irq.c
@@ -81,7 +81,7 @@ struct lpc32xx_event_info {
 /*
  * Maps an IRQ number to and event mask and register
  */
-static const struct lpc32xx_event_info lpc32xx_events[NR_IRQS] = {
+static const struct lpc32xx_event_info lpc32xx_events[LPC32XX_NR_IRQS] = {
 	[IRQ_LPC32XX_GPI_08] = {
 		.event_group = &lpc32xx_event_pin_regs,
 		.mask = LPC32XX_CLKPWR_EXTSRC_GPI_08_BIT,
@@ -431,7 +431,7 @@ void __init lpc32xx_init_irq(void)
 				LPC32XX_INTC_ACT_TYPE(LPC32XX_SIC2_BASE));
 
 	/* Configure supported IRQ's */
-	for (i = 0; i < NR_IRQS; i++) {
+	for (i = 0; i < LPC32XX_NR_IRQS; i++) {
 		irq_set_chip_and_handler(i, &lpc32xx_irq_chip,
 					 handle_level_irq);
 		irq_clear_status_flags(i, IRQ_NOREQUEST);
@@ -465,7 +465,7 @@ void __init lpc32xx_init_irq(void)
 
 	of_irq_init(mic_of_match);
 
-	lpc32xx_mic_domain = irq_domain_add_legacy(lpc32xx_mic_np, NR_IRQS,
+	lpc32xx_mic_domain = irq_domain_add_legacy(lpc32xx_mic_np, LPC32XX_NR_IRQS,
 						   0, 0, &irq_domain_simple_ops,
 						   NULL);
 	if (!lpc32xx_mic_domain)
-- 
2.7.0
