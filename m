From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Sep 2014 15:24:08 +0200
Subject: [PATCH] gpiolib: fix callers of gpiochip_remove
Message-ID: <2923496.zl6JUbOQrZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent API change made gpiochip_remove return void instead of an
error value, which broke drivers that use this return value:

gpio/gpio-sch311x.c: In function 'sch311x_gpio_probe':
gpio/gpio-sch311x.c:286:7: error: void value not ignored as it ought to be
   if (gpiochip_remove(&priv->blocks[i].chip))
       ^

This changes the callers that I have found during randconfig testing
so they no longer depend on the error code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: e1db1706c86e ("gpio: gpiolib: set gpiochip_remove retval to void")

diff --git a/drivers/gpio/gpio-sch311x.c b/drivers/gpio/gpio-sch311x.c
index 223830cb95ca..1c8e45b92471 100644
--- a/drivers/gpio/gpio-sch311x.c
+++ b/drivers/gpio/gpio-sch311x.c
@@ -283,9 +283,7 @@ exit_err:
 	release_region(pdata->runtime_reg + GP1, 6);
 	/* release already registered chips */
 	for (--i; i >= 0; i--)
-		if (gpiochip_remove(&priv->blocks[i].chip))
-			dev_err(&pdev->dev,
-				"Could not unregister gpiochip, %d\n", err);
+		gpiochip_remove(&priv->blocks[i].chip);
 
 	return err;
 }
diff --git a/drivers/pinctrl/pinctrl-bcm2835.c b/drivers/pinctrl/pinctrl-bcm2835.c
index 9771bdb7ff38..a12c78206e36 100644
--- a/drivers/pinctrl/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/pinctrl-bcm2835.c
@@ -1029,7 +1029,8 @@ static int bcm2835_pinctrl_probe(struct platform_device *pdev)
 
 	pc->pctl_dev = pinctrl_register(&bcm2835_pinctrl_desc, dev, pc);
 	if (!pc->pctl_dev) {
-		return gpiochip_remove(&pc->gpio_chip) ? : -EINVAL;
+		gpiochip_remove(&pc->gpio_chip);
+		return -EINVAL;
 	}
 
 	pc->gpio_range = bcm2835_pinctrl_gpio_range;
@@ -1045,7 +1046,8 @@ static int bcm2835_pinctrl_remove(struct platform_device *pdev)
 	struct bcm2835_pinctrl *pc = platform_get_drvdata(pdev);
 
 	pinctrl_unregister(pc->pctl_dev);
-	return gpiochip_remove(&pc->gpio_chip);
+	gpiochip_remove(&pc->gpio_chip);
+	return 0;
 }
 
 static struct of_device_id bcm2835_pinctrl_match[] = {
