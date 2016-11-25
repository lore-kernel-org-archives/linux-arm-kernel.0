From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 25 Nov 2016 15:17:42 +0100
Subject: [PATCH] pinctrl: sx150x: use new nested IRQ infrastructure
Message-ID: <1480083462-29591-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new gpiochip_irqchip_add_nested() and
gpiochip_set_nested_irqchip() calls to properly created
a nested irqchip and mark all child irqs properly with
their parent IRQ.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-sx150x.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-sx150x.c b/drivers/pinctrl/pinctrl-sx150x.c
index 1a1c8b51a992..36cb0f1ed538 100644
--- a/drivers/pinctrl/pinctrl-sx150x.c
+++ b/drivers/pinctrl/pinctrl-sx150x.c
@@ -1219,9 +1219,9 @@ static int sx150x_probe(struct i2c_client *client,
 		 * plus it will be instantly noticeable if it is ever
 		 * called (should not happen)
 		 */
-		ret = gpiochip_irqchip_add(&pctl->gpio,
-					   &pctl->irq_chip, 0,
-					   handle_bad_irq, IRQ_TYPE_NONE);
+		ret = gpiochip_irqchip_add_nested(&pctl->gpio,
+					&pctl->irq_chip, 0,
+					handle_bad_irq, IRQ_TYPE_NONE);
 		if (ret) {
 			dev_err(dev, "could not connect irqchip to gpiochip\n");
 			return ret;
@@ -1234,6 +1234,10 @@ static int sx150x_probe(struct i2c_client *client,
 						pctl->irq_chip.name, pctl);
 		if (ret < 0)
 			return ret;
+
+		gpiochip_set_nested_irqchip(&pctl->gpio,
+					    &pctl->irq_chip,
+					    client-irq);
 	}
 
 	/* Pinctrl_desc */
-- 
2.7.4
