From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 16 Feb 2012 10:13:52 +0100
Subject: [PATCH] ARM: 3ds_debugboard: Let ethernet be functional again
In-Reply-To: <20120216075825.GA11631@opensource.wolfsonmicro.com>
References: <1328646473-11828-1-git-send-email-festevam@gmail.com>
 <20120213082741.GN3852@pengutronix.de>
 <20120213144820.GA3494@opensource.wolfsonmicro.com>
 <20120214105823.GS3852@pengutronix.de>
 <20120214172902.GB3916@opensource.wolfsonmicro.com>
 <20120216073236.GE3852@pengutronix.de>
 <20120216075825.GA11631@opensource.wolfsonmicro.com>
Message-ID: <20120216091352.GK3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2012 at 11:58:26PM -0800, Mark Brown wrote:
> On Thu, Feb 16, 2012 at 08:32:36AM +0100, Sascha Hauer wrote:
> > On Tue, Feb 14, 2012 at 09:29:04AM -0800, Mark Brown wrote:
> 
> > > The main thing here is to avoid these driver specific bodges that people
> > > keep churning out again and again, it's quite depressing really.
> 
> > I think this churning will continue until we either make the dummy
> > regulator non optional and drop this warning that gets printed each
> > time it is used, or we at least provide a way to easily add a fixed
> 
> That's obviously not a good idea, if we do that we may as well just drop
> all error checking from the API.
> 
> > dummy regulator without adding >20 lines of code to each board just
> > for saying that we don't have a regulator for this particular device.
> 
> It's not per device, of course - there's an overhead from putting a
> fixed regulator in but then per supply it's just a line.

You mean one supply if the voltages are the same, right? Otherwise
we need multiple fixed regulators (or we shouldn't claim that the
board-dummy-fixed-catch-all regulator has a particular voltage)

> 
> > +#if IS_ENABLED(CONFIG_REGULATOR_FIXED_VOLTAGE)
> > +struct platform_device *regulator_register_fixed(const char *name, int id,
> > +		int microvolts, struct regulator_consumer_supply *supplies,
> > +		int num_supplies);
> > +#else
> > +static struct platform_device *regulator_register_fixed(const char *name, int id,
> > +		int microvolts, struct regulator_consumer_supply *supplies,
> > +		int num_supplies)
> > +{
> > +	return NULL;
> > +}
> > +#endif
> 
> This is obviously not good for users, they'd still have to do error
> checking to determine if the device was created or not and then manually
> register the device with the driver core and ideally also care if that
> worked or not.

I understand that error checking is a good idea, but what do you mean
with 'manually register the device with the core'? The regulator is
registered with the core in this function.

> I'm not sure something like this will really save enough
> unless the device actually gets registered by the function, otherwise
> it's going to be converting data to code.
> 
> I'd also drop the microvolts and name parameters, if people are going to
> be doing enough work to describe the individual rails on the board
> they're probably not going to be put off by having to register a
> platform device.
> 
> Of course with device tree this all becomes moot as this won't be
> happening from code anyway...

I wonder what the devicetree guys will do with this situation anyway.
The devicetree won't describe regulators that are actually not present
in the hardware, does it?

Don't get me wrong. All I want is just a way for people to be able to
add regulator support to drivers *without* breaking its users. Normally
we have the policy in the kernel that changes to the kernel do not break
its users. The smsc case violated this and it will happen again. In the
end it doesn't even matter if a particular board could control a supply
via software or not. Patches should not simply declare all users of a
driver as broken.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
