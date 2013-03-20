From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Mar 2013 12:41:12 +0100
Subject: [PATCH 1/8] pinctrl: sirf: convert to linear irq domain
In-Reply-To: <1363779679-16880-1-git-send-email-arnd@arndb.de>
References: <1363779679-16880-1-git-send-email-arnd@arndb.de>
Message-ID: <1363779679-16880-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sirf platforms use no hardcoded IRQ numbers, so there is no reason to
use the legacy domain, and by converting to the linear domain, we get
a more efficient representation of sparse IRQs and remove the dependency
on the mach/irqs.h header file.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-sirf.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-sirf.c b/drivers/pinctrl/pinctrl-sirf.c
index d02498b..a0bc78b 100644
--- a/drivers/pinctrl/pinctrl-sirf.c
+++ b/drivers/pinctrl/pinctrl-sirf.c
@@ -1485,7 +1485,6 @@ static void sirfsoc_gpio_handle_irq(unsigned int irq, struct irq_desc *desc)
 	struct sirfsoc_gpio_bank *bank = irq_get_handler_data(irq);
 	u32 status, ctrl;
 	int idx = 0;
-	unsigned int first_irq;
 	struct irq_chip *chip = irq_get_chip(irq);
 
 	chained_irq_enter(chip, desc);
@@ -1499,8 +1498,6 @@ static void sirfsoc_gpio_handle_irq(unsigned int irq, struct irq_desc *desc)
 		return;
 	}
 
-	first_irq = bank->domain->revmap_data.legacy.first_irq;
-
 	while (status) {
 		ctrl = readl(bank->chip.regs + SIRFSOC_GPIO_CTRL(bank->id, idx));
 
@@ -1511,7 +1508,7 @@ static void sirfsoc_gpio_handle_irq(unsigned int irq, struct irq_desc *desc)
 		if ((status & 0x1) && (ctrl & SIRFSOC_GPIO_CTL_INTR_EN_MASK)) {
 			pr_debug("%s: gpio id %d idx %d happens\n",
 				__func__, bank->id, idx);
-			generic_handle_irq(first_irq + idx);
+			generic_handle_irq(irq_find_mapping(bank->domain, idx));
 		}
 
 		idx++;
@@ -1770,9 +1767,8 @@ static int sirfsoc_gpio_probe(struct device_node *np)
 			goto out;
 		}
 
-		bank->domain = irq_domain_add_legacy(np, SIRFSOC_GPIO_BANK_SIZE,
-			SIRFSOC_GPIO_IRQ_START + i * SIRFSOC_GPIO_BANK_SIZE, 0,
-			&sirfsoc_gpio_irq_simple_ops, bank);
+		bank->domain = irq_domain_add_linear(np, SIRFSOC_GPIO_BANK_SIZE,
+						&sirfsoc_gpio_irq_simple_ops, bank);
 
 		if (!bank->domain) {
 			pr_err("%s: Failed to create irqdomain\n", np->full_name);
-- 
1.8.1.2
