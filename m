From: 21cnbao@gmail.com (Barry Song)
Date: Thu,  4 Dec 2014 20:12:08 +0800
Subject: [PATCH 1/3] gpio: sx150x: move to irqdomain framework for sx150x
 driver
Message-ID: <1417695130-5712-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Chen <Wei.Chen@csr.com>

The sx150x gpio driver used a loop to set liner irq map for gpio pins.
Now we use the irq domain to rebuild this irq mappig and make sure the
codes are still compatible to old users.

this patch also adds IRQF_ONESHOT flag to fix the IRQ flooding issues.

Signed-off-by: Wei Chen <Wei.Chen@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/gpio/gpio-sx150x.c | 72 ++++++++++++----------------------------------
 1 file changed, 18 insertions(+), 54 deletions(-)

diff --git a/drivers/gpio/gpio-sx150x.c b/drivers/gpio/gpio-sx150x.c
index bce6c61..0bc61c2 100644
--- a/drivers/gpio/gpio-sx150x.c
+++ b/drivers/gpio/gpio-sx150x.c
@@ -293,27 +293,11 @@ static int sx150x_gpio_direction_output(struct gpio_chip *gc,
 	return status;
 }
 
-static int sx150x_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
-{
-	struct sx150x_chip *chip;
-
-	chip = container_of(gc, struct sx150x_chip, gpio_chip);
-
-	if (offset >= chip->dev_cfg->ngpios)
-		return -EINVAL;
-
-	if (chip->irq_base < 0)
-		return -EINVAL;
-
-	return chip->irq_base + offset;
-}
-
 static void sx150x_irq_mask(struct irq_data *d)
 {
 	struct sx150x_chip *chip = irq_data_get_irq_chip_data(d);
-	unsigned n;
+	unsigned n = d->hwirq;
 
-	n = d->irq - chip->irq_base;
 	chip->irq_masked |= (1 << n);
 	chip->irq_update = n;
 }
@@ -321,9 +305,8 @@ static void sx150x_irq_mask(struct irq_data *d)
 static void sx150x_irq_unmask(struct irq_data *d)
 {
 	struct sx150x_chip *chip = irq_data_get_irq_chip_data(d);
-	unsigned n;
+	unsigned n = d->hwirq;
 
-	n = d->irq - chip->irq_base;
 	chip->irq_masked &= ~(1 << n);
 	chip->irq_update = n;
 }
@@ -336,7 +319,7 @@ static int sx150x_irq_set_type(struct irq_data *d, unsigned int flow_type)
 	if (flow_type & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW))
 		return -EINVAL;
 
-	n = d->irq - chip->irq_base;
+	n = d->hwirq;
 
 	if (flow_type & IRQ_TYPE_EDGE_RISING)
 		val |= 0x1;
@@ -371,7 +354,9 @@ static irqreturn_t sx150x_irq_thread_fn(int irq, void *dev_id)
 				val);
 		for (n = 0; n < 8; ++n) {
 			if (val & (1 << n)) {
-				sub_irq = chip->irq_base + (i * 8) + n;
+				sub_irq = irq_find_mapping(
+					chip->gpio_chip.irqdomain,
+					(i * 8) + n);
 				handle_nested_irq(sub_irq);
 				++nhandled;
 			}
@@ -428,12 +413,12 @@ static void sx150x_init_chip(struct sx150x_chip *chip,
 
 	chip->client                     = client;
 	chip->dev_cfg                    = &sx150x_devices[driver_data];
+	chip->gpio_chip.dev              = &client->dev;
 	chip->gpio_chip.label            = client->name;
 	chip->gpio_chip.direction_input  = sx150x_gpio_direction_input;
 	chip->gpio_chip.direction_output = sx150x_gpio_direction_output;
 	chip->gpio_chip.get              = sx150x_gpio_get;
 	chip->gpio_chip.set              = sx150x_gpio_set;
-	chip->gpio_chip.to_irq           = sx150x_gpio_to_irq;
 	chip->gpio_chip.base             = pdata->gpio_base;
 	chip->gpio_chip.can_sleep        = true;
 	chip->gpio_chip.ngpio            = chip->dev_cfg->ngpios;
@@ -529,31 +514,24 @@ static int sx150x_install_irq_chip(struct sx150x_chip *chip,
 				int irq_base)
 {
 	int err;
-	unsigned n;
-	unsigned irq;
 
 	chip->irq_summary = irq_summary;
 	chip->irq_base    = irq_base;
 
-	for (n = 0; n < chip->dev_cfg->ngpios; ++n) {
-		irq = irq_base + n;
-		irq_set_chip_data(irq, chip);
-		irq_set_chip_and_handler(irq, &chip->irq_chip, handle_edge_irq);
-		irq_set_nested_thread(irq, 1);
-#ifdef CONFIG_ARM
-		set_irq_flags(irq, IRQF_VALID);
-#else
-		irq_set_noprobe(irq);
-#endif
+	/* Add gpio chip to irq subsystem */
+	err = gpiochip_irqchip_add(&chip->gpio_chip,
+		&chip->irq_chip, chip->irq_base,
+		handle_edge_irq, IRQ_TYPE_EDGE_BOTH);
+	if (err) {
+		dev_err(&chip->client->dev,
+			"could not connect irqchip to gpiochip\n");
+		return  err;
 	}
 
 	err = devm_request_threaded_irq(&chip->client->dev,
-				irq_summary,
-				NULL,
-				sx150x_irq_thread_fn,
-				IRQF_SHARED | IRQF_TRIGGER_FALLING,
-				chip->irq_chip.name,
-				chip);
+			irq_summary, NULL, sx150x_irq_thread_fn,
+			IRQF_ONESHOT | IRQF_SHARED | IRQF_TRIGGER_FALLING,
+			chip->irq_chip.name, chip);
 	if (err < 0) {
 		chip->irq_summary = -1;
 		chip->irq_base    = -1;
@@ -562,17 +540,6 @@ static int sx150x_install_irq_chip(struct sx150x_chip *chip,
 	return err;
 }
 
-static void sx150x_remove_irq_chip(struct sx150x_chip *chip)
-{
-	unsigned n;
-	unsigned irq;
-
-	for (n = 0; n < chip->dev_cfg->ngpios; ++n) {
-		irq = chip->irq_base + n;
-		irq_set_chip_and_handler(irq, NULL, NULL);
-	}
-}
-
 static int sx150x_probe(struct i2c_client *client,
 				const struct i2c_device_id *id)
 {
@@ -626,9 +593,6 @@ static int sx150x_remove(struct i2c_client *client)
 	chip = i2c_get_clientdata(client);
 	gpiochip_remove(&chip->gpio_chip);
 
-	if (chip->irq_summary >= 0)
-		sx150x_remove_irq_chip(chip);
-
 	return 0;
 }
 
-- 
2.2.0
