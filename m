From: mark.roszko@gmail.com (Marek Roszko)
Date: Sat, 23 Aug 2014 23:12:04 -0400
Subject: [PATCH v2 1/3] pinctrl: at91: add drive strength configuration
Message-ID: <1408849926-9603-1-git-send-email-mark.roszko@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SAMA5 and SAM9x5 series both have drive strength options for the PIOs. This
patch adds the ability to set one of three hardware options for drive strengths of low,
medium or high for the each pin. The actual current output of the chip based on the setting
is defined in the datasheets and varies per pins separate from banks and with supply voltage.

This patch adds three new dt-bindings that allow setting the strength when configuring
pins. By default, no change will be made to the drive strength of a pin from its reset value.
Due to the difference between the register addresses of the SAMA5 and SAM9x5 series, a new
sama5d3-pinctrl id was added.

Signed-off-by: Marek Roszko <mark.roszko@gmail.com>

---
changes from v1:
rebased to latest pinctrl
added requested comments
fix oversight in shift logic(off by 1)
---
 arch/arm/mach-at91/include/mach/at91_pio.h |   6 ++
 drivers/pinctrl/pinctrl-at91.c             | 162 ++++++++++++++++++++++++++++-
 include/dt-bindings/pinctrl/at91.h         |   5 +
 3 files changed, 172 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/include/mach/at91_pio.h b/arch/arm/mach-at91/include/mach/at91_pio.h
index 732b11c..7b73662 100644
--- a/arch/arm/mach-at91/include/mach/at91_pio.h
+++ b/arch/arm/mach-at91/include/mach/at91_pio.h
@@ -71,4 +71,10 @@
 #define ABCDSR_PERIPH_C	0x2
 #define ABCDSR_PERIPH_D	0x3
 
+#define SAMA5D3_PIO_DRIVER1		0x118  /*PIO Driver 1 register offset*/
+#define SAMA5D3_PIO_DRIVER2		0x11C  /*PIO Driver 2 register offset*/
+
+#define AT91SAM9X5_PIO_DRIVER1	0x114  /*PIO Driver 1 register offset*/
+#define AT91SAM9X5_PIO_DRIVER2	0x118  /*PIO Driver 2 register offset*/
+
 #endif
diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index af1ba4f..8a16595 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -58,11 +58,28 @@ static int gpio_banks;
 #define DEGLITCH	(1 << 2)
 #define PULL_DOWN	(1 << 3)
 #define DIS_SCHMIT	(1 << 4)
+#define DRIVE_STRENGTH_SHIFT	5
+#define DRIVE_STRENGTH_MASK		0x3
+#define DRIVE_STRENGTH   (DRIVE_STRENGTH_MASK << DRIVE_STRENGTH_SHIFT)
 #define DEBOUNCE	(1 << 16)
 #define DEBOUNCE_VAL_SHIFT	17
 #define DEBOUNCE_VAL	(0x3fff << DEBOUNCE_VAL_SHIFT)
 
 /**
+ * These defines will translated the dt binding settings to our internal
+ * settings. They are not necessarily the same value as the register setting.
+ * The actual drive strength current of low, medium and high must be looked up
+ * from the corresponding device datasheet. This value is different for pins
+ * that are even in the same banks. It is also dependent on VCC.
+ * DRIVE_STRENGTH_DEFAULT is just a placeholder to avoid changing the drive
+ * strength when there is no dt config for it.
+ */
+#define DRIVE_STRENGTH_DEFAULT		(0 << DRIVE_STRENGTH_SHIFT)
+#define DRIVE_STRENGTH_LOW          (1 << DRIVE_STRENGTH_SHIFT)
+#define DRIVE_STRENGTH_MED          (2 << DRIVE_STRENGTH_SHIFT)
+#define DRIVE_STRENGTH_HI           (3 << DRIVE_STRENGTH_SHIFT)
+
+/**
  * struct at91_pmx_func - describes AT91 pinmux functions
  * @name: the name of this specific function
  * @groups: corresponding pin groups
@@ -148,6 +165,9 @@ struct at91_pinctrl_mux_ops {
 	void (*set_pulldown)(void __iomem *pio, unsigned mask, bool is_on);
 	bool (*get_schmitt_trig)(void __iomem *pio, unsigned pin);
 	void (*disable_schmitt_trig)(void __iomem *pio, unsigned mask);
+	unsigned (*get_drivestrength)(void __iomem *pio, unsigned pin);
+	void (*set_drivestrength)(void __iomem *pio, unsigned pin,
+					u32 strength);
 	/* irq */
 	int (*irq_type)(struct irq_data *d, unsigned type);
 };
@@ -315,6 +335,30 @@ static unsigned pin_to_mask(unsigned int pin)
 	return 1 << pin;
 }
 
