From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Thu, 09 Oct 2014 19:24:29 +0530
Subject: [PATCH v5 1/6] pinctrl: exynos: Generalize the eint16_31 demux code
In-Reply-To: <1412862874-9335-1-git-send-email-a.kesavan@samsung.com>
References: <1412862874-9335-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1412862874-9335-2-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function exynos_irq_demux_eint16_31 uses pre-defined offsets for external
interrupt pending status and mask registers. So this function is not extensible
for Exynos7 SoC which has these registers at different offsets. Generalize
the exynos_irq_demux_eint16_31 function by using the pending/mask register
offset values from the exynos_irq_chip structure. This is done by adding a
irq_chip field to the samsung_pin_bank struct.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Reviewed-by: Thomas Abraham <thomas.ab@samsung.com>
Tested-by: Thomas Abraham <thomas.ab@samsung.com>
Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/samsung/pinctrl-exynos.c  |   14 ++++++++++----
 drivers/pinctrl/samsung/pinctrl-samsung.h |    2 ++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 6190106..0cca117 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -260,7 +260,7 @@ static int exynos_gpio_irq_map(struct irq_domain *h, unsigned int virq,
 	struct samsung_pin_bank *b = h->host_data;
 
 	irq_set_chip_data(virq, b);
-	irq_set_chip_and_handler(virq, &exynos_gpio_irq_chip.chip,
+	irq_set_chip_and_handler(virq, &b->irq_chip->chip,
 					handle_level_irq);
 	set_irq_flags(virq, IRQF_VALID);
 	return 0;
@@ -343,6 +343,8 @@ static int exynos_eint_gpio_init(struct samsung_pinctrl_drv_data *d)
 			ret = -ENOMEM;
 			goto err_domains;
 		}
+
+		bank->irq_chip = &exynos_gpio_irq_chip;
 	}
 
 	return 0;
@@ -444,9 +446,9 @@ static void exynos_irq_demux_eint16_31(unsigned int irq, struct irq_desc *desc)
 
 	for (i = 0; i < eintd->nr_banks; ++i) {
 		struct samsung_pin_bank *b = eintd->banks[i];
-		pend = readl(d->virt_base + EXYNOS_WKUP_EPEND_OFFSET
+		pend = readl(d->virt_base + b->irq_chip->eint_pend
 				+ b->eint_offset);
-		mask = readl(d->virt_base + EXYNOS_WKUP_EMASK_OFFSET
+		mask = readl(d->virt_base + b->irq_chip->eint_mask
 				+ b->eint_offset);
 		exynos_irq_demux_eint(pend & ~mask, b->irq_domain);
 	}
@@ -457,7 +459,9 @@ static void exynos_irq_demux_eint16_31(unsigned int irq, struct irq_desc *desc)
 static int exynos_wkup_irq_map(struct irq_domain *h, unsigned int virq,
 					irq_hw_number_t hw)
 {
-	irq_set_chip_and_handler(virq, &exynos_wkup_irq_chip.chip,
+	struct samsung_pin_bank *b = h->host_data;
+
+	irq_set_chip_and_handler(virq, &b->irq_chip->chip,
 					handle_level_irq);
 	irq_set_chip_data(virq, h->host_data);
 	set_irq_flags(virq, IRQF_VALID);
@@ -509,6 +513,8 @@ static int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
 			return -ENXIO;
 		}
 
+		bank->irq_chip = &exynos_wkup_irq_chip;
+
 		if (!of_find_property(bank->of_node, "interrupts", NULL)) {
 			bank->eint_type = EINT_TYPE_WKUP_MUX;
 			++muxed_banks;
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
index ec43b7d..3076b8b 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.h
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
@@ -151,6 +151,7 @@ struct samsung_pin_bank_data {
  * @irq_domain: IRQ domain of the bank.
  * @gpio_chip: GPIO chip of the bank.
  * @grange: linux gpio pin range supported by this bank.
+ * @irq_chip: link to irq chip for external gpio and wakeup interrupts.
  * @slock: spinlock protecting bank registers
  * @pm_save: saved register values during suspend
  */
@@ -171,6 +172,7 @@ struct samsung_pin_bank {
 	struct irq_domain *irq_domain;
 	struct gpio_chip gpio_chip;
 	struct pinctrl_gpio_range grange;
+	struct exynos_irq_chip *irq_chip;
 	spinlock_t slock;
 
 	u32 pm_save[PINCFG_TYPE_NUM + 1]; /* +1 to handle double CON registers*/
-- 
1.7.9.5
