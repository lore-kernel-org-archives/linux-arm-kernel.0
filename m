From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 24 May 2016 12:03:24 +0200
Subject: [PATCH] pinctrl: oxnas: Add GPIO get_direction
Message-ID: <1464084204-2271-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement a get_direction callback for the OXNAS GPIO driver in order
to have pin output polarity in debugfs and new userspace ABI.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pinctrl/pinctrl-oxnas.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

Linus,

Sorry, I should have implemented it earlier but I was focused to
have a clean driver for upstream !

Thanks,
Neil

diff --git a/drivers/pinctrl/pinctrl-oxnas.c b/drivers/pinctrl/pinctrl-oxnas.c
index 5fd113c..2c6abef 100644
--- a/drivers/pinctrl/pinctrl-oxnas.c
+++ b/drivers/pinctrl/pinctrl-oxnas.c
@@ -49,6 +49,7 @@
 
 /* GPIO Registers */
 #define INPUT_VALUE	0x00
+#define OUTPUT_EN	0x04
 #define IRQ_PENDING	0x0c
 #define OUTPUT_SET	0x14
 #define OUTPUT_CLEAR	0x18
@@ -431,6 +432,15 @@ static int oxnas_gpio_request_enable(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
+static int oxnas_gpio_get_direction(struct gpio_chip *chip,
+				      unsigned int offset)
+{
+	struct oxnas_gpio_bank *bank = gpiochip_get_data(chip);
+	u32 mask = BIT(offset);
+
+	return !(readl_relaxed(bank->reg_base + OUTPUT_EN) & mask);
+}
+
 static int oxnas_gpio_direction_input(struct gpio_chip *chip,
 				      unsigned int offset)
 {
@@ -664,6 +674,7 @@ static void oxnas_gpio_irq_handler(struct irq_desc *desc)
 			.label = "GPIO" #_bank,				\
 			.request = gpiochip_generic_request,		\
 			.free = gpiochip_generic_free,			\
+			.get_direction = oxnas_gpio_get_direction,	\
 			.direction_input = oxnas_gpio_direction_input,	\
 			.direction_output = oxnas_gpio_direction_output, \
 			.get = oxnas_gpio_get,				\
-- 
1.9.1
