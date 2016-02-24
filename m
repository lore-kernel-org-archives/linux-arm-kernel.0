From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:46:01 +0530
Subject: [PATCH 36/50] pinctrl: at91-pio4: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456319775-3216-37-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_pinctrl_register() for pin control registration and clean
error path.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/pinctrl/pinctrl-at91-pio4.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index ee69db6..9d33ef5 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -1034,18 +1034,19 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
 		goto clk_prepare_enable_error;
 	}
 
-	atmel_pioctrl->pinctrl_dev = pinctrl_register(&atmel_pinctrl_desc,
-						      &pdev->dev,
-						      atmel_pioctrl);
-	if (!atmel_pioctrl->pinctrl_dev) {
+	atmel_pioctrl->pinctrl_dev = devm_pinctrl_register(&pdev->dev,
+							   &atmel_pinctrl_desc,
+							   atmel_pioctrl);
+	if (IS_ERR(atmel_pioctrl->pinctrl_dev)) {
+		ret = PTR_ERR(atmel_pioctrl->pinctrl_dev);
 		dev_err(dev, "pinctrl registration failed\n");
-		goto pinctrl_register_error;
+		goto clk_unprep;
 	}
 
 	ret = gpiochip_add_data(atmel_pioctrl->gpio_chip, atmel_pioctrl);
 	if (ret) {
 		dev_err(dev, "failed to add gpiochip\n");
-		goto gpiochip_add_error;
+		goto clk_unprep;
 	}
 
 	ret = gpiochip_add_pin_range(atmel_pioctrl->gpio_chip, dev_name(dev),
@@ -1059,15 +1060,15 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
 
 	return 0;
 
-clk_prepare_enable_error:
-	irq_domain_remove(atmel_pioctrl->irq_domain);
-pinctrl_register_error:
-	clk_disable_unprepare(atmel_pioctrl->clk);
-gpiochip_add_error:
-	pinctrl_unregister(atmel_pioctrl->pinctrl_dev);
 gpiochip_add_pin_range_error:
 	gpiochip_remove(atmel_pioctrl->gpio_chip);
 
+clk_unprep:
+	clk_disable_unprepare(atmel_pioctrl->clk);
+
+clk_prepare_enable_error:
+	irq_domain_remove(atmel_pioctrl->irq_domain);
+
 	return ret;
 }
 
@@ -1077,7 +1078,6 @@ int atmel_pinctrl_remove(struct platform_device *pdev)
 
 	irq_domain_remove(atmel_pioctrl->irq_domain);
 	clk_disable_unprepare(atmel_pioctrl->clk);
-	pinctrl_unregister(atmel_pioctrl->pinctrl_dev);
 	gpiochip_remove(atmel_pioctrl->gpio_chip);
 
 	return 0;
-- 
2.1.4
