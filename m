From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 18 Mar 2013 22:31:52 +0100
Subject: [PATCH 3/6] pinctrl: samsung: Split pin bank description into two
 structures
In-Reply-To: <1363642315-10331-1-git-send-email-tomasz.figa@gmail.com>
References: <1363642315-10331-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1363642315-10331-4-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch splits pin bank description into two structures, one
describing bank type (currently only bitfield widths), which can be
shared across multiple banks and second containing bank-specific
parameters including a pointer to a bank type struct.

It is a prerequisite for further patch removing the statically hardcoded
register offsets, making it impossible to support SoCs with different
set and order of pin control registers.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/pinctrl/pinctrl-exynos.c  | 19 +++++++++++++++----
 drivers/pinctrl/pinctrl-exynos.h  | 16 +++-------------
 drivers/pinctrl/pinctrl-samsung.c | 24 +++++++++++++++---------
 drivers/pinctrl/pinctrl-samsung.h | 26 ++++++++++++++++----------
 4 files changed, 49 insertions(+), 36 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-exynos.c b/drivers/pinctrl/pinctrl-exynos.c
index cf7700e..b5dbb87 100644
--- a/drivers/pinctrl/pinctrl-exynos.c
+++ b/drivers/pinctrl/pinctrl-exynos.c
@@ -34,6 +34,15 @@
 #include "pinctrl-samsung.h"
 #include "pinctrl-exynos.h"
 
