From: nava.manne@xilinx.com (Nava kishore Manne)
Date: Tue, 20 Sep 2016 14:02:04 +0530
Subject: [PATCH] gpio: Added zynq specific check for special pins on bank zero
Message-ID: <1474360324-8168-1-git-send-email-navam@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nava kishore Manne <nava.manne@xilinx.com>

This patch adds zynq specific check for bank 0 pins 7 and 8
are special and cannot be used as inputs

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
---
 drivers/gpio/gpio-zynq.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index e72794e..eae9d24 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -96,6 +96,10 @@
 /* GPIO upper 16 bit mask */
 #define ZYNQ_GPIO_UPPER_MASK 0xFFFF0000
 
+/* For GPIO quirks */
+#define ZYNQ_GPIO	BIT(0)
+#define ZYNQMP_GPIO	BIT(1)
+
 /**
  * struct zynq_gpio - gpio device private data structure
  * @chip:	instance of the gpio_chip
@@ -122,6 +126,7 @@ struct zynq_gpio {
 */
 struct zynq_platform_data {
 	const char *label;
+	u32 quirks;
 	u16 ngpio;
 	int max_bank;
 	int bank_min[ZYNQMP_GPIO_MAX_BANK];
@@ -238,13 +243,19 @@ static void zynq_gpio_set_value(struct gpio_chip *chip, unsigned int pin,
 static int zynq_gpio_dir_in(struct gpio_chip *chip, unsigned int pin)
 {
 	u32 reg;
+	bool is_zynq_gpio;
 	unsigned int bank_num, bank_pin_num;
 	struct zynq_gpio *gpio = gpiochip_get_data(chip);
 
+	is_zynq_gpio = gpio->p_data->quirks & ZYNQ_GPIO;
 	zynq_gpio_get_bank_pin(pin, &bank_num, &bank_pin_num, gpio);
 
-	/* bank 0 pins 7 and 8 are special and cannot be used as inputs */
-	if (bank_num == 0 && (bank_pin_num == 7 || bank_pin_num == 8))
+	/*
+	 * On zynq bank 0 pins 7 and 8 are special and cannot be used
+	 * as inputs.
+	 */
+	if (is_zynq_gpio && bank_num == 0 &&
+		(bank_pin_num == 7 || bank_pin_num == 8))
 		return -EINVAL;
 
 	/* clear the bit in direction mode reg to set the pin as input */
@@ -609,6 +620,7 @@ static const struct dev_pm_ops zynq_gpio_dev_pm_ops = {
 
 static const struct zynq_platform_data zynqmp_gpio_def = {
 	.label = "zynqmp_gpio",
+	.quirks = ZYNQMP_GPIO,
 	.ngpio = ZYNQMP_GPIO_NR_GPIOS,
 	.max_bank = ZYNQMP_GPIO_MAX_BANK,
 	.bank_min[0] = ZYNQ_GPIO_BANK0_PIN_MIN(MP),
@@ -627,6 +639,7 @@ static const struct zynq_platform_data zynqmp_gpio_def = {
 
 static const struct zynq_platform_data zynq_gpio_def = {
 	.label = "zynq_gpio",
+	.quirks = ZYNQ_GPIO,
 	.ngpio = ZYNQ_GPIO_NR_GPIOS,
 	.max_bank = ZYNQ_GPIO_MAX_BANK,
 	.bank_min[0] = ZYNQ_GPIO_BANK0_PIN_MIN(),
-- 
2.1.2
