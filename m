From: rubini-list@gnudd.com (Alessandro Rubini)
Date: Thu, 17 Dec 2009 11:13:30 +0100
Subject: [PATCH 1/3] i2c: added stmpe2401 port extender with irq support
In-Reply-To: <cover.1261044597.git.rubini@unipv.it>
References: <cover.1261044597.git.rubini@unipv.it>
Message-ID: <f1fffebf3289cc62064106f68ebb1734213e34c1.1261044597.git.rubini@unipv.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alessandro Rubini <rubini@unipv.it>

The "STM Port Expander" is a device with 24 gpio lines and a few
alternate functions associated to each of them. It includes 32
interrupt sources, which are handled through in irq_chip structure.
This patch only registers the GPIO lines, but non-gpio interrupts
are working as well.  A keypad driver based on this chip will follow.

Signed-off-by: Alessandro Rubini <rubini@unipv.it>
Acked-by: Andrea Gallo <andrea.gallo@stericsson.com>
---
 drivers/gpio/Kconfig          |    7 +
 drivers/gpio/Makefile         |    1 +
 drivers/gpio/stmpe2401.c      |  571 +++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c/stmpe2401.h |  145 +++++++++++
 4 files changed, 724 insertions(+), 0 deletions(-)
 create mode 100644 drivers/gpio/stmpe2401.c
 create mode 100644 include/linux/i2c/stmpe2401.h

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index a019b49..a4ffd46 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -148,6 +148,13 @@ config GPIO_PCF857X
 	  This driver provides an in-kernel interface to those GPIOs using
 	  platform-neutral GPIO calls.
 
+config GPIO_STMPE2401
+	depends on I2C
+	tristate "STM Port Expander with Keypad and PWM"
+	help
+	 Say y if you want support for the STMPE2401, found for example
+	 in the nhk8815 board.
+
 config GPIO_TWL4030
 	tristate "TWL4030, TWL5030, and TPS659x0 GPIOs"
 	depends on TWL4030_CORE
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 52fe4cf..b9ba69f 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_GPIO_MCP23S08)	+= mcp23s08.o
 obj-$(CONFIG_GPIO_PCA953X)	+= pca953x.o
 obj-$(CONFIG_GPIO_PCF857X)	+= pcf857x.o
 obj-$(CONFIG_GPIO_PL061)	+= pl061.o
+obj-$(CONFIG_GPIO_STMPE2401)	+= stmpe2401.o
 obj-$(CONFIG_GPIO_TIMBERDALE)	+= timbgpio.o
 obj-$(CONFIG_GPIO_TWL4030)	+= twl4030-gpio.o
 obj-$(CONFIG_GPIO_UCB1400)	+= ucb1400_gpio.o
