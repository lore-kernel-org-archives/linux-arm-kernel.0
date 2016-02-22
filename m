From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:06 +0530
Subject: [PATCH 17/61] gpio: dln2: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-18-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-dln2.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-dln2.c b/drivers/gpio/gpio-dln2.c
index e11a7d1..f7a60a4 100644
--- a/drivers/gpio/gpio-dln2.c
+++ b/drivers/gpio/gpio-dln2.c
@@ -479,40 +479,32 @@ static int dln2_gpio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, dln2);
 
-	ret = gpiochip_add_data(&dln2->gpio, dln2);
+	ret = devm_gpiochip_add_data(dev, &dln2->gpio, dln2);
 	if (ret < 0) {
 		dev_err(dev, "failed to add gpio chip: %d\n", ret);
-		goto out;
+		return ret;
 	}
 
 	ret = gpiochip_irqchip_add(&dln2->gpio, &dln2_gpio_irqchip, 0,
 				   handle_simple_irq, IRQ_TYPE_NONE);
 	if (ret < 0) {
 		dev_err(dev, "failed to add irq chip: %d\n", ret);
-		goto out_gpiochip_remove;
+		return ret;
 	}
 
 	ret = dln2_register_event_cb(pdev, DLN2_GPIO_CONDITION_MET_EV,
 				     dln2_gpio_event);
 	if (ret) {
 		dev_err(dev, "failed to register event cb: %d\n", ret);
-		goto out_gpiochip_remove;
+		return ret;
 	}
 
 	return 0;
-
-out_gpiochip_remove:
-	gpiochip_remove(&dln2->gpio);
-out:
-	return ret;
 }
 
 static int dln2_gpio_remove(struct platform_device *pdev)
 {
-	struct dln2_gpio *dln2 = platform_get_drvdata(pdev);
-
 	dln2_unregister_event_cb(pdev, DLN2_GPIO_CONDITION_MET_EV);
-	gpiochip_remove(&dln2->gpio);
 
 	return 0;
 }
-- 
2.1.4
