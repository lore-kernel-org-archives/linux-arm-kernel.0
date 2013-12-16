From: arno@natisbad.org (Arnaud Ebalard)
Date: Mon, 16 Dec 2013 23:36:39 +0100
Subject: [PATCHv4] rtc: Add support for Intersil ISL12057 I2C RTC chip
In-Reply-To: <20131216221850.GA9994@roeck-us.net> (Guenter Roeck's message of
 "Mon, 16 Dec 2013 14:18:50 -0800")
References: <1dec5992db795b61e91e0abf910dee7fce322ccc.1387227955.git.arno@natisbad.org>
 <20131216221850.GA9994@roeck-us.net>
Message-ID: <871u1cl8y0.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Guenter Roeck <linux@roeck-us.net> writes:

> On Mon, Dec 16, 2013 at 10:17:47PM +0100, Arnaud Ebalard wrote:
>> 
>> Intersil ISL12057 I2C RTC chip also supports two alarms. This patch
>> only adds support for basic RTC functionalities (i.e. getting and
>> setting time). Tests have been performed on NETGEAR ReadyNAS 102 w/
>> startup/shutdown scripts, hwclock, ntpdate and openntpd.
>> 
>> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
>
> Weird; I saved the patch again and the '=3D' is gone. Maybe it was PBKC.
> Comments inline.

no problem.

>> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
>> index 27b4bd8..6cd50e5 100644
>> --- a/drivers/rtc/Makefile
>> +++ b/drivers/rtc/Makefile
>> @@ -58,6 +58,7 @@ obj-$(CONFIG_RTC_DRV_HID_SENSOR_TIME) += rtc-hid-sensor-time.o
>>  obj-$(CONFIG_RTC_DRV_IMXDI)	+= rtc-imxdi.o
>>  obj-$(CONFIG_RTC_DRV_ISL1208)	+= rtc-isl1208.o
>>  obj-$(CONFIG_RTC_DRV_ISL12022)	+= rtc-isl12022.o
>> +obj-$(CONFIG_RTC_DRV_ISL12057)  += rtc-isl12057.o
>
> Please use tab after the define.

Will fix that in next round.


>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation.
>
> checkpatch complains about the above paragraph. I would suggest to
> remove it.

Will make checkpacth happy.


>> +/* Control/Status registers */
>> +#define ISL12057_REG_INT        0x0E
>> +#define ISL12057_REG_INT_A1IE   BIT(0) /* Alarm 1 interrupt enable bit */
>> +#define ISL12057_REG_INT_A2IE   BIT(1) /* Alarm 2 interrupt enable bit */
>> +#define ISL12057_REG_INT_INTCN  BIT(2) /* Interrupt control enable bit */
>> +#define ISL12057_REG_INT_RS1    BIT(3) /* Freq out control bit 1 */
>> +#define ISL12057_REG_INT_RS2    BIT(4) /* Freq out control bit 2 */
>> +#define ISL12057_REG_INT_EOSC   BIT(7) /* Oscillator enable bit */
>> +
>> +#define ISL12057_REG_SR         0x0F
>> +#define ISL12057_REG_SR_A1F     BIT(0) /* Alarm 1 interrupt bit */
>> +#define ISL12057_REG_SR_A2F     BIT(1) /* Alarm 2 interrupt bit */
>> +#define ISL12057_REG_SR_OSF     BIT(7) /* Oscillator failure bit */
>> +
>> +/* Register memory map length */
>> +#define ISL12057_MEM_MAP_LEN    0x10
>> +
>
> Please use tab after the define (and if possible before the comments).

ok.


> Also, many of the above defines are unused (especially the alarm defines).
> Will those ever be necessary/used ? Otherwise I would suggest to remove
> the unused defines.

I think it makes sense to keep all the bits definitions instead of
providing some sparse info about used ones. Additionally, alarm bits
will be used as soon as I get some feedback on how to support my use
case: the interrupt line of the chip is not connected to the SoC but
some power component. This does not seem something common.


>
>> +static struct i2c_driver isl12057_driver;
>> +
>
> Unnecessary.

yep.


>> +/*
>> + * Try and match register bits w/ fixed null values to see whether we
>> + * are dealing with an ISL12057.
>> + */
>
> For isl12057_check_rtc_status you added a comment explaining why a lock is not
> needed. It would be useful to have that same comment here as well.

will add it.


>> +/*
>> + * Check current RTC status and enable/disable what needs to be. Return 0 if
>> + * everything went ok and a negative value upon error. Note: this function
>> + * is called early during init and hence does need mutex protection.
>> + */
>> +static int isl12057_check_rtc_status(struct device *dev, struct regmap *regmap)
>> +{
>> +	int ret;
>> +
>> +	/* Enable oscillator if not already running */
>> +	ret = regmap_update_bits(regmap, ISL12057_REG_INT,
>> +				 ISL12057_REG_INT_EOSC, 0);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Enable to enable oscillator\n");
>
> 	s/Enable/Unable/
>
> or at least I think so.

yep.


>> +		return ret;
>> +	}
>> +
>> +	/* Clear oscillator failure bit if needed */
>> +	ret = regmap_update_bits(regmap, ISL12057_REG_SR,
>> +				 ISL12057_REG_SR_OSF, 0);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Enable to clear oscillator failure bit\n");
>
> Unable ?
>
>
>> +		return ret;
>> +	}
>> +
>> +	/* Clear alarm bit if needed */
>> +	ret = regmap_update_bits(regmap, ISL12057_REG_SR,
>> +				 ISL12057_REG_SR_A1F, 0);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Enable to clear alarm bit\n");
>
> Unable ?

Damned. That was a day w/o coffee, I guess.

>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct rtc_class_ops rtc_ops = {
>> +	.read_time = isl12057_rtc_read_time,
>> +	.set_time = isl12057_rtc_set_time,
>> +	.proc = isl12057_rtc_proc,
>> +};
>> +
>> +static struct regmap_config isl12057_rtc_regmap_config = {
>> +	.reg_bits = 8,
>> +	.val_bits = 8,
>> +};
>> +
>> +static int isl12057_probe(struct i2c_client *client,
>> +			  const struct i2c_device_id *id)
>> +{
>> +	struct device *dev = &client->dev;
>> +	struct isl12057_rtc_data *data;
>> +	struct rtc_device *rtc;
>> +	struct regmap *regmap;
>> +	int ret;
>> +
>> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
>> +				     I2C_FUNC_SMBUS_BYTE_DATA |
>> +				     I2C_FUNC_SMBUS_I2C_BLOCK))
>> +		return -ENODEV;
>> +
>> +	regmap = devm_regmap_init_i2c(client, &isl12057_rtc_regmap_config);
>> +	if (IS_ERR(regmap)) {
>> +		ret = PTR_ERR(regmap);
>> +		dev_err(dev, "regmap allocation failed: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = isl12057_i2c_validate_chip(regmap);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = isl12057_check_rtc_status(dev, regmap);
>> +	if (ret)
>> +		return ret;
>> +
>> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	mutex_init(&data->lock);
>> +	data->regmap = regmap;
>> +	dev_set_drvdata(dev, data);
>> +
>> +	rtc = devm_rtc_device_register(dev, DRV_NAME, &rtc_ops, THIS_MODULE);
>> +	if (IS_ERR(rtc))
>> +		return PTR_ERR(rtc);
>> +	data->rtc = rtc;
>
> data->rtc still seems to be unused.

I *indeed* forgot to remove it.

Thanks for your time Guenter.

Cheers,

a+
