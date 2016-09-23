From: nava.manne@xilinx.com (Nava kishore Manne)
Date: Fri, 23 Sep 2016 15:35:37 +0530
Subject: [PATCH v2] gpio: Added zynq specific check for special pins on bank
 zero
Message-ID: <1474625137-9022-1-git-send-email-navam@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nava kishore Manne <nava.manne@xilinx.com>

This patch adds zynq specific check for bank 0 pins 7 and 8
are special and cannot be used as inputs

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
---
Changes for v2:
                -Removed un-used quirks for zynqmp.

 drivers/gpio/gpio-zynq.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index e72794e..2b689e8 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -96,6 +96,9 @@
 /* GPIO upper 16 bit mask */
 #define ZYNQ_GPIO_UPPER_MASK 0xFFFF0000
 
+/* For GPIO quirks */
+#define ZYNQ_GPIO	BIT(0)
+
 /**
  * struct zynq_gpio - gpio device private data structure
  * @chip:	instance of the gpio_chip
@@ -122,6 +125,7 @@ struct zynq_gpio {
 */
 struct zynq_platform_data {
 	const char *label;
+	u32 quirks;
 	u16 ngpio;
 	int max_bank;
 	int bank_min[ZYNQMP_GPIO_MAX_BANK];
@@ -238,13 +242,19 @@ static void zynq_gpio_set_value(struct gpio_chip *chip, unsigned int pin,
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
@@ -627,6 +637,7 @@ static const struct zynq_platform_data zynqmp_gpio_def = {
 
 static const struct zynq_platform_data zynq_gpio_def = {
 	.label = "zynq_gpio",
+	.quirks = ZYNQ_GPIO,
 	.ngpio = ZYNQ_GPIO_NR_GPIOS,
 	.max_bank = ZYNQ_GPIO_MAX_BANK,
 	.bank_min[0] = ZYNQ_GPIO_BANK0_PIN_MIN(),
-- 
2.1.2
