From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed,  2 Dec 2015 11:07:12 +0100
Subject: [PATCH RFC 1/3] input: rotary_encoder: make use of devm_* to simplify
 .probe and .remove
In-Reply-To: <1449050834-31779-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1449050834-31779-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1449050834-31779-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For all operations called in .probe there are devm_* variants.
(input_register_device is clever enough to be devm aware on its own.)
This allows to get rid of the error unwind code paths in .probe and the
complete .remove function.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/input/misc/rotary_encoder.c | 74 +++++++++++--------------------------
 1 file changed, 22 insertions(+), 52 deletions(-)

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index 8aee71986430..386bdb5314e6 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -211,8 +211,8 @@ static struct rotary_encoder_platform_data *rotary_encoder_parse_dt(struct devic
 	if (!of_id || !np)
 		return NULL;
 
-	pdata = kzalloc(sizeof(struct rotary_encoder_platform_data),
-			GFP_KERNEL);
+	pdata = devm_kzalloc(dev, sizeof(struct rotary_encoder_platform_data),
+			     GFP_KERNEL);
 	if (!pdata)
 		return ERR_PTR(-ENOMEM);
 
@@ -277,11 +277,11 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 		}
 	}
 
-	encoder = kzalloc(sizeof(struct rotary_encoder), GFP_KERNEL);
-	input = input_allocate_device();
+	encoder = devm_kzalloc(dev, sizeof(struct rotary_encoder), GFP_KERNEL);
+	input = devm_input_allocate_device(&pdev->dev);
 	if (!encoder || !input) {
-		err = -ENOMEM;
-		goto exit_free_mem;
+		dev_err(dev, "unable to allocate memory\n");
+		return -ENOMEM;
 	}
 
 	encoder->input = input;
@@ -301,16 +301,18 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 	}
 
 	/* request the GPIOs */
-	err = gpio_request_one(pdata->gpio_a, GPIOF_IN, dev_name(dev));
+	err = devm_gpio_request_one(dev, pdata->gpio_a,
+				    GPIOF_IN, dev_name(dev));
 	if (err) {
 		dev_err(dev, "unable to request GPIO %d\n", pdata->gpio_a);
-		goto exit_free_mem;
+		return err;
 	}
 
-	err = gpio_request_one(pdata->gpio_b, GPIOF_IN, dev_name(dev));
+	err = devm_gpio_request_one(dev, pdata->gpio_b,
+				    GPIOF_IN, dev_name(dev));
 	if (err) {
 		dev_err(dev, "unable to request GPIO %d\n", pdata->gpio_b);
-		goto exit_free_gpio_a;
+		return err;
 	}
 
 	encoder->irq_a = gpio_to_irq(pdata->gpio_a);
@@ -331,30 +333,29 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 	default:
 		dev_err(dev, "'%d' is not a valid steps-per-period value\n",
 			pdata->steps_per_period);
-		err = -EINVAL;
-		goto exit_free_gpio_b;
+		return -EINVAL;
 	}
 
-	err = request_irq(encoder->irq_a, handler,
-			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-			  DRV_NAME, encoder);
+	err = devm_request_irq(dev, encoder->irq_a, handler,
+			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+			       DRV_NAME, encoder);
 	if (err) {
 		dev_err(dev, "unable to request IRQ %d\n", encoder->irq_a);
-		goto exit_free_gpio_b;
+		return err;
 	}
 
-	err = request_irq(encoder->irq_b, handler,
-			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-			  DRV_NAME, encoder);
+	err = devm_request_irq(dev, encoder->irq_b, handler,
+			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+			       DRV_NAME, encoder);
 	if (err) {
 		dev_err(dev, "unable to request IRQ %d\n", encoder->irq_b);
-		goto exit_free_irq_a;
+		return err;
 	}
 
 	err = input_register_device(input);
 	if (err) {
 		dev_err(dev, "failed to register input device\n");
-		goto exit_free_irq_b;
+		return err;
 	}
 
 	device_init_wakeup(&pdev->dev, pdata->wakeup_source);
@@ -362,42 +363,11 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, encoder);
 
 	return 0;
-
-exit_free_irq_b:
-	free_irq(encoder->irq_b, encoder);
-exit_free_irq_a:
-	free_irq(encoder->irq_a, encoder);
-exit_free_gpio_b:
-	gpio_free(pdata->gpio_b);
-exit_free_gpio_a:
-	gpio_free(pdata->gpio_a);
-exit_free_mem:
-	input_free_device(input);
-	kfree(encoder);
-	if (!dev_get_platdata(&pdev->dev))
-		kfree(pdata);
-
-	return err;
 }
 
 static int rotary_encoder_remove(struct platform_device *pdev)
 {
-	struct rotary_encoder *encoder = platform_get_drvdata(pdev);
-	const struct rotary_encoder_platform_data *pdata = encoder->pdata;
-
 	device_init_wakeup(&pdev->dev, false);
-
-	free_irq(encoder->irq_a, encoder);
-	free_irq(encoder->irq_b, encoder);
-	gpio_free(pdata->gpio_a);
-	gpio_free(pdata->gpio_b);
-
-	input_unregister_device(encoder->input);
-	kfree(encoder);
-
-	if (!dev_get_platdata(&pdev->dev))
-		kfree(pdata);
-
 	return 0;
 }
 
-- 
2.6.2
