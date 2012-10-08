From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 08 Oct 2012 10:39:10 +0200
Subject: [PATCH 10/16] pinctrl: samsung: Do not pass gpio_chip to
 pin_to_reg_bank
In-Reply-To: <1349685556-23718-1-git-send-email-t.figa@samsung.com>
References: <1349685556-23718-1-git-send-email-t.figa@samsung.com>
Message-ID: <1349685556-23718-11-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pointer to gpio_chip passed to pin_to_reg_bank utility function is
used only to retrieve a pointer to samsung_pinctrl_drv_data structure.

This patch modifies the function and its users to pass a pointer to
samsung_pinctrl_drv_data directly.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 drivers/pinctrl/pinctrl-samsung.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-samsung.c b/drivers/pinctrl/pinctrl-samsung.c
index 6ae82d5..e63a365 100644
--- a/drivers/pinctrl/pinctrl-samsung.c
+++ b/drivers/pinctrl/pinctrl-samsung.c
@@ -252,14 +252,12 @@ static int samsung_pinmux_get_groups(struct pinctrl_dev *pctldev,
  * given a pin number that is local to a pin controller, find out the pin bank
  * and the register base of the pin bank.
  */
-static void pin_to_reg_bank(struct gpio_chip *gc, unsigned pin,
-			void __iomem **reg, u32 *offset,
+static void pin_to_reg_bank(struct samsung_pinctrl_drv_data *drvdata,
+			unsigned pin, void __iomem **reg, u32 *offset,
 			struct samsung_pin_bank **bank)
 {
-	struct samsung_pinctrl_drv_data *drvdata;
 	struct samsung_pin_bank *b;
 
-	drvdata = dev_get_drvdata(gc->dev);
 	b = drvdata->ctrl->pin_banks;
 
 	while ((pin >= b->pin_base) &&
@@ -294,7 +292,7 @@ static void samsung_pinmux_setup(struct pinctrl_dev *pctldev, unsigned selector,
 	 * pin function number in the config register.
 	 */
 	for (cnt = 0; cnt < drvdata->pin_groups[group].num_pins; cnt++) {
-		pin_to_reg_bank(drvdata->gc, pins[cnt] - drvdata->ctrl->base,
+		pin_to_reg_bank(drvdata, pins[cnt] - drvdata->ctrl->base,
 				&reg, &pin_offset, &bank);
 		mask = (1 << bank->func_width) - 1;
 		shift = pin_offset * bank->func_width;
@@ -331,10 +329,13 @@ static int samsung_pinmux_gpio_set_direction(struct pinctrl_dev *pctldev,
 		struct pinctrl_gpio_range *range, unsigned offset, bool input)
 {
 	struct samsung_pin_bank *bank;
+	struct samsung_pinctrl_drv_data *drvdata;
 	void __iomem *reg;
 	u32 data, pin_offset, mask, shift;
 
-	pin_to_reg_bank(range->gc, offset, &reg, &pin_offset, &bank);
+	drvdata = pinctrl_dev_get_drvdata(pctldev);
+
+	pin_to_reg_bank(drvdata, offset, &reg, &pin_offset, &bank);
 	mask = (1 << bank->func_width) - 1;
 	shift = pin_offset * bank->func_width;
 
@@ -368,7 +369,7 @@ static int samsung_pinconf_rw(struct pinctrl_dev *pctldev, unsigned int pin,
 	u32 cfg_value, cfg_reg;
 
 	drvdata = pinctrl_dev_get_drvdata(pctldev);
-	pin_to_reg_bank(drvdata->gc, pin - drvdata->ctrl->base, &reg_base,
+	pin_to_reg_bank(drvdata, pin - drvdata->ctrl->base, &reg_base,
 					&pin_offset, &bank);
 
 	switch (cfg_type) {
@@ -470,8 +471,11 @@ static void samsung_gpio_set(struct gpio_chip *gc, unsigned offset, int value)
 {
 	void __iomem *reg;
 	u32 pin_offset, data;
+	struct samsung_pinctrl_drv_data *drvdata;
 
-	pin_to_reg_bank(gc, offset, &reg, &pin_offset, NULL);
+	drvdata = dev_get_drvdata(gc->dev);
+
+	pin_to_reg_bank(drvdata, offset, &reg, &pin_offset, NULL);
 	data = readl(reg + DAT_REG);
 	data &= ~(1 << pin_offset);
 	if (value)
@@ -484,8 +488,11 @@ static int samsung_gpio_get(struct gpio_chip *gc, unsigned offset)
 {
 	void __iomem *reg;
 	u32 pin_offset, data;
+	struct samsung_pinctrl_drv_data *drvdata;
+
+	drvdata = dev_get_drvdata(gc->dev);
 
-	pin_to_reg_bank(gc, offset, &reg, &pin_offset, NULL);
+	pin_to_reg_bank(drvdata, offset, &reg, &pin_offset, NULL);
 	data = readl(reg + DAT_REG);
 	data >>= pin_offset;
 	data &= 1;
-- 
1.7.12
