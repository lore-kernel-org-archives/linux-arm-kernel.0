From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 4 Jul 2012 15:27:13 +0000
Subject: [PATCH 1/4] mfd: support 88pm80x in 80x driver
In-Reply-To: <B2A7C617B3AB7F44B7B44C7D374B431E13A09E8DEE@sc-vexch3.marvell.com>
References: <1341392115-9425-1-git-send-email-zhouqiao@marvell.com>
 <201207041137.49020.arnd@arndb.de>
 <B2A7C617B3AB7F44B7B44C7D374B431E13A09E8DEE@sc-vexch3.marvell.com>
Message-ID: <201207041527.13954.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 July 2012, Qiao Zhou wrote:
> >> +	ret = mfd_add_devices(chip->dev, 0, &onkey_devs[0],
> >> +			      ARRAY_SIZE(onkey_devs), &onkey_resources[0],
> >> +			      chip->irq_base);
> >
> >According to what I discussed with Mark in the previous version, I think you
> >need to pass 0 instead of chip->irq_base here, and transform the interrupt
> >numbers using the domain in the client drivers.
> >
> >> +
> >> +const struct i2c_device_id pm80x_id_table[] = {
> >> +	{"88PM800", CHIP_PM800},
> >> +	{"88PM805", CHIP_PM805},
> >> +};
> >> +MODULE_DEVICE_TABLE(i2c, pm80x_id_table);
> >
> >Since these are separate modules now, you have to move the device table
> >into the split files as well.
> Is it ok to export it in 88pm80x.h?

You mean putting the MODULE_DEVICE_TABLE() into 88pm80x.h? No, that would
not work.

The correct way is to have two MODULE_DEVICE_TABLE statements, one per file.
Actually the table only makes sense for loadable modules, so if you decide
to keep the driver only built-in, it's best to just drop this table.

> >> +
> >> +/**
> >> + * pm80x_reg_read: Read a single 88PM80x register.
> >> + *
> >> + * @map: regmap to read from.
> >> + * @reg: Register to read.
> >> + */
> >> +int pm80x_reg_read(struct regmap *map, u32 reg)
> >> +{
> >> +	unsigned int val;
> >> +	int ret;
> >> +
> >> +	ret = regmap_read(map, reg, &val);
> >> +
> >> +	if (ret < 0)
> >> +		return ret;
> >> +	else
> >> +		return val;
> >> +}
> >> +EXPORT_SYMBOL_GPL(pm80x_reg_read);
> >
> >In your introductory email you write
> >
> >"Exported r/w API which requires regmap handle. as currently the pm800
> >chip has 3 i2c device, only passing a pm80x_chip info can't ensure r/w the
> >register in correct i2c device."
> >
> >Your first driver version had this, then you removed the functions
> >after I asked you to, and now they are back, so I assume there is something
> >I don't see yet. It looks like the function is just an unnecessary wrapper
> >that is better open-coded in the caller. Can you explain again what the
> >difference is?
>
> After you suggest to change the r/w API so that caller doesn't care about it's
> via i2c or spi, it makes sense. However due to pm800 has 3 i2c devices, and
> it's hard to export such interface for pm800. Currently to add such interface
> via regmap handle, caller still doesn't care about the actual hw implement,
> also it's clear that all pm80x sub-driver or plat call the unified r/w API.

But there is nothing unified about the function above, it just calls
regmap_read(), so the caller already has access to the regmap pointer.

> >> +/**
> >> + * pm80x_bulk_read: Read multiple 88PM80x registers
> >> + *
> >> + * @map: regmap to read from
> >> + * @reg: First register
> >> + * @buf: Buffer to fill.  The data will be returned big endian.
> >> + * @count: Number of registers
> >> + */
> >> +int pm80x_bulk_read(struct regmap *map, u32 reg, u8 *buf, int count)
> >> +{
> >> +	return regmap_raw_read(map, reg, buf, count);
> >> +}
> >
> >Unused function? Either export this if you want to provide it as
> >the general API, or drop the function.
> It's used by rtc driver.

