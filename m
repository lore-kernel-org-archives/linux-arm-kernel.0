From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Mon, 1 Mar 2010 15:04:28 +0530
Subject: [PATCH 3/5] nomadik-gpio: mask/ack/unmask the parent irq
In-Reply-To: <1267436070-10631-1-git-send-email-rabin.vincent@stericsson.com>
References: <1267436070-10631-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1267436070-10631-4-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we register as a chained handler, we need to take care of acking
the parent irq.  Current code had the acking disabled because just
acking the interrupt disables it on some interrupt controllers (like the
VIC used on Nomadik).  However, not acking at all is incorrect because
interrupt controllers like the GIC need an EOI indication, which is done
in the ack routine.

Solve this by maskacking and unmasking it appropriately, similar to how
handle_level_irq operates.

Acked-by: Alessandro Rubini <rubini@unipv.it>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/plat-nomadik/gpio.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index a9ee988..4c3ea1a 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -211,21 +211,27 @@ static struct irq_chip nmk_gpio_irq_chip = {
 static void nmk_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
 	struct nmk_gpio_chip *nmk_chip;
-	struct irq_chip *host_chip;
+	struct irq_chip *host_chip = get_irq_chip(irq);
 	unsigned int gpio_irq;
 	u32 pending;
 	unsigned int first_irq;
 
+	if (host_chip->mask_ack)
+		host_chip->mask_ack(irq);
+	else {
+		host_chip->mask(irq);
+		if (host_chip->ack)
+			host_chip->ack(irq);
+	}
+
 	nmk_chip = get_irq_data(irq);
 	first_irq = NOMADIK_GPIO_TO_IRQ(nmk_chip->chip.base);
 	while ( (pending = readl(nmk_chip->addr + NMK_GPIO_IS)) ) {
 		gpio_irq = first_irq + __ffs(pending);
 		generic_handle_irq(gpio_irq);
 	}
-	if (0) {/* don't ack parent irq, as ack == disable */
-		host_chip = get_irq_chip(irq);
-		host_chip->ack(irq);
-	}
+
+	host_chip->unmask(irq);
 }
 
 static int nmk_gpio_init_irq(struct nmk_gpio_chip *nmk_chip)
-- 
1.7.0
