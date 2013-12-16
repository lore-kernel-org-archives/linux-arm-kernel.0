From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 16 Dec 2013 12:14:24 -0800
Subject: [PATCHv3,RESEND] rtc: Add support for Intersil ISL12057 I2C RTC
 chip
In-Reply-To: <637f26e051b700ca510a0af695dfd84cf2bfd35d.1387222475.git.arno@natisbad.org>
References: <637f26e051b700ca510a0af695dfd84cf2bfd35d.1387222475.git.arno@natisbad.org>
Message-ID: <20131216201424.GA6639@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 16, 2013 at 08:49:36PM +0100, Arnaud Ebalard wrote:
> 
> Intersil ISL12057 I2C RTC chip also supports two alarms. This patch
> only adds support for basic RTC functionalities (i.e. getting and
> setting time). Tests have been performed on NETGEAR ReadyNAS 102 w/
> startup/shutdown scripts, hwclock, ntpdate and openntpd.
> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
> This is a resend - just in case the initial mail slept through - as I
> got no feedback over the past week. I have also Cc'ed additional
> people.
> 
Looks like your mailer corrupts the patch. You'll have to fix that.
More comments below.

[ ... ]

> +#define ISL12057_REG_RTC_HR_PM  (1<<5) /* AM/PM bit in 12h format */
> +#define ISL12057_REG_RTC_HR_MIL (1<<6) /* 24h/12h format */

Use BIT() or@least spaces around '<<'.

