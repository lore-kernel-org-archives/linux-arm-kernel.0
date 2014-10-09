From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Thu, 09 Oct 2014 19:24:30 +0530
Subject: [PATCH v5 2/6] pinctrl: exynos: Consolidate irq domain callbacks
In-Reply-To: <1412862874-9335-1-git-send-email-a.kesavan@samsung.com>
References: <1412862874-9335-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1412862874-9335-3-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding a irq_chip field to the samsung_pin_bank struct helps in
consolidating the irq domain callbacks for external gpio and wakeup
interrupt controllers. The exynos_wkup_irqd_ops and exynos_gpio_irqd_ops
have now been merged into a single exynos_eint_irqd_ops.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Reviewed-by: Thomas Abraham <thomas.ab@samsung.com>
Tested-by: Thomas Abraham <thomas.ab@samsung.com>
Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/samsung/pinctrl-exynos.c |   32 ++++++------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 0cca117..f7ac9c7 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -254,7 +254,7 @@ static struct exynos_irq_chip exynos_gpio_irq_chip = {
 	.eint_pend = EXYNOS_GPIO_EPEND_OFFSET,
 };
 
-static int exynos_gpio_irq_map(struct irq_domain *h, unsigned int virq,
+static int exynos_eint_irq_map(struct irq_domain *h, unsigned int virq,
 					irq_hw_number_t hw)
 {
 	struct samsung_pin_bank *b = h->host_data;
@@ -267,10 +267,10 @@ static int exynos_gpio_irq_map(struct irq_domain *h, unsigned int virq,
 }
 
 /*
- * irq domain callbacks for external gpio interrupt controller.
+ * irq domain callbacks for external gpio and wakeup interrupt controllers.
  */
-static const struct irq_domain_ops exynos_gpio_irqd_ops = {
-	.map	= exynos_gpio_irq_map,
+static const struct irq_domain_ops exynos_eint_irqd_ops = {
+	.map	= exynos_eint_irq_map,
 	.xlate	= irq_domain_xlate_twocell,
 };
 
@@ -329,7 +329,7 @@ static int exynos_eint_gpio_init(struct samsung_pinctrl_drv_data *d)
 		if (bank->eint_type != EINT_TYPE_GPIO)
 			continue;
 		bank->irq_domain = irq_domain_add_linear(bank->of_node,
-				bank->nr_pins, &exynos_gpio_irqd_ops, bank);
+				bank->nr_pins, &exynos_eint_irqd_ops, bank);
 		if (!bank->irq_domain) {
 			dev_err(dev, "gpio irq domain add failed\n");
 			ret = -ENXIO;
@@ -456,26 +456,6 @@ static void exynos_irq_demux_eint16_31(unsigned int irq, struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static int exynos_wkup_irq_map(struct irq_domain *h, unsigned int virq,
-					irq_hw_number_t hw)
-{
-	struct samsung_pin_bank *b = h->host_data;
-
-	irq_set_chip_and_handler(virq, &b->irq_chip->chip,
-					handle_level_irq);
-	irq_set_chip_data(virq, h->host_data);
-	set_irq_flags(virq, IRQF_VALID);
-	return 0;
-}
-
-/*
- * irq domain callbacks for external wakeup interrupt controller.
- */
-static const struct irq_domain_ops exynos_wkup_irqd_ops = {
-	.map	= exynos_wkup_irq_map,
-	.xlate	= irq_domain_xlate_twocell,
-};
-
 /*
  * exynos_eint_wkup_init() - setup handling of external wakeup interrupts.
  * @d: driver data of samsung pinctrl driver.
@@ -507,7 +487,7 @@ static int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
 			continue;
 
 		bank->irq_domain = irq_domain_add_linear(bank->of_node,
-				bank->nr_pins, &exynos_wkup_irqd_ops, bank);
+				bank->nr_pins, &exynos_eint_irqd_ops, bank);
 		if (!bank->irq_domain) {
 			dev_err(dev, "wkup irq domain add failed\n");
 			return -ENXIO;
-- 
1.7.9.5
