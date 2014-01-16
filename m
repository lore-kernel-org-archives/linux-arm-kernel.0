From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 16 Jan 2014 18:07:48 +0800
Subject: [PATCH RESEND v2] pinctrl: sunxi: Honor GPIO output initial vaules
Message-ID: <1389866868-29989-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some GPIO users, such as fixed-regulator, request GPIO output with
initial value of 1. This was ignored by sunxi driver.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: stable at vger.kernel.org
---

Resend CCing stable.

Changes since v2:

  * Set output value before setting the pin function to avoid a glitch.


 drivers/pinctrl/pinctrl-sunxi.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-sunxi.c b/drivers/pinctrl/pinctrl-sunxi.c
index 119d2dd..6ebf306 100644
--- a/drivers/pinctrl/pinctrl-sunxi.c
+++ b/drivers/pinctrl/pinctrl-sunxi.c
@@ -469,12 +469,6 @@ static int sunxi_pinctrl_gpio_get(struct gpio_chip *chip, unsigned offset)
 	return val;
 }
 
-static int sunxi_pinctrl_gpio_direction_output(struct gpio_chip *chip,
-					unsigned offset, int value)
-{
-	return pinctrl_gpio_direction_output(chip->base + offset);
-}
-
 static void sunxi_pinctrl_gpio_set(struct gpio_chip *chip,
 				unsigned offset, int value)
 {
@@ -498,6 +492,13 @@ static void sunxi_pinctrl_gpio_set(struct gpio_chip *chip,
 	spin_unlock_irqrestore(&pctl->lock, flags);
 }
 
+static int sunxi_pinctrl_gpio_direction_output(struct gpio_chip *chip,
+					unsigned offset, int value)
+{
+	sunxi_pinctrl_gpio_set(chip, offset, value);
+	return pinctrl_gpio_direction_output(chip->base + offset);
+}
+
 static int sunxi_pinctrl_gpio_of_xlate(struct gpio_chip *gc,
 				const struct of_phandle_args *gpiospec,
 				u32 *flags)
-- 
1.8.5.2