> +#define ISL12057_REG_RTC_DW     0x03 /* Day of the Week */
> +#define ISL12057_REG_RTC_DT     0x04 /* Date */
> +#define ISL12057_REG_RTC_MO     0x05 /* Month */
> +#define ISL12057_REG_RTC_YR     0x06 /* Year */
> +#define ISL12057_RTC_SEC_LEN    7
> +
> +/* Alarm 1 section */
> +#define ISL12057_REG_A1_SC      0x07 /* Alarm 1 Seconds */
> +#define ISL12057_REG_A1_MN      0x08 /* Alarm 1 Minutes */
> +#define ISL12057_REG_A1_HR      0x09 /* Alarm 1 Hours */
> +#define ISL12057_REG_A1_HR_PM   (1<<5) /* AM/PM bit in 12h format */
> +#define ISL12057_REG_A1_HR_MIL  (1<<6) /* 24h/12h format */
> +#define ISL12057_REG_A1_DWDT    0x0A /* Alarm 1 Date / Day of the week */
> +#define ISL12057_REG_A1_DWDT_B  (1<<6) /* DW / DT selection bit */
> +#define ISL12057_A1_SEC_LEN     4
> +
> +/* Alarm 2 section */
> +#define ISL12057_REG_A2_MN      0x0B /* Alarm 2 Minutes */
> +#define ISL12057_REG_A2_HR      0x0C /* Alarm 2 Hours */
> +#define ISL12057_REG_A2_DWDT    0x0D /* Alarm 2 Date / Day of the week */
> +#define ISL12057_A2_SEC_LEN     3
> +
> +/* Control/Status registers */
> +#define ISL12057_REG_INT        0x0E
> +#define ISL12057_REG_INT_A1IE   (1<<0) /* Alarm 1 interrupt enable bit */
> +#define ISL12057_REG_INT_A2IE   (1<<1) /* Alarm 2 interrupt enable bit */
> +#define ISL12057_REG_INT_INTCN  (1<<2) /* Interrupt control enable bit */
> +#define ISL12057_REG_INT_RS1    (1<<3) /* Freq out control bit 1 */
> +#define ISL12057_REG_INT_RS2    (1<<4) /* Freq out control bit 2 */
> +#define ISL12057_REG_INT_EOSC   (1<<7) /* Oscillator enable bit */
> +
> +#define ISL12057_REG_SR         0x0F
> +#define ISL12057_REG_SR_A1F     (1<<0) /* Alarm 1 interrupt bit */
> +#define ISL12057_REG_SR_A2F     (1<<1) /* Alarm 2 interrupt bit */
> +#define ISL12057_REG_SR_OSF     (1<<7) /* Oscillator failure bit */
> +
> +/* Register memory map length */
> +#define ISL12057_MEM_MAP_LEN    0x10
> +
> +static struct i2c_driver isl12057_driver;
> +
> +struct isl12057_rtc_data {
> +	struct i2c_client *client;
> +	struct rtc_device *rtc;
> +	struct regmap *regmap;
> +	struct mutex lock;
> +};
> +
> +static void isl12057_rtc_regs_to_tm(struct rtc_time *tm, u8 *regs)
> +{
> +	tm->tm_sec  = bcd2bin(regs[ISL12057_REG_RTC_SC]);
> +	tm->tm_min  = bcd2bin(regs[ISL12057_REG_RTC_MN]);

Extra spaces.

> +
> +	if (regs[ISL12057_REG_RTC_HR] & ISL12057_REG_RTC_HR_MIL) { /* AM/PM */
> +		tm->tm_hour = bcd2bin(regs[ISL12057_REG_RTC_HR] & 0x0f);
> +		if (regs[ISL12057_REG_RTC_HR] & ISL12057_REG_RTC_HR_PM)
> +			tm->tm_hour += 12;
> +	} else {                                            /* 24 hour mode */
> +		tm->tm_hour = bcd2bin(regs[ISL12057_REG_RTC_HR] & 0x3f);
> +	}
> +
> +	tm->tm_mday = bcd2bin(regs[ISL12057_REG_RTC_DT]);
> +	tm->tm_wday = bcd2bin(regs[ISL12057_REG_RTC_DW]) - 1; /* starts at 1 */
> +	tm->tm_mon  = bcd2bin(regs[ISL12057_REG_RTC_MO]) - 1; /* starts at 1 */
> +	tm->tm_year = bcd2bin(regs[ISL12057_REG_RTC_YR]) + 100;
> +}
> +
> +static int isl12057_rtc_tm_to_regs(u8 *regs, struct rtc_time *tm)
> +{
> +	/*
> +	 * The clock has an 8 bit wide bcd-coded register for the year.
> +	 * tm_year is an offset from 1900 and we are interested in the
> +	 * 2000-2099 range, so any value less than 100 is invalid.
> +	 */
> +	if (tm->tm_year < 100)
> +		return -EINVAL;
> +
> +	regs[ISL12057_REG_RTC_SC] = bin2bcd(tm->tm_sec);
> +	regs[ISL12057_REG_RTC_MN] = bin2bcd(tm->tm_min);
> +	regs[ISL12057_REG_RTC_HR] = bin2bcd(tm->tm_hour); /* 24-hour format */
> +	regs[ISL12057_REG_RTC_DT] = bin2bcd(tm->tm_mday);
> +	regs[ISL12057_REG_RTC_MO] = bin2bcd(tm->tm_mon + 1);
> +	regs[ISL12057_REG_RTC_YR] = bin2bcd(tm->tm_year - 100);
> +	regs[ISL12057_REG_RTC_DW] = bin2bcd(tm->tm_wday + 1);
> +
> +	return 0;
> +}
> +
> +/*
> + * Try and match register bits w/ fixed null values to see whether we
> + * are dealing with an ISL12057.
> + */
> +static int isl12057_i2c_validate_client(struct regmap *regmap)
> +{
> +	u8 regs[ISL12057_MEM_MAP_LEN];
> +	u8 mask[ISL12057_MEM_MAP_LEN] = { 0x80, 0x80, 0x80, 0xf8,
> +					  0xc0, 0x60, 0x00, 0x00,
> +					  0x00, 0x00, 0x00, 0x00,
> +					  0x00, 0x00, 0x60, 0x7c };
> +	int ret, i;
> +
> +	ret = regmap_bulk_read(regmap, 0, regs, ISL12057_MEM_MAP_LEN);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < ISL12057_MEM_MAP_LEN; ++i) {
> +		if (regs[i] & mask[i])	/* check if bits are cleared */
> +			return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static int isl12057_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct isl12057_rtc_data *data = i2c_get_clientdata(client);
> +	u8 regs[ISL12057_RTC_SEC_LEN];
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +	ret = regmap_bulk_read(data->regmap, ISL12057_REG_RTC_SC, regs,
> +			       ISL12057_RTC_SEC_LEN);
> +	mutex_unlock(&data->lock);
> +
> +	if (ret) {
> +		dev_err(&client->dev, "%s: RTC read failed\n", __func__);

'dev' and '&client->dev' should be the same, so why not just use 'dev' ?

Reason for asking is that this is the major use of 'client'. To get 'data',
you could use 'dev_set_drvdata' and 'dev_get_drvdata'. Then you could replace
	struct i2c_client *client = to_i2c_client(dev);
	struct isl12057_rtc_data *data = i2c_get_clientdata(client);
with
	struct isl12057_rtc_data *data = dev_get_drvdata(dev);
everywhere.

> +		return ret;
> +	}
> +
> +	isl12057_rtc_regs_to_tm(tm, regs);
> +
> +	return rtc_valid_tm(tm);
> +}
> +
> +static int isl12057_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct isl12057_rtc_data *data = i2c_get_clientdata(client);
> +	u8 regs[ISL12057_RTC_SEC_LEN];
> +	int ret;
> +
> +	ret = isl12057_rtc_tm_to_regs(regs, tm);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&data->lock);
> +	ret = regmap_bulk_write(data->regmap, ISL12057_REG_RTC_SC, regs,
> +				ISL12057_RTC_SEC_LEN);
> +	mutex_unlock(&data->lock);
> +
> +	if (ret)
> +		dev_err(&client->dev, "%s: RTC write failed\n", __func__);
> +
> +	return ret;
> +}
> +
> +static int isl12057_rtc_proc(struct device *dev, struct seq_file *seq)
> +{
> +	struct i2c_client *const client = to_i2c_client(dev);
> +	struct isl12057_rtc_data *data = i2c_get_clientdata(client);
> +	int reg, ret;
> +
> +	mutex_lock(&data->lock);
> +
> +	/* Status register */
> +	ret = regmap_read(data->regmap, ISL12057_REG_SR, &reg);
> +	if (ret) {
> +		dev_err(&client->dev, "%s: reading SR failed\n", __func__);
> +		goto out;
> +	}
> +
> +	seq_printf(seq, "status_reg\t:%s%s%s (0x%.2x)\n",
> +		   (reg & ISL12057_REG_SR_OSF) ? " OSF" : "",
> +		   (reg & ISL12057_REG_SR_A1F) ? " A1F" : "",
> +		   (reg & ISL12057_REG_SR_A2F) ? " A2F" : "", reg);
> +
> +	/* Control register */
> +	ret = regmap_read(data->regmap, ISL12057_REG_INT, &reg);
> +	if (ret) {
> +		dev_err(&client->dev, "%s: reading INT failed\n", __func__);
> +		goto out;
> +	}
> +
> +	seq_printf(seq, "control_reg\t:%s%s%s%s%s%s (0x%.2x)\n",
> +		   (reg & ISL12057_REG_INT_A1IE) ?  " A1IE"  : "",
> +		   (reg & ISL12057_REG_INT_A2IE) ?  " A2IE"  : "",
> +		   (reg & ISL12057_REG_INT_INTCN) ? " INTCN" : "",
> +		   (reg & ISL12057_REG_INT_RS1) ?   " RS1"   : "",
> +		   (reg & ISL12057_REG_INT_RS2) ?   " RS2"   : "",
> +		   (reg & ISL12057_REG_INT_EOSC) ?  " EOSC"  : "", reg);
> +
> + out:
> +	mutex_unlock(&data->lock);
> +
> +	return ret;
> +}
> +
> +/*
> + * Check current RTC status and enable/disable what needs to be. Return 0 if
> + * everything went ok and a negative value upon error. Note: this function
> + * is called early during init and hence does need mutex protection.
> + */
> +static int isl12057_check_rtc_status(struct device *dev, struct regmap *regmap)
> +{
> +	int ret;
> +
> +	/* Enable oscillator if not already running */
> +	ret = regmap_update_bits(regmap, ISL12057_REG_INT,
> +				 ISL12057_REG_INT_EOSC, 0);
> +	if (ret < 0) {
> +		dev_err(dev, "Enable to enable oscillator\n");
> +		return ret;
> +	}
> +
> +	/* Clear oscillator failure bit if needed */
> +	ret = regmap_update_bits(regmap, ISL12057_REG_SR,
> +				 ISL12057_REG_SR_OSF, 0);
> +	if (ret < 0) {
> +		dev_err(dev, "Enable to clear oscillator failure bit\n");
> +		return ret;
> +	}
> +
> +	/* Clear alarm bit if needed */
> +	ret = regmap_update_bits(regmap, ISL12057_REG_SR,
> +				 ISL12057_REG_SR_A1F, 0);
> +	if (ret < 0) {
> +		dev_err(dev, "Enable to clear alarm bit\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct rtc_class_ops rtc_ops = {
> +	.read_time = isl12057_rtc_read_time,
> +	.set_time = isl12057_rtc_set_time,
> +	.proc = isl12057_rtc_proc,
> +};
> +
> +static struct regmap_config isl12057_rtc_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};
> +
> +static int isl12057_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	struct isl12057_rtc_data *data;
> +	struct rtc_device *rtc;
> +	struct regmap *regmap;
> +	int ret = 0;

Unless I am missing something, this initialization is unnecessary.

> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
> +				     I2C_FUNC_SMBUS_BYTE_DATA |
> +				     I2C_FUNC_SMBUS_I2C_BLOCK))
> +		return -ENODEV;
> +
> +	regmap = devm_regmap_init_i2c(client, &isl12057_rtc_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		ret = PTR_ERR(regmap);
> +		dev_err(&client->dev, "regmap allocation failed: %d\n", ret);

Since you assigned dev = &client->dev above, might as well use it.

> +		return ret;
> +	}
> +
> +	ret = isl12057_i2c_validate_client(regmap);
> +	if (ret)
> +		return ret;
> +
> +	ret = isl12057_check_rtc_status(dev, regmap);
> +	if (ret)
> +		return ret;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	mutex_init(&data->lock);
> +	data->client = client;

