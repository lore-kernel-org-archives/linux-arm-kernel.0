From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 13 Jun 2010 12:30:08 +0200
Subject: [PATCH 1/3] ISL6271A voltage regulator support.
In-Reply-To: <20100612172114.GA20610@opensource.wolfsonmicro.com>
References: <1276346679-2893-1-git-send-email-marek.vasut@gmail.com>
	<20100612172114.GA20610@opensource.wolfsonmicro.com>
Message-ID: <201006131230.08408.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne So 12. ?ervna 2010 19:21:14 Mark Brown napsal(a):
> On Sat, Jun 12, 2010 at 02:44:37PM +0200, Marek Vasut wrote:
> > This device is very simple, it supports only one LDO. This single LDO is
> > programmed over I2C to 16 possible voltages.
> 
> Google tells me that the device has three regulators on it - two LDOs
> and one DCDC buck convertor:
> 
>    http://www.intersil.com/products/deviceinfo.asp?pn=ISL6271A
> 
> While the LDOs look like they have no software control it'd be best to
> provide hookup for them, even if that's just a case of instantiating the
> appropriate fixed voltage regulators.

Is this necessary? I'd only increase the kernel size without any gain ... or am 
I wrong ?
> 
> > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> > 
> > +/* Supported voltage values for regulators */
> > +static const u32 core_buck_table[] = {
> > +	 850000,  900000,  950000, 1000000,
> > +	1050000, 1100000, 1150000, 1200000,
> > +	1250000, 1300000, 1350000, 1400000,
> > +	1450000, 1500000, 1550000, 1600000,
> > +};
> 
> This looks like it could be replaced with a simple function rather than
> a lookup table which would simplify the code.

Will do.
> 
> Also, are you sure this is a buck?  That's a specific technical term
> usually only applied to DCDC regulators - LDOs are a different type of
> regulator

That's what's written in the ISL6271a TRM. On the first page, under the 
"Features" section.
> 
> > +static int __devinit isl6271a_probe(struct i2c_client *client,
> > +				     const struct i2c_device_id *id)
> > +{
> > +	struct regulator_init_data *init_data	= client->dev.platform_data;
> > +	struct isl_pmic *pmic;
> > +	int err;
> > +
> > +	if (!i2c_check_functionality(client->adapter,
> > I2C_FUNC_SMBUS_BYTE_DATA)) +		return -EIO;
> > +
> > +	if (!init_data)
> > +		return -EIO;
> 
> It'd be better to print an error message here so users know what's going
> on when the device fails to appear.

Ok.

Thanks!
