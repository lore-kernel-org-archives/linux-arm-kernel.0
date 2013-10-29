From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 29 Oct 2013 09:19:24 +0100
Subject: [RESEND PATCH 2/2] w1-gpio: Use devm_* functions
In-Reply-To: <1383034764-22091-1-git-send-email-mpa@pengutronix.de>
References: <1383034764-22091-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1383034764-22091-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Acked-by: Evgeniy Polyakov <zbr@ioremap.net>
---
 drivers/w1/masters/w1-gpio.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/w1/masters/w1-gpio.c b/drivers/w1/masters/w1-gpio.c
index ae53e88..264ad1c 100644
--- a/drivers/w1/masters/w1-gpio.c
+++ b/drivers/w1/masters/w1-gpio.c
@@ -99,25 +99,27 @@ static int w1_gpio_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	master = kzalloc(sizeof(struct w1_bus_master), GFP_KERNEL);
+	master = devm_kzalloc(&pdev->dev, sizeof(struct w1_bus_master),
+			GFP_KERNEL);
 	if (!master) {
 		dev_err(&pdev->dev, "Out of memory\n");
 		return -ENOMEM;
 	}
 
-	err = gpio_request(pdata->pin, "w1");
+	err = devm_gpio_request(&pdev->dev, pdata->pin, "w1");
 	if (err) {
 		dev_err(&pdev->dev, "gpio_request (pin) failed\n");
-		goto free_master;
+		return err;
 	}
 
 	if (gpio_is_valid(pdata->ext_pullup_enable_pin)) {
-		err = gpio_request_one(pdata->ext_pullup_enable_pin,
-				       GPIOF_INIT_LOW, "w1 pullup");
+		err = devm_gpio_request_one(&pdev->dev,
+				pdata->ext_pullup_enable_pin, GPIOF_INIT_LOW,
+				"w1 pullup");
 		if (err < 0) {
 			dev_err(&pdev->dev, "gpio_request_one "
 					"(ext_pullup_enable_pin) failed\n");
-			goto free_gpio;
+			return err;
 		}
 	}
 
@@ -135,7 +137,7 @@ static int w1_gpio_probe(struct platform_device *pdev)
 	err = w1_add_master_device(master);
 	if (err) {
 		dev_err(&pdev->dev, "w1_add_master device failed\n");
-		goto free_gpio_ext_pu;
+		return err;
 	}
 
 	if (pdata->enable_external_pullup)
@@ -147,16 +149,6 @@ static int w1_gpio_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, master);
 
 	return 0;
-
- free_gpio_ext_pu:
-	if (gpio_is_valid(pdata->ext_pullup_enable_pin))
-		gpio_free(pdata->ext_pullup_enable_pin);
- free_gpio:
-	gpio_free(pdata->pin);
- free_master:
-	kfree(master);
-
-	return err;
 }
 
 static int w1_gpio_remove(struct platform_device *pdev)
@@ -171,8 +163,6 @@ static int w1_gpio_remove(struct platform_device *pdev)
 		gpio_set_value(pdata->ext_pullup_enable_pin, 0);
 
 	w1_remove_master_device(master);
-	gpio_free(pdata->pin);
-	kfree(master);
 
 	return 0;
 }
-- 
1.8.4.rc3
