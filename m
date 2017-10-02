From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Mon,  2 Oct 2017 14:08:46 +0200
Subject: [PATCH v3 04/12] pinctrl: axp209: add programmable gpio_status_offset
In-Reply-To: <20171002120854.5212-1-quentin.schulz@free-electrons.com>
References: <20171002120854.5212-1-quentin.schulz@free-electrons.com>
Message-ID: <20171002120854.5212-5-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To prepare for patches that will add support for a new PMIC that has a
different GPIO input status register, add a gpio_status_offset within
axp20x_pctl structure and use it.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/pinctrl/pinctrl-axp209.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-axp209.c b/drivers/pinctrl/pinctrl-axp209.c
index 3ddeba45feed..17146496b22a 100644
--- a/drivers/pinctrl/pinctrl-axp209.c
+++ b/drivers/pinctrl/pinctrl-axp209.c
@@ -45,6 +45,7 @@ struct axp20x_pctrl_desc {
 	unsigned int			ldo_mask;
 	/* Stores the pins supporting ADC function. Bit offset is pin number. */
 	unsigned int			adc_mask;
+	unsigned int			gpio_status_offset;
 };
 
 struct axp20x_pinctrl_function {
@@ -74,6 +75,7 @@ static const struct axp20x_pctrl_desc axp20x_data = {
 	.npins	= ARRAY_SIZE(axp209_pins),
 	.ldo_mask = BIT(0) | BIT(1),
 	.adc_mask = BIT(0) | BIT(1),
+	.gpio_status_offset = 4,
 };
 
 static int axp20x_gpio_get_reg(unsigned offset)
@@ -105,7 +107,7 @@ static int axp20x_gpio_get(struct gpio_chip *chip, unsigned offset)
 	if (ret)
 		return ret;
 
-	return !!(val & BIT(offset + 4));
+	return !!(val & BIT(offset + pctl->desc->gpio_status_offset));
 }
 
 static int axp20x_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
-- 
2.11.0
