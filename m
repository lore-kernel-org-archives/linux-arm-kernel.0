From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue,  5 Dec 2017 15:46:44 +0100
Subject: [PATCH v5 6/9] pinctrl: axp209: add programmable gpio_status_offset
In-Reply-To: <20171205144647.17594-1-quentin.schulz@free-electrons.com>
References: <20171205144647.17594-1-quentin.schulz@free-electrons.com>
Message-ID: <20171205144647.17594-7-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To prepare for patches that will add support for a new PMIC that has a
different GPIO input status register, add a gpio_status_offset within
axp20x_pctl structure and use it.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/pinctrl/pinctrl-axp209.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-axp209.c b/drivers/pinctrl/pinctrl-axp209.c
index 17eeb0410a5b..db8e319b6e11 100644
--- a/drivers/pinctrl/pinctrl-axp209.c
+++ b/drivers/pinctrl/pinctrl-axp209.c
@@ -48,6 +48,7 @@ struct axp20x_pctrl_desc {
 	u8				ldo_mask;
 	/* Stores the pins supporting ADC function. Bit offset is pin number. */
 	u8				adc_mask;
+	u8				gpio_status_offset;
 };
 
 struct axp20x_pinctrl_function {
@@ -77,6 +78,7 @@ static const struct axp20x_pctrl_desc axp20x_data = {
 	.npins	= ARRAY_SIZE(axp209_pins),
 	.ldo_mask = BIT(0) | BIT(1),
 	.adc_mask = BIT(0) | BIT(1),
+	.gpio_status_offset = 4,
 };
 
 static int axp20x_gpio_get_reg(unsigned int offset)
@@ -108,7 +110,7 @@ static int axp20x_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	if (ret)
 		return ret;
 
-	return !!(val & BIT(offset + 4));
+	return !!(val & BIT(offset + pctl->desc->gpio_status_offset));
 }
 
 static int axp20x_gpio_get_direction(struct gpio_chip *chip,
-- 
2.14.1