Then it needs to be exported, so the rtc driver can be a module.


> >
> >I would still argue that the majority of the constants in this file
> >should get moved into the driver .c file that uses them. Putting them
> >into the header is better done only for interfaces between the
> >driver parts, and for constants that are used by multiple drivers.
>
> These registers still in this header file are either used by mfd core
> driver, regulator/rtc/onkey/codec, or used in platform initial setting.

Exactly. All the values that are only used by the core driver should be
part of the core driver (or a local header in the mfd directory if they
need to be shared between multiple files). The platform code should not
really touch the registers, but only things like the platform_data
structure, which indeed belongs into the global header.

> >> +struct pm80x_subchip {
> >> +	struct i2c_client *power_page;	/* chip client for power page */
> >> +	struct i2c_client *gpadc_page;	/* chip client for gpadc page */
> >> +	struct regmap *regmap_power;
> >> +	struct regmap *regmap_gpadc;
> >> +	unsigned short power_page_addr;	/* power page I2C address */
> >> +	unsigned short gpadc_page_addr;	/* gpadc page I2C address */
> >> +};
> >> +
> >> +struct pm80x_chip {
> >> +	struct pm80x_subchip *subchip;
> >> +	struct device *dev;
> >> +	struct i2c_client *client;
> >> +	struct regmap *regmap;
> >> +	struct regmap_irq_chip *regmap_irq_chip;
> >> +	struct regmap_irq_chip_data *irq_data;
> >> +	unsigned char version;
> >> +	int id;
> >> +	int irq;
> >> +	int irq_mode;
> >> +	int irq_base;
> >> +	unsigned int wu_flag;
> >> +};
> >
> >One thing I forgot to ask in the previous review although I had already
> >noticed it then: What is the separation of pm80x_chip and pm80x_subchip
> >used for?
> Pm80x_chip is common for both pm800 and pm805, while pm80x_subchip
> handles the other i2c devices as discussed before, only that these two
> i2c devices are not as much as pm800 and pm805 i2c device, and they are
> only for gpadc & power settings purpose. The subchip can be treated as
> some special feature/function for pm800.

ok

> >> +struct pm80x_rtc_pdata {
> >> +	int		vrtc;
> >> +	int		rtc_wakeup;
> >> +};
> >> +
> >> +struct pm80x_platform_data {
> >> +	struct pm80x_rtc_pdata *rtc;
> >> +	unsigned short pm800_addr;
> >> +	unsigned short pm805_addr;
> >> +	unsigned short power_page_addr;	/* power page I2C address */
> >> +	unsigned short gpadc_page_addr;	/* gpadc page I2C address */
> >> +	int irq_mode;		/* Clear interrupt by read/write(0/1) */
> >> +	int irq_base;		/* IRQ base of chip */
> >> +	int batt_det;		/* enable/disable */
> >> +};
> >
> >You removed the callback here as I asked you to, which I think is a useful
> >cleanup, but you can actually managed to convinced me that it would be ok
> >to have it, so I don't mind if you want to put it back and use auxdata.
> Actually it's convenient for us to put it back currently, and would use
> auxdata instead.

ok

> >On the other hand, I think it probably makes sense to drop the irq_base
> >member in this struct and rely on irq domains to allocate them dynamically
> >as mentioned before.
> Do you mean that both regmap_add_irq_chip and mfd_add_devices api pass -1 as
> the irq_base, so that system can dynamically allocate the irq_base for it?

regmap_add_irq_chip should pass -1, mfd_add_devices should pass 0.
Mark can probably correct me if that's wrong.

> Given the proper regmap_irq_chip & device resource, is there anything else
> needed? As I don't want to miss the exact meaning of " transform the
> interrupt numbers using the domain in the client drivers" you mentioned above.

The drivers using the numbers need to call regmap_irq_get_virq() to get the
real interrupt number. See include/linux/mfd/wm8994/core.h for an example.

	Arnd
