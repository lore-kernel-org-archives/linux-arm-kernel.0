From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 12 Mar 2017 00:14:29 +0100
Subject: [PATCH 3/4] irqchip: faraday: fix the trigger types
Message-ID: <20170311231429.15961-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The triggers in the driver were right for high level triggered
IRQs but the edge detection on edge triggered IRQs was wrong.
After studying a proper driver from Po-Yu Chuang I now know how
to handle these right, and we can properly implement low level
IRQs as well.

The device trees for the Gemini had polarity switched around
so these have been fixed to conform to the right polarity as
well.

Greentime Hu <green.hu@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/irqchip/irq-ftintc010.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-ftintc010.c b/drivers/irqchip/irq-ftintc010.c
index 48982a421549..8c52450b5075 100644
--- a/drivers/irqchip/irq-ftintc010.c
+++ b/drivers/irqchip/irq-ftintc010.c
@@ -26,7 +26,9 @@
 #define FT010_IRQ_SOURCE(base_addr)	(base_addr + 0x00)
 #define FT010_IRQ_MASK(base_addr)	(base_addr + 0x04)
 #define FT010_IRQ_CLEAR(base_addr)	(base_addr + 0x08)
+/* Selects level- or edge-triggered */
 #define FT010_IRQ_MODE(base_addr)	(base_addr + 0x0C)
+/* Selects active low/high or falling/rising edge */
 #define FT010_IRQ_POLARITY(base_addr)	(base_addr + 0x10)
 #define FT010_IRQ_STATUS(base_addr)	(base_addr + 0x14)
 #define FT010_FIQ_SOURCE(base_addr)	(base_addr + 0x20)
@@ -84,22 +86,25 @@ static int ft010_irq_set_type(struct irq_data *d, unsigned int trigger)
 	mode = readl(FT010_IRQ_MODE(f->base));
 	polarity = readl(FT010_IRQ_POLARITY(f->base));
 
-	if (trigger & (IRQ_TYPE_LEVEL_HIGH)) {
+	if (trigger & (IRQ_TYPE_LEVEL_LOW)) {
+		irq_set_handler_locked(d, handle_level_irq);
+		mode &= ~BIT(offset);
+		polarity |= BIT(offset);
+	} else if (trigger & (IRQ_TYPE_LEVEL_HIGH)) {
 		irq_set_handler_locked(d, handle_level_irq);
-		/* Disable edge detection */
 		mode &= ~BIT(offset);
 		polarity &= ~BIT(offset);
-	} else if (trigger & IRQ_TYPE_EDGE_RISING) {
+	} else if (trigger & IRQ_TYPE_EDGE_FALLING) {
 		irq_set_handler_locked(d, handle_edge_irq);
 		mode |= BIT(offset);
 		polarity |= BIT(offset);
-	} else if (trigger & IRQ_TYPE_EDGE_FALLING) {
+	} else if (trigger & IRQ_TYPE_EDGE_RISING) {
 		irq_set_handler_locked(d, handle_edge_irq);
 		mode |= BIT(offset);
 		polarity &= ~BIT(offset);
 	} else {
 		irq_set_handler_locked(d, handle_bad_irq);
-		pr_warn("GEMINI IRQ: no supported trigger selected for line %d\n",
+		pr_warn("Faraday IRQ: no supported trigger selected for line %d\n",
 			offset);
 	}
 
-- 
2.9.3