+static unsigned two_bit_pin_value_shift_amount(unsigned int pin)
+{
+	/* return the shift value for a pin for "two bit" per pin registers,
+	 * i.e. drive strength */
+	return 2*((pin >= MAX_NB_GPIO_PER_BANK/2)
+			? pin - MAX_NB_GPIO_PER_BANK/2 : pin);
+}
+
+static unsigned sama5d3_get_drive_register(unsigned int pin)
+{
+	/* drive strength is split between two registers
+	 * with two bits per pin */
+	return (pin >= MAX_NB_GPIO_PER_BANK/2)
+			? SAMA5D3_PIO_DRIVER2 : SAMA5D3_PIO_DRIVER1;
+}
+
+static unsigned at91sam9x5_get_drive_register(unsigned int pin)
+{
+	/* drive strength is split between two registers
+	 * with two bits per pin */
+	return (pin >= MAX_NB_GPIO_PER_BANK/2)
+			? AT91SAM9X5_PIO_DRIVER2 : AT91SAM9X5_PIO_DRIVER1;
+}
+
 static void at91_mux_disable_interrupt(void __iomem *pio, unsigned mask)
 {
 	writel_relaxed(mask, pio + PIO_IDR);
@@ -468,6 +512,79 @@ static bool at91_mux_pio3_get_schmitt_trig(void __iomem *pio, unsigned pin)
 	return (__raw_readl(pio + PIO_SCHMITT) >> pin) & 0x1;
 }
 
