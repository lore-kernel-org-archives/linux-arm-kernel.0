From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Thu, 10 Apr 2014 14:25:44 +0200
Subject: [PATCH v2 2/5] pinctrl: sunxi: support multiple pin controller
In-Reply-To: <1397132747-13917-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1397132747-13917-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1397132747-13917-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for multiple pin controller instances.

First remove the static definition of the sunxi gpio chip struct and fill
the dynamically struct instead.
Then define a new pin_base field in the sunxi_pinctrl_desc which will be
used to specify the gpiochip base pin.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 drivers/pinctrl/pinctrl-sunxi.c | 30 ++++++++++++++----------------
 drivers/pinctrl/pinctrl-sunxi.h |  1 +
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-sunxi.c b/drivers/pinctrl/pinctrl-sunxi.c
index f9fabe9..64bcc68 100644
--- a/drivers/pinctrl/pinctrl-sunxi.c
+++ b/drivers/pinctrl/pinctrl-sunxi.c
@@ -538,19 +538,6 @@ static int sunxi_pinctrl_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 	return irq_find_mapping(pctl->domain, desc->irqnum);
 }
 
-static struct gpio_chip sunxi_pinctrl_gpio_chip = {
-	.owner			= THIS_MODULE,
-	.request		= sunxi_pinctrl_gpio_request,
-	.free			= sunxi_pinctrl_gpio_free,
-	.direction_input	= sunxi_pinctrl_gpio_direction_input,
-	.direction_output	= sunxi_pinctrl_gpio_direction_output,
-	.get			= sunxi_pinctrl_gpio_get,
-	.set			= sunxi_pinctrl_gpio_set,
-	.of_xlate		= sunxi_pinctrl_gpio_of_xlate,
-	.to_irq			= sunxi_pinctrl_gpio_to_irq,
-	.of_gpio_n_cells	= 3,
-	.can_sleep		= false,
-};
 
 static int sunxi_pinctrl_irq_set_type(struct irq_data *d,
 				      unsigned int type)
@@ -858,11 +845,22 @@ static int sunxi_pinctrl_probe(struct platform_device *pdev)
 	}
 
 	last_pin = pctl->desc->pins[pctl->desc->npins - 1].pin.number;
-	pctl->chip = &sunxi_pinctrl_gpio_chip;
-	pctl->chip->ngpio = round_up(last_pin, PINS_PER_BANK);
+	pctl->chip->owner = THIS_MODULE;
+	pctl->chip->request = sunxi_pinctrl_gpio_request,
+	pctl->chip->free = sunxi_pinctrl_gpio_free,
+	pctl->chip->direction_input = sunxi_pinctrl_gpio_direction_input,
+	pctl->chip->direction_output = sunxi_pinctrl_gpio_direction_output,
+	pctl->chip->get = sunxi_pinctrl_gpio_get,
+	pctl->chip->set = sunxi_pinctrl_gpio_set,
+	pctl->chip->of_xlate = sunxi_pinctrl_gpio_of_xlate,
+	pctl->chip->to_irq = sunxi_pinctrl_gpio_to_irq,
+	pctl->chip->of_gpio_n_cells = 3,
+	pctl->chip->can_sleep = false,
+	pctl->chip->ngpio = round_up(last_pin, PINS_PER_BANK) -
+			    pctl->desc->pin_base;
 	pctl->chip->label = dev_name(&pdev->dev);
 	pctl->chip->dev = &pdev->dev;
-	pctl->chip->base = 0;
+	pctl->chip->base = pctl->desc->pin_base;
 
 	ret = gpiochip_add(pctl->chip);
 	if (ret)
diff --git a/drivers/pinctrl/pinctrl-sunxi.h b/drivers/pinctrl/pinctrl-sunxi.h
index ed3c4d7..35d15b2 100644
--- a/drivers/pinctrl/pinctrl-sunxi.h
+++ b/drivers/pinctrl/pinctrl-sunxi.h
@@ -450,6 +450,7 @@ struct sunxi_pinctrl_desc {
 	int				npins;
 	struct pinctrl_gpio_range	*ranges;
 	int				nranges;
+	unsigned			pin_base;
 };
 
 struct sunxi_pinctrl_function {
-- 
1.8.3.2
