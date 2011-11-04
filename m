From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 4 Nov 2011 10:26:02 +0100
Subject: [PATCH] ARM/mx35/3ds: gpio: add mc9s08dz60 gpio function
In-Reply-To: <1320381143-28621-1-git-send-email-b39297@freescale.com>
References: <1320381143-28621-1-git-send-email-b39297@freescale.com>
Message-ID: <20111104092602.GK16886@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2011 at 12:32:23PM +0800, wu guoxing wrote:
> we only use the gpio function of mc9s08dz60 mcu chip, so just
> add the gpio driver, as this mcu will never be used in other board.
> 
> Signed-off-by: Wu Guoxing <b39297@freescale.com>
> ---
>  drivers/gpio/Kconfig           |    6 ++
>  drivers/gpio/Makefile          |    1 +
>  drivers/gpio/gpio-mc9s08dz60.c |  169 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 176 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/gpio/gpio-mc9s08dz60.c
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index d539efd..7f6beee 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -487,4 +487,10 @@ config GPIO_TPS65910
>  	help
>  	  Select this option to enable GPIO driver for the TPS65910
>  	  chip family.
> +
> +config GPIO_MC9S08DZ60
> +	bool "MX35 3DS BOARD MC9S08DZ60 GPIO functions"
> +	depends on I2C && MACH_MX35_3DS
> +	help
> +	  Select this to enable the MC9S08DZ60 GPIO driver
>  endif
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 9588948..85b8799 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -60,3 +60,4 @@ obj-$(CONFIG_GPIO_WM831X)	+= gpio-wm831x.o
>  obj-$(CONFIG_GPIO_WM8350)	+= gpio-wm8350.o
>  obj-$(CONFIG_GPIO_WM8994)	+= gpio-wm8994.o
>  obj-$(CONFIG_GPIO_XILINX)	+= gpio-xilinx.o
> +obj-$(CONFIG_GPIO_MC9S08DZ60) += gpio-mc9s08dz60.o
> diff --git a/drivers/gpio/gpio-mc9s08dz60.c b/drivers/gpio/gpio-mc9s08dz60.c
> new file mode 100644
> index 0000000..9c87e06
> --- /dev/null
> +++ b/drivers/gpio/gpio-mc9s08dz60.c
> @@ -0,0 +1,169 @@
> +/*
> + * Copyright 2009-2011 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * Author: Wu Guoxing <b39297@freescale.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/gpio.h>
> +
> +#define GPIO_GROUP_NUM 2
> +#define GPIO_NUM_PER_GROUP 8
> +#define GPIO_NUM (GPIO_GROUP_NUM*GPIO_NUM_PER_GROUP)
> +
> +static struct i2c_client *mc9s08dz60_client;

No. Please don't make this driver single instance only. Instead, create
a driver private struct, embed the gpio_chip in it and access your i2c
client using container_of().

> +
> +static int gpio_to_reg_and_bit(int offset, u8 *reg, u8 *bit)
> +{
> +	u8 ret = 0;
> +	if (offset >= GPIO_NUM)
> +		ret = -1;

You don't have to check this here. gpiolib will never call you with
offset >= GPIO_NUM.

> +	else {
> +		*reg = 0x20 + offset / GPIO_NUM_PER_GROUP;
> +		*bit = offset % GPIO_NUM_PER_GROUP;
> +	}
> +
> +	return ret;
> +}
> +
> +static int mc9s08dz60_get_value(struct gpio_chip *gc, unsigned offset)
> +{
> +	int ret = 0;
> +	u8 reg, bit;
> +	s32 value;
> +
> +	if (!gpio_to_reg_and_bit(offset, &reg, &bit)) {
> +		value = i2c_smbus_read_byte_data(mc9s08dz60_client, reg);
> +		if (value >= 0)
> +			ret = (value >> bit) & 0x1;
> +	}
> +
> +	return ret;
> +}
> +
> +static void mc9s08dz60_set_value(struct gpio_chip *gc, unsigned offset, int val)
> +{
> +	u8 reg, bit;
> +	s32 value;
> +
> +	if (!gpio_to_reg_and_bit(offset, &reg, &bit)) {
> +		value = i2c_smbus_read_byte_data(mc9s08dz60_client, reg);
> +		if (value >= 0) {
> +			if (val)
> +				value |= 1 << bit;
> +			else
> +				value &= ~(1 << bit);
> +
> +			i2c_smbus_write_byte_data(mc9s08dz60_client, reg,
> +						  value);
> +		}
> +	}
> +}
> +
> +static int mc9s08dz60_direction_output(struct gpio_chip *gc,
> +				       unsigned offset, int val)
> +{
> +	mc9s08dz60_set_value(gc, offset, val);
> +	return 0;
> +}
> +
> +static int mc9s08dz60_probe(struct i2c_client *client,
> +			    const struct i2c_device_id *id)
> +{
> +	int ret = 0;
> +	struct gpio_chip *chip;
> +
> +	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	chip->label = client->name;
> +	chip->base = -1;
> +	chip->dev = &client->dev;
> +	chip->owner = THIS_MODULE;
> +	chip->ngpio = GPIO_NUM;
> +	chip->get = mc9s08dz60_get_value;
> +	chip->set = mc9s08dz60_set_value;
> +	chip->direction_output = mc9s08dz60_direction_output;

chip->can_sleep should be set to 1.

> +
> +	ret = gpiochip_add(chip);
> +	if (ret)
> +		goto error;
> +
> +	i2c_set_clientdata(client, chip);
> +	mc9s08dz60_client = client;
> +
> +	return 0;
> +
> +error:
> +	kfree(chip);
> +	return ret;
> +}
> +
> +static int mc9s08dz60_remove(struct i2c_client *client)
> +{
> +	struct gpio_chip *chip;
> +	int ret;
> +
> +	chip = i2c_get_clientdata(client);
> +	if (chip == NULL)
> +		return -ENODEV;
> +
> +	i2c_set_clientdata(client, NULL);
> +
> +	ret = gpiochip_remove(chip);
> +	if (!ret)
> +		kfree(chip);
> +
> +	return ret;
> +}
> +
> +static const struct i2c_device_id mc9s08dz60_id[] = {
> +	{"mc9s08dz60", 0},
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, mc9s08dz60_id);
> +
> +static struct i2c_driver mc9s08dz60_i2c_driver = {
> +	.driver = {.owner = THIS_MODULE,
> +		   .name = "mc9s08dz60",
> +		   },
> +	.probe = mc9s08dz60_probe,
> +	.remove = mc9s08dz60_remove,
> +	.id_table = mc9s08dz60_id,
> +};
> +
> +int __init mc9s08dz60_init(void)

static

> +{
> +	int err;
> +
> +	err = i2c_add_driver(&mc9s08dz60_i2c_driver);
> +	return err;
> +}
> +
> +void __exit mc9s08dz60_exit(void)

ditto

> +{
> +	i2c_del_driver(&mc9s08dz60_i2c_driver);
> +}
> +
> +module_init(mc9s08dz60_init);
> +module_exit(mc9s08dz60_exit);
> +
> +MODULE_AUTHOR("Freescale Semiconductor, Inc."
> +		"Wu Guoxing <b39297@freescale.com>");
> +MODULE_DESCRIPTION("mc9s08dz60 gpio function on mx35 3ds board");
> +MODULE_LICENSE("GPL v2");
> -- 
> 1.7.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
