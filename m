From: ian@slimlogic.co.uk (Ian Lartey)
Date: Fri, 22 Mar 2013 13:36:09 +0000
Subject: [PATCH v9 07/11] gpio: Palmas palmas_gpio_(read|write|update)
 factoring
In-Reply-To: <1363959373-10671-1-git-send-email-ian@slimlogic.co.uk>
References: <1363959373-10671-1-git-send-email-ian@slimlogic.co.uk>
Message-ID: <1363959373-10671-8-git-send-email-ian@slimlogic.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

palmas_gpio_(read|write|update)  gpio parameter renamed to offset
palmas_gpio_write   renamed to palmas_gpio_clear_and_set
as it no longer takes a data value instead it always sets the
offset bit and clears all other bits -

Signed-off-by: Ian Lartey <ian@slimlogic.co.uk>
---
 drivers/gpio/gpio-palmas.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpio-palmas.c b/drivers/gpio/gpio-palmas.c
index 04da57a..689c633 100644
--- a/drivers/gpio/gpio-palmas.c
+++ b/drivers/gpio/gpio-palmas.c
@@ -32,30 +32,31 @@ struct palmas_gpio {
 };
 
 static int palmas_gpio_read(struct palmas *palmas, unsigned int reg,
-		int gpio, unsigned int *dest)
+		int offset, unsigned int *dest)
 {
 	/* registers for second bank are identical and offset by 0x9 */
-	if (gpio > 7)
+	if (offset > 7)
 		reg += PALMAS_GPIO_DATA_IN2;
 
 	return palmas_read(palmas, PALMAS_GPIO_BASE, reg, dest);
 }
 
-static int palmas_gpio_write(struct palmas *palmas, unsigned int reg,
-		int gpio, unsigned int data)
+/* Note: This procedure sets 1 bit and clears _all_ others */
+static int palmas_gpio_clear_and_set(struct palmas *palmas, unsigned int reg,
+		int offset)
 {
 	/* registers for second bank are identical and offset by 0x9 */
-	if (gpio > 7)
+	if (offset > 7)
 		reg += PALMAS_GPIO_DATA_IN2;
 
-	return palmas_write(palmas, PALMAS_GPIO_BASE, reg, data);
+	return palmas_write(palmas, PALMAS_GPIO_BASE, reg, BIT(offset % 8));
 }
 
 static int palmas_gpio_update_bits(struct palmas *palmas, unsigned int reg,
-		int gpio, unsigned int mask, unsigned int data)
+		int offset, unsigned int mask, unsigned int data)
 {
 	/* registers for second bank are identical and offset by 0x9 */
-	if (gpio > 7)
+	if (offset > 7)
 		reg += PALMAS_GPIO_DATA_IN2;
 
 	return palmas_update_bits(palmas, PALMAS_GPIO_BASE, reg, mask, data);
@@ -89,11 +90,11 @@ static void palmas_gpio_set(struct gpio_chip *gc, unsigned offset,
 	int ret;
 
 	if (value)
-		ret = palmas_gpio_write(palmas, PALMAS_GPIO_SET_DATA_OUT,
-				offset, BIT(offset % 8));
+		ret = palmas_gpio_clear_and_set(palmas,
+				PALMAS_GPIO_SET_DATA_OUT, offset);
 	else
-		ret = palmas_gpio_write(palmas, PALMAS_GPIO_CLEAR_DATA_OUT,
-				offset, BIT(offset % 8));
+		ret = palmas_gpio_clear_and_set(palmas,
+				PALMAS_GPIO_CLEAR_DATA_OUT, offset);
 	if (ret < 0)
 		dev_err(gc->dev, "%s write failed, err = %d\n",
 			(value) ? "GPIO_SET_DATA_OUT" : "GPIO_CLEAR_DATA_OUT",
@@ -111,7 +112,7 @@ static int palmas_gpio_output(struct gpio_chip *gc, unsigned offset,
 	palmas_gpio_set(gc, offset, value);
 
 	ret = palmas_gpio_update_bits(palmas, PALMAS_GPIO_DATA_DIR,
-			offset, 1 << (offset % 8), 1 << (offset % 8));
+			offset, BIT(offset % 8), BIT(offset % 8));
 	if (ret < 0)
 		dev_err(gc->dev, "GPIO_DATA_DIR write failed, err = %d\n", ret);
 	return ret;
@@ -124,7 +125,7 @@ static int palmas_gpio_input(struct gpio_chip *gc, unsigned offset)
 	int ret;
 
 	ret =  palmas_gpio_update_bits(palmas, PALMAS_GPIO_DATA_DIR,
-				offset, 1 << (offset % 8), 0);
+				offset, BIT(offset % 8), 0);
 	if (ret < 0)
 		dev_err(gc->dev, "GPIO_DATA_DIR write failed, err = %d\n", ret);
 	return ret;
@@ -149,7 +150,7 @@ static int palmas_gpio_set_debounce(struct gpio_chip *gc, unsigned offset,
 		data = 0xff;
 
 	return palmas_gpio_update_bits(palmas, PALMAS_GPIO_DEBOUNCE_EN,
-			offset, 1 << (offset % 8), data);
+			offset, BIT(offset % 8), data);
 }
 
 static int  palmas_gpio_probe(struct platform_device *pdev)
@@ -210,7 +211,6 @@ static int palmas_gpio_remove(struct platform_device *pdev)
 
 static struct of_device_id of_palmas_match_tbl[] = {
 	{ .compatible = "ti,palmas-gpio", },
-	{ .compatible = "ti,palmas-charger-gpio", },
 	{ .compatible = "ti,twl6035-gpio", },
 	{ .compatible = "ti,twl6036-gpio", },
 	{ .compatible = "ti,twl6037-gpio", },
-- 
1.7.0.4
