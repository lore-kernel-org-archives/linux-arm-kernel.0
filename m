From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Wed, 23 Nov 2016 15:11:50 +0100
Subject: [PATCH RESEND 1/2] gpio: axp209: use correct register for GPIO input
 status
In-Reply-To: <20161123141151.25315-1-quentin.schulz@free-electrons.com>
References: <20161123141151.25315-1-quentin.schulz@free-electrons.com>
Message-ID: <20161123141151.25315-2-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPIO input status was read from control register
(AXP20X_GPIO[210]_CTRL) instead of status register (AXP20X_GPIO20_SS).

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/gpio/gpio-axp209.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-axp209.c b/drivers/gpio/gpio-axp209.c
index d9c2a51..4a346b7 100644
--- a/drivers/gpio/gpio-axp209.c
+++ b/drivers/gpio/gpio-axp209.c
@@ -64,13 +64,9 @@ static int axp20x_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
 	struct axp20x_gpio *gpio = gpiochip_get_data(chip);
 	unsigned int val;
-	int reg, ret;
-
-	reg = axp20x_gpio_get_reg(offset);
-	if (reg < 0)
-		return reg;
+	int ret;
 
-	ret = regmap_read(gpio->regmap, reg, &val);
+	ret = regmap_read(gpio->regmap, AXP20X_GPIO20_SS, &val);
 	if (ret)
 		return ret;
 
-- 
2.9.3
