From: mark.roszko@gmail.com (Marek Roszko)
Date: Tue, 21 Jan 2014 01:33:11 -0500
Subject: [PATCH] pinctrl:at91:add drive strength configuration
In-Reply-To: <20140121060637.GP9558@ns203013.ovh.net>
References: <20140121060637.GP9558@ns203013.ovh.net>
Message-ID: <1390285991-1634-1-git-send-email-mark.roszko@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SAMA5 and most SAM9xGs(baring a few exceptions like the SAM945G) have drive
control registers that allow configuring the output current of the gpio pins between
three predefined levels of low,medium and high drive.

This patch adds four new dt-bindings that allow setting the strength via the device tree.
Added set/get drive strength to pinctrl ops table.
A sama5d3-gpio of id entry was made to set the set/get drive strength function for the
sam5d3s which unforunately have different register addresses and strength-to-value
map than the sam9s.
Added PIO_DRIVER1/2 defines in at91_pio.h prefixed with the target SoC.
---
 arch/arm/boot/dts/sama5d3.dtsi             |   10 +--
 arch/arm/mach-at91/include/mach/at91_pio.h |    7 ++
 drivers/pinctrl/pinctrl-at91.c             |  131 +++++++++++++++++++++++++++-
 include/dt-bindings/pinctrl/at91.h         |    5 ++
 4 files changed, 147 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 5cdaba4..5576330 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -619,7 +619,7 @@
 
 
 				pioA: gpio at fffff200 {
-					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					compatible = "atmel,sama5d3-gpio", "atmel,at91rm9200-gpio";
 					reg = <0xfffff200 0x100>;
 					interrupts = <6 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
@@ -629,7 +629,7 @@
 				};
 
 				pioB: gpio at fffff400 {
-					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					compatible = "atmel,sama5d3-gpio", "atmel,at91rm9200-gpio";
 					reg = <0xfffff400 0x100>;
 					interrupts = <7 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
@@ -639,7 +639,7 @@
 				};
 
 				pioC: gpio at fffff600 {
-					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					compatible = "atmel,sama5d3-gpio", "atmel,at91rm9200-gpio";
 					reg = <0xfffff600 0x100>;
 					interrupts = <8 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
@@ -649,7 +649,7 @@
 				};
 
 				pioD: gpio at fffff800 {
-					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					compatible = "atmel,sama5d3-gpio", "atmel,at91rm9200-gpio";
 					reg = <0xfffff800 0x100>;
 					interrupts = <9 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
@@ -659,7 +659,7 @@
 				};
 
 				pioE: gpio at fffffa00 {
-					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					compatible = "atmel,sama5d3-gpio", "atmel,at91rm9200-gpio";
 					reg = <0xfffffa00 0x100>;
 					interrupts = <10 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
diff --git a/arch/arm/mach-at91/include/mach/at91_pio.h b/arch/arm/mach-at91/include/mach/at91_pio.h
index 732b11c..b1e6380 100644
--- a/arch/arm/mach-at91/include/mach/at91_pio.h
+++ b/arch/arm/mach-at91/include/mach/at91_pio.h
@@ -66,6 +66,13 @@
 #define PIO_FRLHSR	0xd8	/* Fall/Rise - Low/High Status Register */
 #define PIO_SCHMITT	0x100	/* Schmitt Trigger Register */
 
+
+#define SAMA5D3_PIO_DRIVER1		0x118  /*PIO Driver 1 register offset*/
+#define SAMA5D3_PIO_DRIVER2		0x11C  /*PIO Driver 2 register offset*/
+
+#define AT91SAM9X5_PIO_DRIVER1	0x114  /*PIO Driver 1 register offset*/
+#define AT91SAM9X5_PIO_DRIVER2	0x118  /*PIO Driver 2 register offset*/
+
 #define ABCDSR_PERIPH_A	0x0
 #define ABCDSR_PERIPH_B	0x1
 #define ABCDSR_PERIPH_C	0x2
diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index a7549c4..d79e085 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -62,10 +62,21 @@ static int gpio_banks;
 #define DEGLITCH	(1 << 2)
 #define PULL_DOWN	(1 << 3)
 #define DIS_SCHMIT	(1 << 4)
+#define DRIVE_STRENGTH_SHIFT    5
+#define DRIVE_STRENGTH   (0x3 << DRIVE_STRENGTH_SHIFT)
 #define DEBOUNCE	(1 << 16)
 #define DEBOUNCE_VAL_SHIFT	17
 #define DEBOUNCE_VAL	(0x3fff << DEBOUNCE_VAL_SHIFT)
 
+#define DRIVE_STRENGTH_DEFAULT	(0x0 << 5)
+#define DRIVE_STRENGTH_LOW		(0x1 << 5)
+#define DRIVE_STRENGTH_MED		(0x2 << 5)
+#define DRIVE_STRENGTH_HI		(0x3 << 5)
+
+
+#define DRIVE_STRENGTH_MASK  0x3
+#define NUM_PINS_PER_DIVIDED_REGS	16
+
 /**
  * struct at91_pmx_func - describes AT91 pinmux functions
  * @name: the name of this specific function
@@ -148,6 +159,8 @@ struct at91_pinctrl_mux_ops {
 	void (*set_deglitch)(void __iomem *pio, unsigned mask, bool is_on);
 	bool (*get_debounce)(void __iomem *pio, unsigned pin, u32 *div);
 	void (*set_debounce)(void __iomem *pio, unsigned mask, bool is_on, u32 div);
+	unsigned (*get_drivestrength)(void __iomem *pio, unsigned pin);
+	void (*set_drivestrength)(void __iomem *pio, unsigned pin, u32 strength);
 	bool (*get_pulldown)(void __iomem *pio, unsigned pin);
 	void (*set_pulldown)(void __iomem *pio, unsigned mask, bool is_on);
 	bool (*get_schmitt_trig)(void __iomem *pio, unsigned pin);
@@ -319,6 +332,24 @@ static unsigned pin_to_mask(unsigned int pin)
 	return 1 << pin;
 }
 
+static inline int two_bit_pin_value_shift(unsigned pin)
+{
+	return 2*((pin >= NUM_PINS_PER_DIVIDED_REGS) 
+			? pin - NUM_PINS_PER_DIVIDED_REGS : pin);
+}
+
+static unsigned sama5d3_get_drive_register(unsigned int pin)
+{
+	return (pin > NUM_PINS_PER_DIVIDED_REGS-1)
+			 ? SAMA5D3_PIO_DRIVER2: SAMA5D3_PIO_DRIVER1;
+}
+
+static unsigned at91sam9x5_get_drive_register(unsigned int pin)
+{
+	return (pin > NUM_PINS_PER_DIVIDED_REGS-1)
+			 ? AT91SAM9X5_PIO_DRIVER2: AT91SAM9X5_PIO_DRIVER1;
+}
+
 static void at91_mux_disable_interrupt(void __iomem *pio, unsigned mask)
 {
 	writel_relaxed(mask, pio + PIO_IDR);
@@ -462,6 +493,73 @@ static void at91_mux_pio3_set_pulldown(void __iomem *pio, unsigned mask, bool is
 	__raw_writel(mask, pio + (is_on ? PIO_PPDER : PIO_PPDDR));
 }
 
+static inline u32 read_drive_strength(void __iomem *reg, unsigned pin)
+{
+	unsigned tmp = __raw_readl(reg);
+	tmp = tmp >> two_bit_pin_value_shift(pin)
+
+	return tmp & DRIVE_STRENGTH_MASK;
+}
+
+static unsigned at91_mux_sama5d3_get_drivestrength(void __iomem *pio, unsigned pin)
+{
+	unsigned tmp = read_drive_strength(pio + sama5d3_get_drive_register(pin), pin);
+
+	/*value of 0 = low, all other values are 1 to 1*/
+	if (!tmp)
+		tmp = DRIVE_STRENGTH_LOW;
+
+	return tmp;
+}
+
+static unsigned at91_mux_sam9x5_get_drivestrength(void __iomem *pio, unsigned pin)
+{
+	unsigned tmp = read_drive_strength(pio + at91sam9x5_get_drive_register(pin), pin);
+
+	/*
+	 * inverse the setting for dt defines
+	 * 0 = hi, 1 = med, 2 = low, 3 = rsvd
+	 */
+	tmp = DRIVE_STRENGTH_HI - tmp;
+
+	return tmp;
+}
+
+static void set_drive_strength(void __iomem *reg, unsigned pin, u32 strength)
+{
+	unsigned tmp = __raw_readl(reg);
+
+	tmp &= ~(DRIVE_STRENGTH_MASK  <<  two_bit_pin_value_shift(pin));
+	tmp |= strength << two_bit_pin_value_shift(pin);
+
+    __raw_writel(tmp, reg);
+}
+
+static void at91_mux_sama5d3_set_drivestrength(void __iomem *pio, unsigned pin,
+											u32 setting)
+{
+	/* do nothing if setting is zero */
+	if (!setting)
+		return;
+
+	/* strength is 1 to 1 with setting for SAMA5 */
+	set_drive_strength(pio + sama5d3_get_drive_register(pin), pin, setting);
+}
+
+static void at91_mux_sam9x5_set_drivestrength(void __iomem *pio, unsigned pin,
+											u32 setting)
+{
+	/* do nothing if setting is zero */
+	if (!setting)
+		return;
+
+	/* strength is inverse on SAM9s, 0 = hi, 1 = med, 2 = low, 3 = rsvd */
+	setting = DRIVE_STRENGTH_HI - setting;
+
+	set_drive_strength(pio + at91sam9x5_get_drive_register(pin), pin, setting);
+}
+
+
 static void at91_mux_pio3_disable_schmitt_trig(void __iomem *pio, unsigned mask)
 {
 	__raw_writel(__raw_readl(pio + PIO_SCHMITT) | mask, pio + PIO_SCHMITT);
@@ -491,6 +589,27 @@ static struct at91_pinctrl_mux_ops at91sam9x5_ops = {
 	.set_deglitch	= at91_mux_pio3_set_deglitch,
 	.get_debounce	= at91_mux_pio3_get_debounce,
 	.set_debounce	= at91_mux_pio3_set_debounce,
+	.get_drivestrength = at91_mux_sam9x5_get_drivestrength,
+	.set_drivestrength = at91_mux_sam9x5_set_drivestrength,
+	.get_pulldown	= at91_mux_pio3_get_pulldown,
+	.set_pulldown	= at91_mux_pio3_set_pulldown,
+	.get_schmitt_trig = at91_mux_pio3_get_schmitt_trig,
+	.disable_schmitt_trig = at91_mux_pio3_disable_schmitt_trig,
+	.irq_type	= alt_gpio_irq_type,
+};
+
+static struct at91_pinctrl_mux_ops sama5d3_ops = {
+	.get_periph	= at91_mux_pio3_get_periph,
+	.mux_A_periph	= at91_mux_pio3_set_A_periph,
+	.mux_B_periph	= at91_mux_pio3_set_B_periph,
+	.mux_C_periph	= at91_mux_pio3_set_C_periph,
+	.mux_D_periph	= at91_mux_pio3_set_D_periph,
+	.get_deglitch	= at91_mux_pio3_get_deglitch,
+	.set_deglitch	= at91_mux_pio3_set_deglitch,
+	.get_debounce	= at91_mux_pio3_get_debounce,
+	.set_debounce	= at91_mux_pio3_set_debounce,
+	.get_drivestrength = at91_mux_sama5d3_get_drivestrength,
+	.set_drivestrength = at91_mux_sama5d3_set_drivestrength,
 	.get_pulldown	= at91_mux_pio3_get_pulldown,
 	.set_pulldown	= at91_mux_pio3_set_pulldown,
 	.get_schmitt_trig = at91_mux_pio3_get_schmitt_trig,
@@ -498,6 +617,7 @@ static struct at91_pinctrl_mux_ops at91sam9x5_ops = {
 	.irq_type	= alt_gpio_irq_type,
 };
 
+
 static void at91_pin_dbg(const struct device *dev, const struct at91_pmx_pin *pin)
 {
 	if (pin->mux) {
@@ -736,6 +856,9 @@ static int at91_pinconf_get(struct pinctrl_dev *pctldev,
 		*config |= DEGLITCH;
 	if (info->ops->get_debounce && info->ops->get_debounce(pio, pin, &div))
 		*config |= DEBOUNCE | (div << DEBOUNCE_VAL_SHIFT);
+	if (info->ops->get_drivestrength)
+		*config |= DRIVE_STRENGTH | (info->ops->get_drivestrength(pio, pin)
+										 << DRIVE_STRENGTH_SHIFT);
 	if (info->ops->get_pulldown && info->ops->get_pulldown(pio, pin))
 		*config |= PULL_DOWN;
 	if (info->ops->get_schmitt_trig && info->ops->get_schmitt_trig(pio, pin))
@@ -753,6 +876,7 @@ static int at91_pinconf_set(struct pinctrl_dev *pctldev,
 	void __iomem *pio;
 	int i;
 	unsigned long config;
+	unsigned pin;
 
 	for (i = 0; i < num_configs; i++) {
 		config = configs[i];
@@ -761,7 +885,8 @@ static int at91_pinconf_set(struct pinctrl_dev *pctldev,
 			"%s:%d, pin_id=%d, config=0x%lx",
 			__func__, __LINE__, pin_id, config);
 		pio = pin_to_controller(info, pin_to_bank(pin_id));
-		mask = pin_to_mask(pin_id % MAX_NB_GPIO_PER_BANK);
+		pin = pin_id % MAX_NB_GPIO_PER_BANK;
+		mask = pin_to_mask(pin);
 
 		if (config & PULL_UP && config & PULL_DOWN)
 			return -EINVAL;
@@ -773,6 +898,9 @@ static int at91_pinconf_set(struct pinctrl_dev *pctldev,
 		if (info->ops->set_debounce)
 			info->ops->set_debounce(pio, mask, config & DEBOUNCE,
 				(config & DEBOUNCE_VAL) >> DEBOUNCE_VAL_SHIFT);
+		if (info->ops->set_drivestrength)
+			info->ops->set_drivestrength(pio, pin,
+				(config & DRIVE_STRENGTH) >> DRIVE_STRENGTH_SHIFT);
 		if (info->ops->set_pulldown)
 			info->ops->set_pulldown(pio, mask, config & PULL_DOWN);
 		if (info->ops->disable_schmitt_trig && config & DIS_SCHMIT)
@@ -1551,6 +1679,7 @@ static void at91_gpio_probe_fixup(void)
 
 static struct of_device_id at91_gpio_of_match[] = {
 	{ .compatible = "atmel,at91sam9x5-gpio", .data = &at91sam9x5_ops, },
+	{ .compatible = "atmel,sama5d3-gpio", .data = &sama5d3_ops, },
 	{ .compatible = "atmel,at91rm9200-gpio", .data = &at91rm9200_ops },
 	{ /* sentinel */ }
 };
diff --git a/include/dt-bindings/pinctrl/at91.h b/include/dt-bindings/pinctrl/at91.h
index 0fee6ff..af71ebb 100644
--- a/include/dt-bindings/pinctrl/at91.h
+++ b/include/dt-bindings/pinctrl/at91.h
@@ -20,6 +20,11 @@
 
 #define AT91_PINCTRL_PULL_UP_DEGLITCH	(AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DEGLITCH)
 
+#define AT91_PINCTRL_DRIVE_STRENGTH_DEFAULT	(0x0 << 5)
+#define AT91_PINCTRL_DRIVE_STRENGTH_LOW		(0x1 << 5)
+#define AT91_PINCTRL_DRIVE_STRENGTH_MED		(0x2 << 5)
+#define AT91_PINCTRL_DRIVE_STRENGTH_HI		(0x3 << 5)
+
 #define AT91_PIOA	0
 #define AT91_PIOB	1
 #define AT91_PIOC	2
-- 
1.7.10.4
