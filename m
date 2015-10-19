From: pramodku@broadcom.com (Pramod Kumar)
Date: Mon, 19 Oct 2015 11:13:16 +0530
Subject: [PATCH 09/11] gpio: Rename func/macro/var to IP-block,iproc
In-Reply-To: <1445233398-27129-1-git-send-email-pramodku@broadcom.com>
References: <1445233398-27129-1-git-send-email-pramodku@broadcom.com>
Message-ID: <1445233398-27129-10-git-send-email-pramodku@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change functions, macros and variables name from cygnus to IP block,
iproc, so that it could be used in all iproc based future SoCs having
same GPIO controller block.

Signed-off-by: Pramod Kumar <pramodku@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c | 306 +++++++++++++++---------------
 1 file changed, 154 insertions(+), 152 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c b/drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c
index d0d788f..ed21ab2 100644
--- a/drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c
+++ b/drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c
@@ -10,14 +10,16 @@
  * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * This file contains the Broadcom Cygnus GPIO driver that supports 3
- * GPIO controllers on Cygnus including the ASIU GPIO controller, the
+ * This file contains the Broadcom Iproc GPIO driver that supports 3
+ * GPIO controllers on Iproc including the ASIU GPIO controller, the
  * chipCommonG GPIO controller, and the always-on GPIO controller. Basic
  * PINCONF such as bias pull up/down, and drive strength are also supported
  * in this driver.
  *
- * Pins from the ASIU GPIO can be individually muxed to GPIO function,
- * through the interaction with the Cygnus IOMUX controller
+ * It provides the functionality where pins from the GPIO can be
+ * individually muxed to GPIO function, if individual pad
+ * configuration is supported, through the interaction with respective
+ * SoCs IOMUX controller.
  */
 
 #include <linux/kernel.h>
@@ -34,42 +36,42 @@
 
 #include "../pinctrl-utils.h"
 
-#define CYGNUS_GPIO_DATA_IN_OFFSET   0x00
-#define CYGNUS_GPIO_DATA_OUT_OFFSET  0x04
-#define CYGNUS_GPIO_OUT_EN_OFFSET    0x08
-#define CYGNUS_GPIO_INT_TYPE_OFFSET  0x0c
-#define CYGNUS_GPIO_INT_DE_OFFSET    0x10
-#define CYGNUS_GPIO_INT_EDGE_OFFSET  0x14
-#define CYGNUS_GPIO_INT_MSK_OFFSET   0x18
-#define CYGNUS_GPIO_INT_STAT_OFFSET  0x1c
-#define CYGNUS_GPIO_INT_MSTAT_OFFSET 0x20
-#define CYGNUS_GPIO_INT_CLR_OFFSET   0x24
-#define CYGNUS_GPIO_PAD_RES_OFFSET   0x34
-#define CYGNUS_GPIO_RES_EN_OFFSET    0x38
+#define IPROC_GPIO_DATA_IN_OFFSET   0x00
+#define IPROC_GPIO_DATA_OUT_OFFSET  0x04
+#define IPROC_GPIO_OUT_EN_OFFSET    0x08
+#define IPROC_GPIO_INT_TYPE_OFFSET  0x0c
+#define IPROC_GPIO_INT_DE_OFFSET    0x10
+#define IPROC_GPIO_INT_EDGE_OFFSET  0x14
+#define IPROC_GPIO_INT_MSK_OFFSET   0x18
+#define IPROC_GPIO_INT_STAT_OFFSET  0x1c
+#define IPROC_GPIO_INT_MSTAT_OFFSET 0x20
+#define IPROC_GPIO_INT_CLR_OFFSET   0x24
+#define IPROC_GPIO_PAD_RES_OFFSET   0x34
+#define IPROC_GPIO_RES_EN_OFFSET    0x38
 
 /* drive strength control for ASIU GPIO */
-#define CYGNUS_GPIO_ASIU_DRV0_CTRL_OFFSET 0x58
+#define IPROC_GPIO_ASIU_DRV0_CTRL_OFFSET 0x58
 
 /* drive strength control for CCM/CRMU (AON) GPIO */
-#define CYGNUS_GPIO_DRV0_CTRL_OFFSET  0x00
+#define IPROC_GPIO_DRV0_CTRL_OFFSET  0x00
 
 #define GPIO_BANK_SIZE 0x200
 #define NGPIOS_PER_BANK 32
 #define GPIO_BANK(pin) ((pin) / NGPIOS_PER_BANK)
 
