From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 14 Nov 2017 17:51:50 +0100
Subject: [PATCH] pinctrl: armada-37xx: Fix direction_output() callback behavior
Message-ID: <20171114165150.19599-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The direction_output callback of the gpio_chip structure is supposed to
set the output direction but also to set the value of the gpio. For the
armada-37xx driver this callback acted as the gpio_set_direction callback
for the pinctrl.

This patch fixes the behavior of the direction_output callback by also
applying the value received as parameter.

Cc: stable at vger.kernel.org
Fixes: 5715092a458c ("pinctrl: armada-37xx: Add gpio support")
Reported-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index 71b944748304..c5fe7d4a9065 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -408,12 +408,21 @@ static int armada_37xx_gpio_direction_output(struct gpio_chip *chip,
 {
 	struct armada_37xx_pinctrl *info = gpiochip_get_data(chip);
 	unsigned int reg = OUTPUT_EN;
-	unsigned int mask;
+	unsigned int mask, val, ret;
 
 	armada_37xx_update_reg(&reg, offset);
 	mask = BIT(offset);
 
-	return regmap_update_bits(info->regmap, reg, mask, mask);
+	ret = regmap_update_bits(info->regmap, reg, mask, mask);
+
+	if (ret)
+		return ret;
+
+	reg = OUTPUT_VAL;
+	val = value ? mask : 0;
+	regmap_update_bits(info->regmap, reg, mask, val);
+
+	return 0;
 }
 
 static int armada_37xx_gpio_get(struct gpio_chip *chip, unsigned int offset)
-- 
2.14.2
