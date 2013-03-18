From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 18 Mar 2013 22:31:53 +0100
Subject: [PATCH 4/6] pinctrl: samsung: Remove hardcoded register offsets
In-Reply-To: <1363642315-10331-1-git-send-email-tomasz.figa@gmail.com>
References: <1363642315-10331-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1363642315-10331-5-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replaces statically hardcoded register offsets of Exynos SoCs
with an array of register offsets in samsung_pin_bank_type struct.

Thanks to this change, support for SoCs with other set and order of
registers can be added (e.g. S3C24xx and S3C64xx).

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/pinctrl/pinctrl-exynos.c  |  6 ++++--
 drivers/pinctrl/pinctrl-samsung.c | 37 +++++++++----------------------------
 drivers/pinctrl/pinctrl-samsung.h |  9 ++-------
 3 files changed, 15 insertions(+), 37 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-exynos.c b/drivers/pinctrl/pinctrl-exynos.c
index b5dbb87..8b10b1a 100644
--- a/drivers/pinctrl/pinctrl-exynos.c
+++ b/drivers/pinctrl/pinctrl-exynos.c
@@ -37,10 +37,12 @@
 
 static struct samsung_pin_bank_type bank_type_off = {
 	.fld_width = { 4, 1, 2, 2, 2, 2, },
+	.reg_offset = { 0x00, 0x04, 0x08, 0x0c, 0x10, 0x14, },
 };
 
 static struct samsung_pin_bank_type bank_type_alive = {
 	.fld_width = { 4, 1, 2, 2, },
+	.reg_offset = { 0x00, 0x04, 0x08, 0x0c, },
 };
 
 /* list of external wakeup controllers supported */
@@ -126,7 +128,7 @@ static int exynos_gpio_irq_set_type(struct irq_data *irqd, unsigned int type)
 	con |= trig_type << shift;
 	writel(con, d->virt_base + reg_con);
 
-	reg_con = bank->pctl_offset;
+	reg_con = bank->pctl_offset + bank_type->reg_offset[PINCFG_TYPE_FUNC];
 	shift = pin * bank_type->fld_width[PINCFG_TYPE_FUNC];
 	mask = (1 << bank_type->fld_width[PINCFG_TYPE_FUNC]) - 1;
 
@@ -309,7 +311,7 @@ static int exynos_wkup_irq_set_type(struct irq_data *irqd, unsigned int type)
 	con |= trig_type << shift;
 	writel(con, d->virt_base + reg_con);
 
-	reg_con = bank->pctl_offset;
+	reg_con = bank->pctl_offset + bank_type->reg_offset[PINCFG_TYPE_FUNC];
 	shift = pin * bank_type->fld_width[PINCFG_TYPE_FUNC];
 	mask = (1 << bank_type->fld_width[PINCFG_TYPE_FUNC]) - 1;
 
diff --git a/drivers/pinctrl/pinctrl-samsung.c b/drivers/pinctrl/pinctrl-samsung.c
index ac428ff..45a9939 100644
--- a/drivers/pinctrl/pinctrl-samsung.c
+++ b/drivers/pinctrl/pinctrl-samsung.c
@@ -275,10 +275,6 @@ static void pin_to_reg_bank(struct samsung_pinctrl_drv_data *drvdata,
 	*offset = pin - b->pin_base;
 	if (bank)
 		*bank = b;
-
-	/* some banks have two config registers in a single bank */
-	if (*offset * b->func_width > BITS_PER_LONG)
-		*reg += 4;
 }
 
 /* enable or disable a pinmux function */
@@ -310,11 +306,11 @@ static void samsung_pinmux_setup(struct pinctrl_dev *pctldev, unsigned selector,
 
 		spin_lock_irqsave(&bank->slock, flags);
 
-		data = readl(reg);
+		data = readl(reg + type->reg_offset[PINCFG_TYPE_FUNC]);
 		data &= ~(mask << shift);
 		if (enable)
 			data |= drvdata->pin_groups[group].func << shift;
-		writel(data, reg);
+		writel(data, reg + type->reg_offset[PINCFG_TYPE_FUNC]);
 
 		spin_unlock_irqrestore(&bank->slock, flags);
 	}
