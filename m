From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 20 Nov 2012 22:31:40 +0100
Subject: [PATCH 2/5] pinctrl: at91 add deglitch, debounce,
 pull down and schmitt trigger mux option support
In-Reply-To: <1353447103-31616-1-git-send-email-plagnioj@jcrosoft.com>
References: <20121120212326.GO4398@game.jcrosoft.org>
 <1353447103-31616-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1353447103-31616-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add :
 set_deglitch: enable/disable deglitch
 set_debounce: enable/disable debounce
 set_pulldown: enable/disable pulldown
 disable_schmitt_trig: disable schmitt trigger

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/pinctrl/atmel,at91-pinctrl.txt        |    9 +-
 drivers/pinctrl/pinctrl-at91.c                     |  111 ++++++++++++++++++++
 2 files changed, 118 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
index 20a987e..3a26812 100644
--- a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
@@ -84,8 +84,13 @@ Required properties for pin configuration node:
   The PERIPH 0 means gpio.
 
 Bits used for CONFIG:
-PULL_UP(1 << 0): indicate this pin need a pull up.
-MULTIDRIVE(1 << 1): indicate this pin need to be configured as multidrive.
+PULL_UP		(1 << 0): indicate this pin need a pull up.
+MULTIDRIVE	(1 << 1): indicate this pin need to be configured as multidrive.
+DEGLITCH	(1 << 2): indicate this pin need deglitch.
+PULL_DOWN	(1 << 3): indicate this pin need a pull down.
+DIS_SCHMIT	(1 << 4): indicate this pin need to disable schmit trigger.
+DEBOUNCE	(1 << 16): indicate this pin need debounce.
+DEBOUNCE_VAL	(0x3fff << 17): debounce val.
 
 NOTE:
 Some requirements for using atmel,at91rm9200-pinctrl binding:
diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 401fc96..0d7e6c3 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -59,6 +59,12 @@ static int gpio_banks;
 
 #define PULL_UP		(1 << 0)
 #define MULTI_DRIVE	(1 << 1)
+#define DEGLITCH	(1 << 2)
+#define PULL_DOWN	(1 << 3)
+#define DIS_SCHMIT	(1 << 4)
+#define DEBOUNCE	(1 << 16)
+#define DEBOUNCE_VAL_SHIFT	17
+#define DEBOUNCE_VAL	(0x3fff << DEBOUNCE_VAL_SHIFT)
 
 /**
  * struct at91_pmx_func - describes AT91 pinmux functions
@@ -122,6 +128,14 @@ struct at91_pin_group {
  * @mux_B_periph: mux as periph B
  * @mux_C_periph: mux as periph C
  * @mux_D_periph: mux as periph D
+ * @get_deglitch: get deglitch status
+ * @set_deglitch: enable/disable deglitch
+ * @get_debounce: get debounce status
+ * @set_debounce: enable/disable debounce
+ * @get_pulldown: get pulldown status
+ * @set_pulldown: enable/disable pulldown
+ * @get_schmitt_trig: get schmitt trigger status
+ * @disable_schmitt_trig: disable schmitt trigger
  * @irq_type: return irq type
  */
 struct at91_pinctrl_mux_ops {
@@ -130,6 +144,14 @@ struct at91_pinctrl_mux_ops {
 	void (*mux_B_periph)(void __iomem *pio, unsigned mask);
 	void (*mux_C_periph)(void __iomem *pio, unsigned mask);
 	void (*mux_D_periph)(void __iomem *pio, unsigned mask);
+	bool (*get_deglitch)(void __iomem *pio, unsigned pin);
+	void (*set_deglitch)(void __iomem *pio, unsigned mask, bool in_on);
+	bool (*get_debounce)(void __iomem *pio, unsigned pin, u32 *div);
+	void (*set_debounce)(void __iomem *pio, unsigned mask, bool in_on, u32 div);
+	bool (*get_pulldown)(void __iomem *pio, unsigned pin);
+	void (*set_pulldown)(void __iomem *pio, unsigned mask, bool in_on);
+	bool (*get_schmitt_trig)(void __iomem *pio, unsigned pin);
+	void (*disable_schmitt_trig)(void __iomem *pio, unsigned mask);
 	/* irq */
 	int (*irq_type)(struct irq_data *d, unsigned type);
 };
@@ -386,10 +408,68 @@ static enum at91_mux at91_mux_get_periph(void __iomem *pio, unsigned mask)
 	return select + 1;
 }
 
