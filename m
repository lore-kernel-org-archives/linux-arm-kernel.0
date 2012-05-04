From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri,  4 May 2012 23:45:26 +0800
Subject: [PATCH 1/4] gpio/mxs: use devm_* helpers to make error handling simple
In-Reply-To: <1336146329-3821-1-git-send-email-shawn.guo@linaro.org>
References: <1336146329-3821-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1336146329-3821-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It uses devm_* helpers to make the error handling of probe clean
and simple.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/gpio/gpio-mxs.c |   52 +++++++++++-----------------------------------
 1 files changed, 13 insertions(+), 39 deletions(-)

diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index 385c58e..95a11db 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -186,44 +186,29 @@ static int __devinit mxs_gpio_probe(struct platform_device *pdev)
 	struct resource *iores = NULL;
 	int err;
 
-	port = kzalloc(sizeof(struct mxs_gpio_port), GFP_KERNEL);
+	port = devm_kzalloc(&pdev->dev, sizeof(*port), GFP_KERNEL);
 	if (!port)
 		return -ENOMEM;
 
 	port->id = pdev->id;
 	port->virtual_irq_start = MXS_GPIO_IRQ_START + port->id * 32;
 
+	port->irq = platform_get_irq(pdev, 0);
+	if (port->irq < 0)
+		return port->irq;
+
 	/*
 	 * map memory region only once, as all the gpio ports
 	 * share the same one
 	 */
 	if (!base) {
 		iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		if (!iores) {
-			err = -ENODEV;
-			goto out_kfree;
-		}
-
-		if (!request_mem_region(iores->start, resource_size(iores),
-					pdev->name)) {
-			err = -EBUSY;
-			goto out_kfree;
-		}
-
-		base = ioremap(iores->start, resource_size(iores));
-		if (!base) {
-			err = -ENOMEM;
-			goto out_release_mem;
-		}
+		base = devm_request_and_ioremap(&pdev->dev, iores);
+		if (!base)
+			return -EADDRNOTAVAIL;
 	}
 	port->base = base;
 
-	port->irq = platform_get_irq(pdev, 0);
-	if (port->irq < 0) {
-		err = -EINVAL;
-		goto out_iounmap;
-	}
-
 	/*
 	 * select the pin interrupt functionality but initially
 	 * disable the interrupts
@@ -246,29 +231,18 @@ static int __devinit mxs_gpio_probe(struct platform_device *pdev)
 			 port->base + PINCTRL_DOUT(port->id), NULL,
 			 port->base + PINCTRL_DOE(port->id), NULL, false);
 	if (err)
-		goto out_iounmap;
+		return err;
 
 	port->bgc.gc.to_irq = mxs_gpio_to_irq;
 	port->bgc.gc.base = port->id * 32;
 
 	err = gpiochip_add(&port->bgc.gc);
-	if (err)
-		goto out_bgpio_remove;
+	if (err) {
+		bgpio_remove(&port->bgc);
+		return err;
+	}
 
 	return 0;
-
-out_bgpio_remove:
-	bgpio_remove(&port->bgc);
-out_iounmap:
-	if (iores)
-		iounmap(port->base);
-out_release_mem:
-	if (iores)
-		release_mem_region(iores->start, resource_size(iores));
-out_kfree:
-	kfree(port);
-	dev_info(&pdev->dev, "%s failed with errno %d\n", __func__, err);
-	return err;
 }
 
 static struct platform_driver mxs_gpio_driver = {
-- 
1.7.5.4
