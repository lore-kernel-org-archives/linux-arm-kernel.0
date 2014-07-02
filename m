From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 02 Jul 2014 17:41:02 +0200
Subject: [PATCH 4/6] pinctrl: exynos: Lock GPIOs as interrupts when used as
 EINTs
In-Reply-To: <1404315664-3174-1-git-send-email-t.figa@samsung.com>
References: <1404315664-3174-1-git-send-email-t.figa@samsung.com>
Message-ID: <1404315664-3174-5-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently after configuring a GPIO pin as an interrupt related pinmux
registers are changed, but there is no protection from calling
gpio_direction_*() in a badly written driver, which would cause the same
pinmux register to be reconfigured for regular input/output and this
disabling interrupt capability of the pin.

This patch addresses this issue by moving pinmux reconfiguration to
.irq_startup() callback of irq_chip and calling gpio_lock_as_irq()
helper to prevent reconfiguration of pin direction.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 drivers/pinctrl/pinctrl-exynos.c  | 69 +++++++++++++++++++++++++++++++++++----
 drivers/pinctrl/pinctrl-samsung.h |  1 +
 2 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-exynos.c b/drivers/pinctrl/pinctrl-exynos.c
index 003bfd8..a209cb4 100644
--- a/drivers/pinctrl/pinctrl-exynos.c
+++ b/drivers/pinctrl/pinctrl-exynos.c
@@ -127,14 +127,10 @@ static int exynos_irq_set_type(struct irq_data *irqd, unsigned int type)
 	struct irq_chip *chip = irq_data_get_irq_chip(irqd);
 	struct exynos_irq_chip *our_chip = to_exynos_irq_chip(chip);
 	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
-	struct samsung_pin_bank_type *bank_type = bank->type;
 	struct samsung_pinctrl_drv_data *d = bank->drvdata;
-	unsigned int pin = irqd->hwirq;
-	unsigned int shift = EXYNOS_EINT_CON_LEN * pin;
+	unsigned int shift = EXYNOS_EINT_CON_LEN * irqd->hwirq;
 	unsigned int con, trig_type;
 	unsigned long reg_con = our_chip->eint_con + bank->eint_offset;
-	unsigned long flags;
-	unsigned int mask;
 
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
@@ -167,8 +163,32 @@ static int exynos_irq_set_type(struct irq_data *irqd, unsigned int type)
 	con |= trig_type << shift;
 	writel(con, d->virt_base + reg_con);
 
+	return 0;
+}
+
+static unsigned int exynos_irq_startup(struct irq_data *irqd)
+{
+	struct irq_chip *chip = irq_data_get_irq_chip(irqd);
+	struct exynos_irq_chip *our_chip = to_exynos_irq_chip(chip);
+	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
+	struct samsung_pin_bank_type *bank_type = bank->type;
+	struct samsung_pinctrl_drv_data *d = bank->drvdata;
+	unsigned int shift = EXYNOS_EINT_CON_LEN * irqd->hwirq;
+	unsigned long reg_con = our_chip->eint_con + bank->eint_offset;
+	unsigned long flags;
+	unsigned int mask;
+	unsigned int con;
+	int ret;
+
+	ret = gpio_lock_as_irq(&bank->gpio_chip, irqd->hwirq);
+	if (ret) {
+		dev_err(bank->gpio_chip.dev, "unable to lock pin %s-%lu IRQ\n",
+			bank->name, irqd->hwirq);
+		return ret;
+	}
+
 	reg_con = bank->pctl_offset + bank_type->reg_offset[PINCFG_TYPE_FUNC];
-	shift = pin * bank_type->fld_width[PINCFG_TYPE_FUNC];
+	shift = irqd->hwirq * bank_type->fld_width[PINCFG_TYPE_FUNC];
 	mask = (1 << bank_type->fld_width[PINCFG_TYPE_FUNC]) - 1;
 
 	spin_lock_irqsave(&bank->slock, flags);
@@ -180,9 +200,42 @@ static int exynos_irq_set_type(struct irq_data *irqd, unsigned int type)
 
 	spin_unlock_irqrestore(&bank->slock, flags);
 
+	exynos_irq_unmask(irqd);
+
 	return 0;
 }
 
+static void exynos_irq_shutdown(struct irq_data *irqd)
+{
+	struct irq_chip *chip = irq_data_get_irq_chip(irqd);
+	struct exynos_irq_chip *our_chip = to_exynos_irq_chip(chip);
+	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
+	struct samsung_pin_bank_type *bank_type = bank->type;
+	struct samsung_pinctrl_drv_data *d = bank->drvdata;
+	unsigned int shift = EXYNOS_EINT_CON_LEN * irqd->hwirq;
+	unsigned long reg_con = our_chip->eint_con + bank->eint_offset;
+	unsigned long flags;
+	unsigned int mask;
+	unsigned int con;
+
+	reg_con = bank->pctl_offset + bank_type->reg_offset[PINCFG_TYPE_FUNC];
+	shift = irqd->hwirq * bank_type->fld_width[PINCFG_TYPE_FUNC];
+	mask = (1 << bank_type->fld_width[PINCFG_TYPE_FUNC]) - 1;
+
+	exynos_irq_mask(irqd);
+
+	spin_lock_irqsave(&bank->slock, flags);
+
+	con = readl(d->virt_base + reg_con);
+	con &= ~(mask << shift);
+	con |= FUNC_INPUT << shift;
+	writel(con, d->virt_base + reg_con);
+
+	spin_unlock_irqrestore(&bank->slock, flags);
+
+	gpio_unlock_as_irq(&bank->gpio_chip, irqd->hwirq);
+}
+
 /*
  * irq_chip for gpio interrupts.
  */
@@ -193,6 +246,8 @@ static struct exynos_irq_chip exynos_gpio_irq_chip = {
 		.irq_mask = exynos_irq_mask,
 		.irq_ack = exynos_irq_ack,
 		.irq_set_type = exynos_irq_set_type,
+		.irq_startup = exynos_irq_startup,
+		.irq_shutdown = exynos_irq_shutdown,
 	},
 	.eint_con = EXYNOS_GPIO_ECON_OFFSET,
 	.eint_mask = EXYNOS_GPIO_EMASK_OFFSET,
@@ -336,6 +391,8 @@ static struct exynos_irq_chip exynos_wkup_irq_chip = {
 		.irq_ack = exynos_irq_ack,
 		.irq_set_type = exynos_irq_set_type,
 		.irq_set_wake = exynos_wkup_irq_set_wake,
+		.irq_startup = exynos_irq_startup,
+		.irq_shutdown = exynos_irq_shutdown,
 	},
 	.eint_con = EXYNOS_WKUP_ECON_OFFSET,
 	.eint_mask = EXYNOS_WKUP_EMASK_OFFSET,
diff --git a/drivers/pinctrl/pinctrl-samsung.h b/drivers/pinctrl/pinctrl-samsung.h
index e2dce47..4d7566a 100644
--- a/drivers/pinctrl/pinctrl-samsung.h
+++ b/drivers/pinctrl/pinctrl-samsung.h
@@ -26,6 +26,7 @@
 #include <linux/gpio.h>
 
 /* pinmux function number for pin as gpio output line */
+#define FUNC_INPUT	0x0
 #define FUNC_OUTPUT	0x1
 
 /**
-- 
1.9.3
