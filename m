From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:33 +0530
Subject: [PATCH 44/61] gpio: tb10x: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-45-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration and clean the
error path.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-tb10x.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpio-tb10x.c b/drivers/gpio/gpio-tb10x.c
index 5eaec20..80b6959a 100644
--- a/drivers/gpio/gpio-tb10x.c
+++ b/drivers/gpio/gpio-tb10x.c
@@ -205,10 +205,10 @@ static int tb10x_gpio_probe(struct platform_device *pdev)
 	tb10x_gpio->gc.can_sleep	= false;
 
 
-	ret = gpiochip_add_data(&tb10x_gpio->gc, tb10x_gpio);
+	ret = devm_gpiochip_add_data(&pdev->dev, &tb10x_gpio->gc, tb10x_gpio);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Could not add gpiochip.\n");
-		goto fail_gpiochip_registration;
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, tb10x_gpio);
@@ -219,7 +219,7 @@ static int tb10x_gpio_probe(struct platform_device *pdev)
 		ret = platform_get_irq(pdev, 0);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "No interrupt specified.\n");
-			goto fail_get_irq;
+			return ret;
 		}
 
 		tb10x_gpio->gc.to_irq	= tb10x_gpio_to_irq;
@@ -229,14 +229,13 @@ static int tb10x_gpio_probe(struct platform_device *pdev)
 				IRQF_TRIGGER_NONE | IRQF_SHARED,
 				dev_name(&pdev->dev), tb10x_gpio);
 		if (ret != 0)
-			goto fail_request_irq;
+			return ret;
 
 		tb10x_gpio->domain = irq_domain_add_linear(dn,
 						tb10x_gpio->gc.ngpio,
 						&irq_generic_chip_ops, NULL);
 		if (!tb10x_gpio->domain) {
-			ret = -ENOMEM;
-			goto fail_irq_domain;
+			return -ENOMEM;
 		}
 
 		ret = irq_alloc_domain_generic_chips(tb10x_gpio->domain,
@@ -244,7 +243,7 @@ static int tb10x_gpio_probe(struct platform_device *pdev)
 				handle_edge_irq, IRQ_NOREQUEST, IRQ_NOPROBE,
 				IRQ_GC_INIT_MASK_CACHE);
 		if (ret)
-			goto fail_irq_domain;
+			return ret;
 
 		gc = tb10x_gpio->domain->gc->gc[0];
 		gc->reg_base                         = tb10x_gpio->base;
@@ -258,14 +257,6 @@ static int tb10x_gpio_probe(struct platform_device *pdev)
 	}
 
 	return 0;
-
-fail_irq_domain:
-fail_request_irq:
-fail_get_irq:
-	gpiochip_remove(&tb10x_gpio->gc);
-fail_gpiochip_registration:
-fail_ioremap:
-	return ret;
 }
 
 static int tb10x_gpio_remove(struct platform_device *pdev)
@@ -278,7 +269,6 @@ static int tb10x_gpio_remove(struct platform_device *pdev)
 		kfree(tb10x_gpio->domain->gc);
 		irq_domain_remove(tb10x_gpio->domain);
 	}
-	gpiochip_remove(&tb10x_gpio->gc);
 
 	return 0;
 }
-- 
2.1.4
