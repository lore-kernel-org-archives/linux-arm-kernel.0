From: simon.guinot@sequanux.org (Simon Guinot)
Date: Tue, 22 Sep 2015 10:24:08 +0200
Subject: [PATCH v5 4/4] leds: netxbig: convert to use the devm_ functions
In-Reply-To: <1442910248-11380-1-git-send-email-simon.guinot@sequanux.org>
References: <1442910248-11380-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <1442910248-11380-5-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch converts the leds-netxbig driver to use the devres functions
devm_gpio_request_one() and devm_led_classdev_register(). This allows to
simplify the code a bit.

Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
---
 drivers/leds/leds-netxbig.c | 108 ++++++++++++--------------------------------
 1 file changed, 28 insertions(+), 80 deletions(-)

diff --git a/drivers/leds/leds-netxbig.c b/drivers/leds/leds-netxbig.c
index 19dac94b0364..3a982b99f738 100644
--- a/drivers/leds/leds-netxbig.c
+++ b/drivers/leds/leds-netxbig.c
@@ -71,7 +71,8 @@ static void gpio_ext_set_value(struct netxbig_gpio_ext *gpio_ext,
 	spin_unlock_irqrestore(&gpio_ext_lock, flags);
 }
 
-static int gpio_ext_init(struct netxbig_gpio_ext *gpio_ext)
+static int gpio_ext_init(struct platform_device *pdev,
+			 struct netxbig_gpio_ext *gpio_ext)
 {
 	int err;
 	int i;
@@ -81,46 +82,28 @@ static int gpio_ext_init(struct netxbig_gpio_ext *gpio_ext)
 
 	/* Configure address GPIOs. */
 	for (i = 0; i < gpio_ext->num_addr; i++) {
-		err = gpio_request_one(gpio_ext->addr[i], GPIOF_OUT_INIT_LOW,
-				       "GPIO extension addr");
+		err = devm_gpio_request_one(&pdev->dev, gpio_ext->addr[i],
+					    GPIOF_OUT_INIT_LOW,
+					    "GPIO extension addr");
 		if (err)
-			goto err_free_addr;
+			return err;
 	}
 	/* Configure data GPIOs. */
 	for (i = 0; i < gpio_ext->num_data; i++) {
-		err = gpio_request_one(gpio_ext->data[i], GPIOF_OUT_INIT_LOW,
-				   "GPIO extension data");
+		err = devm_gpio_request_one(&pdev->dev, gpio_ext->data[i],
+					    GPIOF_OUT_INIT_LOW,
+					    "GPIO extension data");
 		if (err)
-			goto err_free_data;
+			return err;
 	}
 	/* Configure "enable select" GPIO. */
-	err = gpio_request_one(gpio_ext->enable, GPIOF_OUT_INIT_LOW,
-			       "GPIO extension enable");
+	err = devm_gpio_request_one(&pdev->dev, gpio_ext->enable,
+				    GPIOF_OUT_INIT_LOW,
+				    "GPIO extension enable");
 	if (err)
-		goto err_free_data;
+		return err;
 
 	return 0;
-
-err_free_data:
-	for (i = i - 1; i >= 0; i--)
-		gpio_free(gpio_ext->data[i]);
-	i = gpio_ext->num_addr;
-err_free_addr:
-	for (i = i - 1; i >= 0; i--)
-		gpio_free(gpio_ext->addr[i]);
-
-	return err;
-}
-
-static void gpio_ext_free(struct netxbig_gpio_ext *gpio_ext)
-{
-	int i;
-
-	gpio_free(gpio_ext->enable);
-	for (i = gpio_ext->num_addr - 1; i >= 0; i--)
-		gpio_free(gpio_ext->addr[i]);
-	for (i = gpio_ext->num_data - 1; i >= 0; i--)
-		gpio_free(gpio_ext->data[i]);
 }
 
 /*
@@ -141,11 +124,6 @@ struct netxbig_led_data {
 	spinlock_t		lock;
 };
 
-struct netxbig_led_priv {
-	struct netxbig_led_platform_data *pdata;
-	struct netxbig_led_data leds_data[];
-};
-
 static int netxbig_led_get_timer_mode(enum netxbig_led_mode *mode,
 				      unsigned long delay_on,
 				      unsigned long delay_off,
@@ -305,18 +283,11 @@ static struct attribute *netxbig_led_attrs[] = {
 };
 ATTRIBUTE_GROUPS(netxbig_led);
 
-static void delete_netxbig_led(struct netxbig_led_data *led_dat)
-{
-	led_classdev_unregister(&led_dat->cdev);
-}
-
-static int create_netxbig_led(struct platform_device *pdev, int led,
-			      struct netxbig_led_priv *priv)
+static int create_netxbig_led(struct platform_device *pdev,
+			      struct netxbig_led_platform_data *pdata,
+			      struct netxbig_led_data *led_dat,
+			      const struct netxbig_led *template)
 {
-	struct netxbig_led_platform_data *pdata = priv->pdata;
-	struct netxbig_led_data *led_dat = &priv->leds_data[led];
-	const struct netxbig_led *template = &priv->pdata->leds[led];
-
 	spin_lock_init(&led_dat->lock);
 	led_dat->gpio_ext = pdata->gpio_ext;
 	led_dat->cdev.name = template->name;
@@ -349,7 +320,7 @@ static int create_netxbig_led(struct platform_device *pdev, int led,
 	if (led_dat->mode_val[NETXBIG_LED_SATA] != NETXBIG_LED_INVALID_MODE)
 		led_dat->cdev.groups = netxbig_led_groups;
 
-	return led_classdev_register(&pdev->dev, &led_dat->cdev);
+	return devm_led_classdev_register(&pdev->dev, &led_dat->cdev);
 }
 
 #ifdef CONFIG_OF_GPIO
@@ -564,7 +535,7 @@ netxbig_leds_get_of_pdata(struct device *dev,
 static int netxbig_led_probe(struct platform_device *pdev)
 {
 	struct netxbig_led_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct netxbig_led_priv *priv;
+	struct netxbig_led_data *leds_data;
 	int i;
 	int ret;
 
@@ -577,51 +548,28 @@ static int netxbig_led_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv) +
-			    pdata->num_leds * sizeof(struct netxbig_led_data),
-			    GFP_KERNEL);
-	if (!priv)
+	leds_data = devm_kzalloc(&pdev->dev,
+				 pdata->num_leds * sizeof(*leds_data),
+				 GFP_KERNEL);
+	if (!leds_data)
 		return -ENOMEM;
-	priv->pdata = pdata;
 
-	ret = gpio_ext_init(pdata->gpio_ext);
+	ret = gpio_ext_init(pdev, pdata->gpio_ext);
 	if (ret < 0)
 		return ret;
 
 	for (i = 0; i < pdata->num_leds; i++) {
-		ret = create_netxbig_led(pdev, i, priv);
+		ret = create_netxbig_led(pdev, pdata,
+					 &leds_data[i], &pdata->leds[i]);
 		if (ret < 0)
-			goto err_free_leds;
+			return ret;
 	}
-	platform_set_drvdata(pdev, priv);
-
-	return 0;
-
-err_free_leds:
-	for (i = i - 1; i >= 0; i--)
-		delete_netxbig_led(&priv->leds_data[i]);
-
-	gpio_ext_free(pdata->gpio_ext);
-	return ret;
-}
-
-static int netxbig_led_remove(struct platform_device *pdev)
-{
-	struct netxbig_led_priv *priv = platform_get_drvdata(pdev);
-	struct netxbig_led_platform_data *pdata = priv->pdata;
-	int i;
-
-	for (i = 0; i < pdata->num_leds; i++)
-		delete_netxbig_led(&priv->leds_data[i]);
-
-	gpio_ext_free(pdata->gpio_ext);
 
 	return 0;
 }
 
 static struct platform_driver netxbig_led_driver = {
 	.probe		= netxbig_led_probe,
-	.remove		= netxbig_led_remove,
 	.driver		= {
 		.name		= "leds-netxbig",
 		.of_match_table	= of_match_ptr(of_netxbig_leds_match),
-- 
2.1.4
