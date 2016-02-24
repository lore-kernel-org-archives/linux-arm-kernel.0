From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:45:31 +0530
Subject: [PATCH 06/50] pinctrl: iproc-gpio: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456319775-3216-7-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_pinctrl_register() for pin control registration and clean
the error path.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Jon Mason <jonmason@broadcom.com>
---
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
index d530ab4..e753af3 100644
--- a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
+++ b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
@@ -623,7 +623,7 @@ static int iproc_gpio_register_pinconf(struct iproc_gpio *chip)
 	pctldesc->npins = gc->ngpio;
 	pctldesc->confops = &iproc_pconf_ops;
 
-	chip->pctl = pinctrl_register(pctldesc, chip->dev, chip);
+	chip->pctl = devm_pinctrl_register(chip->dev, pctldesc, chip);
 	if (IS_ERR(chip->pctl)) {
 		dev_err(chip->dev, "unable to register pinctrl device\n");
 		return PTR_ERR(chip->pctl);
@@ -632,11 +632,6 @@ static int iproc_gpio_register_pinconf(struct iproc_gpio *chip)
 	return 0;
 }
 
-static void iproc_gpio_unregister_pinconf(struct iproc_gpio *chip)
-{
-	pinctrl_unregister(chip->pctl);
-}
-
 static const struct of_device_id iproc_gpio_of_match[] = {
 	{ .compatible = "brcm,cygnus-ccm-gpio" },
 	{ .compatible = "brcm,cygnus-asiu-gpio" },
@@ -720,7 +715,7 @@ static int iproc_gpio_probe(struct platform_device *pdev)
 					   handle_simple_irq, IRQ_TYPE_NONE);
 		if (ret) {
 			dev_err(dev, "no GPIO irqchip\n");
-			goto err_unregister_pinconf;
+			goto err_rm_gpiochip;
 		}
 
 		gpiochip_set_chained_irqchip(gc, &iproc_gpio_irq_chip, irq,
@@ -729,9 +724,6 @@ static int iproc_gpio_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_unregister_pinconf:
-	iproc_gpio_unregister_pinconf(chip);
-
 err_rm_gpiochip:
 	gpiochip_remove(gc);
 
-- 
2.1.4
