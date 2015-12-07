From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon,  7 Dec 2015 18:10:24 +0000
Subject: [PATCH RESEND] pinctrl: bcm2835: Fix initial value for
 direction_output
Message-ID: <1449511825-6156-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the provided initial value for bcm2835_gpio_direction_output
has no effect. So fix this issue by changing the value before
changing the GPIO direction. As a result we need to move the function below
bcm2835_gpio_set.

Suggested-by: Martin Sperl <kernel@martin.sperl.org>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Fixes: e1b2dc70cd5b ("pinctrl: add bcm2835 driver")
Acked-by: Stephen Warren <swarren@wwwdotorg.org>
Acked-by: Eric Anholt <eric@anholt.net>
---

This patch was inspired by this discussion [1].

[1] - http://lists.infradead.org/pipermail/linux-rpi-kernel/2015-April/001499.html

Changes:
- added suggested-by, fixes and acked-by tag since first submit

 drivers/pinctrl/bcm/pinctrl-bcm2835.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index 8efa235..fd1441b 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -352,12 +352,6 @@ static int bcm2835_gpio_get(struct gpio_chip *chip, unsigned offset)
 	return bcm2835_gpio_get_bit(pc, GPLEV0, offset);
 }
 
-static int bcm2835_gpio_direction_output(struct gpio_chip *chip,
-		unsigned offset, int value)
-{
-	return pinctrl_gpio_direction_output(chip->base + offset);
-}
-
 static void bcm2835_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
 	struct bcm2835_pinctrl *pc = dev_get_drvdata(chip->dev);
@@ -365,6 +359,13 @@ static void bcm2835_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	bcm2835_gpio_set_bit(pc, value ? GPSET0 : GPCLR0, offset);
 }
 
+static int bcm2835_gpio_direction_output(struct gpio_chip *chip,
+		unsigned offset, int value)
+{
+	bcm2835_gpio_set(chip, offset, value);
+	return pinctrl_gpio_direction_output(chip->base + offset);
+}
+
 static int bcm2835_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 {
 	struct bcm2835_pinctrl *pc = dev_get_drvdata(chip->dev);
-- 
1.7.9.5
