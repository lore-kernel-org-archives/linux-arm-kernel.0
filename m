From: maz@misterjones.org (Marc Zyngier)
Date: Thu, 24 Dec 2009 18:52:40 +0100
Subject: [PATCH v2] Add interrupt handling capability to pca953x
Message-ID: <20091224185240.07474930@taxman.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric, Haojian,

Here is the 2nd version of my pca953x irq chip patch.

>From previous version (v1):
- Removed irq_interrupt feature, following Haojian remark. All input
  pins are now interrupt capable
- Moved most of the pending interrupt computing out of the main
  interrupt loop
- pca953x_set_irq_type() now configures the line as input

Pending problems to be solved:
- Modular build is broken, as handle_edge_irq, set_irq_flags and
  irq_to_desc are not exported, among others. First approach would be
  to disable the irq_chip when build modular, but I really don't like
  it.
- request_irq vs request_threaded_irq: genirq is a bit of a mess in
  this respect. We'd love a consistent API...

	M.

>From baa8ea367f16fc555e786b8811a9fdcd3d38b646 Mon Sep 17 00:00:00 2001
From: Marc Zyngier <maz@misterjones.org>
Date: Tue, 24 Dec 2009 17:38:29 +0100
Subject: [PATCH] Add interrupt handling capability to pca953x.

Most of the GPIO expanders controlled by the pca953x driver are
able to report changes on the input pins through an *INT pin.

This patch implements the irq_chip functionality (edge detection
only).

The driver has been tested on an Arcom Zeus.

Signed-off-by: Marc Zyngier <maz@misterjones.org>
---
 drivers/gpio/pca953x.c      |  208
++++++++++++++++++++++++++++++++++++++++--- include/linux/i2c/pca953x.h
|    3 + 2 files changed, 198 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/pca953x.c b/drivers/gpio/pca953x.c
index 6a2fb3f..e7fb190 100644
--- a/drivers/gpio/pca953x.c
+++ b/drivers/gpio/pca953x.c
@@ -14,6 +14,8 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/i2c.h>
 #include <linux/i2c/pca953x.h>
 #ifdef CONFIG_OF_GPIO
@@ -26,23 +28,28 @@
 #define PCA953X_INVERT         2
 #define PCA953X_DIRECTION      3
 
+#define PCA953X_GPIOS	       0x00FF
+#define PCA953X_INT	       0x0100
+
 static const struct i2c_device_id pca953x_id[] = {
-	{ "pca9534", 8, },
-	{ "pca9535", 16, },
+	{ "pca9534", 8  | PCA953X_INT, },
+	{ "pca9535", 16 | PCA953X_INT, },
 	{ "pca9536", 4, },
-	{ "pca9537", 4, },
-	{ "pca9538", 8, },
-	{ "pca9539", 16, },
-	{ "pca9554", 8, },
-	{ "pca9555", 16, },
+	{ "pca9537", 4  | PCA953X_INT, },
+	{ "pca9538", 8  | PCA953X_INT, },
+	{ "pca9539", 16 | PCA953X_INT, },
+	{ "pca9554", 8  | PCA953X_INT, },
+	{ "pca9555", 16 | PCA953X_INT, },
 	{ "pca9556", 8, },
 	{ "pca9557", 8, },
 
 	{ "max7310", 8, },
-	{ "max7315", 8, },
-	{ "pca6107", 8, },
-	{ "tca6408", 8, },
-	{ "tca6416", 16, },
+	{ "max7312", 16 | PCA953X_INT, },
+	{ "max7313", 16 | PCA953X_INT, },
+	{ "max7315", 8  | PCA953X_INT, },
+	{ "pca6107", 8  | PCA953X_INT, },
+	{ "tca6408", 8  | PCA953X_INT, },
+	{ "tca6416", 16 | PCA953X_INT, },
 	/* NYET:  { "tca6424", 24, }, */
 	{ }
 };