-#define CYGNUS_GPIO_REG(pin, reg) (GPIO_BANK(pin) * GPIO_BANK_SIZE + (reg))
-#define CYGNUS_GPIO_SHIFT(pin) ((pin) % NGPIOS_PER_BANK)
+#define IPROC_GPIO_REG(pin, reg) (GPIO_BANK(pin) * GPIO_BANK_SIZE + (reg))
+#define IPROC_GPIO_SHIFT(pin) ((pin) % NGPIOS_PER_BANK)
 
 #define GPIO_DRV_STRENGTH_BIT_SHIFT  20
 #define GPIO_DRV_STRENGTH_BITS       3
 #define GPIO_DRV_STRENGTH_BIT_MASK   ((1 << GPIO_DRV_STRENGTH_BITS) - 1)
 
 /*
- * Cygnus GPIO core
+ * Iproc GPIO core
  *
  * @dev: pointer to device
- * @base: I/O register base for Cygnus GPIO controller
- * @io_ctrl: I/O register base for certain type of Cygnus GPIO controller that
+ * @base: I/O register base for Iproc GPIO controller
+ * @io_ctrl: I/O register base for certain type of Iproc GPIO controller that
  * has the PINCONF support implemented outside of the GPIO block
  * @lock: lock to protect access to I/O registers
  * @gc: GPIO chip
@@ -79,7 +81,7 @@
  * @pctl: pointer to pinctrl_dev
  * @pctldesc: pinctrl descriptor
  */
