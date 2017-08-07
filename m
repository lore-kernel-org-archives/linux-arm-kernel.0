From: michal.simek@xilinx.com (Michal Simek)
Date: Mon,  7 Aug 2017 13:01:57 +0200
Subject: [PATCH 4/8] gpio: zynq: Provided workaround for GPIO
In-Reply-To: <cover.1502103715.git.michal.simek@xilinx.com>
References: <cover.1502103715.git.michal.simek@xilinx.com>
Message-ID: <4f1f7ed79879d17e38ffda095d631d0f561c2818.1502103715.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Swapna Manupati <swapna.manupati@xilinx.com>

This patch provides workaround in the gpio driver
for Zynq and ZynqMP Platforms by reading pin value
of EMIO banks through DATA register as it was unable
to read the value of it from DATA_RO register.

Signed-off-by: Swapna Manupati <swapnam@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/gpio/gpio-zynq.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index bcf11f0ef5c3..1ab0f8c991b6 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -70,6 +70,7 @@
 /* MSW Mask & Data -WO */
 #define ZYNQ_GPIO_DATA_MSW_OFFSET(BANK)	(0x004 + (8 * BANK))
 /* Data Register-RW */
+#define ZYNQ_GPIO_DATA_OFFSET(BANK)	(0x040 + (4 * BANK))
 #define ZYNQ_GPIO_DATA_RO_OFFSET(BANK)	(0x060 + (4 * BANK))
 /* Direction mode reg-RW */
 #define ZYNQ_GPIO_DIRM_OFFSET(BANK)	(0x204 + (0x40 * BANK))
@@ -101,6 +102,7 @@
 
 /* set to differentiate zynq from zynqmp, 0=zynqmp, 1=zynq */
 #define ZYNQ_GPIO_QUIRK_IS_ZYNQ	BIT(0)
+#define GPIO_QUIRK_DATA_RO_BUG	BIT(1)
 
 struct gpio_regs {
 	u32 datamsw[ZYNQMP_GPIO_MAX_BANK];
@@ -163,6 +165,17 @@ static int zynq_gpio_is_zynq(struct zynq_gpio *gpio)
 }
 
 /**
+ * gpio_data_ro_bug - test if HW bug exists or not
+ * @gpio:       Pointer to driver data struct
+ *
+ * Return: 0 if bug doesnot exist, 1 if bug exists.
+ */
+static int gpio_data_ro_bug(struct zynq_gpio *gpio)
+{
+	return !!(gpio->p_data->quirks & GPIO_QUIRK_DATA_RO_BUG);
+}
+
+/**
  * zynq_gpio_get_bank_pin - Get the bank number and pin number within that bank
  * for a given pin in the GPIO device
  * @pin_num:	gpio pin number within the device
@@ -213,9 +226,28 @@ static int zynq_gpio_get_value(struct gpio_chip *chip, unsigned int pin)
 
 	zynq_gpio_get_bank_pin(pin, &bank_num, &bank_pin_num, gpio);
 
-	data = readl_relaxed(gpio->base_addr +
-			     ZYNQ_GPIO_DATA_RO_OFFSET(bank_num));
-
+	if (gpio_data_ro_bug(gpio)) {
+		if (zynq_gpio_is_zynq(gpio)) {
+			if (bank_num <= 1) {
+				data = readl_relaxed(gpio->base_addr +
+					ZYNQ_GPIO_DATA_RO_OFFSET(bank_num));
+			} else {
+				data = readl_relaxed(gpio->base_addr +
+					ZYNQ_GPIO_DATA_OFFSET(bank_num));
+			}
+		} else {
+			if (bank_num <= 2) {
+				data = readl_relaxed(gpio->base_addr +
+					ZYNQ_GPIO_DATA_RO_OFFSET(bank_num));
+			} else {
+				data = readl_relaxed(gpio->base_addr +
+					ZYNQ_GPIO_DATA_OFFSET(bank_num));
+			}
+		}
+	} else {
+		data = readl_relaxed(gpio->base_addr +
+			ZYNQ_GPIO_DATA_RO_OFFSET(bank_num));
+	}
 	return (data >> bank_pin_num) & 1;
 }
 
@@ -743,6 +775,7 @@ static void zynq_gpio_free(struct gpio_chip *chip, unsigned offset)
 
 static const struct zynq_platform_data zynqmp_gpio_def = {
 	.label = "zynqmp_gpio",
+	.quirks = GPIO_QUIRK_DATA_RO_BUG,
 	.ngpio = ZYNQMP_GPIO_NR_GPIOS,
 	.max_bank = ZYNQMP_GPIO_MAX_BANK,
 	.bank_min[0] = ZYNQ_GPIO_BANK0_PIN_MIN(MP),
@@ -761,7 +794,7 @@ static void zynq_gpio_free(struct gpio_chip *chip, unsigned offset)
 
 static const struct zynq_platform_data zynq_gpio_def = {
 	.label = "zynq_gpio",
-	.quirks = ZYNQ_GPIO_QUIRK_IS_ZYNQ,
+	.quirks = ZYNQ_GPIO_QUIRK_IS_ZYNQ | GPIO_QUIRK_DATA_RO_BUG,
 	.ngpio = ZYNQ_GPIO_NR_GPIOS,
 	.max_bank = ZYNQ_GPIO_MAX_BANK,
 	.bank_min[0] = ZYNQ_GPIO_BANK0_PIN_MIN(),
-- 
1.9.1
