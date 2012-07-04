From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 4 Jul 2012 11:37:48 +0000
Subject: [PATCH 1/4] mfd: support 88pm80x in 80x driver
In-Reply-To: <1341392115-9425-2-git-send-email-zhouqiao@marvell.com>
References: <1341392115-9425-1-git-send-email-zhouqiao@marvell.com>
 <1341392115-9425-2-git-send-email-zhouqiao@marvell.com>
Message-ID: <201207041137.49020.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 July 2012, Qiao Zhou wrote:
> 88PM800 and 88PM805 are two discrete chips used for power management.
> Hardware designer can use them together or only one of them according
> to requirement.
> 
> 88pm80x_i2c.c provides common i2c driver handling for both 800 and
> 805, such as i2c_driver init, regmap init, read/write api etc.
> 
> 88pm800_core.c handles specifically for 800, such as chip init, irq
> init/handle, mfd device register, including rtc, onkey, regulator(
> to be add later) etc. besides that, 800 has three i2c device, one
> regular i2c client, two other i2c dummy for gpadc and power purpose.
> 
> 88pm805_core.c handles specifically for 805, such as chip init, irq
> init/handle, mfd device register, including codec, headset/mic detect
> etc.
> 
> the i2c operation of both 800 and 805 are via regmap.
> 
> Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>

The split between the two files looks very good now, I think this way
it makes much more sense for the reader.


> +	ret = mfd_add_devices(chip->dev, 0, &onkey_devs[0],
> +			      ARRAY_SIZE(onkey_devs), &onkey_resources[0],
> +			      chip->irq_base);

According to what I discussed with Mark in the previous version, I think you
need to pass 0 instead of chip->irq_base here, and transform the interrupt
numbers using the domain in the client drivers.

> +
> +const struct i2c_device_id pm80x_id_table[] = {
> +	{"88PM800", CHIP_PM800},
> +	{"88PM805", CHIP_PM805},
> +};
> +MODULE_DEVICE_TABLE(i2c, pm80x_id_table);

Since these are separate modules now, you have to move the device table
into the split files as well.

> +
> +/**
> + * pm80x_reg_read: Read a single 88PM80x register.
> + *
> + * @map: regmap to read from.
> + * @reg: Register to read.
> + */
> +int pm80x_reg_read(struct regmap *map, u32 reg)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(map, reg, &val);
> +
> +	if (ret < 0)
> +		return ret;
> +	else
> +		return val;
> +}
> +EXPORT_SYMBOL_GPL(pm80x_reg_read);

In your introductory email you write

"Exported r/w API which requires regmap handle. as currently the pm800
chip has 3 i2c device, only passing a pm80x_chip info can't ensure r/w the
register in correct i2c device."

Your first driver version had this, then you removed the functions
after I asked you to, and now they are back, so I assume there is something
I don't see yet. It looks like the function is just an unnecessary wrapper
that is better open-coded in the caller. Can you explain again what the
difference is?

> +/**
> + * pm80x_bulk_read: Read multiple 88PM80x registers
> + *
> + * @map: regmap to read from
> + * @reg: First register
> + * @buf: Buffer to fill.  The data will be returned big endian.
> + * @count: Number of registers
> + */
> +int pm80x_bulk_read(struct regmap *map, u32 reg, u8 *buf, int count)
> +{
> +	return regmap_raw_read(map, reg, buf, count);
> +}

Unused function? Either export this if you want to provide it as
the general API, or drop the function.

> +int __devinit pm80x_device_init(struct pm80x_chip *chip,
> +				struct pm80x_platform_data *pdata)

> +void __devexit pm80x_device_exit(struct pm80x_chip *chip)

> +SIMPLE_DEV_PM_OPS(pm80x_pm_ops, pm80x_suspend, pm80x_resume);

I would think that these need to be exported as well, at least if
you want the driver to be modular.

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index e129c82..96dd2d7 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -20,6 +20,18 @@ config MFD_88PM860X
>  	  select individual components like voltage regulators, RTC and
>  	  battery-charger under the corresponding menus.
>  
> +config MFD_88PM80X
> +	bool "Support Marvell 88PM800/88PM805"
> +	depends on I2C=y && GENERIC_HARDIRQS
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	select MFD_CORE
> +	help
> +	  This supports for Marvell 88PM800/88PM805 Power Management IC.
> +	  This includes the I2C driver and the core APIs _only_, you have to
> +	  select individual components like voltage regulators, RTC and
> +	  battery-charger under the corresponding menus.
> +
>  config MFD_SM501
>  	tristate "Support for Silicon Motion SM501"
>  	 ---help---
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 75f6ed6..dc2584e 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -3,7 +3,9 @@
>  #
>  
>  88pm860x-objs			:= 88pm860x-core.o 88pm860x-i2c.o
> +88pm80x-objs			:= 88pm800-core.o 88pm805-core.o 88pm80x-i2c.o
>  obj-$(CONFIG_MFD_88PM860X)	+= 88pm860x.o
> +obj-$(CONFIG_MFD_88PM80X)	+= 88pm80x.o
>  obj-$(CONFIG_MFD_SM501)		+= sm501.o
>  obj-$(CONFIG_MFD_ASIC3)		+= asic3.o tmio_core.o