@@ -53,6 +60,14 @@ struct pca953x_chip {
 	uint16_t reg_output;
 	uint16_t reg_direction;
 
+	struct mutex irq_lock;
+	uint16_t irq_mask;
+	uint16_t irq_stat;
+	uint16_t irq_trig_raise;
+	uint16_t irq_trig_fall;
+
+	int	 irq_base;
+
 	struct i2c_client *client;
 	struct pca953x_platform_data *dyn_pdata;
 	struct gpio_chip gpio_chip;
@@ -202,6 +217,127 @@ static void pca953x_setup_gpio(struct
pca953x_chip *chip, int gpios) gc->names = chip->names;
 }
 
+static int pca953x_gpio_to_irq(struct gpio_chip *gc, unsigned off)
+{
+	struct pca953x_chip *chip;
+
+	chip = container_of(gc, struct pca953x_chip, gpio_chip);
+	return chip->irq_base + off;
+}
+
+static void pca953x_irq_mask(unsigned int irq)
+{
+	struct pca953x_chip *chip = get_irq_chip_data(irq);
+
+	chip->irq_mask &= ~(1 << (irq - chip->irq_base));
+}
+
+static void pca953x_irq_unmask(unsigned int irq)
+{
+	struct pca953x_chip *chip = get_irq_chip_data(irq);
+
+	chip->irq_mask |= 1 << (irq - chip->irq_base);
+}
+
+static void pca953x_irq_bus_lock(unsigned int irq)
+{
+	struct pca953x_chip *chip = get_irq_chip_data(irq);
+
+	mutex_lock(&chip->irq_lock);
+}
+
+static void pca953x_irq_bus_sync_unlock(unsigned int irq)
+{
+	struct pca953x_chip *chip = get_irq_chip_data(irq);
+
+	mutex_unlock(&chip->irq_lock);
+}
+
+static int pca953x_irq_set_type(unsigned int irq, unsigned int type)
+{
+	struct pca953x_chip *chip = get_irq_chip_data(irq);
+	uint16_t level = irq - chip->irq_base;
+	uint16_t mask = 1 << level;
+
+	if (!(type & IRQ_TYPE_EDGE_BOTH)) {
+		dev_err(&chip->client->dev, "irq %d: unsupported type
%d\n",
+			irq, type);
+		return -EINVAL;
+	}
+
+	if (type & IRQ_TYPE_EDGE_FALLING)
+		chip->irq_trig_fall |= mask;
+	else
+		chip->irq_trig_fall &= ~mask;
+
+	if (type & IRQ_TYPE_EDGE_RISING)
+		chip->irq_trig_raise |= mask;
+	else
+		chip->irq_trig_raise &= ~mask;
+
+	return pca953x_gpio_direction_input(&chip->gpio_chip, level);
+}
+
+static struct irq_chip pca953x_irq_chip = {
+	.name			= "pca953x",
+	.mask			= pca953x_irq_mask,
+	.unmask			= pca953x_irq_unmask,
+	.bus_lock		= pca953x_irq_bus_lock,
+	.bus_sync_unlock	= pca953x_irq_bus_sync_unlock,
+	.set_type		= pca953x_irq_set_type,
+};
+
+static inline uint16_t pca953x_irq_pending(struct pca953x_chip *chip)
+{
+	uint16_t cur_stat;
+	uint16_t old_stat;
+	uint16_t pending;
+	uint16_t trigger;
+	int ret;
+
+	ret = pca953x_read_reg(chip, PCA953X_INPUT, &cur_stat);
+	if (ret)
+		return 0;
+
+	/* Remove output pins from the equation */
+	cur_stat &= chip->reg_direction;
+
+	old_stat = chip->irq_stat;
+	trigger = (cur_stat ^ old_stat) & chip->irq_mask;
+
+	if (!trigger)
+		return 0;
+
+	chip->irq_stat = cur_stat;
+
+	pending = (old_stat & chip->irq_trig_fall) |
+		  (cur_stat & chip->irq_trig_raise);
+	pending &= trigger;
+
+	return pending;
+}
+
+static irqreturn_t pca953x_irq_handler(int irq, void *devid)
+{
+	struct pca953x_chip *chip = devid;
+	uint16_t pending;
+	uint16_t level;
+
+	pending = pca953x_irq_pending(chip);
+
+	if (!pending)
+		return IRQ_HANDLED;
+
+	do {
+		level = __ffs(pending);
+		handle_nested_irq(level + chip->irq_base);
+
+		pending &= ~(1 << level);
+	} while (pending);
+
+	return IRQ_HANDLED;
+}
+
 /*
  * Handlers for alternative sources of platform_data
  */
