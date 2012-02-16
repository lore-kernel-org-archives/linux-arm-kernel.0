From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 15 Feb 2012 23:58:26 -0800
Subject: [PATCH] ARM: 3ds_debugboard: Let ethernet be functional again
In-Reply-To: <20120216073236.GE3852@pengutronix.de>
References: <1328646473-11828-1-git-send-email-festevam@gmail.com>
 <20120213082741.GN3852@pengutronix.de>
 <20120213144820.GA3494@opensource.wolfsonmicro.com>
 <20120214105823.GS3852@pengutronix.de>
 <20120214172902.GB3916@opensource.wolfsonmicro.com>
 <20120216073236.GE3852@pengutronix.de>
Message-ID: <20120216075825.GA11631@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 08:32:36AM +0100, Sascha Hauer wrote:
> On Tue, Feb 14, 2012 at 09:29:04AM -0800, Mark Brown wrote:

> > The main thing here is to avoid these driver specific bodges that people
> > keep churning out again and again, it's quite depressing really.

> I think this churning will continue until we either make the dummy
> regulator non optional and drop this warning that gets printed each
> time it is used, or we at least provide a way to easily add a fixed

That's obviously not a good idea, if we do that we may as well just drop
all error checking from the API.

> dummy regulator without adding >20 lines of code to each board just
> for saying that we don't have a regulator for this particular device.

It's not per device, of course - there's an overhead from putting a
fixed regulator in but then per supply it's just a line.

> +#if IS_ENABLED(CONFIG_REGULATOR_FIXED_VOLTAGE)
> +struct platform_device *regulator_register_fixed(const char *name, int id,
> +		int microvolts, struct regulator_consumer_supply *supplies,
> +		int num_supplies);
> +#else
> +static struct platform_device *regulator_register_fixed(const char *name, int id,
> +		int microvolts, struct regulator_consumer_supply *supplies,
> +		int num_supplies)
> +{
> +	return NULL;
> +}
> +#endif

This is obviously not good for users, they'd still have to do error
checking to determine if the device was created or not and then manually
register the device with the driver core and ideally also care if that
worked or not.  I'm not sure something like this will really save enough
unless the device actually gets registered by the function, otherwise
it's going to be converting data to code.

I'd also drop the microvolts and name parameters, if people are going to
be doing enough work to describe the individual rails on the board
they're probably not going to be put off by having to register a
platform device.

Of course with device tree this all becomes moot as this won't be
happening from code anyway...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120215/ee6153c8/attachment.sig>
