From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 11 Oct 2012 16:36:37 +0200
Subject: [PATCH] pinctrl/nomadik: always use the simple irqdomain
Message-ID: <1349966197-18777-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Since the simple irqdomain will fall back to a linear domain
if the first_irq provided is <= 0, just use this, just make
sure the first_irq is negative in the device tree case.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-nomadik.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
index 992982c..a4a4247 100644
--- a/drivers/pinctrl/pinctrl-nomadik.c
+++ b/drivers/pinctrl/pinctrl-nomadik.c
@@ -1277,6 +1277,7 @@ static int __devinit nmk_gpio_probe(struct platform_device *dev)
 	struct clk *clk;
 	int secondary_irq;
 	void __iomem *base;
+	int irq_start = -1;
 	int irq;
 	int ret;
 
@@ -1380,19 +1381,11 @@ static int __devinit nmk_gpio_probe(struct platform_device *dev)
 
 	platform_set_drvdata(dev, nmk_chip);
 
-	if (np) {
-		/* The DT case will just grab a set of IRQ numbers */
-		nmk_chip->domain = irq_domain_add_linear(np, NMK_GPIO_PER_CHIP,
-				&nmk_gpio_irq_simple_ops, nmk_chip);
-	} else {
-		/* Non-DT legacy mode, use hardwired IRQ numbers */
-		int irq_start;
-
+	if (!np)
 		irq_start = NOMADIK_GPIO_TO_IRQ(pdata->first_gpio);
-		nmk_chip->domain = irq_domain_add_simple(NULL,
+	nmk_chip->domain = irq_domain_add_simple(NULL,
 				NMK_GPIO_PER_CHIP, irq_start,
 				&nmk_gpio_irq_simple_ops, nmk_chip);
-	}
 	if (!nmk_chip->domain) {
 		dev_err(&dev->dev, "failed to create irqdomain\n");
 		ret = -ENOSYS;
-- 
1.7.11.3