-struct cygnus_gpio {
+struct iproc_gpio {
 	struct device *dev;
 
 	void __iomem *base;
@@ -96,33 +98,33 @@ struct cygnus_gpio {
 	struct pinctrl_desc pctldesc;
 };
 
-static inline struct cygnus_gpio *to_cygnus_gpio(struct gpio_chip *gc)
+static inline struct iproc_gpio *to_iproc_gpio(struct gpio_chip *gc)
 {
-	return container_of(gc, struct cygnus_gpio, gc);
+	return container_of(gc, struct iproc_gpio, gc);
 }
 
 /*
  * Mapping from PINCONF pins to GPIO pins is 1-to-1
  */
-static inline unsigned cygnus_pin_to_gpio(unsigned pin)
+static inline unsigned iproc_pin_to_gpio(unsigned pin)
 {
 	return pin;
 }
 
 /**
- *  cygnus_set_bit - set or clear one bit (corresponding to the GPIO pin) in a
- *  Cygnus GPIO register
+ *  iproc_set_bit - set or clear one bit (corresponding to the GPIO pin) in a
+ *  Iproc GPIO register
  *
- *  @cygnus_gpio: Cygnus GPIO device
+ *  @iproc_gpio: Iproc GPIO device
  *  @reg: register offset
  *  @gpio: GPIO pin
  *  @set: set or clear
  */
-static inline void cygnus_set_bit(struct cygnus_gpio *chip, unsigned int reg,
+static inline void iproc_set_bit(struct iproc_gpio *chip, unsigned int reg,
 				  unsigned gpio, bool set)
 {
-	unsigned int offset = CYGNUS_GPIO_REG(gpio, reg);
-	unsigned int shift = CYGNUS_GPIO_SHIFT(gpio);
+	unsigned int offset = IPROC_GPIO_REG(gpio, reg);
+	unsigned int shift = IPROC_GPIO_SHIFT(gpio);
 	u32 val;
 
 	val = readl(chip->base + offset);
@@ -133,19 +135,19 @@ static inline void cygnus_set_bit(struct cygnus_gpio *chip, unsigned int reg,
 	writel(val, chip->base + offset);
 }
 
-static inline bool cygnus_get_bit(struct cygnus_gpio *chip, unsigned int reg,
+static inline bool iproc_get_bit(struct iproc_gpio *chip, unsigned int reg,
 				  unsigned gpio)
 {
-	unsigned int offset = CYGNUS_GPIO_REG(gpio, reg);
-	unsigned int shift = CYGNUS_GPIO_SHIFT(gpio);
+	unsigned int offset = IPROC_GPIO_REG(gpio, reg);
+	unsigned int shift = IPROC_GPIO_SHIFT(gpio);
 
 	return !!(readl(chip->base + offset) & BIT(shift));
 }
 
-static void cygnus_gpio_irq_handler(struct irq_desc *desc)
+static void iproc_gpio_irq_handler(struct irq_desc *desc)
 {
 	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
-	struct cygnus_gpio *chip = to_cygnus_gpio(gc);
+	struct iproc_gpio *chip = to_iproc_gpio(gc);
 	struct irq_chip *irq_chip = irq_desc_get_chip(desc);
 	int i, bit;
 
@@ -154,7 +156,7 @@ static void cygnus_gpio_irq_handler(struct irq_desc *desc)
 	/* go through the entire GPIO banks and handle all interrupts */
 	for (i = 0; i < chip->num_banks; i++) {
 		unsigned long val = readl(chip->base + (i * GPIO_BANK_SIZE) +
-					  CYGNUS_GPIO_INT_MSTAT_OFFSET);
+					  IPROC_GPIO_INT_MSTAT_OFFSET);
 
 		for_each_set_bit(bit, &val, NGPIOS_PER_BANK) {
 			unsigned pin = NGPIOS_PER_BANK * i + bit;
@@ -165,7 +167,7 @@ static void cygnus_gpio_irq_handler(struct irq_desc *desc)
 			 * handler, so we do not leave any window
 			 */
 			writel(BIT(bit), chip->base + (i * GPIO_BANK_SIZE) +
-			       CYGNUS_GPIO_INT_CLR_OFFSET);
+			       IPROC_GPIO_INT_CLR_OFFSET);
 
 			generic_handle_irq(child_irq);
 		}
@@ -175,60 +177,60 @@ static void cygnus_gpio_irq_handler(struct irq_desc *desc)
 }
 
 
-static void cygnus_gpio_irq_ack(struct irq_data *d)
+static void iproc_gpio_irq_ack(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct cygnus_gpio *chip = to_cygnus_gpio(gc);
+	struct iproc_gpio *chip = to_iproc_gpio(gc);
 	unsigned gpio = d->hwirq;
-	unsigned int offset = CYGNUS_GPIO_REG(gpio,
-			CYGNUS_GPIO_INT_CLR_OFFSET);
-	unsigned int shift = CYGNUS_GPIO_SHIFT(gpio);
+	unsigned int offset = IPROC_GPIO_REG(gpio,
+			IPROC_GPIO_INT_CLR_OFFSET);
+	unsigned int shift = IPROC_GPIO_SHIFT(gpio);
 	u32 val = BIT(shift);
 
 	writel(val, chip->base + offset);
 }
 
 /**
- *  cygnus_gpio_irq_set_mask - mask/unmask a GPIO interrupt
+ *  iproc_gpio_irq_set_mask - mask/unmask a GPIO interrupt
  *
  *  @d: IRQ chip data
  *  @unmask: mask/unmask GPIO interrupt
  */
-static void cygnus_gpio_irq_set_mask(struct irq_data *d, bool unmask)
+static void iproc_gpio_irq_set_mask(struct irq_data *d, bool unmask)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct cygnus_gpio *chip = to_cygnus_gpio(gc);
+	struct iproc_gpio *chip = to_iproc_gpio(gc);
 	unsigned gpio = d->hwirq;
 
-	cygnus_set_bit(chip, CYGNUS_GPIO_INT_MSK_OFFSET, gpio, unmask);
+	iproc_set_bit(chip, IPROC_GPIO_INT_MSK_OFFSET, gpio, unmask);
 }
 
-static void cygnus_gpio_irq_mask(struct irq_data *d)
+static void iproc_gpio_irq_mask(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct cygnus_gpio *chip = to_cygnus_gpio(gc);
+	struct iproc_gpio *chip = to_iproc_gpio(gc);
 	unsigned long flags;
 
 	spin_lock_irqsave(&chip->lock, flags);
-	cygnus_gpio_irq_set_mask(d, false);
+	iproc_gpio_irq_set_mask(d, false);
 	spin_unlock_irqrestore(&chip->lock, flags);
 }
 
-static void cygnus_gpio_irq_unmask(struct irq_data *d)
+static void iproc_gpio_irq_unmask(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct cygnus_gpio *chip = to_cygnus_gpio(gc);
+	struct iproc_gpio *chip = to_iproc_gpio(gc);
 	unsigned long flags;
 
 	spin_lock_irqsave(&chip->lock, flags);
-	cygnus_gpio_irq_set_mask(d, true);
+	iproc_gpio_irq_set_mask(d, true);
 	spin_unlock_irqrestore(&chip->lock, flags);
 }
 
-static int cygnus_gpio_irq_set_type(struct irq_data *d, unsigned int type)
+static int iproc_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct cygnus_gpio *chip = to_cygnus_gpio(gc);
+	struct iproc_gpio *chip = to_iproc_gpio(gc);
 	unsigned gpio = d->hwirq;
 	bool level_triggered = false;
 	bool dual_edge = false;
@@ -263,10 +265,10 @@ static int cygnus_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	}
 
 	spin_lock_irqsave(&chip->lock, flags);
-	cygnus_set_bit(chip, CYGNUS_GPIO_INT_TYPE_OFFSET, gpio,
+	iproc_set_bit(chip, IPROC_GPIO_INT_TYPE_OFFSET, gpio,
 		       level_triggered);
-	cygnus_set_bit(chip, CYGNUS_GPIO_INT_DE_OFFSET, gpio, dual_edge);
-	cygnus_set_bit(chip, CYGNUS_GPIO_INT_EDGE_OFFSET, gpio,
+	iproc_set_bit(chip, IPROC_GPIO_INT_DE_OFFSET, gpio, dual_edge);
+	iproc_set_bit(chip, IPROC_GPIO_INT_EDGE_OFFSET, gpio,
 		       rising_or_high);
 	spin_unlock_irqrestore(&chip->lock, flags);
 
@@ -277,32 +279,32 @@ static int cygnus_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	return 0;
 }
 
-static struct irq_chip cygnus_gpio_irq_chip = {
-	.name = "bcm-cygnus-gpio",
-	.irq_ack = cygnus_gpio_irq_ack,
-	.irq_mask = cygnus_gpio_irq_mask,
-	.irq_unmask = cygnus_gpio_irq_unmask,
-	.irq_set_type = cygnus_gpio_irq_set_type,
+static struct irq_chip iproc_gpio_irq_chip = {
+	.name = "bcm-iproc-gpio",
+	.irq_ack = iproc_gpio_irq_ack,
+	.irq_mask = iproc_gpio_irq_mask,
+	.irq_unmask = iproc_gpio_irq_unmask,
+	.irq_set_type = iproc_gpio_irq_set_type,
 };
 
 /*
- * Request the Cygnus IOMUX pinmux controller to mux individual pins to GPIO
+ * Request the Iproc IOMUX pinmux controller to mux individual pins to GPIO
  */
-static int cygnus_gpio_request(struct gpio_chip *gc, unsigned offset)
+static int iproc_gpio_request(struct gpio_chip *gc, unsigned offset)
 {
-	struct cygnus_gpio *chip = to_cygnus_gpio(gc);
+	struct iproc_gpio *chip = to_iproc_gpio(gc);
 	unsigned gpio = gc->base + offset;
 
-	/* not all Cygnus GPIO pins can be muxed individually */
+	/* not all Iproc GPIO pins can be muxed individually */
 	if (!chip->pinmux_is_supported)
 		return 0;
 
 	return pinctrl_request_gpio(gpio);
 }
 
-static void cygnus_gpio_free(struct gpio_chip *gc, unsigned offset)
+static void iproc_gpio_free(struct gpio_chip *gc, unsigned offset)
 {
-	struct cygnus_gpio *chip = to_cygnus_gpio(gc);
+	struct iproc_gpio *chip = to_iproc_gpio(gc);
 	unsigned gpio = gc->base + offset;
 
 	if (!chip->pinmux_is_supported)
@@ -311,13 +313,13 @@ static void cygnus_gpio_free(struct gpio_chip *gc, unsigned offset)
 	pinctrl_free_gpio(gpio);
 }
 
-static int cygnus_gpio_direction_input(struct gpio_chip *gc, unsigned gpio)
+static int iproc_gpio_direction_input(struct gpio_chip *gc, unsigned gpio)
 {
-	struct cygnus_gpio *chip = to_cygnus_gpio(gc);
+	struct iproc_gpio *chip = to_iproc_gpio(gc);
 	unsigned long flags;
 
 	spin_lock_irqsave(&chip->lock, flags);
-	cygnus_set_bit(chip, CYGNUS_GPIO_OUT_EN_OFFSET, gpio, false);
+	iproc_set_bit(chip, IPROC_GPIO_OUT_EN_OFFSET, gpio, false);
 	spin_unlock_irqrestore(&chip->lock, flags);
 
 	dev_dbg(chip->dev, "gpio:%u set input\n", gpio);
@@ -325,15 +327,15 @@ static int cygnus_gpio_direction_input(struct gpio_chip *gc, unsigned gpio)
 	return 0;
 }
 
-static int cygnus_gpio_direction_output(struct gpio_chip *gc, unsigned gpio,
+static int iproc_gpio_direction_output(struct gpio_chip *gc, unsigned gpio,
 					int val)
 {
-	struct cygnus_gpio *chip = to_cygnus_gpio(gc);
+	struct iproc_gpio *chip = to_iproc_gpio(gc);
 	unsigned long flags;
 
 	spin_lock_irqsave(&chip->lock, flags);
-	cygnus_set_bit(chip, CYGNUS_GPIO_OUT_EN_OFFSET, gpio, true);
-	cygnus_set_bit(chip, CYGNUS_GPIO_DATA_OUT_OFFSET, gpio, !!(val));
+	iproc_set_bit(chip, IPROC_GPIO_OUT_EN_OFFSET, gpio, true);
+	iproc_set_bit(chip, IPROC_GPIO_DATA_OUT_OFFSET, gpio, !!(val));
 	spin_unlock_irqrestore(&chip->lock, flags);
 
 	dev_dbg(chip->dev, "gpio:%u set output, value:%d\n", gpio, val);
@@ -341,29 +343,29 @@ static int cygnus_gpio_direction_output(struct gpio_chip *gc, unsigned gpio,
 	return 0;
 }
 
-static void cygnus_gpio_set(struct gpio_chip *gc, unsigned gpio, int val)
+static void iproc_gpio_set(struct gpio_chip *gc, unsigned gpio, int val)
 {
-	struct cygnus_gpio *chip = to_cygnus_gpio(gc);
+	struct iproc_gpio *chip = to_iproc_gpio(gc);
 	unsigned long flags;
 
 	spin_lock_irqsave(&chip->lock, flags);
-	cygnus_set_bit(chip, CYGNUS_GPIO_DATA_OUT_OFFSET, gpio, !!(val));
+	iproc_set_bit(chip, IPROC_GPIO_DATA_OUT_OFFSET, gpio, !!(val));
 	spin_unlock_irqrestore(&chip->lock, flags);
 
 	dev_dbg(chip->dev, "gpio:%u set, value:%d\n", gpio, val);
 }
 
-static int cygnus_gpio_get(struct gpio_chip *gc, unsigned gpio)
+static int iproc_gpio_get(struct gpio_chip *gc, unsigned gpio)
 {
-	struct cygnus_gpio *chip = to_cygnus_gpio(gc);
-	unsigned int offset = CYGNUS_GPIO_REG(gpio,
-					      CYGNUS_GPIO_DATA_IN_OFFSET);
-	unsigned int shift = CYGNUS_GPIO_SHIFT(gpio);
+	struct iproc_gpio *chip = to_iproc_gpio(gc);
+	unsigned int offset = IPROC_GPIO_REG(gpio,
+					      IPROC_GPIO_DATA_IN_OFFSET);
+	unsigned int shift = IPROC_GPIO_SHIFT(gpio);
 
 	return !!(readl(chip->base + offset) & BIT(shift));
 }
 
-static int cygnus_get_groups_count(struct pinctrl_dev *pctldev)
+static int iproc_get_groups_count(struct pinctrl_dev *pctldev)
 {
 	return 1;
 }
@@ -372,20 +374,20 @@ static int cygnus_get_groups_count(struct pinctrl_dev *pctldev)
  * Only one group: "gpio_grp", since this local pinctrl device only performs
  * GPIO specific PINCONF configurations
  */
-static const char *cygnus_get_group_name(struct pinctrl_dev *pctldev,
+static const char *iproc_get_group_name(struct pinctrl_dev *pctldev,
 					 unsigned selector)
 {
 	return "gpio_grp";
 }
 
-static const struct pinctrl_ops cygnus_pctrl_ops = {
-	.get_groups_count = cygnus_get_groups_count,
-	.get_group_name = cygnus_get_group_name,
+static const struct pinctrl_ops iproc_pctrl_ops = {
+	.get_groups_count = iproc_get_groups_count,
+	.get_group_name = iproc_get_group_name,
 	.dt_node_to_map = pinconf_generic_dt_node_to_map_pin,
 	.dt_free_map = pinctrl_utils_dt_free_map,
 };
 
-static int cygnus_gpio_set_pull(struct cygnus_gpio *chip, unsigned gpio,
+static int iproc_gpio_set_pull(struct iproc_gpio *chip, unsigned gpio,
 				bool disable, bool pull_up)
 {
 	unsigned long flags;
@@ -393,11 +395,11 @@ static int cygnus_gpio_set_pull(struct cygnus_gpio *chip, unsigned gpio,
 	spin_lock_irqsave(&chip->lock, flags);
 
 	if (disable) {
-		cygnus_set_bit(chip, CYGNUS_GPIO_RES_EN_OFFSET, gpio, false);
+		iproc_set_bit(chip, IPROC_GPIO_RES_EN_OFFSET, gpio, false);
 	} else {
-		cygnus_set_bit(chip, CYGNUS_GPIO_PAD_RES_OFFSET, gpio,
+		iproc_set_bit(chip, IPROC_GPIO_PAD_RES_OFFSET, gpio,
 			       pull_up);
-		cygnus_set_bit(chip, CYGNUS_GPIO_RES_EN_OFFSET, gpio, true);
+		iproc_set_bit(chip, IPROC_GPIO_RES_EN_OFFSET, gpio, true);
 	}
 
 	spin_unlock_irqrestore(&chip->lock, flags);
@@ -407,18 +409,18 @@ static int cygnus_gpio_set_pull(struct cygnus_gpio *chip, unsigned gpio,
 	return 0;
 }
 
-static void cygnus_gpio_get_pull(struct cygnus_gpio *chip, unsigned gpio,
+static void iproc_gpio_get_pull(struct iproc_gpio *chip, unsigned gpio,
 				 bool *disable, bool *pull_up)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&chip->lock, flags);
-	*disable = !cygnus_get_bit(chip, CYGNUS_GPIO_RES_EN_OFFSET, gpio);
-	*pull_up = cygnus_get_bit(chip, CYGNUS_GPIO_PAD_RES_OFFSET, gpio);
+	*disable = !iproc_get_bit(chip, IPROC_GPIO_RES_EN_OFFSET, gpio);
+	*pull_up = iproc_get_bit(chip, IPROC_GPIO_PAD_RES_OFFSET, gpio);
 	spin_unlock_irqrestore(&chip->lock, flags);
 }
 
-static int cygnus_gpio_set_strength(struct cygnus_gpio *chip, unsigned gpio,
+static int iproc_gpio_set_strength(struct iproc_gpio *chip, unsigned gpio,
 				    unsigned strength)
 {
 	void __iomem *base;
@@ -432,14 +434,14 @@ static int cygnus_gpio_set_strength(struct cygnus_gpio *chip, unsigned gpio,
 
 	if (chip->io_ctrl) {
 		base = chip->io_ctrl;
-		offset = CYGNUS_GPIO_DRV0_CTRL_OFFSET;
+		offset = IPROC_GPIO_DRV0_CTRL_OFFSET;
 	} else {
 		base = chip->base;
-		offset = CYGNUS_GPIO_REG(gpio,
-					 CYGNUS_GPIO_ASIU_DRV0_CTRL_OFFSET);
+		offset = IPROC_GPIO_REG(gpio,
+					 IPROC_GPIO_ASIU_DRV0_CTRL_OFFSET);
 	}
 
-	shift = CYGNUS_GPIO_SHIFT(gpio);
+	shift = IPROC_GPIO_SHIFT(gpio);
 
 	dev_dbg(chip->dev, "gpio:%u set drive strength:%d mA\n", gpio,
 		strength);
@@ -458,7 +460,7 @@ static int cygnus_gpio_set_strength(struct cygnus_gpio *chip, unsigned gpio,
 	return 0;
 }
 
-static int cygnus_gpio_get_strength(struct cygnus_gpio *chip, unsigned gpio,
+static int iproc_gpio_get_strength(struct iproc_gpio *chip, unsigned gpio,
 				    u16 *strength)
 {
 	void __iomem *base;
@@ -468,14 +470,14 @@ static int cygnus_gpio_get_strength(struct cygnus_gpio *chip, unsigned gpio,
 
 	if (chip->io_ctrl) {
 		base = chip->io_ctrl;
-		offset = CYGNUS_GPIO_DRV0_CTRL_OFFSET;
+		offset = IPROC_GPIO_DRV0_CTRL_OFFSET;
 	} else {
 		base = chip->base;
-		offset = CYGNUS_GPIO_REG(gpio,
-					 CYGNUS_GPIO_ASIU_DRV0_CTRL_OFFSET);
+		offset = IPROC_GPIO_REG(gpio,
+					 IPROC_GPIO_ASIU_DRV0_CTRL_OFFSET);
 	}
 
-	shift = CYGNUS_GPIO_SHIFT(gpio);
+	shift = IPROC_GPIO_SHIFT(gpio);
 
 	spin_lock_irqsave(&chip->lock, flags);
 	*strength = 0;
@@ -493,40 +495,40 @@ static int cygnus_gpio_get_strength(struct cygnus_gpio *chip, unsigned gpio,
 	return 0;
 }
 
-static int cygnus_pin_config_get(struct pinctrl_dev *pctldev, unsigned pin,
+static int iproc_pin_config_get(struct pinctrl_dev *pctldev, unsigned pin,
 				 unsigned long *config)
 {
-	struct cygnus_gpio *chip = pinctrl_dev_get_drvdata(pctldev);
+	struct iproc_gpio *chip = pinctrl_dev_get_drvdata(pctldev);
 	enum pin_config_param param = pinconf_to_config_param(*config);
-	unsigned gpio = cygnus_pin_to_gpio(pin);
+	unsigned gpio = iproc_pin_to_gpio(pin);
 	u16 arg;
 	bool disable, pull_up;
 	int ret;
 
 	switch (param) {
 	case PIN_CONFIG_BIAS_DISABLE:
-		cygnus_gpio_get_pull(chip, gpio, &disable, &pull_up);
+		iproc_gpio_get_pull(chip, gpio, &disable, &pull_up);
 		if (disable)
 			return 0;
 		else
 			return -EINVAL;
 
 	case PIN_CONFIG_BIAS_PULL_UP:
-		cygnus_gpio_get_pull(chip, gpio, &disable, &pull_up);
+		iproc_gpio_get_pull(chip, gpio, &disable, &pull_up);
 		if (!disable && pull_up)
 			return 0;
 		else
 			return -EINVAL;
 
 	case PIN_CONFIG_BIAS_PULL_DOWN:
-		cygnus_gpio_get_pull(chip, gpio, &disable, &pull_up);
+		iproc_gpio_get_pull(chip, gpio, &disable, &pull_up);
 		if (!disable && !pull_up)
 			return 0;
 		else
 			return -EINVAL;
 
 	case PIN_CONFIG_DRIVE_STRENGTH:
-		ret = cygnus_gpio_get_strength(chip, gpio, &arg);
+		ret = iproc_gpio_get_strength(chip, gpio, &arg);
 		if (ret)
 			return ret;
 		else
@@ -541,13 +543,13 @@ static int cygnus_pin_config_get(struct pinctrl_dev *pctldev, unsigned pin,
 	return -ENOTSUPP;
 }
 
-static int cygnus_pin_config_set(struct pinctrl_dev *pctldev, unsigned pin,
+static int iproc_pin_config_set(struct pinctrl_dev *pctldev, unsigned pin,
 				 unsigned long *configs, unsigned num_configs)
 {
-	struct cygnus_gpio *chip = pinctrl_dev_get_drvdata(pctldev);
+	struct iproc_gpio *chip = pinctrl_dev_get_drvdata(pctldev);
 	enum pin_config_param param;
 	u16 arg;
-	unsigned i, gpio = cygnus_pin_to_gpio(pin);
+	unsigned i, gpio = iproc_pin_to_gpio(pin);
 	int ret = -ENOTSUPP;
 
 	for (i = 0; i < num_configs; i++) {
@@ -556,25 +558,25 @@ static int cygnus_pin_config_set(struct pinctrl_dev *pctldev, unsigned pin,
 
 		switch (param) {
 		case PIN_CONFIG_BIAS_DISABLE:
-			ret = cygnus_gpio_set_pull(chip, gpio, true, false);
+			ret = iproc_gpio_set_pull(chip, gpio, true, false);
 			if (ret < 0)
 				goto out;
 			break;
 
 		case PIN_CONFIG_BIAS_PULL_UP:
-			ret = cygnus_gpio_set_pull(chip, gpio, false, true);
+			ret = iproc_gpio_set_pull(chip, gpio, false, true);
 			if (ret < 0)
 				goto out;
 			break;
 
 		case PIN_CONFIG_BIAS_PULL_DOWN:
-			ret = cygnus_gpio_set_pull(chip, gpio, false, false);
+			ret = iproc_gpio_set_pull(chip, gpio, false, false);
 			if (ret < 0)
 				goto out;
 			break;
 
 		case PIN_CONFIG_DRIVE_STRENGTH:
-			ret = cygnus_gpio_set_strength(chip, gpio, arg);
+			ret = iproc_gpio_set_strength(chip, gpio, arg);
 			if (ret < 0)
 				goto out;
 			break;
@@ -589,20 +591,20 @@ out:
 	return ret;
 }
 
-static const struct pinconf_ops cygnus_pconf_ops = {
+static const struct pinconf_ops iproc_pconf_ops = {
 	.is_generic = true,
-	.pin_config_get = cygnus_pin_config_get,
-	.pin_config_set = cygnus_pin_config_set,
+	.pin_config_get = iproc_pin_config_get,
+	.pin_config_set = iproc_pin_config_set,
 };
 
 /*
- * Cygnus GPIO controller supports some PINCONF related configurations such as
+ * Iproc GPIO controller supports some PINCONF related configurations such as
  * pull up, pull down, and drive strength, when the pin is configured to GPIO
  *
  * Here a local pinctrl device is created with simple 1-to-1 pin mapping to the
  * local GPIO pins
  */
-static int cygnus_gpio_register_pinconf(struct cygnus_gpio *chip)
+static int iproc_gpio_register_pinconf(struct iproc_gpio *chip)
 {
 	struct pinctrl_desc *pctldesc = &chip->pctldesc;
 	struct pinctrl_pin_desc *pins;
@@ -622,10 +624,10 @@ static int cygnus_gpio_register_pinconf(struct cygnus_gpio *chip)
 	}
 
 	pctldesc->name = dev_name(chip->dev);
-	pctldesc->pctlops = &cygnus_pctrl_ops;
+	pctldesc->pctlops = &iproc_pctrl_ops;
 	pctldesc->pins = pins;
 	pctldesc->npins = gc->ngpio;
-	pctldesc->confops = &cygnus_pconf_ops;
+	pctldesc->confops = &iproc_pconf_ops;
 
 	chip->pctl = pinctrl_register(pctldesc, chip->dev, chip);
 	if (IS_ERR(chip->pctl)) {
@@ -636,13 +638,13 @@ static int cygnus_gpio_register_pinconf(struct cygnus_gpio *chip)
 	return 0;
 }
 
-static void cygnus_gpio_unregister_pinconf(struct cygnus_gpio *chip)
+static void iproc_gpio_unregister_pinconf(struct iproc_gpio *chip)
 {
 	if (chip->pctl)
 		pinctrl_unregister(chip->pctl);
 }
 
-static const struct of_device_id cygnus_gpio_of_match[] = {
+static const struct of_device_id iproc_gpio_of_match[] = {
 	{ .compatible = "brcm,cygnus-ccm-gpio" },
 	{ .compatible = "brcm,cygnus-asiu-gpio" },
 	{ .compatible = "brcm,cygnus-crmu-gpio" },
@@ -650,11 +652,11 @@ static const struct of_device_id cygnus_gpio_of_match[] = {
 	{ }
 };
 
-static int cygnus_gpio_probe(struct platform_device *pdev)
+static int iproc_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct resource *res;
-	struct cygnus_gpio *chip;
+	struct iproc_gpio *chip;
 	struct gpio_chip *gc;
 	u32 ngpios;
 	int irq, ret;
@@ -696,12 +698,12 @@ static int cygnus_gpio_probe(struct platform_device *pdev)
 	gc->label = dev_name(dev);
 	gc->dev = dev;
 	gc->of_node = dev->of_node;
-	gc->request = cygnus_gpio_request;
-	gc->free = cygnus_gpio_free;
-	gc->direction_input = cygnus_gpio_direction_input;
-	gc->direction_output = cygnus_gpio_direction_output;
-	gc->set = cygnus_gpio_set;
-	gc->get = cygnus_gpio_get;
+	gc->request = iproc_gpio_request;
+	gc->free = iproc_gpio_free;
+	gc->direction_input = iproc_gpio_direction_input;
+	gc->direction_output = iproc_gpio_direction_output;
+	gc->set = iproc_gpio_set;
+	gc->get = iproc_gpio_get;
 
 	chip->pinmux_is_supported = of_property_read_bool(dev->of_node,
 							"gpio-ranges");
@@ -712,7 +714,7 @@ static int cygnus_gpio_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = cygnus_gpio_register_pinconf(chip);
+	ret = iproc_gpio_register_pinconf(chip);
 	if (ret) {
 		dev_err(dev, "unable to register pinconf\n");
 		goto err_rm_gpiochip;
@@ -721,21 +723,21 @@ static int cygnus_gpio_probe(struct platform_device *pdev)
 	/* optional GPIO interrupt support */
 	irq = platform_get_irq(pdev, 0);
 	if (irq) {
-		ret = gpiochip_irqchip_add(gc, &cygnus_gpio_irq_chip, 0,
+		ret = gpiochip_irqchip_add(gc, &iproc_gpio_irq_chip, 0,
 					   handle_simple_irq, IRQ_TYPE_NONE);
 		if (ret) {
 			dev_err(dev, "no GPIO irqchip\n");
 			goto err_unregister_pinconf;
 		}
 
-		gpiochip_set_chained_irqchip(gc, &cygnus_gpio_irq_chip, irq,
-					     cygnus_gpio_irq_handler);
+		gpiochip_set_chained_irqchip(gc, &iproc_gpio_irq_chip, irq,
+					     iproc_gpio_irq_handler);
 	}
 
 	return 0;
 
 err_unregister_pinconf:
-	cygnus_gpio_unregister_pinconf(chip);
+	iproc_gpio_unregister_pinconf(chip);
 
 err_rm_gpiochip:
 	gpiochip_remove(gc);
@@ -743,16 +745,16 @@ err_rm_gpiochip:
 	return ret;
 }
 
-static struct platform_driver cygnus_gpio_driver = {
+static struct platform_driver iproc_gpio_driver = {
 	.driver = {
-		.name = "cygnus-gpio",
-		.of_match_table = cygnus_gpio_of_match,
+		.name = "iproc-gpio",
+		.of_match_table = iproc_gpio_of_match,
 	},
-	.probe = cygnus_gpio_probe,
+	.probe = iproc_gpio_probe,
 };
 
-static int __init cygnus_gpio_init(void)
+static int __init iproc_gpio_init(void)
 {
-	return platform_driver_probe(&cygnus_gpio_driver, cygnus_gpio_probe);
+	return platform_driver_probe(&iproc_gpio_driver, iproc_gpio_probe);
 }
-arch_initcall_sync(cygnus_gpio_init);
+arch_initcall_sync(iproc_gpio_init);
-- 
1.9.1
