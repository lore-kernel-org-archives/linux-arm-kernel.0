From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 12 Jun 2017 17:34:52 +0200
Subject: [PATCH v3 1/9] gpio: mvebu: fix regmap_update_bits usage
In-Reply-To: <cover.d003a5e862e6d732d901a61d1765a349c9a89eef.1497281623.git-series.gregory.clement@free-electrons.com>
References: <cover.d003a5e862e6d732d901a61d1765a349c9a89eef.1497281623.git-series.gregory.clement@free-electrons.com>
Message-ID: <9a098130daa8daeef89fd6c1e80d982699d5c175.1497281623.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some place in the driver regmap_update_bits was misused. Indeed the
last argument is not the value of the bit (or group of bits) itself but
the mask value inside the register.

So when setting the bit N, then the value must be BIT(N) and not 1.

CC: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
CC: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Tested-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Tested-by: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/gpio/gpio-mvebu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 4aec8762fdc5..d5939913d310 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -341,7 +341,7 @@ static int mvebu_gpio_direction_input(struct gpio_chip *chip, unsigned int pin)
 		return ret;
 
 	regmap_update_bits(mvchip->regs, GPIO_IO_CONF_OFF,
-			   BIT(pin), 1);
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
git-series 0.9.1
