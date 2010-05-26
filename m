From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Wed, 26 May 2010 09:25:01 +0530
Subject: [PATCH] nomadik-gpio: set val in ->direction_output()
Message-ID: <1274846101-29433-1-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ->direction_output() callback needs to set the value it was passed,
in addition to setting the direction as output.  On this peripheral, we
can't set the value before setting the direction, so set it after.

Acked-by: Alessandro Rubini <rubini@unipv.it>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/plat-nomadik/gpio.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index 5fe17bf..12d1c7c 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -456,16 +456,6 @@ static int nmk_gpio_make_input(struct gpio_chip *chip, unsigned offset)
 	return 0;
 }
 
-static int nmk_gpio_make_output(struct gpio_chip *chip, unsigned offset,
-				int val)
-{
-	struct nmk_gpio_chip *nmk_chip =
-		container_of(chip, struct nmk_gpio_chip, chip);
-
-	writel(1 << offset, nmk_chip->addr + NMK_GPIO_DIRS);
-	return 0;
-}
-
 static int nmk_gpio_get_input(struct gpio_chip *chip, unsigned offset)
 {
 	struct nmk_gpio_chip *nmk_chip =
@@ -488,6 +478,18 @@ static void nmk_gpio_set_output(struct gpio_chip *chip, unsigned offset,
 		writel(bit, nmk_chip->addr + NMK_GPIO_DATC);
 }
 
+static int nmk_gpio_make_output(struct gpio_chip *chip, unsigned offset,
+				int val)
+{
+	struct nmk_gpio_chip *nmk_chip =
+		container_of(chip, struct nmk_gpio_chip, chip);
+
+	writel(1 << offset, nmk_chip->addr + NMK_GPIO_DIRS);
+	nmk_gpio_set_output(chip, offset, val);
+
+	return 0;
+}
+
 /* This structure is replicated for each GPIO block allocated at probe time */
 static struct gpio_chip nmk_gpio_template = {
 	.direction_input	= nmk_gpio_make_input,
-- 
1.7.0