@@ -355,7 +351,8 @@ static int samsung_pinmux_gpio_set_direction(struct pinctrl_dev *pctldev,
 	drvdata = pinctrl_dev_get_drvdata(pctldev);
 
 	pin_offset = offset - bank->pin_base;
-	reg = drvdata->virt_base + bank->pctl_offset;
+	reg = drvdata->virt_base + bank->pctl_offset +
+					type->reg_offset[PINCFG_TYPE_FUNC];
 
 	mask = (1 << type->fld_width[PINCFG_TYPE_FUNC]) - 1;
 	shift = pin_offset * type->fld_width[PINCFG_TYPE_FUNC];
@@ -401,28 +398,11 @@ static int samsung_pinconf_rw(struct pinctrl_dev *pctldev, unsigned int pin,
 					&pin_offset, &bank);
 	type = bank->type;
 
-	switch (cfg_type) {
-	case PINCFG_TYPE_PUD:
-		cfg_reg = PUD_REG;
-		break;
-	case PINCFG_TYPE_DRV:
-		cfg_reg = DRV_REG;
-		break;
-	case PINCFG_TYPE_CON_PDN:
-		cfg_reg = CONPDN_REG;
-		break;
-	case PINCFG_TYPE_PUD_PDN:
-		cfg_reg = PUDPDN_REG;
-		break;
-	default:
-		WARN_ON(1);
-		return -EINVAL;
-	}
-
 	if (cfg_type >= PINCFG_TYPE_NUM || !type->fld_width[cfg_type])
 		return -EINVAL;
 
 	width = type->fld_width[cfg_type];
+	cfg_reg = type->reg_offset[cfg_type];
 
 	spin_lock_irqsave(&bank->slock, flags);
 
@@ -511,11 +491,11 @@ static void samsung_gpio_set(struct gpio_chip *gc, unsigned offset, int value)
 
 	spin_lock_irqsave(&bank->slock, flags);
 
-	data = readl(reg + DAT_REG);
+	data = readl(reg + type->reg_offset[PINCFG_TYPE_DAT]);
 	data &= ~(1 << offset);
 	if (value)
 		data |= 1 << offset;
-	writel(data, reg + DAT_REG);
+	writel(data, reg + type->reg_offset[PINCFG_TYPE_DAT]);
 
 	spin_unlock_irqrestore(&bank->slock, flags);
 }
@@ -526,10 +506,11 @@ static int samsung_gpio_get(struct gpio_chip *gc, unsigned offset)
 	void __iomem *reg;
 	u32 data;
 	struct samsung_pin_bank *bank = gc_to_pin_bank(gc);
+	struct samsung_pin_bank_type *type = bank->type;
 
 	reg = bank->drvdata->virt_base + bank->pctl_offset;
 
-	data = readl(reg + DAT_REG);
+	data = readl(reg + type->reg_offset[PINCFG_TYPE_DAT]);
 	data >>= offset;
 	data &= 1;
 	return data;
diff --git a/drivers/pinctrl/pinctrl-samsung.h b/drivers/pinctrl/pinctrl-samsung.h
index 1c590f7..9efeee8 100644
--- a/drivers/pinctrl/pinctrl-samsung.h
+++ b/drivers/pinctrl/pinctrl-samsung.h
@@ -25,13 +25,6 @@
 
 #include <linux/gpio.h>
 
-/* register offsets within a pin bank */
-#define DAT_REG		0x4
-#define PUD_REG		0x8
-#define DRV_REG		0xC
-#define CONPDN_REG	0x10
-#define PUDPDN_REG	0x14
-
 /* pinmux function number for pin as gpio output line */
 #define FUNC_OUTPUT	0x1
 
@@ -111,9 +104,11 @@ struct samsung_pinctrl_drv_data;
 /**
  * struct samsung_pin_bank_type: pin bank type description
  * @fld_width: widths of configuration bitfields (0 if unavailable)
+ * @reg_offset: offsets of configuration registers (don't care of width is 0)
  */
 struct samsung_pin_bank_type {
 	u8 fld_width[PINCFG_TYPE_NUM];
+	u8 reg_offset[PINCFG_TYPE_NUM];
 };
 
 /**
-- 
1.8.1.5