diff --git a/drivers/gpio/stmpe2401.c b/drivers/gpio/stmpe2401.c
new file mode 100644
index 0000000..50beea8
--- /dev/null
+++ b/drivers/gpio/stmpe2401.c
@@ -0,0 +1,571 @@
+/*
+ *  stmpe2401.c - 24 gpio ports, keypad and PWM controller
+ *
+ *  Copyright (C) 2009 Alessandro Rubini <rubini@unipv.it>
+ *
+ *  Based on the gpio extender implementation found in pca953x.c:
+ *     Copyright (C) 2005 Ben Gardner <bgardner@wabtec.com>
+ *     Copyright (C) 2007 Marvell International Ltd.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/gpio.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/i2c/stmpe2401.h>
+
+static const struct i2c_device_id stmpe_id[] = {
+	{ "stmpe2401", },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, stmpe_id);
+
+struct stmpe_chip {
+	struct gpio_chip		gpio_chip;
+	struct irq_chip			irq_chip;
+	struct mutex			lock;
+	unsigned long 			flags;
+#define STMPE_FLAG_IRQ_PENDING	0 /* it has been reported */
+#define STMPE_FLAG_IRQ_RUNNING	1 /* it is being handled */
+
+	struct stmpe2401_platform_data	*pdata;
+	struct i2c_client 		*client;
+	struct work_struct		work;
+	/* We also keep track of our status, to avoid asking the device */
+	u32			gpioie;		/* interrupt enable */
+	u32			gpiois;		/* interrupt status */
+	u32			gpiod;		/* direction */
+	u32			gpioed;		/* edge detection */
+	u32			gpiore;		/* rising edge */
+	u32			gpiofe;		/* falling edge */
+	u32			gpiopu;		/* pull up */
+	u32			gpiopd;		/* pull down */
+	u16			syscon;
+	u16			icr;
+	u16			ier;
+	u16			isr;
+	unsigned char		gpioaf[6];
+};
+
+/* Most registers are 8 bits, but some are 16 or 24 bits */
+enum regsize {REG8, REG16, REG24};
+
+/*
+ * Double-underscore functions are internal helpers within this file.
+ * All 16-bit and all 24-bit registers are MSB-first, so handle it.
+ */
+static inline int __stmpe_write(enum regsize s, struct stmpe_chip *chip,
+				int reg, int val)
+{
+	int ret;
+	u8 d[3];
+
+	switch (s) {
+	case REG8:
+		ret = i2c_smbus_write_byte_data(chip->client, reg, val);
+		break;
+	case REG16:
+		d[0] = val >> 8;
+		d[1] = val >> 0;
+		ret = i2c_smbus_write_i2c_block_data(chip->client, reg, 2, d);
+		break;
+	case REG24:
+		d[0] = val >> 16;
+		d[1] = val >>  8;
+		d[2] = val >>  0;
+		ret = i2c_smbus_write_i2c_block_data(chip->client, reg, 3, d);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	if (ret < 0)
+		dev_err(&chip->client->dev, "write: error %i\n", ret);
+	return ret;
+}
+
+/* here the returned data is always an integer */
+static inline int __stmpe_read(enum regsize s, struct stmpe_chip *chip,
+			       int reg, int *val)
+{
+	int ret;
+	u8 d[3];
+
+	switch (s) {
+	case REG8:
+		ret = i2c_smbus_read_byte_data(chip->client, reg);
+		if (ret >= 0) {
+			*val = ret;
+			ret = 0;
+		}
+		break;
+	case REG16:
+		ret = i2c_smbus_read_i2c_block_data(chip->client, reg, 2, d);
+		if (ret == 2) {
+			*val = (d[0] << 8) | d[1];
+			ret = 0;
+		} else if (ret >= 0)
+			ret = -EIO;
+		break;
+	case REG24:
+		ret = i2c_smbus_read_i2c_block_data(chip->client, reg, 3, d);
+		if (ret == 3) {
+			*val = (d[0] << 16) | (d[1] << 8) | d[2];
+			ret = 0;
+		} else if (ret >= 0)
+			ret = -EIO;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	if (ret < 0)
+		dev_err(&chip->client->dev, "read: error %i\n", ret);
+	return ret;
+}
+
+static int __stmpe_dir_val(struct gpio_chip *gc, int isoutput, unsigned off,
+	int val)
+{
+	struct stmpe_chip *chip;
+	u32 rval, newval;
+	int reg, ret = 0;
+
+	chip = container_of(gc, struct stmpe_chip, gpio_chip);
+	mutex_lock(&chip->lock);
+
+	if (isoutput) { /* First set value: use the set or clear reg */
+		if (val)
+			reg = STMPE_GPIO_REG(GPSR, off);
+		else
+			reg = STMPE_GPIO_REG(GPCR, off);
+		ret = __stmpe_write(REG8, chip, reg, 1 << (off & 7));
+		if (ret)
+			goto out;
+	}
+
+	/* Then set direction, but only if needed */
+	rval = (chip->gpiod >> off) & 1;
+	if (rval == isoutput)
+		goto out;
+
+	reg = STMPE_GPIO_REG(GPDR, off);
+	newval = chip->gpiod & ~(1 << off);
+	if (isoutput)
+		newval |= (1 << off);
+
+	rval = (newval >> (off & ~7)) & 0xff;
+	reg = STMPE_GPIO_REG(GPDR, off);
+	ret = __stmpe_write(REG8, chip, reg, rval);
+	if (ret)
+		goto out;
+
+	chip->gpiod = newval;
+out:
+	mutex_unlock(&chip->lock);
+	return ret;
+}
+
+/*
+ * The next functions implement the methods needed by the gpio API.
+ */
+
+static int stmpe_direction_input(struct gpio_chip *gc, unsigned off)
+{
+	return __stmpe_dir_val(gc, 0, off, 0);
+}
+
+static int stmpe_direction_output(struct gpio_chip *gc,
+		unsigned off, int val)
+{
+	return __stmpe_dir_val(gc, 1, off, val);
+}
+
+static int stmpe_get_value(struct gpio_chip *gc, unsigned off)
+{
+	struct stmpe_chip *chip;
+	int rval;
+	int ret;
+
+	chip = container_of(gc, struct stmpe_chip, gpio_chip);
+
+	ret = __stmpe_read(REG8, chip, STMPE_GPIO_REG(GPMR, off), &rval);
+	if (ret < 0)
+		goto out;
+	ret = (rval >> (off & 7)) & 1;
+out:
+	return ret;
+}
+
+static void stmpe_set_value(struct gpio_chip *gc, unsigned off, int val)
+{
+	__stmpe_dir_val(gc, 1 /* out */, off, val);
+}
+
+/*
+ * Next method is to change alternate function, called by board functions
+ */
+int stmpe2401_set_mode(struct gpio_chip *gc, unsigned off, int val)
+{
+	struct stmpe_chip *chip;
+	int reg, shift, ret = 0;
+	u8 mask, newval;
+
+	chip = container_of(gc, struct stmpe_chip, gpio_chip);
+	if (off >= gc->ngpio || val < STMPE_ALT_GPIO || val > STMPE_ALT_3)
+		return -EINVAL;
+
+	mutex_lock(&chip->lock);
+	/* 4 gpio per registers (6 registers, MSB first) */
+	reg = 5 - (off / 4);
+	shift = 2 * (off % 4);
+	mask = 3 << shift;
+	if ((chip->gpioaf[reg] & mask) == val << shift)
+		goto out; /* nothing to do */
+	newval = chip->gpioaf[reg] & ~mask;
+	newval |= val << shift;
+	ret = __stmpe_write(REG8, chip, STMPE_GPAFR_BASE + off, newval);
+	if (ret)
+		goto out;
+	chip->gpioaf[reg] = newval;
+out:
+	mutex_unlock(&chip->lock);
+	return ret;
+}
+EXPORT_SYMBOL(stmpe2401_set_mode);
+
+/*
+ * Interrupt management: this uses a work structure, to use process context
+ */
+static void stmpe_irq_ack(unsigned int irq)
+{
+	struct stmpe_chip *chip = get_irq_chip_data(irq);
+	int localirq, i, gpio, reg;
+
+	localirq = irq - chip->pdata->irq_base;
+
+	if (localirq < STMPE2401_IRQ_GENERIC_GPIO) {
+		/*  0..7: non-gpio (keypad etc): just ack in the LSB */
+		i = 1 << localirq;
+		__stmpe_write(REG8, chip, STMPE_ISR_LSB, i);
+		return;
+	}
+
+	/* 8..31 = gpio irq: ack three bits: from least to most specific */
+	gpio = localirq - STMPE2401_IRQ_GENERIC_GPIO; /* 0..23 */
+	/* First: the general gpio bit, position 8 of ISR */
+	__stmpe_write(REG8, chip, STMPE_ISR_MSB, 1);
+	/* Then, the gpio itself, in ISGPIO */
+	reg = STMPE_GPIO_REG(ISGPIO, gpio);
+	i = 1 << (gpio & 7);
+	__stmpe_write(REG8, chip, reg, i);
+	/* Finally, the edge detection status, in GPEDR */
+	reg = STMPE_GPIO_REG(GPEDR, gpio);
+	i = 1 << (gpio & 7);
+	__stmpe_write(REG8, chip, reg, i);
+}
+
+static void stmpe_irq_mask(unsigned int irq)
+{
+	struct stmpe_chip *chip = get_irq_chip_data(irq);
+	int localirq, localgpio;
+
+	localirq = irq - chip->pdata->irq_base;
+
+	if (localirq < STMPE2401_IRQ_GENERIC_GPIO) {
+		chip->ier &= ~(1 << localirq);
+		__stmpe_write(REG16, chip, STMPE_IER_MSB, chip->ier);
+		return;
+	}
+	/* Else, a gpio: disable the specific bit */
+	localgpio = localirq - STMPE2401_IRQ_GENERIC_GPIO; /* 00..23 */
+	chip->gpioie &= ~(1 << localgpio);
+	__stmpe_write(REG24, chip, STMPE_IEGPIO_MSB, chip->gpioie);
+	if (!chip->gpioie) {
+		/* no more gpio interrupts: disable globally */
+		chip->ier &= ~STMPE_IRQ_GPIO;
+		__stmpe_write(REG16, chip, STMPE_IER_MSB, chip->ier);
+	}
+}
+
+static void stmpe_irq_unmask(unsigned int irq)
+{
+	struct stmpe_chip *chip = get_irq_chip_data(irq);
+	int localirq, localgpio;
+
+	localirq = irq - chip->pdata->irq_base;
+
+	if (localirq < STMPE2401_IRQ_GENERIC_GPIO) {
+		chip->ier |= (1 << localirq);
+		__stmpe_write(REG16, chip, STMPE_IER_MSB, chip->ier);
+		return;
+	}
+	/* Else, a gpio: if first time. enable in generic register too */
+	localgpio = localirq - STMPE2401_IRQ_GENERIC_GPIO; /* 00..23 */
+	chip->gpioie |= (1 << localgpio);
+	__stmpe_write(REG24, chip, STMPE_IEGPIO_MSB, chip->gpioie);
+
+	if ((chip->ier & STMPE_IRQ_GPIO) == 0) {
+		chip->ier |= STMPE_IRQ_GPIO;
+		__stmpe_write(REG16, chip, STMPE_IER_MSB, chip->ier);
+	}
+}
+
+static int stmpe_irq_set_type(unsigned int irq, unsigned int type)
+{
+	struct stmpe_chip *chip = get_irq_chip_data(irq);
+	int localirq, localgpio;
+
+	localirq = irq - chip->pdata->irq_base;
+
+	if (localirq < STMPE2401_IRQ_GENERIC_GPIO) {
+		printk(KERN_WARNING "stmpe: can't set mode for irq %i (%i)\n",
+		       irq, localirq);
+		return 0;
+	}
+
+	/* otherwise, a gpio irq: refuse level-trigger, configure edge */
+	localgpio = localirq - STMPE2401_IRQ_GENERIC_GPIO; /* 00..23 */
+	if (type & (IRQF_TRIGGER_HIGH | IRQF_TRIGGER_LOW))
+		return -EINVAL;
+	if (type & IRQF_TRIGGER_RISING) {
+		chip->gpiore |= (1 << localgpio);
+		__stmpe_write(REG24, chip, STMPE_GPRER_MSB, chip->gpiore);
+	}
+	if (type & IRQF_TRIGGER_FALLING) {
+		chip->gpiofe |= (1 << localgpio);
+		__stmpe_write(REG24, chip, STMPE_GPFER_MSB, chip->gpiofe);
+	}
+	return 0;
+}
+
+static struct irq_chip stmpe_irq_chip = {
+	.name		= "STMPE2401",
+	.ack		= stmpe_irq_ack,
+	.mask		= stmpe_irq_mask,
+	.unmask		= stmpe_irq_unmask,
+	.set_type	= stmpe_irq_set_type,
+};
+
+/* This is the work structure, for in-thread interrupt handling */
+static void stmpe_work(struct work_struct *work)
+{
+	struct stmpe_chip *chip = container_of(work, struct stmpe_chip, work);
+	int i = 0, first_irq = chip->pdata->irq_base;
+	u32 pending;
+
+	/*
+	 * Some basic check for concurrency problems: we have a single
+	 * work queue, so stuff must be serialized. If another interrupt
+	 * happens, it is signalled in the flags and we simply loop over
+	 */
+	if (test_and_set_bit(STMPE_FLAG_IRQ_RUNNING, &chip->flags))
+		printk(KERN_WARNING "%s: already running\n", __func__);
+	do {
+		if (!test_and_clear_bit(STMPE_FLAG_IRQ_PENDING, &chip->flags))
+			printk(KERN_WARNING "%s: irq not pending?\n", __func__);
+		/* get status of the interrupt controller, allow errors */
+		chip->isr = chip->gpiois = 0;
+		/* read interrupt status, and mask with interrupt enable */
+		if (!__stmpe_read(REG16, chip, STMPE_ISR_MSB, &i))
+			chip->isr = i & chip->ier;
+		/* if there is some gpio interrupt, get status and mask again */
+		if (chip->isr & (1 << STMPE2401_IRQ_GENERIC_GPIO)) {
+			if (!__stmpe_read(REG24, chip, STMPE_ISGPIO_MSB, &i))
+				chip->gpiois = i & chip->gpioie;
+		}
+		pending = (chip->isr & 0xff) | (chip->gpiois << 8);
+		while (pending) {
+			int irq = first_irq + __ffs(pending);
+			pending &= ~(1 << __ffs(pending));
+			generic_handle_irq(irq);
+		}
+	} while (test_bit(STMPE_FLAG_IRQ_PENDING, &chip->flags));
+
+	clear_bit(STMPE_FLAG_IRQ_RUNNING, &chip->flags);
+}
+
+/* This one is called at interrupt time and fires the work queue */
+static void stmpe_irq_handler(unsigned int irq, struct irq_desc *desc)
+{
+	struct stmpe_chip *chip;
+	struct irq_chip *host_chip;
+
+	chip = get_irq_data(irq);
+	/* Mark we got irq; schedule the work unless already running */
+	set_bit(STMPE_FLAG_IRQ_PENDING, &chip->flags);
+	if (!test_bit(STMPE_FLAG_IRQ_RUNNING, &chip->flags))
+		schedule_work(&chip->work);
+	/* Finally, acknowledge the parent irq */
+	host_chip = get_irq_chip(chip->pdata->parent_irq);
+	host_chip->ack(chip->pdata->parent_irq);
+}
+
+static int stmpe_init_irq(struct stmpe_chip *chip)
+{
+	struct stmpe2401_platform_data *pdata;
+	unsigned int first_irq;
+	int i;
+
+	pdata = chip->pdata;
+	if (pdata->irq_base < 0)
+		return 0; /* nothing to do */
+
+	chip->ier = 0; /* all disabled */
+	__stmpe_write(REG16, chip, STMPE_IER_MSB, chip->ier);
+	chip->gpioie = 0;
+	__stmpe_write(REG24, chip, STMPE_IER_MSB, chip->gpioie);
+
+	/* configure our line as rising-edge (should be added to pdata?) */
+	chip->icr = STMPE_ICR_ENA | STMPE_ICR_EDGE | STMPE_ICR_HIGH;
+	__stmpe_write(REG8, chip, STMPE_ICR_LSB, chip->icr);
+	set_irq_type(pdata->parent_irq, IRQF_TRIGGER_RISING);
+
+	first_irq = pdata->irq_base;
+	for (i = first_irq; i < first_irq + STMPE2401_NIRQ; i++) {
+		set_irq_chip(i, &stmpe_irq_chip);
+		set_irq_handler(i, handle_edge_irq);
+		set_irq_flags(i, IRQF_VALID);
+		set_irq_chip_data(i, chip);
+	}
+	set_irq_chained_handler(pdata->parent_irq, stmpe_irq_handler);
+	set_irq_data(pdata->parent_irq, chip);
+	return 0;
+}
+
+/* Probe and remove method, for module init/exit */
+static int __devinit stmpe_probe(struct i2c_client *client,
+				 const struct i2c_device_id *id)
+{
+	struct stmpe2401_platform_data *pdata;
+	struct stmpe_chip *chip;
+	struct gpio_chip *gchip;
+	int ret, regval = 0; /* set to zero to prevent a warning */
+
+	if (!client->dev.platform_data)
+		return -EINVAL;
+
+	chip = kzalloc(sizeof(struct stmpe_chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	mutex_init(&chip->lock);
+	INIT_WORK(&chip->work, stmpe_work);
+	chip->pdata = pdata = client->dev.platform_data;
+	chip->client = client;
+
+	/* Identify the chip (CHIPID must be 1) */
+	ret  = __stmpe_read(REG8, chip, STMPE_CHIPID, &regval);
+	if (!ret && regval != 1)
+		ret = -ENODEV;
+	if (ret)
+		goto out_free;
+
+	/* Don't reset, but rather recover current config set by boot loader */
+	ret = __stmpe_read(REG24, chip, STMPE_GPDR_MSB, &regval);
+	if (ret)
+		goto out_free;
+	chip->gpiod = regval;
+
+	/* Similarly, recover the alternate function status of the bits */
+	i2c_smbus_read_i2c_block_data(client, STMPE_GPDR_MSB, 6,
+				      chip->gpioaf);
+
+	/* Initialize the gpio chip structure */
+	gchip = &chip->gpio_chip;
+	gchip->direction_input  = stmpe_direction_input;
+	gchip->direction_output = stmpe_direction_output;
+	gchip->get = stmpe_get_value;
+	gchip->set = stmpe_set_value;
+	gchip->can_sleep = 1; /* actually, depends on i2c implementation */
+
+	gchip->base = pdata->gpio_base;
+	gchip->ngpio = STMPE2401_NGPIO;
+	gchip->label = chip->client->name;
+	gchip->dev = &chip->client->dev;
+	gchip->owner = THIS_MODULE;
+	gchip->names = pdata->names;
+
+	ret = gpiochip_add(&chip->gpio_chip);
+	if (ret)
+		goto out_free; /* diagnostics already printed */
+
+	/* Register as an interrupt chip */
+	stmpe_init_irq(chip);
+
+	if (pdata->setup)
+		ret = pdata->setup(client, &chip->gpio_chip, pdata->context);
+	if (ret)
+		goto out_remove; /* diagnostics already printed */
+	i2c_set_clientdata(client, chip);
+
+	printk(KERN_INFO "STMPE2401: addr %02x, gpio %i-%i base-irq %i\n",
+	       chip->client->addr, pdata->gpio_base,
+	       pdata->gpio_base + STMPE2401_NGPIO - 1, pdata->irq_base);
+	return 0;
+
+out_remove:
+	gpiochip_remove(&chip->gpio_chip);
+out_free:
+	kfree(chip);
+	return ret;
+}
+
+static int stmpe_remove(struct i2c_client *client)
+{
+	struct stmpe2401_platform_data *pdata = client->dev.platform_data;
+	struct stmpe_chip *chip = i2c_get_clientdata(client);
+	int ret = 0;
+
+	if (pdata->teardown) {
+		ret = pdata->teardown(client, &chip->gpio_chip, pdata->context);
+		if (ret < 0) {
+			dev_err(&client->dev, "%s failed, %d\n",
+					"teardown", ret);
+			return ret;
+		}
+	}
+
+	ret = gpiochip_remove(&chip->gpio_chip);
+	if (ret) {
+		dev_err(&client->dev, "%s failed, %d\n",
+				"gpiochip_remove()", ret);
+		return ret;
+	}
+
+	kfree(chip);
+	return 0;
+}
+
+static struct i2c_driver stmpe_driver = {
+	.driver = {
+		.name	= "stmpe",
+	},
+	.probe		= stmpe_probe,
+	.remove		= stmpe_remove,
+	.id_table	= stmpe_id,
+};
+
+static int __init stmpe_init(void)
+{
+	return i2c_add_driver(&stmpe_driver);
+}
+/*
+ * [from pca953x.c:] register after i2c postcore initcall and before
+ * subsys initcalls that may rely on these GPIOs
+ */
+subsys_initcall(stmpe_init);
+
+static void __exit stmpe_exit(void)
+{
+	i2c_del_driver(&stmpe_driver);
+}
+module_exit(stmpe_exit);
+
+MODULE_AUTHOR("Alessandro Rubini <rubini@unipv.it>");
+MODULE_DESCRIPTION("GPIO expander driver for PCA953x");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/i2c/stmpe2401.h b/include/linux/i2c/stmpe2401.h
new file mode 100644
index 0000000..14bb8fc
--- /dev/null
+++ b/include/linux/i2c/stmpe2401.h
@@ -0,0 +1,145 @@
+/*
+ *  stmpe2401.c - 24 gpio ports, keypad and PWM controller
+ *
+ *  Copyright (C) 2009 Alessandro Rubini <rubini@unipv.it>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ */
+#ifndef __LINUX_I2C_STMPE2401_H
+#define __LINUX_I2C_STMPE2401_H
+
+/*
+ * The STMPE2401 (STM Port Expander) offers 24 GPIO bits, keypad
+ * scanning and PWM control. The interrupt register includes 9
+ * interrupt sources, one of which multiplexes the 24 GPIO interrupts.
+ * To avoid shared handlers, each of them reading i2c register, we declare
+ * 32 interrupts and do the multiplexing once only in the chip driver.
+ */
+
+#define STMPE2401_NGPIO		24
+#define STMPE2401_NIRQ		32
+
+/* Above defs used in irqs.h, so mask out for assembly */
+#ifndef __ASSEMBLY__
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+
+struct stmpe2401_platform_data {
+	int		gpio_base;
+	int		irq_base;	/* -1 if no interrupt support used */
+	int		parent_irq;
+	void		*context;	/* for setup/teardown */
+
+	/* setup passes back the struct gpio_chip, to allow changing mode */
+	int		(*setup)(struct i2c_client *client,
+				 struct gpio_chip *chip, void *context);
+	int		(*teardown)(struct i2c_client *client,
+				    struct gpio_chip *chip, void *context);
+	char		**names;
+};
+
+/*
+ * Following are the interrupt sources: 8 specific and 24 for the 24 bits
+ * The interrupt registers have 9 bits (0..8) where bit 8 selects gpio
+ */
+#define STMPE2401_IRQ_WAKEUP		0
+#define STMPE2401_IRQ_KEYPAD		1
+#define STMPE2401_IRQ_KEYPAD_OVERFLOW	2
+#define STMPE2401_IRQ_ROTATOR		3
+#define STMPE2401_IRQ_ROTATOR_OVERFLOW	4
+#define STMPE2401_IRQ_PWM0		5
+#define STMPE2401_IRQ_PWM1		6
+#define STMPE2401_IRQ_PWM2		7
+#define STMPE2401_IRQ_GENERIC_GPIO	8
+
+#define STMPE2401_IRQ_GPIO(x)		(8+(x))
+#define STMPE2401_NGPIO		24
+
+
+/*
+ * Register definitions -- use a shorter prefix to save typing
+ * (not all of them are defined for laziness, as they are not used)
+ */
+
+/* 00..07 and 80..81: clock and power manager */
+#define STMPE_SYSCON		0x02
+#define STMPE_SYSCON_ROTENA		0x01
+#define STMPE_SYSCON_KPCENA		0x02
+#define STMPE_SYSCON_PWMENA		0x04
+#define STMPE_SYSCON_GPIOENA		0x08
+#define STMPE_SYSCON_SLEEP		0x10
+#define STMPE_SYSCON_NO32KHZ		0x20	/* puts in hibernate mode */
+#define STMPE_SYSCON_SOFTRESET		0x80
+#define STMPE_CHIPID		0x80	/* write 0x01 to reset chip */
+#define STMPE_VERSION		0x81
+
+/* 10..1f: interrupt controller: they are 2-byte or 3-byte regs, msb first*/
+#define STMPE_ICR_MSB		0x10
+#define STMPE_ICR_LSB		0x11
+#define STMPE_ICR_ENA			0x01	/* enable sending interrupts */
+#define STMPE_ICR_EDGE			0x02	/* otherwise level */
+#define STMPE_ICR_HIGH			0x04	/* active high or rising */
+#define STMPE_IER_MSB		0x12
+#define STMPE_IER_LSB		0x13
+#define STMPE_ISR_MSB		0x14
+#define STMPE_ISR_LSB		0x15
+#define STMPE_IRQ_WAKEUP		0x01	/* all bits for both IER/ISR */
+#define STMPE_IRQ_KEYPAD		0x02
+#define STMPE_IRQ_KEYPADOF		0x04	/* Overflow */
+#define STMPE_IRQ_ROT			0x08
+#define STMPE_IRQ_ROTOF			0x10
+#define STMPE_IRQ_PWM0			0x20
+#define STMPE_IRQ_PWM1			0x40
+#define STMPE_IRQ_PWM2			0x80
+#define STMPE_IRQ_GPIO			0x100
+#define STMPE_IEGPIO_MSB	0x16
+#define STMPE_IEGPIO_MID	0x17
+#define STMPE_IEGPIO_LSB	0x18
+#define STMPE_ISGPIO_MSB	0x19
+#define STMPE_ISGPIO_MID	0x1a
+#define STMPE_ISGPIO_LSB	0x1b
+
+/* 30..3f: pwm controller */
+
+/* 60..67: keypad controller */
+
+/* 70..77: rotator controller */
+
+/*
+ * 80..bf: gpio controller -- all but AF are three registers, MSB first
+ *	A macro is defined to access the right reg from bit number.
+ */
+#define STMPE_GPMR_MSB		0xa2	/* monitor pin */
+#define STMPE_GPSR_MSB		0x83	/* set pin register */
+#define STMPE_GPCR_MSB		0x86	/* clear pin register */
+#define STMPE_GPDR_MSB		0x89	/* direction registers */
+#define STMPE_GPEDR_MSB		0x8c	/* edge detection */
+#define STMPE_GPRER_MSB		0x8f	/* rising edge */
+#define STMPE_GPFER_MSB		0x92	/* falling edge */
+#define STMPE_GPPUR_MSB		0x95	/* pull up */
+#define STMPE_GPPDR_MSB		0x98	/* pull down */
+
+#define STMPE_GPIO_REG(name, n)	(STMPE_##name##_MSB + 2 - (n)/8)
+
+/*
+ * The alternate functionis different: two bits per GPIO bit, so
+ * 48 bit total. This is 6 bites starting from the most significant.
+ * Let code do the calculations, as it's done rarely.
+ *
+ * For all 24 bits, primary (AF0) is GPIO. Keypad and PWM ar AF1
+ * Since mapping of keypad rows/columns to gpio is nontrivial, it's
+ * written in a table in the relevant keypad source file
+ */
+#define STMPE_GPAFR_BASE	0x9b
+
+/* These are the alternate function values, and a function to change it */
+#define STMPE_ALT_GPIO	0
+#define STMPE_ALT_1	1
+#define STMPE_ALT_2	2
+#define STMPE_ALT_3	3
+extern int stmpe2401_set_mode(struct gpio_chip *gc, unsigned off, int val);
+
+#endif /* __ASSEMBLY__ */
+#endif /* __LINUX_I2C_STMPE2401_H */
-- 
1.6.0.2