+static inline u32 read_drive_strength(void __iomem *reg, unsigned pin)
+{
+	unsigned tmp = __raw_readl(reg);
+
+	tmp = tmp >> two_bit_pin_value_shift_amount(pin);
+
+	return tmp & DRIVE_STRENGTH_MASK;
+}
+
+static unsigned at91_mux_sama5d3_get_drivestrength(void __iomem *pio,
+							unsigned pin)
+{
+	unsigned tmp = read_drive_strength(pio +
+					sama5d3_get_drive_register(pin), pin);
+
+	/* SAMA5 strength is 1:1 with our defines,
+	 * except 0 is equivalent to low per datasheet */
+	if (!tmp)
+		tmp = DRIVE_STRENGTH_LOW;
+
+	return tmp;
+}
+
+static unsigned at91_mux_sam9x5_get_drivestrength(void __iomem *pio,
+							unsigned pin)
+{
+	unsigned tmp = read_drive_strength(pio +
+				at91sam9x5_get_drive_register(pin), pin);
+
+	/* strength is inverse in SAM9x5s hardware with the pinctrl defines
+	 * hardware: 0 = hi, 1 = med, 2 = low, 3 = rsvd */
+	tmp = DRIVE_STRENGTH_HI - tmp;
+
+	return tmp;
+}
+
+static void set_drive_strength(void __iomem *reg, unsigned pin, u32 strength)
+{
+	unsigned tmp = __raw_readl(reg);
+	unsigned shift = two_bit_pin_value_shift_amount(pin);
+
+	tmp &= ~(DRIVE_STRENGTH_MASK  <<  shift);
+	tmp |= strength << shift;
+
+	__raw_writel(tmp, reg);
+}
+
+static void at91_mux_sama5d3_set_drivestrength(void __iomem *pio, unsigned pin,
+						u32 setting)
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
+						u32 setting)
+{
+	/* do nothing if setting is zero */
+	if (!setting)
+		return;
+
+	/* strength is inverse on SAM9x5s with our defines
+	 * 0 = hi, 1 = med, 2 = low, 3 = rsvd */
+	setting = DRIVE_STRENGTH_HI - setting;
+
+	set_drive_strength(pio + at91sam9x5_get_drive_register(pin), pin,
+				setting);
+}
+
 static struct at91_pinctrl_mux_ops at91rm9200_ops = {
 	.get_periph	= at91_mux_get_periph,
 	.mux_A_periph	= at91_mux_set_A_periph,
@@ -491,6 +608,27 @@ static struct at91_pinctrl_mux_ops at91sam9x5_ops = {
 	.set_pulldown	= at91_mux_pio3_set_pulldown,
 	.get_schmitt_trig = at91_mux_pio3_get_schmitt_trig,
 	.disable_schmitt_trig = at91_mux_pio3_disable_schmitt_trig,
+	.get_drivestrength = at91_mux_sam9x5_get_drivestrength,
+	.set_drivestrength = at91_mux_sam9x5_set_drivestrength,
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
+	.get_pulldown	= at91_mux_pio3_get_pulldown,
+	.set_pulldown	= at91_mux_pio3_set_pulldown,
+	.get_schmitt_trig = at91_mux_pio3_get_schmitt_trig,
+	.disable_schmitt_trig = at91_mux_pio3_disable_schmitt_trig,
+	.get_drivestrength = at91_mux_sama5d3_get_drivestrength,
+	.set_drivestrength = at91_mux_sama5d3_set_drivestrength,
 	.irq_type	= alt_gpio_irq_type,
 };
 
@@ -716,6 +854,9 @@ static int at91_pinconf_get(struct pinctrl_dev *pctldev,
 		*config |= PULL_DOWN;
 	if (info->ops->get_schmitt_trig && info->ops->get_schmitt_trig(pio, pin))
 		*config |= DIS_SCHMIT;
+	if (info->ops->get_drivestrength)
+		*config |= (info->ops->get_drivestrength(pio, pin)
+				<< DRIVE_STRENGTH_SHIFT);
 
 	return 0;
 }
@@ -729,6 +870,7 @@ static int at91_pinconf_set(struct pinctrl_dev *pctldev,
 	void __iomem *pio;
 	int i;
 	unsigned long config;
+	unsigned pin;
 
 	for (i = 0; i < num_configs; i++) {
 		config = configs[i];
@@ -737,7 +879,8 @@ static int at91_pinconf_set(struct pinctrl_dev *pctldev,
 			"%s:%d, pin_id=%d, config=0x%lx",
 			__func__, __LINE__, pin_id, config);
 		pio = pin_to_controller(info, pin_to_bank(pin_id));
-		mask = pin_to_mask(pin_id % MAX_NB_GPIO_PER_BANK);
+		pin = pin_id % MAX_NB_GPIO_PER_BANK;
+		mask = pin_to_mask(pin);
 
 		if (config & PULL_UP && config & PULL_DOWN)
 			return -EINVAL;
@@ -753,6 +896,10 @@ static int at91_pinconf_set(struct pinctrl_dev *pctldev,
 			info->ops->set_pulldown(pio, mask, config & PULL_DOWN);
 		if (info->ops->disable_schmitt_trig && config & DIS_SCHMIT)
 			info->ops->disable_schmitt_trig(pio, mask);
+		if (info->ops->set_drivestrength)
+			info->ops->set_drivestrength(pio, pin,
+				(config & DRIVE_STRENGTH)
+					>> DRIVE_STRENGTH_SHIFT);
 
 	} /* for each config */
 
@@ -768,6 +915,15 @@ static int at91_pinconf_set(struct pinctrl_dev *pctldev,
 	}					\
 } while (0)
 
+#define DBG_SHOW_FLAG_MASKED(mask,flag) do {	\
+	if ((config & mask) == flag) {		\
+		if (num_conf)			\
+			seq_puts(s, "|");	\
+		seq_puts(s, #flag);		\
+		num_conf++;			\
+	}					\
+} while (0)
+
 static void at91_pinconf_dbg_show(struct pinctrl_dev *pctldev,
 				   struct seq_file *s, unsigned pin_id)
 {
@@ -781,6 +937,9 @@ static void at91_pinconf_dbg_show(struct pinctrl_dev *pctldev,
 	DBG_SHOW_FLAG(PULL_DOWN);
 	DBG_SHOW_FLAG(DIS_SCHMIT);
 	DBG_SHOW_FLAG(DEGLITCH);
+	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_LOW);
+	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_MED);
+	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_HI);
 	DBG_SHOW_FLAG(DEBOUNCE);
 	if (config & DEBOUNCE) {
 		val = config >> DEBOUNCE_VAL_SHIFT;
@@ -945,6 +1104,7 @@ static int at91_pinctrl_parse_functions(struct device_node *np,
 }
 
 static struct of_device_id at91_pinctrl_of_match[] = {
+	{ .compatible = "atmel,sama5d3-pinctrl", .data = &sama5d3_ops },
 	{ .compatible = "atmel,at91sam9x5-pinctrl", .data = &at91sam9x5_ops },
 	{ .compatible = "atmel,at91rm9200-pinctrl", .data = &at91rm9200_ops },
 	{ /* sentinel */ }
diff --git a/include/dt-bindings/pinctrl/at91.h b/include/dt-bindings/pinctrl/at91.h
index 0fee6ff..bbca3d0 100644
--- a/include/dt-bindings/pinctrl/at91.h
+++ b/include/dt-bindings/pinctrl/at91.h
@@ -20,6 +20,11 @@
 
 #define AT91_PINCTRL_PULL_UP_DEGLITCH	(AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DEGLITCH)
 
+#define AT91_PINCTRL_DRIVE_STRENGTH_DEFAULT		(0x0 << 5)
+#define AT91_PINCTRL_DRIVE_STRENGTH_LOW			(0x1 << 5)
+#define AT91_PINCTRL_DRIVE_STRENGTH_MED			(0x2 << 5)
+#define AT91_PINCTRL_DRIVE_STRENGTH_HI			(0x3 << 5)
+
 #define AT91_PIOA	0
 #define AT91_PIOB	1
 #define AT91_PIOC	2
-- 
1.9.1
