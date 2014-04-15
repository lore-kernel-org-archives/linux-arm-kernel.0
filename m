From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 15 Apr 2014 14:43:47 +0800
Subject: [PATCH 2/4] pinctrl: sirf: switch driver to use gpiolib irqchip
 helpers
In-Reply-To: <1397544229-20545-1-git-send-email-21cnbao@gmail.com>
References: <1397544229-20545-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1397544229-20545-3-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This switches the SiRF pinctrl driver over to using the gpiolib
irqchip helpers simplifying some of the code.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 came from Linus Walleij's patch.

 drivers/pinctrl/Kconfig             |    1 +
 drivers/pinctrl/sirf/pinctrl-sirf.c |   89 ++++++++++------------------------
 2 files changed, 27 insertions(+), 63 deletions(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index e493240..ddd4e6e 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -270,6 +270,7 @@ config PINCTRL_SIRF
 	bool "CSR SiRFprimaII/SiRFmarco pin controller driver"
 	depends on ARCH_SIRF
 	select PINMUX
+	select GPIOLIB_IRQCHIP
 
 config PINCTRL_SUNXI
 	bool
diff --git a/drivers/pinctrl/sirf/pinctrl-sirf.c b/drivers/pinctrl/sirf/pinctrl-sirf.c
index cb81b15..c03dcc7 100644
--- a/drivers/pinctrl/sirf/pinctrl-sirf.c
+++ b/drivers/pinctrl/sirf/pinctrl-sirf.c
@@ -14,8 +14,6 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/err.h>
-#include <linux/irqdomain.h>
-#include <linux/irqchip/chained_irq.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
 #include <linux/pinctrl/consumer.h>
@@ -27,7 +25,6 @@
 #include <linux/bitops.h>
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
-#include <asm/mach/irq.h>
 
 #include "pinctrl-sirf.h"
 
@@ -41,7 +38,6 @@ struct sirfsoc_gpio_bank {
 
 struct sirfsoc_gpio_chip {
 	struct of_mm_gpio_chip chip;
-	struct irq_domain *domain;
 	bool is_marco; /* for marco, some registers are different with prima2 */
 	struct sirfsoc_gpio_bank sgpio_bank[SIRFSOC_GPIO_NO_OF_BANKS];
 };
@@ -450,15 +446,11 @@ static inline struct sirfsoc_gpio_bank *sirfsoc_gpio_to_bank(unsigned int gpio)
 	return &sgpio_chip.sgpio_bank[gpio / SIRFSOC_GPIO_BANK_SIZE];
 }
 
-static int sirfsoc_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
-{
-	return irq_create_mapping(sgpio_chip.domain, offset);
-}
-
 static inline int sirfsoc_gpio_to_bankoff(unsigned int gpio)
 {
 	return gpio % SIRFSOC_GPIO_BANK_SIZE;
 }
+
 static void sirfsoc_gpio_irq_ack(struct irq_data *d)
 {
 	struct sirfsoc_gpio_bank *bank = sirfsoc_gpio_to_bank(d->hwirq);
@@ -566,38 +558,28 @@ static int sirfsoc_gpio_irq_type(struct irq_data *d, unsigned type)
 	return 0;
 }
 
-static int sirfsoc_gpio_irq_reqres(struct irq_data *d)
-{
-	if (gpio_lock_as_irq(&sgpio_chip.chip.gc, d->hwirq)) {
-		dev_err(sgpio_chip.chip.gc.dev,
-			"unable to lock HW IRQ %lu for IRQ\n",
-			d->hwirq);
-		return -EINVAL;
-	}
-	return 0;
-}
-
-static void sirfsoc_gpio_irq_relres(struct irq_data *d)
-{
-	gpio_unlock_as_irq(&sgpio_chip.chip.gc, d->hwirq);
-}
-
 static struct irq_chip sirfsoc_irq_chip = {
 	.name = "sirf-gpio-irq",
 	.irq_ack = sirfsoc_gpio_irq_ack,
 	.irq_mask = sirfsoc_gpio_irq_mask,
 	.irq_unmask = sirfsoc_gpio_irq_unmask,
 	.irq_set_type = sirfsoc_gpio_irq_type,
-	.irq_request_resources = sirfsoc_gpio_irq_reqres,
-	.irq_release_resources = sirfsoc_gpio_irq_relres,
 };
 
 static void sirfsoc_gpio_handle_irq(unsigned int irq, struct irq_desc *desc)
 {
-	struct sirfsoc_gpio_bank *bank = irq_get_handler_data(irq);
+	struct sirfsoc_gpio_bank *bank;
 	u32 status, ctrl;
 	int idx = 0;
 	struct irq_chip *chip = irq_get_chip(irq);
+	int i;
+
+	for (i = 0; i < SIRFSOC_GPIO_BANK_SIZE; i++) {
+		bank = &sgpio_chip.sgpio_bank[i];
+		if (bank->parent_irq == irq)
+			break;
+	}
+	BUG_ON (i == SIRFSOC_GPIO_BANK_SIZE);
 
 	chained_irq_enter(chip, desc);
 
@@ -620,7 +602,7 @@ static void sirfsoc_gpio_handle_irq(unsigned int irq, struct irq_desc *desc)
 		if ((status & 0x1) && (ctrl & SIRFSOC_GPIO_CTL_INTR_EN_MASK)) {
 			pr_debug("%s: gpio id %d idx %d happens\n",
 				__func__, bank->id, idx);
-			generic_handle_irq(irq_find_mapping(sgpio_chip.domain, idx +
+			generic_handle_irq(irq_find_mapping(sgpio_chip.chip.gc.irqdomain, idx +
 					bank->id * SIRFSOC_GPIO_BANK_SIZE));
 		}
 
@@ -768,26 +750,6 @@ static void sirfsoc_gpio_set_value(struct gpio_chip *chip, unsigned offset,
 	spin_unlock_irqrestore(&bank->lock, flags);
 }
 
-static int sirfsoc_gpio_irq_map(struct irq_domain *d, unsigned int irq,
-				irq_hw_number_t hwirq)
-{
-	struct sirfsoc_gpio_bank *bank = d->host_data;
-
-	if (!bank)
-		return -EINVAL;
-
-	irq_set_chip(irq, &sirfsoc_irq_chip);
-	irq_set_handler(irq, handle_level_irq);
-	set_irq_flags(irq, IRQF_VALID);
-
-	return 0;
-}
-
-static const struct irq_domain_ops sirfsoc_gpio_irq_simple_ops = {
-	.map = sirfsoc_gpio_irq_map,
-	.xlate = irq_domain_xlate_twocell,
-};
-
 static void sirfsoc_gpio_set_pullup(const u32 *pullups)
 {
 	int i, n;
@@ -826,7 +788,6 @@ static int sirfsoc_gpio_probe(struct device_node *np)
 	struct sirfsoc_gpio_bank *bank;
 	void __iomem *regs;
 	struct platform_device *pdev;
-	struct irq_domain *domain;
 	bool is_marco = false;
 
 	u32 pullups[SIRFSOC_GPIO_NO_OF_BANKS], pulldowns[SIRFSOC_GPIO_NO_OF_BANKS];
@@ -842,21 +803,12 @@ static int sirfsoc_gpio_probe(struct device_node *np)
 	if (of_device_is_compatible(np, "sirf,marco-pinctrl"))
 		is_marco = 1;
 
-	domain = irq_domain_add_linear(np, SIRFSOC_GPIO_BANK_SIZE * SIRFSOC_GPIO_NO_OF_BANKS,
-		&sirfsoc_gpio_irq_simple_ops, &sgpio_chip);
-	if (!domain) {
-		pr_err("%s: Failed to create irqdomain\n", np->full_name);
-			err = -ENOSYS;
-		goto out;
-	}
-
 	sgpio_chip.chip.gc.request = sirfsoc_gpio_request;
 	sgpio_chip.chip.gc.free = sirfsoc_gpio_free;
 	sgpio_chip.chip.gc.direction_input = sirfsoc_gpio_direction_input;
 	sgpio_chip.chip.gc.get = sirfsoc_gpio_get_value;
 	sgpio_chip.chip.gc.direction_output = sirfsoc_gpio_direction_output;
 	sgpio_chip.chip.gc.set = sirfsoc_gpio_set_value;
-	sgpio_chip.chip.gc.to_irq = sirfsoc_gpio_to_irq;
 	sgpio_chip.chip.gc.base = 0;
 	sgpio_chip.chip.gc.ngpio = SIRFSOC_GPIO_BANK_SIZE * SIRFSOC_GPIO_NO_OF_BANKS;
 	sgpio_chip.chip.gc.label = kstrdup(np->full_name, GFP_KERNEL);
@@ -866,15 +818,24 @@ static int sirfsoc_gpio_probe(struct device_node *np)
 	sgpio_chip.chip.gc.dev = &pdev->dev;
 	sgpio_chip.chip.regs = regs;
 	sgpio_chip.is_marco = is_marco;
-	sgpio_chip.domain = domain;
 
 	err = gpiochip_add(&sgpio_chip.chip.gc);
 	if (err) {
-		pr_err("%s: error in probe function with status %d\n",
+		dev_err(&pdev->dev, "%s: error in probe function with status %d\n",
 			np->full_name, err);
 		goto out;
 	}
 
+	err =  gpiochip_irqchip_add(&sgpio_chip.chip.gc,
+		&sirfsoc_irq_chip,
+		0, handle_level_irq,
+		IRQ_TYPE_NONE);
+	if (err) {
+		dev_err(&pdev->dev,
+			"could not connect irqchip to gpiochip\n");
+		goto out;
+	}
+
 	for (i = 0; i < SIRFSOC_GPIO_NO_OF_BANKS; i++) {
 		bank = &sgpio_chip.sgpio_bank[i];
 		spin_lock_init(&bank->lock);
@@ -884,8 +845,10 @@ static int sirfsoc_gpio_probe(struct device_node *np)
 			goto out;
 		}
 
-		irq_set_chained_handler(bank->parent_irq, sirfsoc_gpio_handle_irq);
-		irq_set_handler_data(bank->parent_irq, bank);
+		gpiochip_set_chained_irqchip(&sgpio_chip.chip.gc,
+			&sirfsoc_irq_chip,
+			bank->parent_irq,
+			sirfsoc_gpio_handle_irq);
 	}
 
 	if (!of_property_read_u32_array(np, "sirf,pullups", pullups,
-- 
1.7.5.4
