From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 02 Jul 2014 17:41:01 +0200
Subject: [PATCH 3/6] pinctrl: exynos: Consolidate irq_chips of GPIO and WKUP
 EINTs
In-Reply-To: <1404315664-3174-1-git-send-email-t.figa@samsung.com>
References: <1404315664-3174-1-git-send-email-t.figa@samsung.com>
Message-ID: <1404315664-3174-4-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Handling of irq_chip operations for GPIO and WKUP external interrupts
is mostly the same, with the difference being offset of registers.
However currently the driver has all the code duplicated for both EINT
types, which is undesirable, because changes in irq_chip operations have
to be done to both instances of the same code.

This patch fixes this by creating exynos_irq_chip struct that has normal
irq_chip struct embedded and contain differences between particular EINT
types, which are three register offsets. One instance of code is removed
and the new structure is used instead to fetch necessary data instead of
samsung_pin_ctrl struct used previously.

While at it, the patch removes Exynos-specific fields from
aforementioned structure to improve layering of the driver.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 drivers/pinctrl/pinctrl-exynos.c  | 307 ++++++++------------------------------
 drivers/pinctrl/pinctrl-samsung.h |  17 ---
 2 files changed, 60 insertions(+), 264 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-exynos.c b/drivers/pinctrl/pinctrl-exynos.c
index 9609c23..003bfd8 100644
--- a/drivers/pinctrl/pinctrl-exynos.c
+++ b/drivers/pinctrl/pinctrl-exynos.c
@@ -33,6 +33,18 @@
 #include "pinctrl-samsung.h"
 #include "pinctrl-exynos.h"
 
