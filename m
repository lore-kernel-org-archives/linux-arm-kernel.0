From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 02 Jul 2014 17:40:59 +0200
Subject: [PATCH 1/6] pinctrl: samsung: Decouple direction setting from pinctrl
In-Reply-To: <1404315664-3174-1-git-send-email-t.figa@samsung.com>
References: <1404315664-3174-1-git-send-email-t.figa@samsung.com>
Message-ID: <1404315664-3174-2-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes the pinctrl-samsung driver configure GPIO direction on
its own, without using the pinctrl_gpio_direction_*() "helpers". The
rationale behind this change is as follows:
 - pinctrl-samsung does not need translation from GPIO namespace to
   pinctrl namespace to handle GPIO operations - GPIO chip and offset
   therein are enough to calculate necessary offsets and bit masks in
   constant time,
 - the pinctrl_gpio_direction_*() functions do not do anything useful
   other than translating the pin into pinctrl namespace and calling the
   .gpio_set_direction() from pinmux_ops of the controller,
 - the undesirable side effect of using those helpers is losing the
   ability to change GPIO direction in atomic context, because they
   explicitly use a mutex for synchronization,

Results of this patch are:
 - fixed warnings about scheduling while atomic in code that needs to
   set GPIO direction in atomic context (e.g. interrupt handler),
 - reduced overhead of bitbanging drivers that use gpio_direction_*(),
   e.g. i2c-gpio.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 drivers/pinctrl/pinctrl-samsung.c | 99 +++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 55 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-samsung.c b/drivers/pinctrl/pinctrl-samsung.c
index 3e61d0f..779c8bc 100644
--- a/drivers/pinctrl/pinctrl-samsung.c
+++ b/drivers/pinctrl/pinctrl-samsung.c
@@ -340,50 +340,6 @@ static void samsung_pinmux_disable(struct pinctrl_dev *pctldev,
 	samsung_pinmux_setup(pctldev, selector, group, false);
 }
 
-/*
- * The calls to gpio_direction_output() and gpio_direction_input()
- * leads to this function call (via the pinctrl_gpio_direction_{input|output}()
- * function called from the gpiolib interface).
- */
-static int samsung_pinmux_gpio_set_direction(struct pinctrl_dev *pctldev,
-		struct pinctrl_gpio_range *range, unsigned offset, bool input)
-{
-	struct samsung_pin_bank_type *type;
-	struct samsung_pin_bank *bank;
-	struct samsung_pinctrl_drv_data *drvdata;
-	void __iomem *reg;
-	u32 data, pin_offset, mask, shift;
-	unsigned long flags;
-
-	bank = gc_to_pin_bank(range->gc);
-	type = bank->type;
-	drvdata = pinctrl_dev_get_drvdata(pctldev);
-
-	pin_offset = offset - bank->pin_base;
-	reg = drvdata->virt_base + bank->pctl_offset +
-					type->reg_offset[PINCFG_TYPE_FUNC];
-
-	mask = (1 << type->fld_width[PINCFG_TYPE_FUNC]) - 1;
-	shift = pin_offset * type->fld_width[PINCFG_TYPE_FUNC];
-	if (shift >= 32) {
-		/* Some banks have two config registers */
-		shift -= 32;
-		reg += 4;
-	}
-
-	spin_lock_irqsave(&bank->slock, flags);
-
-	data = readl(reg);
-	data &= ~(mask << shift);
-	if (!input)
-		data |= FUNC_OUTPUT << shift;
-	writel(data, reg);
-
-	spin_unlock_irqrestore(&bank->slock, flags);
-
-	return 0;
-}
-
 /* list of pinmux callbacks for the pinmux vertical in pinctrl core */
 static const struct pinmux_ops samsung_pinmux_ops = {
 	.get_functions_count	= samsung_get_functions_count,
@@ -391,7 +347,6 @@ static const struct pinmux_ops samsung_pinmux_ops = {
 	.get_function_groups	= samsung_pinmux_get_groups,
 	.enable			= samsung_pinmux_enable,
 	.disable		= samsung_pinmux_disable,
-	.gpio_set_direction	= samsung_pinmux_gpio_set_direction,
 };
 
 /* set or get the pin config settings for a specified pin */
@@ -540,25 +495,59 @@ static int samsung_gpio_get(struct gpio_chip *gc, unsigned offset)
 }
 
 /*
- * gpiolib gpio_direction_input callback function. The setting of the pin
- * mux function as 'gpio input' will be handled by the pinctrl susbsystem
- * interface.
+ * The calls to gpio_direction_output() and gpio_direction_input()
+ * leads to this function call.
  */
+static int samsung_gpio_set_direction(struct gpio_chip *gc,
+					     unsigned offset, bool input)
+{
+	struct samsung_pin_bank_type *type;
+	struct samsung_pin_bank *bank;
+	struct samsung_pinctrl_drv_data *drvdata;
+	void __iomem *reg;
+	u32 data, mask, shift;
+	unsigned long flags;
+
+	bank = gc_to_pin_bank(gc);
+	type = bank->type;
+	drvdata = bank->drvdata;
+
+	reg = drvdata->virt_base + bank->pctl_offset +
+					type->reg_offset[PINCFG_TYPE_FUNC];
+
+	mask = (1 << type->fld_width[PINCFG_TYPE_FUNC]) - 1;
+	shift = offset * type->fld_width[PINCFG_TYPE_FUNC];
+	if (shift >= 32) {
+		/* Some banks have two config registers */
+		shift -= 32;
+		reg += 4;
+	}
+
+	spin_lock_irqsave(&bank->slock, flags);
+
+	data = readl(reg);
+	data &= ~(mask << shift);
+	if (!input)
+		data |= FUNC_OUTPUT << shift;
+	writel(data, reg);
+
+	spin_unlock_irqrestore(&bank->slock, flags);
+
+	return 0;
+}
+
+/* gpiolib gpio_direction_input callback function. */
 static int samsung_gpio_direction_input(struct gpio_chip *gc, unsigned offset)
 {
-	return pinctrl_gpio_direction_input(gc->base + offset);
+	return samsung_gpio_set_direction(gc, offset, true);
 }
 
-/*
- * gpiolib gpio_direction_output callback function. The setting of the pin
- * mux function as 'gpio output' will be handled by the pinctrl susbsystem
- * interface.
- */
+/* gpiolib gpio_direction_output callback function. */
 static int samsung_gpio_direction_output(struct gpio_chip *gc, unsigned offset,
 							int value)
 {
 	samsung_gpio_set(gc, offset, value);
-	return pinctrl_gpio_direction_output(gc->base + offset);
+	return samsung_gpio_set_direction(gc, offset, false);
 }
 
 /*
-- 
1.9.3
