From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 21 Jan 2014 16:55:18 +0100
Subject: [PATCH] pinctrl: at91: use locked variant of irq_set_handler
Message-ID: <1390319718-12285-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When setting the gpio irq type, use the __irq_set_handler_locked()
variant instead of the irq_set_handler() to prevent false
spinlock recursion warning.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: stable <stable@vger.kernel.org> # v3.12
---
 drivers/pinctrl/pinctrl-at91.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index a7549c4c83b4..7d7a21c20931 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1260,22 +1260,22 @@ static int alt_gpio_irq_type(struct irq_data *d, unsigned type)
 
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
-		irq_set_handler(d->irq, handle_simple_irq);
+		__irq_set_handler_locked(d->irq, handle_simple_irq);
 		writel_relaxed(mask, pio + PIO_ESR);
 		writel_relaxed(mask, pio + PIO_REHLSR);
 		break;
 	case IRQ_TYPE_EDGE_FALLING:
-		irq_set_handler(d->irq, handle_simple_irq);
+		__irq_set_handler_locked(d->irq, handle_simple_irq);
 		writel_relaxed(mask, pio + PIO_ESR);
 		writel_relaxed(mask, pio + PIO_FELLSR);
 		break;
 	case IRQ_TYPE_LEVEL_LOW:
-		irq_set_handler(d->irq, handle_level_irq);
+		__irq_set_handler_locked(d->irq, handle_level_irq);
 		writel_relaxed(mask, pio + PIO_LSR);
 		writel_relaxed(mask, pio + PIO_FELLSR);
 		break;
 	case IRQ_TYPE_LEVEL_HIGH:
-		irq_set_handler(d->irq, handle_level_irq);
+		__irq_set_handler_locked(d->irq, handle_level_irq);
 		writel_relaxed(mask, pio + PIO_LSR);
 		writel_relaxed(mask, pio + PIO_REHLSR);
 		break;
@@ -1284,7 +1284,7 @@ static int alt_gpio_irq_type(struct irq_data *d, unsigned type)
 		 * disable additional interrupt modes:
 		 * fall back to default behavior
 		 */
-		irq_set_handler(d->irq, handle_simple_irq);
+		__irq_set_handler_locked(d->irq, handle_simple_irq);
 		writel_relaxed(mask, pio + PIO_AIMDR);
 		return 0;
 	case IRQ_TYPE_NONE:
-- 
1.8.2.2
