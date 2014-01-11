From: 21cnbao@gmail.com (Barry Song)
Date: Sat, 11 Jan 2014 16:48:42 +0800
Subject: [PATCH 1/2] pinctrl: sirf: use only one irq_domain for the whole
 device node
Message-ID: <1389430123-8036-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

in sirfsoc gpio probe(), we create 5 irq_domains for 5 gpio banks. but
in irq_create_of_mapping() of irqchip core level, irq_find_host() can
only return the 1st irq_domain attached the pinctrl dt device node as
we can see from the codes:

unsigned int irq_create_of_mapping(struct device_node *controller,
				   const u32 *intspec, unsigned int intsize)
{
	struct irq_domain *domain;
	...
	domain = controller ? irq_find_host(controller) : irq_default_domain;
}

struct irq_domain *irq_find_host(struct device_node *node)
{
	struct irq_domain *h, *found = NULL;
	int rc;

	/* We might want to match the legacy controller last since
	 * it might potentially be set to match all interrupts in
	 * the absence of a device node. This isn't a problem so far
	 * yet though...
	 */
	mutex_lock(&irq_domain_mutex);
	list_for_each_entry(h, &irq_domain_list, link) {
		if (h->ops->match)
			rc = h->ops->match(h, node);
		else
			rc = (h->of_node != NULL) && (h->of_node == node);

		if (rc) {
			found = h;
			break;
		}
	}
	mutex_unlock(&irq_domain_mutex);
	return found;
}

for sirfsoc, the 1st irq_domain attached to the device_node(controller) only
can do linear for the 1st 32 gpios. so for devices who use gpio hwirq above
32 and put the information in dt like:
                                tangoc-ts at 5c{
                                        compatible = "pixcir,tangoc-ts";
+                                       interrupt-parent = <&gpio>;
+                                       interrupts = <34 0>;
                                };

we will fail to get the virq for these devices as hwirq will be bigger than
domain->revmap_data.linear.size in:
unsigned int irq_linear_revmap(struct irq_domain *domain,
			       irq_hw_number_t hwirq)
{

	/* Check revmap bounds; complain if exceeded */
	if (WARN_ON(hwirq >= domain->revmap_data.linear.size))
		return 0;

	return domain->revmap_data.linear.revmap[hwirq];
}

this patch drops redundant irq_domain and keep only one to fix the problem.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/pinctrl/sirf/pinctrl-sirf.c |   26 +++++++++++++++-----------
 1 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/sirf/pinctrl-sirf.c b/drivers/pinctrl/sirf/pinctrl-sirf.c
index b81e388..53a3bc5 100644
--- a/drivers/pinctrl/sirf/pinctrl-sirf.c
+++ b/drivers/pinctrl/sirf/pinctrl-sirf.c
@@ -468,7 +468,8 @@ static inline int sirfsoc_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 	struct sirfsoc_gpio_bank *bank = container_of(to_of_mm_gpio_chip(chip),
 		struct sirfsoc_gpio_bank, chip);
 
-	return irq_create_mapping(bank->domain, offset);
+	return irq_create_mapping(bank->domain, offset + bank->id *
+		SIRFSOC_GPIO_BANK_SIZE);
 }
 
 static inline int sirfsoc_gpio_to_offset(unsigned int gpio)
@@ -629,7 +630,8 @@ static void sirfsoc_gpio_handle_irq(unsigned int irq, struct irq_desc *desc)
 		if ((status & 0x1) && (ctrl & SIRFSOC_GPIO_CTL_INTR_EN_MASK)) {
 			pr_debug("%s: gpio id %d idx %d happens\n",
 				__func__, bank->id, idx);
-			generic_handle_irq(irq_find_mapping(bank->domain, idx));
+			generic_handle_irq(irq_find_mapping(bank->domain, idx +
+					bank->id * SIRFSOC_GPIO_BANK_SIZE));
 		}
 
 		idx++;
@@ -786,7 +788,7 @@ static int sirfsoc_gpio_irq_map(struct irq_domain *d, unsigned int irq,
 
 	irq_set_chip(irq, &sirfsoc_irq_chip);
 	irq_set_handler(irq, handle_level_irq);
-	irq_set_chip_data(irq, bank);
+	irq_set_chip_data(irq, bank + hwirq / SIRFSOC_GPIO_BANK_SIZE);
 	set_irq_flags(irq, IRQF_VALID);
 
 	return 0;
@@ -835,6 +837,7 @@ static int sirfsoc_gpio_probe(struct device_node *np)
 	struct sirfsoc_gpio_bank *bank;
 	void __iomem *regs;
 	struct platform_device *pdev;
+	struct irq_domain *domain;
 	bool is_marco = false;
 
 	u32 pullups[SIRFSOC_GPIO_NO_OF_BANKS], pulldowns[SIRFSOC_GPIO_NO_OF_BANKS];
@@ -850,6 +853,14 @@ static int sirfsoc_gpio_probe(struct device_node *np)
 	if (of_device_is_compatible(np, "sirf,marco-pinctrl"))
 		is_marco = 1;
 
+	domain = irq_domain_add_linear(np, SIRFSOC_GPIO_BANK_SIZE * SIRFSOC_GPIO_NO_OF_BANKS,
+		&sirfsoc_gpio_irq_simple_ops, sgpio_bank);
+	if (!domain) {
+		pr_err("%s: Failed to create irqdomain\n", np->full_name);
+			err = -ENOSYS;
+		goto out;
+	}
+
 	for (i = 0; i < SIRFSOC_GPIO_NO_OF_BANKS; i++) {
 		bank = &sgpio_bank[i];
 		spin_lock_init(&bank->lock);
@@ -882,14 +893,7 @@ static int sirfsoc_gpio_probe(struct device_node *np)
 			goto out;
 		}
 
-		bank->domain = irq_domain_add_linear(np, SIRFSOC_GPIO_BANK_SIZE,
-						&sirfsoc_gpio_irq_simple_ops, bank);
-
-		if (!bank->domain) {
-			pr_err("%s: Failed to create irqdomain\n", np->full_name);
-			err = -ENOSYS;
-			goto out;
-		}
+		bank->domain = domain;
 
 		irq_set_chained_handler(bank->parent_irq, sirfsoc_gpio_handle_irq);
 		irq_set_handler_data(bank->parent_irq, bank);
-- 
1.7.5.4