+struct exynos_irq_chip {
+	struct irq_chip chip;
+
+	u32 eint_con;
+	u32 eint_mask;
+	u32 eint_pend;
+};
+
+static inline struct exynos_irq_chip *to_exynos_irq_chip(struct irq_chip *chip)
+{
+	return container_of(chip, struct exynos_irq_chip, chip);
+}
 
 static struct samsung_pin_bank_type bank_type_off = {
 	.fld_width = { 4, 1, 2, 2, 2, 2, },
@@ -50,11 +62,13 @@ static const struct of_device_id exynos_wkup_irq_ids[] = {
 	{ }
 };
 
-static void exynos_gpio_irq_mask(struct irq_data *irqd)
+static void exynos_irq_mask(struct irq_data *irqd)
 {
+	struct irq_chip *chip = irq_data_get_irq_chip(irqd);
+	struct exynos_irq_chip *our_chip = to_exynos_irq_chip(chip);
 	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
 	struct samsung_pinctrl_drv_data *d = bank->drvdata;
-	unsigned long reg_mask = d->ctrl->geint_mask + bank->eint_offset;
+	unsigned long reg_mask = our_chip->eint_mask + bank->eint_offset;
 	unsigned long mask;
 	unsigned long flags;
 
@@ -67,20 +81,24 @@ static void exynos_gpio_irq_mask(struct irq_data *irqd)
 	spin_unlock_irqrestore(&bank->slock, flags);
 }
 
-static void exynos_gpio_irq_ack(struct irq_data *irqd)
+static void exynos_irq_ack(struct irq_data *irqd)
 {
+	struct irq_chip *chip = irq_data_get_irq_chip(irqd);
+	struct exynos_irq_chip *our_chip = to_exynos_irq_chip(chip);
 	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
 	struct samsung_pinctrl_drv_data *d = bank->drvdata;
-	unsigned long reg_pend = d->ctrl->geint_pend + bank->eint_offset;
+	unsigned long reg_pend = our_chip->eint_pend + bank->eint_offset;
 
 	writel(1 << irqd->hwirq, d->virt_base + reg_pend);
 }
 
-static void exynos_gpio_irq_unmask(struct irq_data *irqd)
+static void exynos_irq_unmask(struct irq_data *irqd)
 {
+	struct irq_chip *chip = irq_data_get_irq_chip(irqd);
+	struct exynos_irq_chip *our_chip = to_exynos_irq_chip(chip);
 	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
 	struct samsung_pinctrl_drv_data *d = bank->drvdata;
-	unsigned long reg_mask = d->ctrl->geint_mask + bank->eint_offset;
+	unsigned long reg_mask = our_chip->eint_mask + bank->eint_offset;
 	unsigned long mask;
 	unsigned long flags;
 
@@ -93,7 +111,7 @@ static void exynos_gpio_irq_unmask(struct irq_data *irqd)
 	 * masked.
 	 */
 	if (irqd_get_trigger_type(irqd) & IRQ_TYPE_LEVEL_MASK)
-		exynos_gpio_irq_ack(irqd);
+		exynos_irq_ack(irqd);
 
 	spin_lock_irqsave(&bank->slock, flags);
 
@@ -104,16 +122,17 @@ static void exynos_gpio_irq_unmask(struct irq_data *irqd)
 	spin_unlock_irqrestore(&bank->slock, flags);
 }
 
-static int exynos_gpio_irq_set_type(struct irq_data *irqd, unsigned int type)
+static int exynos_irq_set_type(struct irq_data *irqd, unsigned int type)
 {
+	struct irq_chip *chip = irq_data_get_irq_chip(irqd);
+	struct exynos_irq_chip *our_chip = to_exynos_irq_chip(chip);
 	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
 	struct samsung_pin_bank_type *bank_type = bank->type;
 	struct samsung_pinctrl_drv_data *d = bank->drvdata;
-	struct samsung_pin_ctrl *ctrl = d->ctrl;
 	unsigned int pin = irqd->hwirq;
 	unsigned int shift = EXYNOS_EINT_CON_LEN * pin;
 	unsigned int con, trig_type;
-	unsigned long reg_con = ctrl->geint_con + bank->eint_offset;
+	unsigned long reg_con = our_chip->eint_con + bank->eint_offset;
 	unsigned long flags;
 	unsigned int mask;
 
@@ -167,12 +186,17 @@ static int exynos_gpio_irq_set_type(struct irq_data *irqd, unsigned int type)
 /*
  * irq_chip for gpio interrupts.
  */
-static struct irq_chip exynos_gpio_irq_chip = {
-	.name		= "exynos_gpio_irq_chip",
-	.irq_unmask	= exynos_gpio_irq_unmask,
-	.irq_mask	= exynos_gpio_irq_mask,
-	.irq_ack		= exynos_gpio_irq_ack,
-	.irq_set_type	= exynos_gpio_irq_set_type,
+static struct exynos_irq_chip exynos_gpio_irq_chip = {
+	.chip = {
+		.name = "exynos_gpio_irq_chip",
+		.irq_unmask = exynos_irq_unmask,
+		.irq_mask = exynos_irq_mask,
+		.irq_ack = exynos_irq_ack,
+		.irq_set_type = exynos_irq_set_type,
+	},
+	.eint_con = EXYNOS_GPIO_ECON_OFFSET,
+	.eint_mask = EXYNOS_GPIO_EMASK_OFFSET,
+	.eint_pend = EXYNOS_GPIO_EPEND_OFFSET,
 };
 
 static int exynos_gpio_irq_map(struct irq_domain *h, unsigned int virq,
@@ -181,7 +205,7 @@ static int exynos_gpio_irq_map(struct irq_domain *h, unsigned int virq,
 	struct samsung_pin_bank *b = h->host_data;
 
 	irq_set_chip_data(virq, b);
-	irq_set_chip_and_handler(virq, &exynos_gpio_irq_chip,
+	irq_set_chip_and_handler(virq, &exynos_gpio_irq_chip.chip,
 					handle_level_irq);
 	set_irq_flags(virq, IRQF_VALID);
 	return 0;
@@ -202,7 +226,7 @@ static irqreturn_t exynos_eint_gpio_irq(int irq, void *data)
 	struct samsung_pin_bank *bank = ctrl->pin_banks;
 	unsigned int svc, group, pin, virq;
 
-	svc = readl(d->virt_base + ctrl->svc);
+	svc = readl(d->virt_base + EXYNOS_SVC_OFFSET);
 	group = EXYNOS_SVC_GROUP(svc);
 	pin = svc & EXYNOS_SVC_NUM_MASK;
 
@@ -279,119 +303,6 @@ err_domains:
 	return ret;
 }
 
-static void exynos_wkup_irq_mask(struct irq_data *irqd)
-{
-	struct samsung_pin_bank *b = irq_data_get_irq_chip_data(irqd);
-	struct samsung_pinctrl_drv_data *d = b->drvdata;
-	unsigned long reg_mask = d->ctrl->weint_mask + b->eint_offset;
-	unsigned long mask;
-	unsigned long flags;
-
-	spin_lock_irqsave(&b->slock, flags);
-
-	mask = readl(d->virt_base + reg_mask);
-	mask |= 1 << irqd->hwirq;
-	writel(mask, d->virt_base + reg_mask);
-
-	spin_unlock_irqrestore(&b->slock, flags);
-}
-
-static void exynos_wkup_irq_ack(struct irq_data *irqd)
-{
-	struct samsung_pin_bank *b = irq_data_get_irq_chip_data(irqd);
-	struct samsung_pinctrl_drv_data *d = b->drvdata;
-	unsigned long pend = d->ctrl->weint_pend + b->eint_offset;
-
-	writel(1 << irqd->hwirq, d->virt_base + pend);
-}
-
-static void exynos_wkup_irq_unmask(struct irq_data *irqd)
-{
-	struct samsung_pin_bank *b = irq_data_get_irq_chip_data(irqd);
-	struct samsung_pinctrl_drv_data *d = b->drvdata;
-	unsigned long reg_mask = d->ctrl->weint_mask + b->eint_offset;
-	unsigned long mask;
-	unsigned long flags;
-
-	/*
-	 * Ack level interrupts right before unmask
-	 *
-	 * If we don't do this we'll get a double-interrupt.  Level triggered
-	 * interrupts must not fire an interrupt if the level is not
-	 * _currently_ active, even if it was active while the interrupt was
-	 * masked.
-	 */
-	if (irqd_get_trigger_type(irqd) & IRQ_TYPE_LEVEL_MASK)
-		exynos_wkup_irq_ack(irqd);
-
-	spin_lock_irqsave(&b->slock, flags);
-
-	mask = readl(d->virt_base + reg_mask);
-	mask &= ~(1 << irqd->hwirq);
-	writel(mask, d->virt_base + reg_mask);
-
-	spin_unlock_irqrestore(&b->slock, flags);
-}
-
-static int exynos_wkup_irq_set_type(struct irq_data *irqd, unsigned int type)
-{
-	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
-	struct samsung_pin_bank_type *bank_type = bank->type;
-	struct samsung_pinctrl_drv_data *d = bank->drvdata;
-	unsigned int pin = irqd->hwirq;
-	unsigned long reg_con = d->ctrl->weint_con + bank->eint_offset;
-	unsigned long shift = EXYNOS_EINT_CON_LEN * pin;
-	unsigned long con, trig_type;
-	unsigned long flags;
-	unsigned int mask;
-
-	switch (type) {
-	case IRQ_TYPE_EDGE_RISING:
-		trig_type = EXYNOS_EINT_EDGE_RISING;
-		break;
-	case IRQ_TYPE_EDGE_FALLING:
-		trig_type = EXYNOS_EINT_EDGE_FALLING;
-		break;
-	case IRQ_TYPE_EDGE_BOTH:
-		trig_type = EXYNOS_EINT_EDGE_BOTH;
-		break;
-	case IRQ_TYPE_LEVEL_HIGH:
-		trig_type = EXYNOS_EINT_LEVEL_HIGH;
-		break;
-	case IRQ_TYPE_LEVEL_LOW:
-		trig_type = EXYNOS_EINT_LEVEL_LOW;
-		break;
-	default:
-		pr_err("unsupported external interrupt type\n");
-		return -EINVAL;
-	}
-
-	if (type & IRQ_TYPE_EDGE_BOTH)
-		__irq_set_handler_locked(irqd->irq, handle_edge_irq);
-	else
-		__irq_set_handler_locked(irqd->irq, handle_level_irq);
-
-	con = readl(d->virt_base + reg_con);
-	con &= ~(EXYNOS_EINT_CON_MASK << shift);
-	con |= trig_type << shift;
-	writel(con, d->virt_base + reg_con);
-
-	reg_con = bank->pctl_offset + bank_type->reg_offset[PINCFG_TYPE_FUNC];
-	shift = pin * bank_type->fld_width[PINCFG_TYPE_FUNC];
-	mask = (1 << bank_type->fld_width[PINCFG_TYPE_FUNC]) - 1;
-
-	spin_lock_irqsave(&bank->slock, flags);
-
-	con = readl(d->virt_base + reg_con);
-	con &= ~(mask << shift);
-	con |= EXYNOS_EINT_FUNC << shift;
-	writel(con, d->virt_base + reg_con);
-
-	spin_unlock_irqrestore(&bank->slock, flags);
-
-	return 0;
-}
-
 static u32 exynos_eint_wake_mask = 0xffffffff;
 
 u32 exynos_get_eint_wake_mask(void)
@@ -417,13 +328,18 @@ static int exynos_wkup_irq_set_wake(struct irq_data *irqd, unsigned int on)
 /*
  * irq_chip for wakeup interrupts
  */
-static struct irq_chip exynos_wkup_irq_chip = {
-	.name	= "exynos_wkup_irq_chip",
-	.irq_unmask	= exynos_wkup_irq_unmask,
-	.irq_mask	= exynos_wkup_irq_mask,
-	.irq_ack	= exynos_wkup_irq_ack,
-	.irq_set_type	= exynos_wkup_irq_set_type,
-	.irq_set_wake	= exynos_wkup_irq_set_wake,
+static struct exynos_irq_chip exynos_wkup_irq_chip = {
+	.chip = {
+		.name = "exynos_wkup_irq_chip",
+		.irq_unmask = exynos_irq_unmask,
+		.irq_mask = exynos_irq_mask,
+		.irq_ack = exynos_irq_ack,
+		.irq_set_type = exynos_irq_set_type,
+		.irq_set_wake = exynos_wkup_irq_set_wake,
+	},
+	.eint_con = EXYNOS_WKUP_ECON_OFFSET,
+	.eint_mask = EXYNOS_WKUP_EMASK_OFFSET,
+	.eint_pend = EXYNOS_WKUP_EPEND_OFFSET,
 };
 
 /* interrupt handler for wakeup interrupts 0..15 */
@@ -464,7 +380,6 @@ static void exynos_irq_demux_eint16_31(unsigned int irq, struct irq_desc *desc)
 	struct irq_chip *chip = irq_get_chip(irq);
 	struct exynos_muxed_weint_data *eintd = irq_get_handler_data(irq);
 	struct samsung_pinctrl_drv_data *d = eintd->banks[0]->drvdata;
-	struct samsung_pin_ctrl *ctrl = d->ctrl;
 	unsigned long pend;
 	unsigned long mask;
 	int i;
@@ -473,8 +388,10 @@ static void exynos_irq_demux_eint16_31(unsigned int irq, struct irq_desc *desc)
 
 	for (i = 0; i < eintd->nr_banks; ++i) {
 		struct samsung_pin_bank *b = eintd->banks[i];
-		pend = readl(d->virt_base + ctrl->weint_pend + b->eint_offset);
-		mask = readl(d->virt_base + ctrl->weint_mask + b->eint_offset);
+		pend = readl(d->virt_base + EXYNOS_WKUP_EPEND_OFFSET
+				+ b->eint_offset);
+		mask = readl(d->virt_base + EXYNOS_WKUP_EMASK_OFFSET
+				+ b->eint_offset);
 		exynos_irq_demux_eint(pend & ~mask, b->irq_domain);
 	}
 
@@ -484,7 +401,8 @@ static void exynos_irq_demux_eint16_31(unsigned int irq, struct irq_desc *desc)
 static int exynos_wkup_irq_map(struct irq_domain *h, unsigned int virq,
 					irq_hw_number_t hw)
 {
-	irq_set_chip_and_handler(virq, &exynos_wkup_irq_chip, handle_level_irq);
+	irq_set_chip_and_handler(virq, &exynos_wkup_irq_chip.chip,
+					handle_level_irq);
 	irq_set_chip_data(virq, h->host_data);
 	set_irq_flags(virq, IRQF_VALID);
 	return 0;
@@ -703,13 +621,6 @@ struct samsung_pin_ctrl s5pv210_pin_ctrl[] = {
 		/* pin-controller instance 0 data */
 		.pin_banks	= s5pv210_pin_bank,
 		.nr_banks	= ARRAY_SIZE(s5pv210_pin_bank),
-		.geint_con	= EXYNOS_GPIO_ECON_OFFSET,
-		.geint_mask	= EXYNOS_GPIO_EMASK_OFFSET,
-		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
-		.weint_con	= EXYNOS_WKUP_ECON_OFFSET,
-		.weint_mask	= EXYNOS_WKUP_EMASK_OFFSET,
-		.weint_pend	= EXYNOS_WKUP_EPEND_OFFSET,
-		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.eint_wkup_init = exynos_eint_wkup_init,
 		.suspend	= exynos_pinctrl_suspend,
@@ -758,10 +669,6 @@ struct samsung_pin_ctrl exynos3250_pin_ctrl[] = {
 		/* pin-controller instance 0 data */
 		.pin_banks	= exynos3250_pin_banks0,
 		.nr_banks	= ARRAY_SIZE(exynos3250_pin_banks0),
-		.geint_con	= EXYNOS_GPIO_ECON_OFFSET,
-		.geint_mask	= EXYNOS_GPIO_EMASK_OFFSET,
-		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
-		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.suspend	= exynos_pinctrl_suspend,
 		.resume		= exynos_pinctrl_resume,
@@ -770,13 +677,6 @@ struct samsung_pin_ctrl exynos3250_pin_ctrl[] = {
 		/* pin-controller instance 1 data */
 		.pin_banks	= exynos3250_pin_banks1,
 		.nr_banks	= ARRAY_SIZE(exynos3250_pin_banks1),
-		.geint_con	= EXYNOS_GPIO_ECON_OFFSET,
-		.geint_mask	= EXYNOS_GPIO_EMASK_OFFSET,
-		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
-		.weint_con	= EXYNOS_WKUP_ECON_OFFSET,
-		.weint_mask	= EXYNOS_WKUP_EMASK_OFFSET,
-		.weint_pend	= EXYNOS_WKUP_EPEND_OFFSET,
-		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.eint_wkup_init = exynos_eint_wkup_init,
 		.suspend	= exynos_pinctrl_suspend,
@@ -843,10 +743,6 @@ struct samsung_pin_ctrl exynos4210_pin_ctrl[] = {
 		/* pin-controller instance 0 data */
 		.pin_banks	= exynos4210_pin_banks0,
 		.nr_banks	= ARRAY_SIZE(exynos4210_pin_banks0),
-		.geint_con	= EXYNOS_GPIO_ECON_OFFSET,
-		.geint_mask	= EXYNOS_GPIO_EMASK_OFFSET,
-		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
-		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.suspend	= exynos_pinctrl_suspend,
 		.resume		= exynos_pinctrl_resume,
@@ -855,13 +751,6 @@ struct samsung_pin_ctrl exynos4210_pin_ctrl[] = {
 		/* pin-controller instance 1 data */
 		.pin_banks	= exynos4210_pin_banks1,
 		.nr_banks	= ARRAY_SIZE(exynos4210_pin_banks1),
-		.geint_con	= EXYNOS_GPIO_ECON_OFFSET,
-		.geint_mask	= EXYNOS_GPIO_EMASK_OFFSET,
-		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
-		.weint_con	= EXYNOS_WKUP_ECON_OFFSET,
-		.weint_mask	= EXYNOS_WKUP_EMASK_OFFSET,
-		.weint_pend	= EXYNOS_WKUP_EPEND_OFFSET,
-		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.eint_wkup_init = exynos_eint_wkup_init,
 		.suspend	= exynos_pinctrl_suspend,
@@ -942,10 +831,6 @@ struct samsung_pin_ctrl exynos4x12_pin_ctrl[] = {
 		/* pin-controller instance 0 data */
 		.pin_banks	= exynos4x12_pin_banks0,
 		.nr_banks	= ARRAY_SIZE(exynos4x12_pin_banks0),
-		.geint_con	= EXYNOS_GPIO_ECON_OFFSET,
-		.geint_mask	= EXYNOS_GPIO_EMASK_OFFSET,
-		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
-		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.suspend	= exynos_pinctrl_suspend,
 		.resume		= exynos_pinctrl_resume,
@@ -954,13 +839,6 @@ struct samsung_pin_ctrl exynos4x12_pin_ctrl[] = {
 		/* pin-controller instance 1 data */
 		.pin_banks	= exynos4x12_pin_banks1,
 		.nr_banks	= ARRAY_SIZE(exynos4x12_pin_banks1),
-		.geint_con	= EXYNOS_GPIO_ECON_OFFSET,
-		.geint_mask	= EXYNOS_GPIO_EMASK_OFFSET,
-		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
-		.weint_con	= EXYNOS_WKUP_ECON_OFFSET,
-		.weint_mask	= EXYNOS_WKUP_EMASK_OFFSET,
-		.weint_pend	= EXYNOS_WKUP_EPEND_OFFSET,
-		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.eint_wkup_init = exynos_eint_wkup_init,
 		.suspend	= exynos_pinctrl_suspend,
@@ -970,10 +848,6 @@ struct samsung_pin_ctrl exynos4x12_pin_ctrl[] = {
 		/* pin-controller instance 2 data */
 		.pin_banks	= exynos4x12_pin_banks2,
 		.nr_banks	= ARRAY_SIZE(exynos4x12_pin_banks2),
-		.geint_con	= EXYNOS_GPIO_ECON_OFFSET,
-		.geint_mask	= EXYNOS_GPIO_EMASK_OFFSET,
-		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
-		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.suspend	= exynos_pinctrl_suspend,
 		.resume		= exynos_pinctrl_resume,
@@ -982,10 +856,6 @@ struct samsung_pin_ctrl exynos4x12_pin_ctrl[] = {
 		/* pin-controller instance 3 data */
 		.pin_banks	= exynos4x12_pin_banks3,
 		.nr_banks	= ARRAY_SIZE(exynos4x12_pin_banks3),
-		.geint_con	= EXYNOS_GPIO_ECON_OFFSET,
-		.geint_mask	= EXYNOS_GPIO_EMASK_OFFSET,
-		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
-		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.suspend	= exynos_pinctrl_suspend,
 		.resume		= exynos_pinctrl_resume,
@@ -1058,13 +928,6 @@ struct samsung_pin_ctrl exynos5250_pin_ctrl[] = {
 		/* pin-controller instance 0 data */
 		.pin_banks	= exynos5250_pin_banks0,
 		.nr_banks	= ARRAY_SIZE(exynos5250_pin_banks0),
-		.geint_con	= EXYNOS_GPIO_ECON_OFFSET,
-		.geint_mask	= EXYNOS_GPIO_EMASK_OFFSET,
-		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
-		.weint_con	= EXYNOS_WKUP_ECON_OFFSET,
-		.weint_mask	= EXYNOS_WKUP_EMASK_OFFSET,
-		.weint_pend	= EXYNOS_WKUP_EPEND_OFFSET,
-		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.eint_wkup_init = exynos_eint_wkup_init,
 		.suspend	= exynos_pinctrl_suspend,
@@ -1074,10 +937,6 @@ struct samsung_pin_ctrl exynos5250_pin_ctrl[] = {
 		/* pin-controller instance 1 data */
 		.pin_banks	= exynos5250_pin_banks1,
 		.nr_banks	= ARRAY_SIZE(exynos5250_pin_banks1),
-		.geint_con	= EXYNOS_GPIO_ECON_OFFSET,
-		.geint_mask	= EXYNOS_GPIO_EMASK_OFFSET,
-		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
-		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.suspend	= exynos_pinctrl_suspend,
 		.resume		= exynos_pinctrl_resume,
@@ -1086,10 +945,6 @@ struct samsung_pin_ctrl exynos5250_pin_ctrl[] = {
 		/* pin-controller instance 2 data */
 		.pin_banks	= exynos5250_pin_banks2,
 		.nr_banks	= ARRAY_SIZE(exynos5250_pin_banks2),
-		.geint_con	= EXYNOS_GPIO_ECON_OFFSET,
-		.geint_mask	= EXYNOS_GPIO_EMASK_OFFSET,
-		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
-		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.suspend	= exynos_pinctrl_suspend,
 		.resume		= exynos_pinctrl_resume,
@@ -1098,10 +953,6 @@ struct samsung_pin_ctrl exynos5250_pin_ctrl[] = {
 		/* pin-controller instance 3 data */
 		.pin_banks	= exynos5250_pin_banks3,
 		.nr_banks	= ARRAY_SIZE(exynos5250_pin_banks3),
-		.geint_con	= EXYNOS_GPIO_ECON_OFFSET,
-		.geint_mask	= EXYNOS_GPIO_EMASK_OFFSET,
-		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
-		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.suspend	= exynos_pinctrl_suspend,
 		.resume		= exynos_pinctrl_resume,
@@ -1158,13 +1009,6 @@ struct samsung_pin_ctrl exynos5260_pin_ctrl[] = {
 		/* pin-controller instance 0 data */
 		.pin_banks	= exynos5260_pin_banks0,
 		.nr_banks	= ARRAY_SIZE(exynos5260_pin_banks0),
-		.geint_con	= EXYNOS_GPIO_ECON_OFFSET,
-		.geint_mask	= EXYNOS_GPIO_EMASK_OFFSET,
-		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
-		.weint_con	= EXYNOS_WKUP_ECON_OFFSET,
-		.weint_mask	= EXYNOS_WKUP_EMASK_OFFSET,
-		.weint_pend	= EXYNOS_WKUP_EPEND_OFFSET,
-		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.eint_wkup_init = exynos_eint_wkup_init,
 		.label		= "exynos5260-gpio-ctrl0",
@@ -1172,20 +1016,12 @@ struct samsung_pin_ctrl exynos5260_pin_ctrl[] = {
 		/* pin-controller instance 1 data */
 		.pin_banks	= exynos5260_pin_banks1,
 		.nr_banks	= ARRAY_SIZE(exynos5260_pin_banks1),
-		.geint_con	= EXYNOS_GPIO_ECON_OFFSET,
-		.geint_mask	= EXYNOS_GPIO_EMASK_OFFSET,
-		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
-		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.label		= "exynos5260-gpio-ctrl1",
 	}, {
 		/* pin-controller instance 2 data */
 		.pin_banks	= exynos5260_pin_banks2,
 		.nr_banks	= ARRAY_SIZE(exynos5260_pin_banks2),
-		.geint_con	= EXYNOS_GPIO_ECON_OFFSET,
-		.geint_mask	= EXYNOS_GPIO_EMASK_OFFSET,
-		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
-		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.label		= "exynos5260-gpio-ctrl2",
 	},
@@ -1256,13 +1092,6 @@ struct samsung_pin_ctrl exynos5420_pin_ctrl[] = {
 		/* pin-controller instance 0 data */
 		.pin_banks	= exynos5420_pin_banks0,
 		.nr_banks	= ARRAY_SIZE(exynos5420_pin_banks0),
-		.geint_con	= EXYNOS_GPIO_ECON_OFFSET,
-		.geint_mask	= EXYNOS_GPIO_EMASK_OFFSET,
-		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
-		.weint_con	= EXYNOS_WKUP_ECON_OFFSET,
-		.weint_mask	= EXYNOS_WKUP_EMASK_OFFSET,
-		.weint_pend	= EXYNOS_WKUP_EPEND_OFFSET,
-		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.eint_wkup_init = exynos_eint_wkup_init,
 		.label		= "exynos5420-gpio-ctrl0",
@@ -1270,40 +1099,24 @@ struct samsung_pin_ctrl exynos5420_pin_ctrl[] = {
 		/* pin-controller instance 1 data */
 		.pin_banks	= exynos5420_pin_banks1,
 		.nr_banks	= ARRAY_SIZE(exynos5420_pin_banks1),
-		.geint_con	= EXYNOS_GPIO_ECON_OFFSET,
-		.geint_mask	= EXYNOS_GPIO_EMASK_OFFSET,
-		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
-		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.label		= "exynos5420-gpio-ctrl1",
 	}, {
 		/* pin-controller instance 2 data */
 		.pin_banks	= exynos5420_pin_banks2,
 		.nr_banks	= ARRAY_SIZE(exynos5420_pin_banks2),
-		.geint_con	= EXYNOS_GPIO_ECON_OFFSET,
-		.geint_mask	= EXYNOS_GPIO_EMASK_OFFSET,
-		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
-		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.label		= "exynos5420-gpio-ctrl2",
 	}, {
 		/* pin-controller instance 3 data */
 		.pin_banks	= exynos5420_pin_banks3,
 		.nr_banks	= ARRAY_SIZE(exynos5420_pin_banks3),
-		.geint_con	= EXYNOS_GPIO_ECON_OFFSET,
-		.geint_mask	= EXYNOS_GPIO_EMASK_OFFSET,
-		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
-		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.label		= "exynos5420-gpio-ctrl3",
 	}, {
 		/* pin-controller instance 4 data */
 		.pin_banks	= exynos5420_pin_banks4,
 		.nr_banks	= ARRAY_SIZE(exynos5420_pin_banks4),
-		.geint_con	= EXYNOS_GPIO_ECON_OFFSET,
-		.geint_mask	= EXYNOS_GPIO_EMASK_OFFSET,
-		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
-		.svc		= EXYNOS_SVC_OFFSET,
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.label		= "exynos5420-gpio-ctrl4",
 	},
diff --git a/drivers/pinctrl/pinctrl-samsung.h b/drivers/pinctrl/pinctrl-samsung.h
index b3e41fa..e2dce47 100644
--- a/drivers/pinctrl/pinctrl-samsung.h
+++ b/drivers/pinctrl/pinctrl-samsung.h
@@ -156,13 +156,6 @@ struct samsung_pin_bank {
  * @nr_banks: number of pin banks.
  * @base: starting system wide pin number.
  * @nr_pins: number of pins supported by the controller.
- * @geint_con: offset of the ext-gpio controller registers.
- * @geint_mask: offset of the ext-gpio interrupt mask registers.
- * @geint_pend: offset of the ext-gpio interrupt pending registers.
- * @weint_con: offset of the ext-wakeup controller registers.
- * @weint_mask: offset of the ext-wakeup interrupt mask registers.
- * @weint_pend: offset of the ext-wakeup interrupt pending registers.
- * @svc: offset of the interrupt service register.
  * @eint_gpio_init: platform specific callback to setup the external gpio
  *	interrupts for the controller.
  * @eint_wkup_init: platform specific callback to setup the external wakeup
@@ -176,16 +169,6 @@ struct samsung_pin_ctrl {
 	u32		base;
 	u32		nr_pins;
 
-	u32		geint_con;
-	u32		geint_mask;
-	u32		geint_pend;
-
-	u32		weint_con;
-	u32		weint_mask;
-	u32		weint_pend;
-
-	u32		svc;
-
 	int		(*eint_gpio_init)(struct samsung_pinctrl_drv_data *);
 	int		(*eint_wkup_init)(struct samsung_pinctrl_drv_data *);
 	void		(*suspend)(struct samsung_pinctrl_drv_data *);
-- 
1.9.3
