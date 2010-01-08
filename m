From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 8 Jan 2010 12:45:15 +0100
Subject: [PATCH 1/4] mfd: enable max8925
In-Reply-To: <771cded01001080234h735d2e7dxafeb5c5a952dc218@mail.gmail.com>
References: <771cded00912210445v67175632i876b7909de8afae3@mail.gmail.com>
	<20100108000126.GE11239@sortiz.org>
	<771cded01001080234h735d2e7dxafeb5c5a952dc218@mail.gmail.com>
Message-ID: <20100108114514.GC23619@sortiz.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2010 at 05:34:45AM -0500, Haojian Zhuang wrote:
> On Thu, Jan 7, 2010 at 7:01 PM, Samuel Ortiz <sameo@linux.intel.com> wrote:
> > Hi Haojian,
> >
> > On Mon, Dec 21, 2009 at 07:45:27AM -0500, Haojian Zhuang wrote:
> >> From 567add422a0d2214e037c3ed1b424b21776dfe34 Mon Sep 17 00:00:00 2001
> >> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> >> Date: Thu, 17 Dec 2009 12:30:16 -0500
> >> Subject: [PATCH] mfd: enable max8925
> >>
> >> Max8925 is a Power Management IC from Maxim Semiconductor.
> >>
> >> Do basic support on accessing MAX8925.
> > The patch looks quite good to me. I have some minor comments/suggestions
> > though:
> >
> >> ?obj-$(CONFIG_PMIC_DA903X) ? ?+= da903x.o
> >> +max8925-objs ? ? ? ? ? ? ? ? := max8925-core.o max8925-i2c.o
> >> +obj-$(CONFIG_MFD_MAX8925) ? ?+= max8925.o
> > No big deal, but it could just be:
> > obj-$(CONFIG_MFD_MAX8925) ? ?+= max8925-core.o max8925-i2c.o
> >
> 
> I prefer to still use this way. If I write it as your way, it will be
> built to max8925-core.ko and max8925-i2c.ko when built as module. I
> just want to make it built as max8925.ko.
> 
> Others are updated. Since it impacts the second one, I upload both #1
> and #2 patches.
Many thanks, patchset applied.

Cheers,
Samuel.

 
> Thanks
> Haojian