I just noticed that it can currently only be builtin. Is there a strict
requirement for that? If not, better make it a tristate option.

If you do that, aside from adding the exports mentioned above, you have
to use three separate modules, as in

obj-$(CONFIG_MFD_88PM80X)	+= 88pm800-core.o 88pm805-core.o 88pm80x-i2c.o

or even

obj-$(CONFIG_MFD_88PM800)	+= 88pm800-core.o 88pm800-core.o
obj-$(CONFIG_MFD_88PM805)	+= 88pm800-core.o 88pm805-core.o

with the respective Kconfig change.

> diff --git a/include/linux/mfd/88pm80x.h b/include/linux/mfd/88pm80x.h
> new file mode 100644
> index 0000000..115348a
> --- /dev/null
> +++ b/include/linux/mfd/88pm80x.h
> @@ -0,0 +1,521 @@
> +#ifndef __LINUX_MFD_88PM80X_H
> +#define __LINUX_MFD_88PM80X_H
> +
> +#define PM80X_VERSION_MASK		(0xFF)	/* 80X chip ID mask */
> +
> +enum {
> +	/* Procida */
> +	PM800_CHIP_A0  = 0x60,
> +	PM800_CHIP_A1  = 0x61,
> +	PM800_CHIP_B0  = 0x62,
> +	PM800_CHIP_C0  = 0x63,
> +	PM800_CHIP_END = PM800_CHIP_C0,
> +
> +	/* Make sure to update this to the last stepping */
> +	PM8XXX_CHIP_END = PM800_CHIP_END
> +};
> +
> +enum {
> +	PM800_ID_INVALID,
> +	PM800_ID_VIBRATOR,
> +	PM800_ID_SOUND,
> +	PM800_ID_MAX,
> +};
> +
> +enum {
> +	PM800_ID_BUCK1 = 0,
> +	PM800_ID_BUCK2,
> +	PM800_ID_BUCK3,
> +	PM800_ID_BUCK4,
> +	PM800_ID_BUCK5,

I would still argue that the majority of the constants in this file
should get moved into the driver .c file that uses them. Putting them
into the header is better done only for interfaces between the
driver parts, and for constants that are used by multiple drivers.

> +struct pm80x_subchip {
> +	struct i2c_client *power_page;	/* chip client for power page */
> +	struct i2c_client *gpadc_page;	/* chip client for gpadc page */
> +	struct regmap *regmap_power;
> +	struct regmap *regmap_gpadc;
> +	unsigned short power_page_addr;	/* power page I2C address */
> +	unsigned short gpadc_page_addr;	/* gpadc page I2C address */
> +};
> +
> +struct pm80x_chip {
> +	struct pm80x_subchip *subchip;
> +	struct device *dev;
> +	struct i2c_client *client;
> +	struct regmap *regmap;
> +	struct regmap_irq_chip *regmap_irq_chip;
> +	struct regmap_irq_chip_data *irq_data;
> +	unsigned char version;
> +	int id;
> +	int irq;
> +	int irq_mode;
> +	int irq_base;
> +	unsigned int wu_flag;
> +};

One thing I forgot to ask in the previous review although I had already
noticed it then: What is the separation of pm80x_chip and pm80x_subchip
used for?

> +struct pm80x_rtc_pdata {
> +	int		vrtc;
> +	int		rtc_wakeup;
> +};
> +
> +struct pm80x_platform_data {
> +	struct pm80x_rtc_pdata *rtc;
> +	unsigned short pm800_addr;
> +	unsigned short pm805_addr;
> +	unsigned short power_page_addr;	/* power page I2C address */
> +	unsigned short gpadc_page_addr;	/* gpadc page I2C address */
> +	int irq_mode;		/* Clear interrupt by read/write(0/1) */
> +	int irq_base;		/* IRQ base of chip */
> +	int batt_det;		/* enable/disable */
> +};

You removed the callback here as I asked you to, which I think is a useful
cleanup, but you can actually managed to convinced me that it would be ok
to have it, so I don't mind if you want to put it back and use auxdata.

On the other hand, I think it probably makes sense to drop the irq_base
member in this struct and rely on irq domains to allocate them dynamically
as mentioned before.

	Arnd
