From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 12 Nov 2013 14:48:37 +0100
Subject: [PATCH 6/7] ARM: sa1100: rewrite the high GPIO IRQ handler
Message-ID: <1384264117-6396-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simplify the handler for the high IRQs and follow the pattern
of the ordinary "normal" IRQ handler.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-sa1100/irq.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
index 5463ba521ac7..a6823f3281e2 100644
--- a/arch/arm/mach-sa1100/irq.c
+++ b/arch/arm/mach-sa1100/irq.c
@@ -106,34 +106,23 @@ static int sa1100_low_gpio_wake(struct irq_data *d, unsigned int on)
 }
 
 /*
- * IRQ11 (GPIO11 through 27) handler.  We enter here with the
- * irq_controller_lock held, and IRQs disabled.  Decode the IRQ
+ * High GPIO on IRQ11 (GPIO11 through 27) handler. We enter here with
+ * the irq_controller_lock held, and IRQs disabled. Decode the IRQ
  * and call the handler.
  */
 static void
 sa1100_high_gpio_handler(unsigned int irq, struct irq_desc *desc)
 {
-	unsigned int mask;
-
-	mask = GEDR & 0xfffff800;
-	do {
-		/*
-		 * clear down all currently active IRQ sources.
-		 * We will be processing them all.
-		 */
-		GEDR = mask;
-
-		irq = IRQ_GPIO11;
-		mask >>= 11;
-		do {
-			if (mask & 1)
-				generic_handle_irq(irq);
-			mask >>= 1;
-			irq++;
-		} while (mask);
-
-		mask = GEDR & 0xfffff800;
-	} while (mask);
+	struct irq_data *data = irq_desc_get_irq_data(desc);
+	struct sa1100_sc *sc = irq_data_get_irq_chip_data(data);
+	int hwirq;
+	u32 status;
+
+	/* We're only interested in GPIOs 11 and upward */
+	while ((status = (GEDR & 0xfffff800))) {
+		hwirq = ffs(status) - 1;
+		generic_handle_irq(irq_find_mapping(sc->high_domain, hwirq));
+	}
 }
 
 /*
-- 
1.8.3.1
