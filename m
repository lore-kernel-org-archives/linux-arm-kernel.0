From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 9 Nov 2011 19:19:48 +0100
Subject: [PATCH v3] ARM/mx35/3ds: gpio: add mc9s08dz60 gpio function
In-Reply-To: <4EBAA038.6010606@pengutronix.de>
References: <1320401551-21377-1-git-send-email-b39297@freescale.com>
 <4EBAA038.6010606@pengutronix.de>
Message-ID: <20111109181948.GO16886@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 09, 2011 at 04:46:00PM +0100, Marc Kleine-Budde wrote:
> On 11/04/2011 11:12 AM, wu guoxing wrote:
> > we only use the gpio function of mc9s08dz60 mcu chip, so just
> > add the gpio driver, as this mcu will never be used in other board.
> 
> see comments inline
> 
> Marc
> > 
> > Signed-off-by: Wu Guoxing <b39297@freescale.com>
> > ---
> > Changes since v1:
> > 	1. add can_sleep = 1
> > 	2. removed some useless return checks and local variable
> > 	3. removed the static variable for i2c client.
> > 	4. make init&exit function static
> > 
> >  drivers/gpio/Kconfig           |    6 ++
> >  drivers/gpio/Makefile          |    1 +
> >  drivers/gpio/gpio-mc9s08dz60.c |  167 ++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 174 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/gpio/gpio-mc9s08dz60.c
> > 
> > diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> > index d539efd..7f6beee 100644
> > --- a/drivers/gpio/Kconfig
> > +++ b/drivers/gpio/Kconfig
> > @@ -487,4 +487,10 @@ config GPIO_TPS65910
> >  	help
> >  	  Select this option to enable GPIO driver for the TPS65910
> >  	  chip family.
> > +
> > +config GPIO_MC9S08DZ60
> > +	bool "MX35 3DS BOARD MC9S08DZ60 GPIO functions"
> > +	depends on I2C && MACH_MX35_3DS
> > +	help
> > +	  Select this to enable the MC9S08DZ60 GPIO driver
> >  endif
> > diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> > index 9588948..85b8799 100644
> > --- a/drivers/gpio/Makefile
> > +++ b/drivers/gpio/Makefile
> > @@ -60,3 +60,4 @@ obj-$(CONFIG_GPIO_WM831X)	+= gpio-wm831x.o
> >  obj-$(CONFIG_GPIO_WM8350)	+= gpio-wm8350.o
> >  obj-$(CONFIG_GPIO_WM8994)	+= gpio-wm8994.o
> >  obj-$(CONFIG_GPIO_XILINX)	+= gpio-xilinx.o
> > +obj-$(CONFIG_GPIO_MC9S08DZ60) += gpio-mc9s08dz60.o
> > diff --git a/drivers/gpio/gpio-mc9s08dz60.c b/drivers/gpio/gpio-mc9s08dz60.c
> > new file mode 100644
> > index 0000000..c41eb16
> > --- /dev/null
> > +++ b/drivers/gpio/gpio-mc9s08dz60.c
> > @@ -0,0 +1,167 @@
> > +/*
> > + * Copyright 2009-2011 Freescale Semiconductor, Inc. All Rightos Reserved.
> > + *
> > + * Author: Wu Guoxing <b39297@freescale.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <linux/i2c.h>
> > +#include <linux/gpio.h>
> > +
> > +#define GPIO_GROUP_NUM 2
> > +#define GPIO_NUM_PER_GROUP 8
> > +#define GPIO_NUM (GPIO_GROUP_NUM*GPIO_NUM_PER_GROUP)
> > +
> > +struct mc9s08dz60 {
> > +	struct i2c_client *client;
> > +	struct gpio_chip chip;
> > +};
> > +
> > +static struct mc9s08dz60 *to_mc9s08dz60(struct gpio_chip *gc)
> > +{
> > +	return container_of(gc, struct mc9s08dz60, chip);
> > +}
> > +
> > +
> > +static void gpio_to_reg_and_bit(int offset, u8 *reg, u8 *bit)
> > +{
> > +	*reg = 0x20 + offset / GPIO_NUM_PER_GROUP;
> > +	*bit = offset % GPIO_NUM_PER_GROUP;
> > +}
> > +
> > +static int mc9s08dz60_get_value(struct gpio_chip *gc, unsigned offset)
> > +{
> > +	int ret = 0;
> > +	u8 reg, bit;
> > +	s32 value;
> > +	struct mc9s08dz60 *mc9s = to_mc9s08dz60(gc);
> > +
> > +	gpio_to_reg_and_bit(offset, &reg, &bit);
> > +	value = i2c_smbus_read_byte_data(mc9s->client, reg);
> > +	if (value >= 0)
> > +		ret = (value >> bit) & 0x1;
> > +
> > +	return ret;
> > +}
> > +
> > +static void mc9s08dz60_set_value(struct gpio_chip *gc, unsigned offset, int val)
> > +{
> > +	u8 reg, bit;
> > +	s32 value;
> > +	struct mc9s08dz60 *mc9s = to_mc9s08dz60(gc);
> > +
> > +	gpio_to_reg_and_bit(offset, &reg, &bit);
> > +	value = i2c_smbus_read_byte_data(mc9s->client, reg);
> > +	if (value >= 0) {
> > +		if (val)
> > +			value |= 1 << bit;
> > +		else
> > +			value &= ~(1 << bit);
> > +
> > +		i2c_smbus_write_byte_data(mc9s->client, reg, value);
> > +	}
> 
> what about propagating potential error values here?

This is a void function.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