@@ -286,7 +422,7 @@ static int __devinit pca953x_probe(struct
i2c_client *client, /* initialize cached registers from their original
values.
 	 * we can't share this chip with another i2c master.
 	 */
-	pca953x_setup_gpio(chip, id->driver_data);
+	pca953x_setup_gpio(chip, id->driver_data & PCA953X_GPIOS);
 
 	ret = pca953x_read_reg(chip, PCA953X_OUTPUT,
&chip->reg_output); if (ret)
@@ -301,10 +437,53 @@ static int __devinit pca953x_probe(struct
i2c_client *client, if (ret)
 		goto out_failed;
 
+	if (pdata->irq_base && (id->driver_data & PCA953X_INT)) {
+		int lvl;
+
+		ret = pca953x_read_reg(chip, PCA953X_INPUT,
+				       &chip->irq_stat);
+		if (ret)
+			goto out_failed;
+
+		/*
+		 * There is no way to know which GPIO line generated
the
+		 * interrupt.  We have to rely on the previous read for
+		 * this purpose.
+		 */
+		chip->irq_stat &= chip->reg_direction;
+		chip->irq_base = pdata->irq_base;
+		mutex_init(&chip->irq_lock);
+
+		for (lvl = 0; lvl < chip->gpio_chip.ngpio; lvl++) {
+			int irq = lvl + chip->irq_base;
+
+			set_irq_chip_data(irq, chip);
+			set_irq_chip_and_handler(irq,
&pca953x_irq_chip,
+						 handle_edge_irq);
+			set_irq_nested_thread(irq, 1);
+			set_irq_flags(irq, IRQF_VALID);
+		}
+
+		ret = request_threaded_irq(client->irq,
+					   NULL,
+					   pca953x_irq_handler,
+					   IRQF_TRIGGER_FALLING |
IRQF_ONESHOT,
+					   dev_name(&client->dev),
chip);
+		if (ret) {
+			dev_err(&client->dev, "failed to request irq
%d\n",
+				client->irq);
+			goto out_failed;
+		}
+
+		chip->gpio_chip.to_irq = pca953x_gpio_to_irq;
+	}
 
 	ret = gpiochip_add(&chip->gpio_chip);
-	if (ret)
+	if (ret) {
+		if (pdata->irq_base)
+			free_irq(client->irq, chip);
 		goto out_failed;
+	}
 
 	if (pdata->setup) {
 		ret = pdata->setup(client, chip->gpio_chip.base,
@@ -345,6 +524,9 @@ static int pca953x_remove(struct i2c_client *client)
 		return ret;
 	}
 
+	if (chip->irq_base)
+		free_irq(client->irq, chip);
+
 	kfree(chip->dyn_pdata);
 	kfree(chip);
 	return 0;
diff --git a/include/linux/i2c/pca953x.h b/include/linux/i2c/pca953x.h
index 81736d6..1a2c141 100644
--- a/include/linux/i2c/pca953x.h
+++ b/include/linux/i2c/pca953x.h
@@ -7,6 +7,9 @@ struct pca953x_platform_data {
 	/* initial polarity inversion setting */
 	uint16_t	invert;
 
+	/* interrupt base */
+	int		irq_base;
+
 	void		*context;	/* param to
setup/teardown */ 
 	int		(*setup)(struct i2c_client *client,
-- 
1.6.0.4


-- 
I'm the slime oozin' out from your TV set...
