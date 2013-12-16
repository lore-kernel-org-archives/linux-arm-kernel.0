From: arno@natisbad.org (Arnaud Ebalard)
Date: Mon, 16 Dec 2013 22:05:01 +0100
Subject: [PATCHv3,
 RESEND] rtc: Add support for Intersil ISL12057 I2C RTC chip
References: <637f26e051b700ca510a0af695dfd84cf2bfd35d.1387222475.git.arno@natisbad.org>
 <20131216201424.GA6639@roeck-us.net>
Message-ID: <87r49cpkw2.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter,

Thanks for the fast feedback! I have handled all your comments and
tested the resulting version on my RN102 w/o problems. Will send a
v4 in a few minutes.

Can you just look at first comment below?

Guenter Roeck <linux@roeck-us.net> writes:

>> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
>> ---
>> This is a resend - just in case the initial mail slept through - as I
>> got no feedback over the past week. I have also Cc'ed additional
>> people.
>> 
> Looks like your mailer corrupts the patch. You'll have to fix that.

If you wonder about the text below the SoB, this is just informational,
i.e. to avoid having it in the final commit. Can you be more specific
if this is not what you meant, i.e. how the patch is otherwise
corrupted?


>> +#define ISL12057_REG_RTC_HR_PM  (1<<5) /* AM/PM bit in 12h format */
>> +#define ISL12057_REG_RTC_HR_MIL (1<<6) /* 24h/12h format */
>
> Use BIT() or at least spaces around '<<'.

Will use BIT().


>> +static void isl12057_rtc_regs_to_tm(struct rtc_time *tm, u8 *regs)
>> +{
>> +	tm->tm_sec  = bcd2bin(regs[ISL12057_REG_RTC_SC]);
>> +	tm->tm_min  = bcd2bin(regs[ISL12057_REG_RTC_MN]);
>
> Extra spaces.

ok.

>> +static int isl12057_rtc_read_time(struct device *dev, struct rtc_time *tm)
>> +{
>> +	struct i2c_client *client = to_i2c_client(dev);
>> +	struct isl12057_rtc_data *data = i2c_get_clientdata(client);
>> +	u8 regs[ISL12057_RTC_SEC_LEN];
>> +	int ret;
>> +
>> +	mutex_lock(&data->lock);
>> +	ret = regmap_bulk_read(data->regmap, ISL12057_REG_RTC_SC, regs,
>> +			       ISL12057_RTC_SEC_LEN);
>> +	mutex_unlock(&data->lock);
>> +
>> +	if (ret) {
>> +		dev_err(&client->dev, "%s: RTC read failed\n", __func__);
>
> 'dev' and '&client->dev' should be the same, so why not just use
> 'dev' ?
>
> Reason for asking is that this is the major use of 'client'. To get 'data',
> you could use 'dev_set_drvdata' and 'dev_get_drvdata'. Then you could replace
> 	struct i2c_client *client = to_i2c_client(dev);
> 	struct isl12057_rtc_data *data = i2c_get_clientdata(client);
> with
> 	struct isl12057_rtc_data *data = dev_get_drvdata(dev);
> everywhere.

Feasible. And It also helps removing a field in my private structure.


>> +static int isl12057_probe(struct i2c_client *client,
>> +			  const struct i2c_device_id *id)
>> +{
>> +	struct device *dev = &client->dev;
>> +	struct isl12057_rtc_data *data;
>> +	struct rtc_device *rtc;
>> +	struct regmap *regmap;
>> +	int ret = 0;
>
> Unless I am missing something, this initialization is unnecessary.

You are right.


>> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
>> +				     I2C_FUNC_SMBUS_BYTE_DATA |
>> +				     I2C_FUNC_SMBUS_I2C_BLOCK))
>> +		return -ENODEV;
>> +
>> +	regmap = devm_regmap_init_i2c(client, &isl12057_rtc_regmap_config);
>> +	if (IS_ERR(regmap)) {
>> +		ret = PTR_ERR(regmap);
>> +		dev_err(&client->dev, "regmap allocation failed: %d\n", ret);
>
> Since you assigned dev = &client->dev above, might as well use it.

Will do.


>> +		return ret;
>> +	}
>> +
>> +	ret = isl12057_i2c_validate_client(regmap);
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
>> +	data->client = client;
>
> data->client does not appear to be used anywhere.

Removed.


>> +	data->regmap = regmap;
>> +	i2c_set_clientdata(client, data);
>> +
>> +	rtc = devm_rtc_device_register(dev, DRV_NAME, &rtc_ops, THIS_MODULE);
>> +	if (IS_ERR(rtc))
>> +		return PTR_ERR(rtc);
>> +	data->rtc = rtc;
>
> data->rtc does not seem to be used anywhere.

Correct.


>
>> +
>> +	return 0;
>> +}
>> +
>> +#ifdef CONFIG_OF
>> +static struct of_device_id isl12057_dt_match[] = {
>> +	{ .compatible = "isl,isl12057" },
>> +	{ },
>> +};
>> +#endif
>> +
> Is this needed ? For i2c devices, struct i2c_device_id should be
> sufficient.

Kept that one as per Mark's comment.

a+
