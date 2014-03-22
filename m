From: carlo@caione.org (Carlo Caione)
Date: Sat, 22 Mar 2014 17:51:32 +0100
Subject: [linux-sunxi] Re: [PATCH v2 1/8] mfd: AXP20x: Add mfd driver for
 AXP20x PMIC
In-Reply-To: <20140318155919.GS25478@lee--X1>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
 <1394898225-28452-2-git-send-email-carlo@caione.org>
 <20140318155919.GS25478@lee--X1>
Message-ID: <20140322165132.GC20668@localhost.fastwebnet.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 18, 2014 at 03:59:19PM +0000, Lee Jones wrote:
> > +static struct mfd_cell axp20x_cells[] = {
> > +	{
> > +		.name		= "axp20x-pek",
> > +		.num_resources	= ARRAY_SIZE(axp20x_pek_resources),
> > +		.resources	= axp20x_pek_resources,
> > +	}, {
> > +		.name		= "axp20x-regulator",
> > +	},
> > +};
> 
> nit: The format of these two structs are inconsistent.

Uhm, what do you mean?

> > +static int axp20x_i2c_probe(struct i2c_client *i2c,
> > +			 const struct i2c_device_id *id)
> > +{
> > +	struct axp20x_dev *axp20x;
> > +	const struct of_device_id *of_id;
> > +	int ret;
> > +
> > +	axp20x = devm_kzalloc(&i2c->dev, sizeof(*axp20x), GFP_KERNEL);
> > +	if (!axp20x)
> > +		return -ENOMEM;
> > +
> > +	of_id = of_match_device(axp20x_of_match, &i2c->dev);
> > +	if (!of_id) {
> > +		dev_err(&i2c->dev, "Unable to setup AXP20X data\n");
> > +		return -ENODEV;
> > +	}
> > +	axp20x->variant = (int) of_id->data;
> 
> No need to cast from void *.

My compiler says otherwise :)

> [...]
> 
> > +static const struct i2c_device_id axp20x_i2c_id[] = {
> > +	{ "axp202", AXP202_ID },
> > +	{ "axp209", AXP209_ID },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);
> 
> Isn't this redundant now that you're using of_id?

It is not. Even it is unused it has to be in the driver otherwise the
driver is not loaded. Probably it is something wrong in the I2C core.

Best,

-- 
Carlo Caione
