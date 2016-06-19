From: stefan@agner.ch (Stefan Agner)
Date: Sat, 18 Jun 2016 17:57:23 -0700
Subject: [PATCH v2 2/5] mfd: add Ricoh RN5T567 PMIC support
In-Reply-To: <20160616145558.GB4948@dell>
References: <20160608010429.19618-1-stefan@agner.ch>
 <20160608010429.19618-3-stefan@agner.ch> <20160616145558.GB4948@dell>
Message-ID: <b7fdeb7bc1c66424d00a5ed12439687d@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-06-16 07:55, Lee Jones wrote:
> On Tue, 07 Jun 2016, Stefan Agner wrote:
> 
>> The Ricoh RN5T567 is from the same family as the Ricoh RN5T618 is,
>> the differences are:
>>
>> + DCDC4
>> + Slightly different output voltage/currents
>> + 32kHz Output
>> - ADC/Charger capabilities
>>
>> Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  Documentation/devicetree/bindings/mfd/rn5t618.txt | 19 ++++++++++-------
>>  drivers/mfd/Kconfig                               |  7 +++---
>>  drivers/mfd/rn5t618.c                             | 26 +++++++++++++++++------
>>  include/linux/mfd/rn5t618.h                       | 12 +++++++++++
>>  4 files changed, 46 insertions(+), 18 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/rn5t618.txt b/Documentation/devicetree/bindings/mfd/rn5t618.txt
>> index 937785a..5b493ed 100644
>> --- a/Documentation/devicetree/bindings/mfd/rn5t618.txt
>> +++ b/Documentation/devicetree/bindings/mfd/rn5t618.txt
>> @@ -1,18 +1,21 @@
>> -* Ricoh RN5T618 PMIC
>> +* Ricoh RN5T567/RN5T618 PMIC
>>
>> -Ricoh RN5T618 is a power management IC which integrates 3 step-down
>> -DCDC converters, 7 low-dropout regulators, a Li-ion battery charger,
>> -fuel gauge, ADC, GPIOs and a watchdog timer. It can be controlled
>> -through a I2C interface.
>> +Ricoh RN5T567/RN5T618 is a power management IC family which integrates
>> +3 to 5 step-down DCDC converters, 7 low-dropout regulators, GPIOs and
>> +a watchdog timer. The RN5T618 provides additionally a Li-ion battery
>> +charger, fuel gauge and an ADC. It can be controlled through a I2C
> 
> Nit: s/a I2C/an I2C/
> 
>> +interface.
>>
>>  Required properties:
>> - - compatible: should be "ricoh,rn5t618"
>> + - compatible: must be one of
>> +		"ricoh,rn5t567"
>> +		"ricoh,rn5t618"
>>   - reg: the I2C slave address of the device
>>
>>  Sub-nodes:
>>   - regulators: the node is required if the regulator functionality is
>> -   needed. The valid regulator names are: DCDC1, DCDC2, DCDC3, LDO1,
>> -   LDO2, LDO3, LDO4, LDO5, LDORTC1 and LDORTC2.
>> +   needed. The valid regulator names are: DCDC1, DCDC2, DCDC3, DCDC4
>> +   (RN5T567), LDO1, LDO2, LDO3, LDO4, LDO5, LDORTC1 and LDORTC2.
>>     The common bindings for each individual regulator can be found in:
>>     Documentation/devicetree/bindings/regulator/regulator.txt
>>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index 1bcf601..ff031a7 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -852,13 +852,14 @@ config MFD_RK808
>>  	  including interrupts, RTC, LDO & DCDC regulators, and onkey.
>>
>>  config MFD_RN5T618
>> -	tristate "Ricoh RN5T5618 PMIC"
>> +	tristate "Ricoh RN5T567/618 PMIC"
>>  	depends on I2C
>> +	depends on OF
>>  	select MFD_CORE
>>  	select REGMAP_I2C
>>  	help
>> -	  Say yes here to add support for the Ricoh RN5T618 PMIC. This
>> -	  driver provides common support for accessing the device,
>> +	  Say yes here to add support for the Ricoh RN5T567 or R5T618 PMIC.
>> +	  This driver provides common support for accessing the device,
>>  	  additional drivers must be enabled in order to use the
>>  	  functionality of the device.
>>
>> diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
>> index 0ad51d7..7607ced 100644
>> --- a/drivers/mfd/rn5t618.c
>> +++ b/drivers/mfd/rn5t618.c
>> @@ -2,6 +2,7 @@
>>   * MFD core driver for Ricoh RN5T618 PMIC
>>   *
>>   * Copyright (C) 2014 Beniamino Galvani <b.galvani@gmail.com>
>> + * Copyright (C) 2016 Toradex AG
>>   *
>>   * This program is free software; you can redistribute it and/or
>>   * modify it under the terms of the GNU General Public License
>> @@ -15,6 +16,7 @@
>>  #include <linux/mfd/core.h>
>>  #include <linux/mfd/rn5t618.h>
>>  #include <linux/module.h>
>> +#include <linux/of_device.h>
>>  #include <linux/regmap.h>
>>
>>  static const struct mfd_cell rn5t618_cells[] = {
>> @@ -59,12 +61,26 @@ static void rn5t618_power_off(void)
>>  			   RN5T618_SLPCNT_SWPWROFF, RN5T618_SLPCNT_SWPWROFF);
>>  }
>>
>> +static const struct of_device_id rn5t618_of_match[] = {
>> +	{ .compatible = "ricoh,rn5t567", .data = (void *)RN5T567 },
>> +	{ .compatible = "ricoh,rn5t618", .data = (void *)RN5T618 },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, rn5t618_of_match);
>> +
>>  static int rn5t618_i2c_probe(struct i2c_client *i2c,
>>  			     const struct i2c_device_id *id)
>>  {
>> +	const struct of_device_id *of_id =
>> +		of_match_device(rn5t618_of_match, &i2c->dev);
> 
> I'd prefer you did the call *after* the variable declarations.
> 
>>  	struct rn5t618 *priv;
>>  	int ret;
> 
> So here ->
>> +	if (!of_id) {
>> +		dev_err(&i2c->dev, "Failed to find matching dt id\n");
> 
> s/dt id/DT ID/
>> +		return -EINVAL;
>> +	}
>> +
>>  	priv = devm_kzalloc(&i2c->dev, sizeof(*priv), GFP_KERNEL);
>>  	if (!priv)
>>  		return -ENOMEM;
>> @@ -78,6 +94,8 @@ static int rn5t618_i2c_probe(struct i2c_client *i2c,
>>  		return ret;
>>  	}
>>
>> +	priv->variant = (long)of_id->data;
>> +
> 
> Why here and not directly after the of_id check?
> 
>>  	ret = devm_mfd_add_devices(&i2c->dev, -1, rn5t618_cells,
>>  				   ARRAY_SIZE(rn5t618_cells), NULL, 0, NULL);
>>  	if (ret) {
>> @@ -105,12 +123,6 @@ static int rn5t618_i2c_remove(struct i2c_client *i2c)
>>  	return 0;
>>  }
>>
>> -static const struct of_device_id rn5t618_of_match[] = {
>> -	{ .compatible = "ricoh,rn5t618" },
>> -	{ }
>> -};
>> -MODULE_DEVICE_TABLE(of, rn5t618_of_match);
>> -
>>  static const struct i2c_device_id rn5t618_i2c_id[] = {
>>  	{ }
>>  };
>> @@ -129,5 +141,5 @@ static struct i2c_driver rn5t618_i2c_driver = {
>>  module_i2c_driver(rn5t618_i2c_driver);
>>
>>  MODULE_AUTHOR("Beniamino Galvani <b.galvani@gmail.com>");
>> -MODULE_DESCRIPTION("Ricoh RN5T618 MFD driver");
>> +MODULE_DESCRIPTION("Ricoh RN5T567/618 MFD driver");
>>  MODULE_LICENSE("GPL v2");
>> diff --git a/include/linux/mfd/rn5t618.h b/include/linux/mfd/rn5t618.h
>> index c72d534..54179c2 100644
>> --- a/include/linux/mfd/rn5t618.h
>> +++ b/include/linux/mfd/rn5t618.h
>> @@ -20,6 +20,7 @@
>>  #define RN5T618_OTPVER			0x01
>>  #define RN5T618_IODAC			0x02
>>  #define RN5T618_VINDAC			0x03
>> +#define RN5T618_OUT32KEN		0x05
>>  #define RN5T618_CPUCNT			0x06
>>  #define RN5T618_PSWR			0x07
>>  #define RN5T618_PONHIS			0x09
>> @@ -38,6 +39,7 @@
>>  #define RN5T618_DC1_SLOT		0x16
>>  #define RN5T618_DC2_SLOT		0x17
>>  #define RN5T618_DC3_SLOT		0x18
>> +#define RN5T618_DC4_SLOT		0x19
>>  #define RN5T618_LDO1_SLOT		0x1b
>>  #define RN5T618_LDO2_SLOT		0x1c
>>  #define RN5T618_LDO3_SLOT		0x1d
>> @@ -54,12 +56,16 @@
>>  #define RN5T618_DC2CTL2			0x2f
>>  #define RN5T618_DC3CTL			0x30
>>  #define RN5T618_DC3CTL2			0x31
>> +#define RN5T618_DC4CTL			0x32
>> +#define RN5T618_DC4CTL2			0x33
>>  #define RN5T618_DC1DAC			0x36
>>  #define RN5T618_DC2DAC			0x37
>>  #define RN5T618_DC3DAC			0x38
>> +#define RN5T618_DC4DAC			0x39
>>  #define RN5T618_DC1DAC_SLP		0x3b
>>  #define RN5T618_DC2DAC_SLP		0x3c
>>  #define RN5T618_DC3DAC_SLP		0x3d
>> +#define RN5T618_DC4DAC_SLP		0x3e
>>  #define RN5T618_DCIREN			0x40
>>  #define RN5T618_DCIRQ			0x41
>>  #define RN5T618_DCIRMON			0x42
>> @@ -221,8 +227,14 @@ enum {
>>  	RN5T618_REG_NUM,
>>  };
>>
>> +enum {
>> +	RN5T567 = 0,
>> +	RN5T618,
>> +};
>> +
>>  struct rn5t618 {
>>  	struct regmap *regmap;
>> +	long variant;
> 
> What do you use this for?

This is used in the regulator driver to detect which variant we are
dealing with...

Ack on all the other stuff, will send a v3 for this.

--
Stefan

> 
>>  };
>>
>>  #endif /* __LINUX_MFD_RN5T618_H */