> From 02c46ce4005e06ff41127d3edd3ebcadd109967e Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Tue, 5 Jan 2010 04:13:00 -0500
> Subject: [PATCH] mfd: enable max8925
> 
> Max8925 is a Power Management IC from Maxim Semiconductor.
> 
> Do basic support on accessing MAX8925.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  drivers/mfd/Kconfig         |    9 ++
>  drivers/mfd/Makefile        |    2 +
>  drivers/mfd/max8925-core.c  |  262 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/mfd/max8925-i2c.c   |  210 ++++++++++++++++++++++++++++++++++
>  include/linux/mfd/max8925.h |  119 +++++++++++++++++++
>  5 files changed, 602 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/mfd/max8925-core.c
>  create mode 100644 drivers/mfd/max8925-i2c.c
>  create mode 100644 include/linux/mfd/max8925.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 8782978..a57e7ea 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -184,6 +184,15 @@ config PMIC_ADP5520
>  	  individual components like LCD backlight, LEDs, GPIOs and Kepad
>  	  under the corresponding menus.
>  
> +config MFD_MAX8925
> +	tristate "Maxim Semiconductor MAX8925 PMIC Support"
> +	depends on I2C
> +	help
> +	  Say yes here to support for Maxim Semiconductor MAX8925. This is
> +	  a Power Management IC. This driver provies common support for
> +	  accessing the device, additional drivers must be enabled in order
> +	  to use the functionality of the device.
> +
>  config MFD_WM8400
>  	tristate "Support Wolfson Microelectronics WM8400"
>  	select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index ca2f2c4..86b435c 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -47,6 +47,8 @@ endif
>  obj-$(CONFIG_UCB1400_CORE)	+= ucb1400_core.o
>  
>  obj-$(CONFIG_PMIC_DA903X)	+= da903x.o
> +max8925-objs			:= max8925-core.o max8925-i2c.o
> +obj-$(CONFIG_MFD_MAX8925)	+= max8925.o
>  
>  obj-$(CONFIG_MFD_PCF50633)	+= pcf50633-core.o
>  obj-$(CONFIG_PCF50633_ADC)	+= pcf50633-adc.o
> diff --git a/drivers/mfd/max8925-core.c b/drivers/mfd/max8925-core.c
> new file mode 100644
> index 0000000..3e26267
> --- /dev/null
> +++ b/drivers/mfd/max8925-core.c
> @@ -0,0 +1,262 @@
> +/*
> + * Base driver for Maxim MAX8925
> + *
> + * Copyright (C) 2009 Marvell International Ltd.
> + *	Haojian Zhuang <haojian.zhuang@marvell.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/max8925.h>
> +
> +#define IRQ_MODE_STATUS		0
> +#define IRQ_MODE_MASK		1
> +
> +static int __get_irq_offset(struct max8925_chip *chip, int irq, int mode,
> +			    int *offset, int *bit)
> +{
> +	if (!offset || !bit)
> +		return -EINVAL;
> +
> +	switch (chip->chip_id) {
> +	case MAX8925_GPM:
> +		*bit = irq % BITS_PER_BYTE;
> +		if (irq < (BITS_PER_BYTE << 1)) {	/* irq = [0,15] */
> +			*offset = (mode) ? MAX8925_CHG_IRQ1_MASK
> +				: MAX8925_CHG_IRQ1;
> +			if (irq >= BITS_PER_BYTE)
> +				(*offset)++;
> +		} else {				/* irq = [16,31] */
> +			*offset = (mode) ? MAX8925_ON_OFF_IRQ1_MASK
> +				: MAX8925_ON_OFF_IRQ1;
> +			if (irq >= (BITS_PER_BYTE * 3))
> +				(*offset)++;
> +		}
> +		break;
> +	case MAX8925_ADC:
> +		*bit = irq % BITS_PER_BYTE;
> +		*offset = (mode) ? MAX8925_TSC_IRQ_MASK : MAX8925_TSC_IRQ;
> +		break;
> +	default:
> +		goto out;
> +	}
> +	return 0;
> +out:
> +	dev_err(chip->dev, "Wrong irq #%d is assigned\n", irq);
> +	return -EINVAL;
> +}
> +
> +static int __check_irq(int irq)
> +{
> +	if ((irq < 0) || (irq >= MAX8925_NUM_IRQ))
> +		return -EINVAL;
> +	return 0;
> +}
> +
> +int max8925_mask_irq(struct max8925_chip *chip, int irq)
> +{
> +	int offset, bit, ret;
> +
> +	ret = __get_irq_offset(chip, irq, IRQ_MODE_MASK, &offset, &bit);
> +	if (ret < 0)
> +		return ret;
> +	ret = max8925_set_bits(chip->i2c, offset, 1 << bit, 1 << bit);
> +	return ret;
> +}
> +
> +int max8925_unmask_irq(struct max8925_chip *chip, int irq)
> +{
> +	int offset, bit, ret;
> +
> +	ret = __get_irq_offset(chip, irq, IRQ_MODE_MASK, &offset, &bit);
> +	if (ret < 0)
> +		return ret;
> +	ret = max8925_set_bits(chip->i2c, offset, 1 << bit, 0);
> +	return ret;
> +}
> +
> +#define INT_STATUS_NUM		(MAX8925_NUM_IRQ / BITS_PER_BYTE)
> +
> +static irqreturn_t max8925_irq_thread(int irq, void *data)
> +{
> +	struct max8925_chip *chip = data;
> +	unsigned long irq_status[INT_STATUS_NUM];
> +	unsigned char status_buf[INT_STATUS_NUM << 1];
> +	int i, ret;
> +
> +	memset(irq_status, 0, sizeof(unsigned long) * INT_STATUS_NUM);
> +
> +	/* all these interrupt status registers are read-only */
> +	switch (chip->chip_id) {
> +	case MAX8925_GPM:
> +		ret = max8925_bulk_read(chip->i2c, MAX8925_CHG_IRQ1,
> +					4, status_buf);
> +		if (ret < 0)
> +			goto out;
> +		ret = max8925_bulk_read(chip->i2c, MAX8925_ON_OFF_IRQ1,
> +					2, &status_buf[4]);
> +		if (ret < 0)
> +			goto out;
> +		ret = max8925_bulk_read(chip->i2c, MAX8925_ON_OFF_IRQ2,
> +					2, &status_buf[6]);
> +		if (ret < 0)
> +			goto out;
> +		/* clear masked interrupt status */
> +		status_buf[0] &= (~status_buf[2] & CHG_IRQ1_MASK);
> +		irq_status[0] |= status_buf[0];
> +		status_buf[1] &= (~status_buf[3] & CHG_IRQ2_MASK);
> +		irq_status[0] |= (status_buf[1] << BITS_PER_BYTE);
> +		status_buf[4] &= (~status_buf[5] & ON_OFF_IRQ1_MASK);
> +		irq_status[0] |= (status_buf[4] << (BITS_PER_BYTE * 2));
> +		status_buf[6] &= (~status_buf[7] & ON_OFF_IRQ2_MASK);
> +		irq_status[0] |= (status_buf[6] << (BITS_PER_BYTE * 3));
> +		break;
> +	case MAX8925_ADC:
> +		ret = max8925_bulk_read(chip->i2c, MAX8925_TSC_IRQ,
> +					2, status_buf);
> +		if (ret < 0)
> +			goto out;
> +		/* clear masked interrupt status */
> +		status_buf[0] &= (~status_buf[1] & TSC_IRQ_MASK);
> +		irq_status[0] |= status_buf[0];
> +		break;
> +	default:
> +		goto out;
> +	}
> +
> +	for_each_bit(i, &irq_status[0], MAX8925_NUM_IRQ) {
> +		clear_bit(i, irq_status);
> +		dev_dbg(chip->dev, "Servicing IRQ #%d in %s\n", i, chip->name);
> +
> +		mutex_lock(&chip->irq_lock);
> +		if (chip->irq[i].handler)
> +			chip->irq[i].handler(i, chip->irq[i].data);
> +		else {
> +			max8925_mask_irq(chip, i);
> +			dev_err(chip->dev, "Noboday cares IRQ #%d in %s. "
> +				"Now mask it.\n", i, chip->name);
> +		}
> +		mutex_unlock(&chip->irq_lock);
> +	}
> +out:
> +	return IRQ_HANDLED;
> +}
> +
> +int max8925_request_irq(struct max8925_chip *chip, int irq,
> +			irq_handler_t handler, void *data)
> +{
> +	if ((__check_irq(irq) < 0) || !handler)
> +		return -EINVAL;
> +
> +	mutex_lock(&chip->irq_lock);
> +	chip->irq[irq].handler = handler;
> +	chip->irq[irq].data = data;
> +	mutex_unlock(&chip->irq_lock);
> +	return 0;
> +}
> +EXPORT_SYMBOL(max8925_request_irq);
> +
> +int max8925_free_irq(struct max8925_chip *chip, int irq)
> +{
> +	if (__check_irq(irq) < 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&chip->irq_lock);
> +	chip->irq[irq].handler = NULL;
> +	chip->irq[irq].data = NULL;
> +	mutex_unlock(&chip->irq_lock);
> +	return 0;
> +}
> +EXPORT_SYMBOL(max8925_free_irq);
> +
> +static int __devinit device_gpm_init(struct max8925_chip *chip,
> +				      struct i2c_client *i2c,
> +				      struct max8925_platform_data *pdata)
> +{
> +	int ret;
> +
> +	/* mask all IRQs */
> +	ret = max8925_set_bits(i2c, MAX8925_CHG_IRQ1_MASK, 0x7, 0x7);
> +	if (ret < 0)
> +		goto out;
> +	ret = max8925_set_bits(i2c, MAX8925_CHG_IRQ2_MASK, 0xff, 0xff);
> +	if (ret < 0)
> +		goto out;
> +	ret = max8925_set_bits(i2c, MAX8925_ON_OFF_IRQ1_MASK, 0xff, 0xff);
> +	if (ret < 0)
> +		goto out;
> +	ret = max8925_set_bits(i2c, MAX8925_ON_OFF_IRQ2_MASK, 0x3, 0x3);
> +	if (ret < 0)
> +		goto out;
> +
> +	chip->name = "GPM";
> +	memset(chip->irq, 0, sizeof(struct max8925_irq) * MAX8925_NUM_IRQ);
> +	ret = request_threaded_irq(i2c->irq, NULL, max8925_irq_thread,
> +				IRQF_ONESHOT | IRQF_TRIGGER_LOW,
> +				"max8925-gpm", chip);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Failed to request IRQ #%d.\n", i2c->irq);
> +		goto out;
> +	}
> +	chip->chip_irq = i2c->irq;
> +
> +	/* enable hard-reset for ONKEY power-off */
> +	max8925_set_bits(i2c, MAX8925_SYSENSEL, 0x80, 0x80);
> +out:
> +	return ret;
> +}
> +
> +static int __devinit device_adc_init(struct max8925_chip *chip,
> +				     struct i2c_client *i2c,
> +				     struct max8925_platform_data *pdata)
> +{
> +	int ret;
> +
> +	/* mask all IRQs */
> +	ret = max8925_set_bits(i2c, MAX8925_TSC_IRQ_MASK, 3, 3);
> +
> +	chip->name = "ADC";
> +	memset(chip->irq, 0, sizeof(struct max8925_irq) * MAX8925_NUM_IRQ);
> +	ret = request_threaded_irq(i2c->irq, NULL, max8925_irq_thread,
> +				IRQF_ONESHOT | IRQF_TRIGGER_LOW,
> +				"max8925-adc", chip);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Failed to request IRQ #%d.\n", i2c->irq);
> +		goto out;
> +	}
> +	chip->chip_irq = i2c->irq;
> +out:
> +	return ret;
> +}
> +
> +int __devinit max8925_device_init(struct max8925_chip *chip,
> +				  struct max8925_platform_data *pdata)
> +{
> +	switch (chip->chip_id) {
> +	case MAX8925_GPM:
> +		device_gpm_init(chip, chip->i2c, pdata);
> +		break;
> +	case MAX8925_ADC:
> +		device_adc_init(chip, chip->i2c, pdata);
> +		break;
> +	}
> +	return 0;
> +}
> +
> +void max8925_device_exit(struct max8925_chip *chip)
> +{
> +	if (chip->chip_irq >= 0)
> +		free_irq(chip->chip_irq, chip);
> +}
> +
> +MODULE_DESCRIPTION("PMIC Driver for Maxim MAX8925");
> +MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/mfd/max8925-i2c.c b/drivers/mfd/max8925-i2c.c
> new file mode 100644
> index 0000000..3104c4f
> --- /dev/null
> +++ b/drivers/mfd/max8925-i2c.c
> @@ -0,0 +1,210 @@
> +/*
> + * I2C driver for Maxim MAX8925
> + *
> + * Copyright (C) 2009 Marvell International Ltd.
> + *	Haojian Zhuang <haojian.zhuang@marvell.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/i2c.h>
> +#include <linux/mfd/max8925.h>
> +
> +static inline int max8925_read_device(struct i2c_client *i2c,
> +				      int reg, int bytes, void *dest)
> +{
> +	unsigned char data;
> +	unsigned char *buf;
> +	int ret;
> +
> +	buf = kzalloc(bytes + 1, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	data = (unsigned char)reg;
> +	ret = i2c_master_send(i2c, &data, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_master_recv(i2c, buf, bytes + 1);
> +	if (ret < 0)
> +		return ret;
> +	memcpy(dest, buf, bytes);
> +	return 0;
> +}
> +
> +static inline int max8925_write_device(struct i2c_client *i2c,
> +				       int reg, int bytes, void *src)
> +{
> +        unsigned char buf[bytes + 1];
> +        int ret;
> +
> +        buf[0] = (unsigned char)reg;
> +        memcpy(&buf[1], src, bytes);
> +
> +        ret = i2c_master_send(i2c, buf, bytes + 1);
> +        if (ret < 0)
> +                return ret;
> +        return 0;
> +}
> +
> +int max8925_reg_read(struct i2c_client *i2c, int reg)
> +{
> +	struct max8925_chip *chip = i2c_get_clientdata(i2c);
> +	unsigned char data;
> +	int ret;
> +
> +	mutex_lock(&chip->io_lock);
> +	ret = max8925_read_device(i2c, reg, 1, &data);
> +	mutex_unlock(&chip->io_lock);
> +
> +	if (ret < 0)
> +		return ret;
> +	else
> +		return (int)data;
> +}
> +EXPORT_SYMBOL(max8925_reg_read);
> +
> +int max8925_reg_write(struct i2c_client *i2c, int reg,
> +		unsigned char data)
> +{
> +	struct max8925_chip *chip = i2c_get_clientdata(i2c);
> +	int ret;
> +
> +	mutex_lock(&chip->io_lock);
> +	ret = max8925_write_device(i2c, reg, 1, &data);
> +	mutex_unlock(&chip->io_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(max8925_reg_write);
> +
> +int max8925_bulk_read(struct i2c_client *i2c, int reg,
> +		int count, unsigned char *buf)
> +{
> +	struct max8925_chip *chip = i2c_get_clientdata(i2c);
> +	int ret;
> +
> +	mutex_lock(&chip->io_lock);
> +	ret = max8925_read_device(i2c, reg, count, buf);
> +	mutex_unlock(&chip->io_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(max8925_bulk_read);
> +
> +int max8925_bulk_write(struct i2c_client *i2c, int reg,
> +		int count, unsigned char *buf)
> +{
> +	struct max8925_chip *chip = i2c_get_clientdata(i2c);
> +	int ret;
> +
> +	mutex_lock(&chip->io_lock);
> +	ret = max8925_write_device(i2c, reg, count, buf);
> +	mutex_unlock(&chip->io_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(max8925_bulk_write);
> +
> +int max8925_set_bits(struct i2c_client *i2c, int reg,
> +		unsigned char mask, unsigned char data)
> +{
> +	struct max8925_chip *chip = i2c_get_clientdata(i2c);
> +	unsigned char value;
> +	int ret;
> +
> +	mutex_lock(&chip->io_lock);
> +	ret = max8925_read_device(i2c, reg, 1, &value);
> +	if (ret < 0)
> +		goto out;
> +	value &= ~mask;
> +	value |= data;
> +	ret = max8925_write_device(i2c, reg, 1, &value);
> +out:
> +	mutex_unlock(&chip->io_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL(max8925_set_bits);
> +
> +
> +static const struct i2c_device_id max8925_id_table[] = {
> +	{ "max8925", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, max8925_id_table);
> +
> +static int __devinit max8925_probe(struct i2c_client *client,
> +				   const struct i2c_device_id *id)
> +{
> +	struct max8925_platform_data *pdata = client->dev.platform_data;
> +	struct max8925_chip *chip;
> +
> +	if (!pdata) {
> +		pr_info("%s: platform data is missing\n", __func__);
> +		return -EINVAL;
> +	}
> +	if ((pdata->chip_id <= MAX8925_INVALID)
> +		|| (pdata->chip_id >= MAX8925_MAX)) {
> +		pr_info("#%s: wrong chip identification\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	chip = kzalloc(sizeof(struct max8925_chip), GFP_KERNEL);
> +	if (chip == NULL)
> +		return -ENOMEM;
> +	chip->i2c = client;
> +	chip->chip_id = pdata->chip_id;
> +	i2c_set_clientdata(client, chip);
> +	chip->dev = &client->dev;
> +	mutex_init(&chip->io_lock);
> +	dev_set_drvdata(chip->dev, chip);
> +	max8925_device_init(chip, pdata);
> +
> +	return 0;
> +}
> +
> +static int __devexit max8925_remove(struct i2c_client *client)
> +{
> +	struct max8925_chip *chip = i2c_get_clientdata(client);
> +
> +	max8925_device_exit(chip);
> +	i2c_set_clientdata(client, NULL);
> +	kfree(chip);
> +	return 0;
> +}
> +
> +static struct i2c_driver max8925_driver = {
> +	.driver	= {
> +		.name	= "max8925",
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe		= max8925_probe,
> +	.remove		= __devexit_p(max8925_remove),
> +	.id_table	= max8925_id_table,
> +};
> +
> +static int __init max8925_i2c_init(void)
> +{
> +	int ret;
> +
> +	ret = i2c_add_driver(&max8925_driver);
> +	if (ret != 0)
> +		pr_err("Failed to register MAX8925 I2C driver: %d\n", ret);
> +	return ret;
> +}
> +subsys_initcall(max8925_i2c_init);
> +
> +static void __exit max8925_i2c_exit(void)
> +{
> +	i2c_del_driver(&max8925_driver);
> +}
> +module_exit(max8925_i2c_exit);
> +
> +MODULE_DESCRIPTION("I2C Driver for Maxim 8925");
> +MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/max8925.h b/include/linux/mfd/max8925.h
> new file mode 100644
> index 0000000..2326246
> --- /dev/null
> +++ b/include/linux/mfd/max8925.h
> @@ -0,0 +1,119 @@
> +/*
> + * Maxim8925 Interface
> + *
> + * Copyright (C) 2009 Marvell International Ltd.
> + *	Haojian Zhuang <haojian.zhuang@marvell.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __LINUX_MFD_MAX8925_H
> +#define __LINUX_MFD_MAX8925_H
> +
> +#include <linux/interrupt.h>
> +
> +/* Charger registers */
> +#define MAX8925_CHG_IRQ1		(0x7e)
> +#define MAX8925_CHG_IRQ2		(0x7f)
> +#define MAX8925_CHG_IRQ1_MASK		(0x80)
> +#define MAX8925_CHG_IRQ2_MASK		(0x81)
> +
> +/* GPM registers */
> +#define MAX8925_SYSENSEL		(0x00)
> +#define MAX8925_ON_OFF_IRQ1		(0x01)
> +#define MAX8925_ON_OFF_IRQ1_MASK	(0x02)
> +#define MAX8925_ON_OFF_STAT		(0x03)
> +#define MAX8925_ON_OFF_IRQ2		(0x0d)
> +#define MAX8925_ON_OFF_IRQ2_MASK	(0x0e)
> +#define MAX8925_RESET_CNFG		(0x0f)
> +
> +/* Touch registers */
> +#define MAX8925_TSC_IRQ			(0x00)
> +#define MAX8925_TSC_IRQ_MASK		(0x01)
> +
> +/* RTC registers */
> +#define MAX8925_RTC_STATUS		(0x1a)
> +#define MAX8925_RTC_IRQ			(0x1c)
> +#define MAX8925_RTC_IRQ_MASK		(0x1d)
> +
> +/* bit definitions */
> +#define CHG_IRQ1_MASK			(0x07)
> +#define CHG_IRQ2_MASK			(0xff)
> +#define ON_OFF_IRQ1_MASK		(0xff)
> +#define ON_OFF_IRQ2_MASK		(0x03)
> +#define TSC_IRQ_MASK			(0x03)
> +#define RTC_IRQ_MASK			(0x0c)
> +
> +#define MAX8925_NUM_IRQ			(32)
> +
> +#define MAX8925_NAME_SIZE		(32)
> +
> +enum {
> +	MAX8925_INVALID = 0,
> +	MAX8925_RTC,
> +	MAX8925_ADC,
> +	MAX8925_GPM,	/* general power management */
> +	MAX8925_MAX,
> +};
> +
> +#define MAX8925_IRQ_VCHG_OVP		(0)
> +#define MAX8925_IRQ_VCHG_F		(1)
> +#define MAX8925_IRQ_VCHG_R		(2)
> +#define MAX8925_IRQ_VCHG_THM_OK_R	(8)
> +#define MAX8925_IRQ_VCHG_THM_OK_F	(9)
> +#define MAX8925_IRQ_VCHG_BATTLOW_F	(10)
> +#define MAX8925_IRQ_VCHG_BATTLOW_R	(11)
> +#define MAX8925_IRQ_VCHG_RST		(12)
> +#define MAX8925_IRQ_VCHG_DONE		(13)
> +#define MAX8925_IRQ_VCHG_TOPOFF		(14)
> +#define MAX8925_IRQ_VCHG_TMR_FAULT	(15)
> +#define MAX8925_IRQ_GPM_RSTIN		(16)
> +#define MAX8925_IRQ_GPM_MPL		(17)
> +#define MAX8925_IRQ_GPM_SW_3SEC		(18)
> +#define MAX8925_IRQ_GPM_EXTON_F		(19)
> +#define MAX8925_IRQ_GPM_EXTON_R		(20)
> +#define MAX8925_IRQ_GPM_SW_1SEC		(21)
> +#define MAX8925_IRQ_GPM_SW_F		(22)
> +#define MAX8925_IRQ_GPM_SW_R		(23)
> +#define MAX8925_IRQ_GPM_SYSCKEN_F	(24)
> +#define MAX8925_IRQ_GPM_SYSCKEN_R	(25)
> +
> +#define MAX8925_IRQ_TSC_STICK		(0)
> +#define MAX8925_IRQ_TSC_NSTICK		(1)
> +
> +struct max8925_irq {
> +	irq_handler_t		handler;
> +	void			*data;
> +};
> +
> +struct max8925_chip {
> +	struct device		*dev;
> +	struct mutex		io_lock;
> +	struct mutex		irq_lock;
> +	struct i2c_client	*i2c;
> +	struct max8925_irq	irq[MAX8925_NUM_IRQ];
> +
> +	const char		*name;
> +	int			chip_id;
> +	int			chip_irq;
> +};
> +
> +struct max8925_platform_data {
> +	int	chip_id;
> +	int	chip_irq;
> +};
> +
> +extern int max8925_reg_read(struct i2c_client *, int);
> +extern int max8925_reg_write(struct i2c_client *, int, unsigned char);
> +extern int max8925_bulk_read(struct i2c_client *, int, int, unsigned char *);
> +extern int max8925_bulk_write(struct i2c_client *, int, int, unsigned char *);
> +extern int max8925_set_bits(struct i2c_client *, int, unsigned char,
> +			unsigned char);
> +
> +extern int max8925_device_init(struct max8925_chip *,
> +				struct max8925_platform_data *);
> +extern void max8925_device_exit(struct max8925_chip *);
> +#endif /* __LINUX_MFD_MAX8925_H */
> +
> -- 
> 1.5.6.5
> 

