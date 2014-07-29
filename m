From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 29 Jul 2014 09:24:43 +0200
Subject: [PATCH 1/4] gpio: pca953x: Drop deprecated DT bindings
In-Reply-To: <1406618686-22385-1-git-send-email-mpa@pengutronix.de>
References: <1406618686-22385-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1406618686-22385-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop deprecated DT bindings and use automaticly assigned gpio and irq
bases.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/gpio/gpio-pca953x.c | 54 +++------------------------------------------
 1 file changed, 3 insertions(+), 51 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index e721a37c3473..fda3eae835d0 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -520,7 +520,7 @@ static int pca953x_irq_setup(struct pca953x_chip *chip,
 	struct i2c_client *client = chip->client;
 	int ret, i, offset = 0;
 
-	if (irq_base != -1
+	if (client->irq && irq_base != -1
 			&& (id->driver_data & PCA_INT)) {
 
 		switch (chip->chip_type) {
@@ -586,50 +586,6 @@ static int pca953x_irq_setup(struct pca953x_chip *chip,
 }
 #endif
 
-/*
- * Handlers for alternative sources of platform_data
- */
-#ifdef CONFIG_OF_GPIO
-/*
- * Translate OpenFirmware node properties into platform_data
- * WARNING: This is DEPRECATED and will be removed eventually!
- */
-static void
-pca953x_get_alt_pdata(struct i2c_client *client, int *gpio_base, u32 *invert)
-{
-	struct device_node *node;
-	const __be32 *val;
-	int size;
-
-	*gpio_base = -1;
-
-	node = client->dev.of_node;
-	if (node == NULL)
-		return;
-
-	val = of_get_property(node, "linux,gpio-base", &size);
-	WARN(val, "%s: device-tree property 'linux,gpio-base' is deprecated!", __func__);
-	if (val) {
-		if (size != sizeof(*val))
-			dev_warn(&client->dev, "%s: wrong linux,gpio-base\n",
-				 node->full_name);
-		else
-			*gpio_base = be32_to_cpup(val);
-	}
-
-	val = of_get_property(node, "polarity", NULL);
-	WARN(val, "%s: device-tree property 'polarity' is deprecated!", __func__);
-	if (val)
-		*invert = *val;
-}
-#else
-static void
-pca953x_get_alt_pdata(struct i2c_client *client, int *gpio_base, u32 *invert)
-{
-	*gpio_base = -1;
-}
-#endif
-
 static int device_pca953x_init(struct pca953x_chip *chip, u32 invert)
 {
 	int ret;
@@ -704,12 +660,8 @@ static int pca953x_probe(struct i2c_client *client,
 		invert = pdata->invert;
 		chip->names = pdata->names;
 	} else {
-		pca953x_get_alt_pdata(client, &chip->gpio_start, &invert);
-#ifdef CONFIG_OF_GPIO
-		/* If I2C node has no interrupts property, disable GPIO interrupts */
-		if (of_find_property(client->dev.of_node, "interrupts", NULL) == NULL)
-			irq_base = -1;
-#endif
+		chip->gpio_start = -1;
+		irq_base = 0;
 	}
 
 	chip->client = client;
-- 
2.0.1
