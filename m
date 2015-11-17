From: hongzhou.yang@mediatek.com (Hongzhou Yang)
Date: Tue, 17 Nov 2015 14:17:13 -0800
Subject: [PATCH] pinctrl: mediatek: Add get_direction support.
Message-ID: <1447798633-24586-1-git-send-email-hongzhou.yang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since Linux gpio framework return 0 for output, 1 for input.
But HW use 0 stands for input, and 1 stands for output.
So use negative to correct it.

And gpio_chip.get is used to get input value, no need to get
output value, so removing it.

Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
---
 Base on v4.4-rc1, resend it.
 Add get direction support.
 Remove gpio_chip.get value for output direction.

 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index f307f1d..5c71727 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -747,7 +747,7 @@ static int mtk_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
 	reg_addr =  mtk_get_port(pctl, offset) + pctl->devdata->dir_offset;
 	bit = BIT(offset & 0xf);
 	regmap_read(pctl->regmap1, reg_addr, &read_val);
-	return !!(read_val & bit);
+	return !(read_val & bit);
 }
 
 static int mtk_gpio_get(struct gpio_chip *chip, unsigned offset)
@@ -757,12 +757,8 @@ static int mtk_gpio_get(struct gpio_chip *chip, unsigned offset)
 	unsigned int read_val = 0;
 	struct mtk_pinctrl *pctl = dev_get_drvdata(chip->dev);
 
-	if (mtk_gpio_get_direction(chip, offset))
-		reg_addr = mtk_get_port(pctl, offset) +
-			pctl->devdata->dout_offset;
-	else
-		reg_addr = mtk_get_port(pctl, offset) +
-			pctl->devdata->din_offset;
+	reg_addr = mtk_get_port(pctl, offset) +
+		pctl->devdata->din_offset;
 
 	bit = BIT(offset & 0xf);
 	regmap_read(pctl->regmap1, reg_addr, &read_val);
@@ -997,6 +993,7 @@ static struct gpio_chip mtk_gpio_chip = {
 	.owner			= THIS_MODULE,
 	.request		= gpiochip_generic_request,
 	.free			= gpiochip_generic_free,
+	.get_direction		= mtk_gpio_get_direction,
 	.direction_input	= mtk_gpio_direction_input,
 	.direction_output	= mtk_gpio_direction_output,
 	.get			= mtk_gpio_get,
-- 
1.7.9.5
