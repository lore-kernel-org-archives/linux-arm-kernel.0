From: robherring2@gmail.com (Rob Herring)
Date: Wed,  3 Aug 2011 13:54:21 -0500
Subject: [PATCH] gpio: pl061: add DT binding support
Message-ID: <1312397661-3328-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This adds devicetree binding support to the ARM pl061 driver removing the
platform_data dependency. When DT binding is used, the gpio numbering is
assigned dynamically. The interrupt assignment is converted to use the
irq_domain infrastructure.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/gpio/gpio-pl061.c |   32 +++++++++++++++++++++++---------
 1 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
index 2c5a18f..7ea74ff 100644
--- a/drivers/gpio/gpio-pl061.c
+++ b/drivers/gpio/gpio-pl061.c
@@ -23,6 +23,7 @@
 #include <linux/amba/bus.h>
 #include <linux/amba/pl061.h>
 #include <linux/slab.h>
+#include <linux/of_irq.h>
 
 #define GPIODIR 0x400
 #define GPIOIS  0x404
@@ -246,6 +247,20 @@ static int pl061_probe(struct amba_device *dev, const struct amba_id *id)
 	if (chip == NULL)
 		return -ENOMEM;
 
+	pdata = dev->dev.platform_data;
+	if (pdata) {
+		chip->gc.base = pdata->gpio_base;
+		chip->irq_base = pdata->irq_base;
+	} else if (dev->dev.of_node) {
+		u32 intspec = 0;
+		chip->gc.base = -1;
+		chip->irq_base = irq_create_of_mapping(dev->dev.of_node,
+						       &intspec, 1);
+	} else {
+		ret = -ENODEV;
+		goto free_mem;
+	}
+
 	if (!request_mem_region(dev->res.start,
 				resource_size(&dev->res), "pl061")) {
 		ret = -EBUSY;
@@ -267,14 +282,11 @@ static int pl061_probe(struct amba_device *dev, const struct amba_id *id)
 	chip->gc.get = pl061_get_value;
 	chip->gc.set = pl061_set_value;
 	chip->gc.to_irq = pl061_to_irq;
-	chip->gc.base = pdata->gpio_base;
 	chip->gc.ngpio = PL061_GPIO_NR;
 	chip->gc.label = dev_name(&dev->dev);
 	chip->gc.dev = &dev->dev;
 	chip->gc.owner = THIS_MODULE;
 
-	chip->irq_base = pdata->irq_base;
-
 	ret = gpiochip_add(&chip->gc);
 	if (ret)
 		goto iounmap;
@@ -283,7 +295,7 @@ static int pl061_probe(struct amba_device *dev, const struct amba_id *id)
 	 * irq_chip support
 	 */
 
-	if (chip->irq_base == (unsigned) -1)
+	if (chip->irq_base == NO_IRQ)
 		return 0;
 
 	writeb(0, chip->base + GPIOIE); /* disable irqs */
@@ -307,11 +319,13 @@ static int pl061_probe(struct amba_device *dev, const struct amba_id *id)
 	list_add(&chip->list, chip_list);
 
 	for (i = 0; i < PL061_GPIO_NR; i++) {
-		if (pdata->directions & (1 << i))
-			pl061_direction_output(&chip->gc, i,
-					pdata->values & (1 << i));
-		else
-			pl061_direction_input(&chip->gc, i);
+		if (pdata) {
+			if (pdata->directions & (1 << i))
+				pl061_direction_output(&chip->gc, i,
+						pdata->values & (1 << i));
+			else
+				pl061_direction_input(&chip->gc, i);
+		}
 
 		irq_set_chip_and_handler(i + chip->irq_base, &pl061_irqchip,
 					 handle_simple_irq);
-- 
1.7.4.1
