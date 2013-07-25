From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 25 Jul 2013 12:41:16 +0200
Subject: [PATCH] pinctrl: sunxi: Fix gpio_set behaviour
Message-ID: <1374748876-23461-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current gpio_set function is ignoring the previous value set in the
GPIO value register, which leads in erasing the values already set for
the other GPIOs in the same bank when setting the value of a given GPIO.

Add the usual read/mask/write pattern to fix this brown paper bag bug.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/pinctrl/pinctrl-sunxi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-sunxi.c b/drivers/pinctrl/pinctrl-sunxi.c
index fc058b6..4f8bb18 100644
--- a/drivers/pinctrl/pinctrl-sunxi.c
+++ b/drivers/pinctrl/pinctrl-sunxi.c
@@ -464,8 +464,14 @@ static void sunxi_pinctrl_gpio_set(struct gpio_chip *chip,
 	struct sunxi_pinctrl *pctl = dev_get_drvdata(chip->dev);
 	u32 reg = sunxi_data_reg(offset);
 	u8 index = sunxi_data_offset(offset);
+	u32 regval = readl(pctl->membase + reg);
 
-	writel((value & DATA_PINS_MASK) << index, pctl->membase + reg);
+	if (value)
+		regval |= BIT(index);
+	else
+		regval &= ~(BIT(index));
+
+	writel(regval, pctl->membase + reg);
 }
 
 static int sunxi_pinctrl_gpio_of_xlate(struct gpio_chip *gc,
-- 
1.8.3.2
