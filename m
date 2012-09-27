From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 27 Sep 2012 15:13:59 +0200
Subject: [PATCH 3/4] pinctrl/nomadik: use simple or linear IRQ domain
Message-ID: <1348751639-17457-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This alters the Nomadik pinctrl driver to:

- Call irqdomain_add_linear() for the DT case so we get
  all independent from IRQ numbers in this case.
- Call irqdomain_add_simple() for the legacy case, which
  allocates the IRQ descriptors for the Nomadik pin controller
  dynamically.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-nomadik.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
index e031c84..6aab107 100644
--- a/drivers/pinctrl/pinctrl-nomadik.c
+++ b/drivers/pinctrl/pinctrl-nomadik.c
@@ -1286,9 +1286,19 @@ static int __devinit nmk_gpio_probe(struct platform_device *dev)
 
 	platform_set_drvdata(dev, nmk_chip);
 
-	nmk_chip->domain = irq_domain_add_legacy(np, NMK_GPIO_PER_CHIP,
-						NOMADIK_GPIO_TO_IRQ(pdata->first_gpio),
-						0, &nmk_gpio_irq_simple_ops, nmk_chip);
+	if (np) {
+		/* The DT case will just grab a set of IRQ numbers */
+		nmk_chip->domain = irq_domain_add_linear(np, NMK_GPIO_PER_CHIP,
+				&nmk_gpio_irq_simple_ops, nmk_chip);
+	} else {
+		/* Non-DT legacy mode, use hardwired IRQ numbers */
+		int irq_start;
+
+		irq_start = NOMADIK_GPIO_TO_IRQ(pdata->first_gpio);
+		nmk_chip->domain = irq_domain_add_simple(NULL,
+				NMK_GPIO_PER_CHIP, irq_start,
+				&nmk_gpio_irq_simple_ops, nmk_chip);
+	}
 	if (!nmk_chip->domain) {
 		dev_err(&dev->dev, "failed to create irqdomain\n");
 		ret = -ENOSYS;
-- 
1.7.11.3
