From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  9 Jun 2017 12:03:18 +0200
Subject: [PATCH] gpio: mvebu: fix regmap_update_bits usage
Message-ID: <20170609100318.26450-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some place in the driver regmap_update_bits was misused. Indeed the
last argument is not the value of the bit (or group of bits) itself but
the mask value inside the register.

So when setting the bit N, then the value must be BIT(N) and not 1.

CC: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
CC: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/gpio/gpio-mvebu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 3d03740a20e7..59cb1d8514b3 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -341,7 +341,7 @@ static int mvebu_gpio_direction_input(struct gpio_chip *chip, unsigned int pin)
 		return ret;
 
 	regmap_update_bits(mvchip->regs, GPIO_IO_CONF_OFF,
-			   BIT(pin), 1);
+			   BIT(pin), BIT(pin));
 
 	return 0;
 }
@@ -364,7 +364,7 @@ static int mvebu_gpio_direction_output(struct gpio_chip *chip, unsigned int pin,
 	mvebu_gpio_set(chip, pin, value);
 
 	regmap_update_bits(mvchip->regs, GPIO_IO_CONF_OFF,
-			   BIT(pin), 0);
+			   BIT(pin), BIT(pin));
 
 	return 0;
 }
@@ -503,7 +503,7 @@ static int mvebu_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	case IRQ_TYPE_EDGE_FALLING:
 	case IRQ_TYPE_LEVEL_LOW:
 		regmap_update_bits(mvchip->regs, GPIO_IN_POL_OFF,
-				   BIT(pin), 1);
+				   BIT(pin), BIT(pin));
 		break;
 	case IRQ_TYPE_EDGE_BOTH: {
 		u32 data_in, in_pol, val;
-- 
2.11.0