+
+static struct samsung_pin_bank_type bank_type_off = {
+	.fld_width = { 4, 1, 2, 2, 2, 2, },
+};
+
+static struct samsung_pin_bank_type bank_type_alive = {
+	.fld_width = { 4, 1, 2, 2, },
+};
+
 /* list of external wakeup controllers supported */
 static const struct of_device_id exynos_wkup_irq_ids[] = {
 	{ .compatible = "samsung,exynos4210-wakeup-eint", },
@@ -76,6 +85,7 @@ static void exynos_gpio_irq_ack(struct irq_data *irqd)
 static int exynos_gpio_irq_set_type(struct irq_data *irqd, unsigned int type)
 {
 	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
+	struct samsung_pin_bank_type *bank_type = bank->type;
 	struct samsung_pinctrl_drv_data *d = bank->drvdata;
 	struct samsung_pin_ctrl *ctrl = d->ctrl;
 	unsigned int pin = irqd->hwirq;
@@ -117,8 +127,8 @@ static int exynos_gpio_irq_set_type(struct irq_data *irqd, unsigned int type)
 	writel(con, d->virt_base + reg_con);
 
 	reg_con = bank->pctl_offset;
-	shift = pin * bank->func_width;
-	mask = (1 << bank->func_width) - 1;
+	shift = pin * bank_type->fld_width[PINCFG_TYPE_FUNC];
+	mask = (1 << bank_type->fld_width[PINCFG_TYPE_FUNC]) - 1;
 
 	spin_lock_irqsave(&bank->slock, flags);
 
@@ -259,6 +269,7 @@ static void exynos_wkup_irq_ack(struct irq_data *irqd)
 static int exynos_wkup_irq_set_type(struct irq_data *irqd, unsigned int type)
 {
 	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
+	struct samsung_pin_bank_type *bank_type = bank->type;
 	struct samsung_pinctrl_drv_data *d = bank->drvdata;
 	unsigned int pin = irqd->hwirq;
 	unsigned long reg_con = d->ctrl->weint_con + bank->eint_offset;
@@ -299,8 +310,8 @@ static int exynos_wkup_irq_set_type(struct irq_data *irqd, unsigned int type)
 	writel(con, d->virt_base + reg_con);
 
 	reg_con = bank->pctl_offset;
-	shift = pin * bank->func_width;
-	mask = (1 << bank->func_width) - 1;
+	shift = pin * bank_type->fld_width[PINCFG_TYPE_FUNC];
+	mask = (1 << bank_type->fld_width[PINCFG_TYPE_FUNC]) - 1;
 
 	spin_lock_irqsave(&bank->slock, flags);
 
diff --git a/drivers/pinctrl/pinctrl-exynos.h b/drivers/pinctrl/pinctrl-exynos.h
index 0a70889..9b1f77a 100644
--- a/drivers/pinctrl/pinctrl-exynos.h
+++ b/drivers/pinctrl/pinctrl-exynos.h
@@ -48,26 +48,18 @@
 
 #define EXYNOS_PIN_BANK_EINTN(pins, reg, id)		\
 	{						\
+		.type		= &bank_type_off,	\
 		.pctl_offset	= reg,			\
 		.nr_pins	= pins,			\
-		.func_width	= 4,			\
-		.pud_width	= 2,			\
-		.drv_width	= 2,			\
-		.conpdn_width	= 2,			\
-		.pudpdn_width	= 2,			\
 		.eint_type	= EINT_TYPE_NONE,	\
 		.name		= id			\
 	}
 
 #define EXYNOS_PIN_BANK_EINTG(pins, reg, id, offs)	\
 	{						\
+		.type		= &bank_type_off,	\
 		.pctl_offset	= reg,			\
 		.nr_pins	= pins,			\
-		.func_width	= 4,			\
-		.pud_width	= 2,			\
-		.drv_width	= 2,			\
-		.conpdn_width	= 2,			\
-		.pudpdn_width	= 2,			\
 		.eint_type	= EINT_TYPE_GPIO,	\
 		.eint_offset	= offs,			\
 		.name		= id			\
@@ -75,11 +67,9 @@
 
 #define EXYNOS_PIN_BANK_EINTW(pins, reg, id, offs)	\
 	{						\
+		.type		= &bank_type_alive,	\
 		.pctl_offset	= reg,			\
 		.nr_pins	= pins,			\
-		.func_width	= 4,			\
-		.pud_width	= 2,			\
-		.drv_width	= 2,			\
 		.eint_type	= EINT_TYPE_WKUP,	\
 		.eint_offset	= offs,			\
 		.name		= id			\
diff --git a/drivers/pinctrl/pinctrl-samsung.c b/drivers/pinctrl/pinctrl-samsung.c
index f1fb562..ac428ff 100644
--- a/drivers/pinctrl/pinctrl-samsung.c
+++ b/drivers/pinctrl/pinctrl-samsung.c
@@ -300,10 +300,13 @@ static void samsung_pinmux_setup(struct pinctrl_dev *pctldev, unsigned selector,
 	 * pin function number in the config register.
 	 */
 	for (cnt = 0; cnt < drvdata->pin_groups[group].num_pins; cnt++) {
+		struct samsung_pin_bank_type *type;
+
 		pin_to_reg_bank(drvdata, pins[cnt] - drvdata->ctrl->base,
 				&reg, &pin_offset, &bank);
-		mask = (1 << bank->func_width) - 1;
-		shift = pin_offset * bank->func_width;
+		type = bank->type;
+		mask = (1 << type->fld_width[PINCFG_TYPE_FUNC]) - 1;
+		shift = pin_offset * type->fld_width[PINCFG_TYPE_FUNC];
 
 		spin_lock_irqsave(&bank->slock, flags);
 
@@ -340,6 +343,7 @@ static void samsung_pinmux_disable(struct pinctrl_dev *pctldev,
 static int samsung_pinmux_gpio_set_direction(struct pinctrl_dev *pctldev,
 		struct pinctrl_gpio_range *range, unsigned offset, bool input)
 {
+	struct samsung_pin_bank_type *type;
 	struct samsung_pin_bank *bank;
 	struct samsung_pinctrl_drv_data *drvdata;
 	void __iomem *reg;
@@ -347,13 +351,14 @@ static int samsung_pinmux_gpio_set_direction(struct pinctrl_dev *pctldev,
 	unsigned long flags;
 
 	bank = gc_to_pin_bank(range->gc);
+	type = bank->type;
 	drvdata = pinctrl_dev_get_drvdata(pctldev);
 
 	pin_offset = offset - bank->pin_base;
 	reg = drvdata->virt_base + bank->pctl_offset;
 
-	mask = (1 << bank->func_width) - 1;
-	shift = pin_offset * bank->func_width;
+	mask = (1 << type->fld_width[PINCFG_TYPE_FUNC]) - 1;
+	shift = pin_offset * type->fld_width[PINCFG_TYPE_FUNC];
 
 	spin_lock_irqsave(&bank->slock, flags);
 
@@ -383,6 +388,7 @@ static int samsung_pinconf_rw(struct pinctrl_dev *pctldev, unsigned int pin,
 				unsigned long *config, bool set)
 {
 	struct samsung_pinctrl_drv_data *drvdata;
+	struct samsung_pin_bank_type *type;
 	struct samsung_pin_bank *bank;
 	void __iomem *reg_base;
 	enum pincfg_type cfg_type = PINCFG_UNPACK_TYPE(*config);
@@ -393,22 +399,19 @@ static int samsung_pinconf_rw(struct pinctrl_dev *pctldev, unsigned int pin,
 	drvdata = pinctrl_dev_get_drvdata(pctldev);
 	pin_to_reg_bank(drvdata, pin - drvdata->ctrl->base, &reg_base,
 					&pin_offset, &bank);
+	type = bank->type;
 
 	switch (cfg_type) {
 	case PINCFG_TYPE_PUD:
-		width = bank->pud_width;
 		cfg_reg = PUD_REG;
 		break;
 	case PINCFG_TYPE_DRV:
-		width = bank->drv_width;
 		cfg_reg = DRV_REG;
 		break;
 	case PINCFG_TYPE_CON_PDN:
-		width = bank->conpdn_width;
 		cfg_reg = CONPDN_REG;
 		break;
 	case PINCFG_TYPE_PUD_PDN:
-		width = bank->pudpdn_width;
 		cfg_reg = PUDPDN_REG;
 		break;
 	default:
@@ -416,9 +419,11 @@ static int samsung_pinconf_rw(struct pinctrl_dev *pctldev, unsigned int pin,
 		return -EINVAL;
 	}
 
-	if (!width)
+	if (cfg_type >= PINCFG_TYPE_NUM || !type->fld_width[cfg_type])
 		return -EINVAL;
 
+	width = type->fld_width[cfg_type];
+
 	spin_lock_irqsave(&bank->slock, flags);
 
 	mask = (1 << width) - 1;
@@ -497,6 +502,7 @@ static const struct pinconf_ops samsung_pinconf_ops = {
 static void samsung_gpio_set(struct gpio_chip *gc, unsigned offset, int value)
 {
 	struct samsung_pin_bank *bank = gc_to_pin_bank(gc);
+	struct samsung_pin_bank_type *type = bank->type;
 	unsigned long flags;
 	void __iomem *reg;
 	u32 data;
diff --git a/drivers/pinctrl/pinctrl-samsung.h b/drivers/pinctrl/pinctrl-samsung.h
index b9dbe79..1c590f7 100644
--- a/drivers/pinctrl/pinctrl-samsung.h
+++ b/drivers/pinctrl/pinctrl-samsung.h
@@ -37,16 +37,22 @@
 
 /**
  * enum pincfg_type - possible pin configuration types supported.
+ * @PINCFG_TYPE_FUNC: Function configuration.
+ * @PINCFG_TYPE_DAT: Pin value configuration.
  * @PINCFG_TYPE_PUD: Pull up/down configuration.
  * @PINCFG_TYPE_DRV: Drive strength configuration.
  * @PINCFG_TYPE_CON_PDN: Pin function in power down mode.
  * @PINCFG_TYPE_PUD_PDN: Pull up/down configuration in power down mode.
  */
 enum pincfg_type {
+	PINCFG_TYPE_FUNC,
+	PINCFG_TYPE_DAT,
 	PINCFG_TYPE_PUD,
 	PINCFG_TYPE_DRV,
 	PINCFG_TYPE_CON_PDN,
 	PINCFG_TYPE_PUD_PDN,
+
+	PINCFG_TYPE_NUM
 };
 
 /*
@@ -103,15 +109,19 @@ enum eint_type {
 struct samsung_pinctrl_drv_data;
 
 /**
+ * struct samsung_pin_bank_type: pin bank type description
+ * @fld_width: widths of configuration bitfields (0 if unavailable)
+ */
+struct samsung_pin_bank_type {
+	u8 fld_width[PINCFG_TYPE_NUM];
+};
+
+/**
  * struct samsung_pin_bank: represent a controller pin-bank.
+ * @type: type of the bank (register offsets and bitfield widths)
  * @pctl_offset: starting offset of the pin-bank registers.
  * @pin_base: starting pin number of the bank.
  * @nr_pins: number of pins included in this bank.
- * @func_width: width of the function selector bit field.
- * @pud_width: width of the pin pull up/down selector bit field.
- * @drv_width: width of the pin driver strength selector bit field.
- * @conpdn_width: width of the sleep mode function selector bin field.
- * @pudpdn_width: width of the sleep mode pull up/down selector bit field.
  * @eint_type: type of the external interrupt supported by the bank.
  * @name: name to be prefixed for each pin in this pin bank.
  * @of_node: OF node of the bank.
@@ -122,14 +132,10 @@ struct samsung_pinctrl_drv_data;
  * @slock: spinlock protecting bank registers
  */
 struct samsung_pin_bank {
+	struct samsung_pin_bank_type *type;
 	u32		pctl_offset;
 	u32		pin_base;
 	u8		nr_pins;
-	u8		func_width;
-	u8		pud_width;
-	u8		drv_width;
-	u8		conpdn_width;
-	u8		pudpdn_width;
 	enum eint_type	eint_type;
 	u32		eint_offset;
 	char		*name;
-- 
1.8.1.5
