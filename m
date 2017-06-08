From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Thu, 8 Jun 2017 10:32:07 -0700
Subject: [PATCH] gpio: zynq: Clarify quirk and provide helper function
Message-ID: <20170608173207.30056-1-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The one quirk used in the zynq GPIO driver was called FOO which is not
very descriptive. Rename the quirk to IS_ZYNQ as it indicates whether
the HW is a zynq or zynqmp device to allow handling of device-specific
differences of the HW.
Also provide a helper function to test whether the HW is zynq or zynqmp.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/gpio/gpio-zynq.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index ed87c9a6e0e6..df0851464006 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -96,8 +96,8 @@
 /* GPIO upper 16 bit mask */
 #define ZYNQ_GPIO_UPPER_MASK 0xFFFF0000
 
-/* For GPIO quirks */
-#define ZYNQ_GPIO_QUIRK_FOO	BIT(0)
+/* set to differentiate zynq from zynqmp, 0=zynqmp, 1=zynq */
+#define ZYNQ_GPIO_QUIRK_IS_ZYNQ	BIT(0)
 
 /**
  * struct zynq_gpio - gpio device private data structure
@@ -136,6 +136,17 @@ static struct irq_chip zynq_gpio_level_irqchip;
 static struct irq_chip zynq_gpio_edge_irqchip;
 
 /**
+ * zynq_gpio_is_zynq - test if HW is zynq or zynqmp
+ * @gpio:	Pointer to driver data struct
+ *
+ * Return: 0 if zynqmp, 1 if zynq.
+ */
+static int zynq_gpio_is_zynq(struct zynq_gpio *gpio)
+{
+	return !!(gpio->p_data->quirks & ZYNQ_GPIO_QUIRK_IS_ZYNQ);
+}
+
+/**
  * zynq_gpio_get_bank_pin - Get the bank number and pin number within that bank
  * for a given pin in the GPIO device
  * @pin_num:	gpio pin number within the device
@@ -242,18 +253,16 @@ static void zynq_gpio_set_value(struct gpio_chip *chip, unsigned int pin,
 static int zynq_gpio_dir_in(struct gpio_chip *chip, unsigned int pin)
 {
 	u32 reg;
-	bool is_zynq_gpio;
 	unsigned int bank_num, bank_pin_num;
 	struct zynq_gpio *gpio = gpiochip_get_data(chip);
 
-	is_zynq_gpio = gpio->p_data->quirks & ZYNQ_GPIO_QUIRK_FOO;
 	zynq_gpio_get_bank_pin(pin, &bank_num, &bank_pin_num, gpio);
 
 	/*
 	 * On zynq bank 0 pins 7 and 8 are special and cannot be used
 	 * as inputs.
 	 */
-	if (is_zynq_gpio && bank_num == 0 &&
+	if (zynq_gpio_is_zynq(gpio) && bank_num == 0 &&
 		(bank_pin_num == 7 || bank_pin_num == 8))
 		return -EINVAL;
 
@@ -637,7 +646,7 @@ static const struct zynq_platform_data zynqmp_gpio_def = {
 
 static const struct zynq_platform_data zynq_gpio_def = {
 	.label = "zynq_gpio",
-	.quirks = ZYNQ_GPIO_QUIRK_FOO,
+	.quirks = ZYNQ_GPIO_QUIRK_IS_ZYNQ,
 	.ngpio = ZYNQ_GPIO_NR_GPIOS,
 	.max_bank = ZYNQ_GPIO_MAX_BANK,
 	.bank_min[0] = ZYNQ_GPIO_BANK0_PIN_MIN(),
-- 
2.13.1.3.g25490cb03