> From de0217875722a19c9ec07848d1edac155d14ce95 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Fri, 8 Jan 2010 12:43:29 -0500
> Subject: [PATCH] mfd: add subdevs in max8925
> 
> Add subdevs in MAX8925. MAX8925 includes regulator, backlight and touch
> components.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  drivers/mfd/Kconfig         |    1 +
>  drivers/mfd/max8925-core.c  |  142 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/max8925.h |   96 +++++++++++++++++++++++++++++
>  3 files changed, 239 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index a57e7ea..94e4d5e 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -187,6 +187,7 @@ config PMIC_ADP5520
>  config MFD_MAX8925
>  	tristate "Maxim Semiconductor MAX8925 PMIC Support"
>  	depends on I2C
> +	select MFD_CORE
>  	help
>  	  Say yes here to support for Maxim Semiconductor MAX8925. This is
>  	  a Power Management IC. This driver provies common support for
> diff --git a/drivers/mfd/max8925-core.c b/drivers/mfd/max8925-core.c
> index 3e26267..f36c494 100644
> --- a/drivers/mfd/max8925-core.c
> +++ b/drivers/mfd/max8925-core.c
> @@ -20,6 +20,109 @@
>  #define IRQ_MODE_STATUS		0
>  #define IRQ_MODE_MASK		1
>  
> +static struct resource backlight_resources[] = {
> +	{
> +		.name	= "max8925-backlight",
> +		.start	= MAX8925_WLED_MODE_CNTL,
> +		.end	= MAX8925_WLED_CNTL,
> +		.flags	= IORESOURCE_IO,
> +	},
> +};
> +
> +static struct mfd_cell backlight_devs[] = {
> +	{
> +		.name		= "max8925-backlight",
> +		.num_resources	= 1,
> +		.resources	= &backlight_resources[0],
> +		.id		= -1,
> +	},
> +};
> +
> +static struct resource touch_resources[] = {
> +	{
> +		.name	= "max8925-tsc",
> +		.start	= MAX8925_TSC_IRQ,
> +		.end	= MAX8925_ADC_RES_END,
> +		.flags	= IORESOURCE_IO,
> +	},
> +};
> +
> +static struct mfd_cell touch_devs[] = {
> +	{
> +		.name		= "max8925-touch",
> +		.num_resources	= 1,
> +		.resources	= &touch_resources[0],
> +		.id		= -1,
> +	},
> +};
> +
> +#define MAX8925_REG_RESOURCE(_start, _end)	\
> +{						\
> +	.start	= MAX8925_##_start,		\
> +	.end	= MAX8925_##_end,		\
> +	.flags	= IORESOURCE_IO,		\
> +}
> +
> +static struct resource regulator_resources[] = {
> +	MAX8925_REG_RESOURCE(SDCTL1, SDCTL1),
> +	MAX8925_REG_RESOURCE(SDCTL2, SDCTL2),
> +	MAX8925_REG_RESOURCE(SDCTL3, SDCTL3),
> +	MAX8925_REG_RESOURCE(LDOCTL1, LDOCTL1),
> +	MAX8925_REG_RESOURCE(LDOCTL2, LDOCTL2),
> +	MAX8925_REG_RESOURCE(LDOCTL3, LDOCTL3),
> +	MAX8925_REG_RESOURCE(LDOCTL4, LDOCTL4),
> +	MAX8925_REG_RESOURCE(LDOCTL5, LDOCTL5),
> +	MAX8925_REG_RESOURCE(LDOCTL6, LDOCTL6),
> +	MAX8925_REG_RESOURCE(LDOCTL7, LDOCTL7),
> +	MAX8925_REG_RESOURCE(LDOCTL8, LDOCTL8),
> +	MAX8925_REG_RESOURCE(LDOCTL9, LDOCTL9),
> +	MAX8925_REG_RESOURCE(LDOCTL10, LDOCTL10),
> +	MAX8925_REG_RESOURCE(LDOCTL11, LDOCTL11),
> +	MAX8925_REG_RESOURCE(LDOCTL12, LDOCTL12),
> +	MAX8925_REG_RESOURCE(LDOCTL13, LDOCTL13),
> +	MAX8925_REG_RESOURCE(LDOCTL14, LDOCTL14),
> +	MAX8925_REG_RESOURCE(LDOCTL15, LDOCTL15),
> +	MAX8925_REG_RESOURCE(LDOCTL16, LDOCTL16),
> +	MAX8925_REG_RESOURCE(LDOCTL17, LDOCTL17),
> +	MAX8925_REG_RESOURCE(LDOCTL18, LDOCTL18),
> +	MAX8925_REG_RESOURCE(LDOCTL19, LDOCTL19),
> +	MAX8925_REG_RESOURCE(LDOCTL20, LDOCTL20),
> +};
> +
> +#define MAX8925_REG_DEVS(_id)						\
> +{									\
> +	.name		= "max8925-regulator",				\
> +	.num_resources	= 1,						\
> +	.resources	= &regulator_resources[MAX8925_ID_##_id],	\
> +	.id		= MAX8925_ID_##_id,				\
> +}
> +
> +static struct mfd_cell regulator_devs[] = {
> +	MAX8925_REG_DEVS(SD1),
> +	MAX8925_REG_DEVS(SD2),
> +	MAX8925_REG_DEVS(SD3),
> +	MAX8925_REG_DEVS(LDO1),
> +	MAX8925_REG_DEVS(LDO2),
> +	MAX8925_REG_DEVS(LDO3),
> +	MAX8925_REG_DEVS(LDO4),
> +	MAX8925_REG_DEVS(LDO5),
> +	MAX8925_REG_DEVS(LDO6),
> +	MAX8925_REG_DEVS(LDO7),
> +	MAX8925_REG_DEVS(LDO8),
> +	MAX8925_REG_DEVS(LDO9),
> +	MAX8925_REG_DEVS(LDO10),
> +	MAX8925_REG_DEVS(LDO11),
> +	MAX8925_REG_DEVS(LDO12),
> +	MAX8925_REG_DEVS(LDO13),
> +	MAX8925_REG_DEVS(LDO14),
> +	MAX8925_REG_DEVS(LDO15),
> +	MAX8925_REG_DEVS(LDO16),
> +	MAX8925_REG_DEVS(LDO17),
> +	MAX8925_REG_DEVS(LDO18),
> +	MAX8925_REG_DEVS(LDO19),
> +	MAX8925_REG_DEVS(LDO20),
> +};
> +
>  static int __get_irq_offset(struct max8925_chip *chip, int irq, int mode,
>  			    int *offset, int *bit)
>  {
> @@ -210,6 +313,30 @@ static int __devinit device_gpm_init(struct max8925_chip *chip,
>  
>  	/* enable hard-reset for ONKEY power-off */
>  	max8925_set_bits(i2c, MAX8925_SYSENSEL, 0x80, 0x80);
> +
> +	ret = mfd_add_devices(chip->dev, 0, &regulator_devs[0],
> +			      ARRAY_SIZE(regulator_devs),
> +			      &regulator_resources[0], 0);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Failed to add regulator subdev\n");
> +		goto out_irq;
> +	}
> +
> +	if (pdata && pdata->backlight) {
> +		ret = mfd_add_devices(chip->dev, 0, &backlight_devs[0],
> +				      ARRAY_SIZE(backlight_devs),
> +				      &backlight_resources[0], 0);
> +		if (ret < 0) {
> +			dev_err(chip->dev, "Failed to add backlight subdev\n");
> +			goto out_dev;
> +		}
> +	}
> +	return 0;
> +out_dev:
> +	mfd_remove_devices(chip->dev);
> +out_irq:
> +	if (chip->chip_irq)
> +		free_irq(chip->chip_irq, chip);
>  out:
>  	return ret;
>  }
> @@ -233,6 +360,20 @@ static int __devinit device_adc_init(struct max8925_chip *chip,
>  		goto out;
>  	}
>  	chip->chip_irq = i2c->irq;
> +
> +	if (pdata && pdata->touch) {
> +		ret = mfd_add_devices(chip->dev, 0, &touch_devs[0],
> +				      ARRAY_SIZE(touch_devs),
> +				      &touch_resources[0], 0);
> +		if (ret < 0) {
> +			dev_err(chip->dev, "Failed to add touch subdev\n");
> +			goto out_irq;
> +		}
> +	}
> +	return 0;
> +out_irq:
> +	if (chip->chip_irq)
> +		free_irq(chip->chip_irq, chip);
>  out:
>  	return ret;
>  }
> @@ -255,6 +396,7 @@ void max8925_device_exit(struct max8925_chip *chip)
>  {
>  	if (chip->chip_irq >= 0)
>  		free_irq(chip->chip_irq, chip);
> +	mfd_remove_devices(chip->dev);
>  }
>  
>  MODULE_DESCRIPTION("PMIC Driver for Maxim MAX8925");
> diff --git a/include/linux/mfd/max8925.h b/include/linux/mfd/max8925.h
> index 2326246..b72dbe1 100644
> --- a/include/linux/mfd/max8925.h
> +++ b/include/linux/mfd/max8925.h
> @@ -14,6 +14,33 @@
>  
>  #include <linux/interrupt.h>
>  
> +/* Unified sub device IDs for MAX8925 */
> +enum {
> +	MAX8925_ID_SD1,
> +	MAX8925_ID_SD2,
> +	MAX8925_ID_SD3,
> +	MAX8925_ID_LDO1,
> +	MAX8925_ID_LDO2,
> +	MAX8925_ID_LDO3,
> +	MAX8925_ID_LDO4,
> +	MAX8925_ID_LDO5,
> +	MAX8925_ID_LDO6,
> +	MAX8925_ID_LDO7,
> +	MAX8925_ID_LDO8,
> +	MAX8925_ID_LDO9,
> +	MAX8925_ID_LDO10,
> +	MAX8925_ID_LDO11,
> +	MAX8925_ID_LDO12,
> +	MAX8925_ID_LDO13,
> +	MAX8925_ID_LDO14,
> +	MAX8925_ID_LDO15,
> +	MAX8925_ID_LDO16,
> +	MAX8925_ID_LDO17,
> +	MAX8925_ID_LDO18,
> +	MAX8925_ID_LDO19,
> +	MAX8925_ID_LDO20,
> +};
> +
>  /* Charger registers */
>  #define MAX8925_CHG_IRQ1		(0x7e)
>  #define MAX8925_CHG_IRQ2		(0x7f)
> @@ -32,12 +59,65 @@
>  /* Touch registers */
>  #define MAX8925_TSC_IRQ			(0x00)
>  #define MAX8925_TSC_IRQ_MASK		(0x01)
> +#define MAX8925_ADC_RES_END		(0x6f)
>  
>  /* RTC registers */
>  #define MAX8925_RTC_STATUS		(0x1a)
>  #define MAX8925_RTC_IRQ			(0x1c)
>  #define MAX8925_RTC_IRQ_MASK		(0x1d)
>  
> +/* WLED registers */
> +#define MAX8925_WLED_MODE_CNTL		(0x84)
> +#define MAX8925_WLED_CNTL		(0x85)
> +
> +/* MAX8925 Registers */
> +#define MAX8925_SDCTL1			(0x04)
> +#define MAX8925_SDCTL2			(0x07)
> +#define MAX8925_SDCTL3			(0x0A)
> +#define MAX8925_SDV1			(0x06)
> +#define MAX8925_SDV2			(0x09)
> +#define MAX8925_SDV3			(0x0C)
> +#define MAX8925_LDOCTL1			(0x18)
> +#define MAX8925_LDOCTL2			(0x1C)
> +#define MAX8925_LDOCTL3			(0x20)
> +#define MAX8925_LDOCTL4			(0x24)
> +#define MAX8925_LDOCTL5			(0x28)
> +#define MAX8925_LDOCTL6			(0x2C)
> +#define MAX8925_LDOCTL7			(0x30)
> +#define MAX8925_LDOCTL8			(0x34)
> +#define MAX8925_LDOCTL9			(0x38)
> +#define MAX8925_LDOCTL10		(0x3C)
> +#define MAX8925_LDOCTL11		(0x40)
> +#define MAX8925_LDOCTL12		(0x44)
> +#define MAX8925_LDOCTL13		(0x48)
> +#define MAX8925_LDOCTL14		(0x4C)
> +#define MAX8925_LDOCTL15		(0x50)
> +#define MAX8925_LDOCTL16		(0x10)
> +#define MAX8925_LDOCTL17		(0x14)
> +#define MAX8925_LDOCTL18		(0x72)
> +#define MAX8925_LDOCTL19		(0x5C)
> +#define MAX8925_LDOCTL20		(0x9C)
> +#define MAX8925_LDOVOUT1		(0x1A)
> +#define MAX8925_LDOVOUT2		(0x1E)
> +#define MAX8925_LDOVOUT3		(0x22)
> +#define MAX8925_LDOVOUT4		(0x26)
> +#define MAX8925_LDOVOUT5		(0x2A)
> +#define MAX8925_LDOVOUT6		(0x2E)
> +#define MAX8925_LDOVOUT7		(0x32)
> +#define MAX8925_LDOVOUT8		(0x36)
> +#define MAX8925_LDOVOUT9		(0x3A)
> +#define MAX8925_LDOVOUT10		(0x3E)
> +#define MAX8925_LDOVOUT11		(0x42)
> +#define MAX8925_LDOVOUT12		(0x46)
> +#define MAX8925_LDOVOUT13		(0x4A)
> +#define MAX8925_LDOVOUT14		(0x4E)
> +#define MAX8925_LDOVOUT15		(0x52)
> +#define MAX8925_LDOVOUT16		(0x12)
> +#define MAX8925_LDOVOUT17		(0x16)
> +#define MAX8925_LDOVOUT18		(0x74)
> +#define MAX8925_LDOVOUT19		(0x5E)
> +#define MAX8925_LDOVOUT20		(0x9E)
> +
>  /* bit definitions */
>  #define CHG_IRQ1_MASK			(0x07)
>  #define CHG_IRQ2_MASK			(0xff)
> @@ -83,6 +163,8 @@ enum {
>  #define MAX8925_IRQ_TSC_STICK		(0)
>  #define MAX8925_IRQ_TSC_NSTICK		(1)
>  
> +#define MAX8925_MAX_REGULATOR		(23)
> +
>  struct max8925_irq {
>  	irq_handler_t		handler;
>  	void			*data;
> @@ -100,7 +182,21 @@ struct max8925_chip {
>  	int			chip_irq;
>  };
>  
> +struct max8925_backlight_pdata {
> +	int	lxw_scl;	/* 0/1 -- 0.8Ohm/0.4Ohm */
> +	int	lxw_freq;	/* 700KHz ~ 1400KHz */
> +	int	dual_string;	/* 0/1 -- single/dual string */
> +};
> +
> +struct max8925_touch_pdata {
> +	unsigned int		flags;
> +};
> +
>  struct max8925_platform_data {
> +	struct max8925_backlight_pdata	*backlight;
> +	struct max8925_touch_pdata	*touch;
> +	struct regulator_init_data	*regulator[MAX8925_MAX_REGULATOR];
> +
>  	int	chip_id;
>  	int	chip_irq;
>  };
> -- 
> 1.5.6.5
> 


-- 
Intel Open Source Technology Centre
http://oss.intel.com/
