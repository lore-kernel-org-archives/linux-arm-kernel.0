From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 20 Nov 2012 22:31:39 +0100
Subject: [PATCH 1/5] pinctrl: at91: provide gpio names
In-Reply-To: <20121120212326.GO4398@game.jcrosoft.org>
References: <20121120212326.GO4398@game.jcrosoft.org>
Message-ID: <1353447103-31616-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-at91.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index b9e2cbd..401fc96 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1364,9 +1364,10 @@ static int __devinit at91_gpio_probe(struct platform_device *pdev)
 	struct gpio_chip *chip;
 	struct pinctrl_gpio_range *range;
 	int ret = 0;
-	int irq;
+	int irq, i;
 	int alias_idx = of_alias_get_id(np, "gpio");
 	uint32_t ngpio;
+	char **names;
 
 	BUG_ON(alias_idx >= ARRAY_SIZE(gpio_chips));
 	if (gpio_chips[alias_idx]) {
@@ -1436,6 +1437,18 @@ static int __devinit at91_gpio_probe(struct platform_device *pdev)
 			chip->ngpio = ngpio;
 	}
 
+	names = devm_kzalloc(&pdev->dev, sizeof(char*) * chip->ngpio, GFP_KERNEL);
+
+	if (!names) {
+		ret = -ENOMEM;
+		goto clk_err;
+	}
+
+	for (i = 0; i < chip->ngpio; i++)
+		names[i] = kasprintf(GFP_KERNEL, "pio%c%d", alias_idx + 'A', i);
+
+	chip->names = (const char*const*)names;
+
 	range = &at91_chip->range;
 	range->name = chip->label;
 	range->id = alias_idx;
-- 
1.7.10.4