data->client does not appear to be used anywhere.

> +	data->regmap = regmap;
> +	i2c_set_clientdata(client, data);
> +
> +	rtc = devm_rtc_device_register(dev, DRV_NAME, &rtc_ops, THIS_MODULE);
> +	if (IS_ERR(rtc))
> +		return PTR_ERR(rtc);
> +	data->rtc = rtc;

data->rtc does not seem to be used anywhere.

> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +static struct of_device_id isl12057_dt_match[] = {
> +	{ .compatible = "isl,isl12057" },
> +	{ },
> +};
> +#endif
> +
Is this needed ? For i2c devices, struct i2c_device_id should be sufficient.

> +static const struct i2c_device_id isl12057_id[] = {
> +	{ "isl12057", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, isl12057_id);
> +
> +static struct i2c_driver isl12057_driver = {
> +	.driver = {
> +		.name = DRV_NAME,
> +		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(isl12057_dt_match),
> +	},
> +	.probe	  = isl12057_probe,
> +	.id_table = isl12057_id,
> +};
> +module_i2c_driver(isl12057_driver);
> +
> +MODULE_AUTHOR("Arnaud EBALARD <arno@natisbad.org>");
> +MODULE_DESCRIPTION("Intersil ISL12057 RTC driver");
> +MODULE_LICENSE("GPL");
> -- 
> 1.8.4.4
> 
> 
