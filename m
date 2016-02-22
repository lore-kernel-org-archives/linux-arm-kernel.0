From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:19 +0530
Subject: [PATCH 30/61] gpio: mvebu: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-31-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration and clean the
error path.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-mvebu.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index a5eacc1..11c6582 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -756,7 +756,7 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 		BUG();
 	}
 
-	gpiochip_add_data(&mvchip->chip, mvchip);
+	devm_gpiochip_add_data(&pdev->dev, &mvchip->chip, mvchip);
 
 	/* Some gpio controllers do not provide irq support */
 	if (!of_irq_count(np))
@@ -777,16 +777,14 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	mvchip->irqbase = irq_alloc_descs(-1, 0, ngpios, -1);
 	if (mvchip->irqbase < 0) {
 		dev_err(&pdev->dev, "no irqs\n");
-		err = mvchip->irqbase;
-		goto err_gpiochip_add;
+		return mvchip->irqbase;
 	}
 
 	gc = irq_alloc_generic_chip("mvebu_gpio_irq", 2, mvchip->irqbase,
 				    mvchip->membase, handle_level_irq);
 	if (!gc) {
 		dev_err(&pdev->dev, "Cannot allocate generic irq_chip\n");
-		err = -ENOMEM;
-		goto err_gpiochip_add;
+		return -ENOMEM;
 	}
 
 	gc->private = mvchip;
@@ -828,9 +826,6 @@ err_generic_chip:
 				IRQ_LEVEL | IRQ_NOPROBE);
 	kfree(gc);
 
-err_gpiochip_add:
-	gpiochip_remove(&mvchip->chip);
-
 	return err;
 }
 
-- 
2.1.4