+static bool at91_mux_get_deglitch(void __iomem *pio, unsigned pin)
+{
+	return (__raw_readl(pio + PIO_IFSR) >> pin) & 0x1;
+}
+
+static void at91_mux_set_deglitch(void __iomem *pio, unsigned mask, bool is_on)
+{
+	__raw_writel(mask, pio + (is_on ? PIO_IFER : PIO_IFDR));
+}
+
+static void at91_mux_pio3_set_deglitch(void __iomem *pio, unsigned mask, bool is_on)
+{
+	if (is_on)
+		__raw_writel(mask, pio + PIO_IFSCDR);
+	at91_mux_set_deglitch(pio, mask, is_on);
+}
+
+static bool at91_mux_pio3_get_debounce(void __iomem *pio, unsigned pin, u32 *div)
+{
+	*div = __raw_readl(pio + PIO_SCDR);
+
+	return (__raw_readl(pio + PIO_IFSCSR) >> pin) & 0x1;
+}
+
+static void at91_mux_pio3_set_debounce(void __iomem *pio, unsigned mask,
+				bool is_on, u32 div)
+{
+	if (is_on) {
+		__raw_writel(mask, pio + PIO_IFSCER);
+		__raw_writel(div & PIO_SCDR_DIV, pio + PIO_SCDR);
+		__raw_writel(mask, pio + PIO_IFER);
+	} else {
+		__raw_writel(mask, pio + PIO_IFDR);
+	}
+}
+
+static bool at91_mux_pio3_get_pulldown(void __iomem *pio, unsigned pin)
+{
+	return (__raw_readl(pio + PIO_PPDSR) >> pin) & 0x1;
+}
+
+static void at91_mux_pio3_set_pulldown(void __iomem *pio, unsigned mask, bool is_on)
+{
+	__raw_writel(mask, pio + (is_on ? PIO_PPDER : PIO_PPDDR));
+}
+
+static void at91_mux_pio3_disable_schmitt_trig(void __iomem *pio, unsigned mask)
+{
+	__raw_writel(__raw_readl(pio + PIO_SCHMITT) | mask, pio + PIO_SCHMITT);
+}
+
+static bool at91_mux_pio3_get_schmitt_trig(void __iomem *pio, unsigned pin)
+{
+	return (__raw_readl(pio + PIO_SCHMITT) >> pin) & 0x1;
+}
+
 static struct at91_pinctrl_mux_ops at91rm9200_ops = {
 	.get_periph	= at91_mux_get_periph,
 	.mux_A_periph	= at91_mux_set_A_periph,
 	.mux_B_periph	= at91_mux_set_B_periph,
+	.get_deglitch	= at91_mux_get_deglitch,
+	.set_deglitch	= at91_mux_set_deglitch,
 	.irq_type	= gpio_irq_type,
 };
 
@@ -399,6 +479,14 @@ static struct at91_pinctrl_mux_ops at91sam9x5_ops = {
 	.mux_B_periph	= at91_mux_pio3_set_B_periph,
 	.mux_C_periph	= at91_mux_pio3_set_C_periph,
 	.mux_D_periph	= at91_mux_pio3_set_D_periph,
+	.get_deglitch	= at91_mux_get_deglitch,
+	.set_deglitch	= at91_mux_pio3_set_deglitch,
+	.get_debounce	= at91_mux_pio3_get_debounce,
+	.set_debounce	= at91_mux_pio3_set_debounce,
+	.get_pulldown	= at91_mux_pio3_get_pulldown,
+	.set_pulldown	= at91_mux_pio3_set_pulldown,
+	.get_schmitt_trig = at91_mux_pio3_get_schmitt_trig,
+	.disable_schmitt_trig = at91_mux_pio3_disable_schmitt_trig,
 	.irq_type	= alt_gpio_irq_type,
 };
 
@@ -624,6 +712,7 @@ static int at91_pinconf_get(struct pinctrl_dev *pctldev,
 	struct at91_pinctrl *info = pinctrl_dev_get_drvdata(pctldev);
 	void __iomem *pio;
 	unsigned pin;
+	int div;
 
 	dev_dbg(info->dev, "%s:%d, pin_id=%d, config=0x%lx", __func__, __LINE__, pin_id, *config);
 	pio = pin_to_controller(info, pin_to_bank(pin_id));
@@ -635,6 +724,15 @@ static int at91_pinconf_get(struct pinctrl_dev *pctldev,
 	if (at91_mux_get_pullup(pio, pin))
 		*config |= PULL_UP;
 
+	if (info->ops->get_deglitch && info->ops->get_deglitch(pio, pin))
+		*config |= DEGLITCH;
+	if (info->ops->get_debounce && info->ops->get_debounce(pio, pin, &div))
+		*config |= DEBOUNCE | (div << DEBOUNCE_VAL_SHIFT);
+	if (info->ops->get_pulldown && info->ops->get_pulldown(pio, pin))
+		*config |= PULL_DOWN;
+	if (info->ops->get_schmitt_trig && info->ops->get_schmitt_trig(pio, pin))
+		*config |= DIS_SCHMIT;
+
 	return 0;
 }
 
@@ -649,8 +747,21 @@ static int at91_pinconf_set(struct pinctrl_dev *pctldev,
 	pio = pin_to_controller(info, pin_to_bank(pin_id));
 	mask = pin_to_mask(pin_id % MAX_NB_GPIO_PER_BANK);
 
+	if (config & PULL_UP && config & PULL_DOWN)
+		return -EINVAL;
+
 	at91_mux_set_pullup(pio, mask, config & PULL_UP);
 	at91_mux_set_multidrive(pio, mask, config & MULTI_DRIVE);
+	if (info->ops->set_deglitch)
+		info->ops->set_deglitch(pio, mask, config & DEGLITCH);
+	if (info->ops->set_debounce)
+		info->ops->set_debounce(pio, mask, config & DEBOUNCE,
+				(config & DEBOUNCE_VAL) >> DEBOUNCE_VAL_SHIFT);
+	if (info->ops->set_pulldown)
+		info->ops->set_pulldown(pio, mask, config & PULL_DOWN);
+	if (info->ops->disable_schmitt_trig && config & DIS_SCHMIT)
+		info->ops->disable_schmitt_trig(pio, mask);
+
 	return 0;
 }
 
-- 
1.7.10.4
