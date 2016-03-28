From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 28 Mar 2016 14:58:24 +0000
Subject: [PATCH] pinctrl: bcm2835: Implement get_direction callback
Message-ID: <1459177104-24353-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement gpio_chip's get_direction() callback, that lets other
drivers get particular GPIOs direction using gpiod_get_direction().

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index 08b1d93..dd8b174 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -342,6 +342,18 @@ static int bcm2835_gpio_get(struct gpio_chip *chip, unsigned offset)
 	return bcm2835_gpio_get_bit(pc, GPLEV0, offset);
 }
 
+static int bcm2835_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
+{
+	struct bcm2835_pinctrl *pc = gpiochip_get_data(chip);
+	enum bcm2835_fsel fsel = bcm2835_pinctrl_fsel_get(pc, offset);
+
+	/* Alternative function doesn't clearly provide a direction */
+	if (fsel > BCM2835_FSEL_GPIO_OUT)
+		return -EINVAL;
+
+	return (fsel == BCM2835_FSEL_GPIO_IN);
+}
+
 static void bcm2835_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
 	struct bcm2835_pinctrl *pc = gpiochip_get_data(chip);
@@ -370,6 +382,7 @@ static struct gpio_chip bcm2835_gpio_chip = {
 	.free = gpiochip_generic_free,
 	.direction_input = bcm2835_gpio_direction_input,
 	.direction_output = bcm2835_gpio_direction_output,
+	.get_direction = bcm2835_gpio_get_direction,
 	.get = bcm2835_gpio_get,
 	.set = bcm2835_gpio_set,
 	.to_irq = bcm2835_gpio_to_irq,
-- 
1.7.9.5
