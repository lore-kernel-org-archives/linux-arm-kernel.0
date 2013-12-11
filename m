From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 11 Dec 2013 16:12:00 +0100
Subject: [PATCH] of/platform: Fix no irq domain found errors when
 populating interrupts
In-Reply-To: <20131211134553.2E967C4061A@trevor.secretlab.ca>
References: <20131123004334.GJ10023@atomide.com>
 <20131124213651.59750C402C3@trevor.secretlab.ca>
 <20131125092549.GD22043@ulmo.nvidia.com>
 <20131125094954.GF22043@ulmo.nvidia.com>
 <20131127155629.DB612C404EC@trevor.secretlab.ca>
 <20131128154622.GB23201@ulmo.nvidia.com>
 <20131211134553.2E967C4061A@trevor.secretlab.ca>
Message-ID: <20131211151159.GA31617@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 01:45:53PM +0000, Grant Likely wrote:
> On Thu, 28 Nov 2013 16:46:23 +0100, Thierry Reding <thierry.reding@gmail.com> wrote:
> > On Wed, Nov 27, 2013 at 03:56:29PM +0000, Grant Likely wrote:
> > > On Mon, 25 Nov 2013 10:49:55 +0100, Thierry Reding <thierry.reding@gmail.com> wrote:
> > > > 
> > > > I should maybe add: one issue that was raised during review of my
> > > > initial patch series was that we'll also need to cope with situations
> > > > like the following:
> > > > 
> > > > 	1) device's interrupt parent is probed (assigned IRQ base X)
> > > > 	2) device is probed (interrupt parent there, therefore gets
> > > > 	   assigned IRQ (X + z)
> > > > 	3) device in removed
> > > > 	4) device's interrupt parent is removed
> > > > 	5) device is probed (deferred because interrupt parent isn't
> > > > 	   there)
> > > > 	6) device's interrupt parent is probed (assigned IRQ base Y)
> > > > 	7) device is probed, gets assigned IRQ (Y + z)
> > > > 
> > > > So not only do we have to track which resources are interrupt resources,
> > > > but we also need to have them reassigned everytime the device is probed,
> > > > therefore interrupt mappings need to be properly disposed and the values
> > > > invalidated when probing is deferred or the device removed.
> > > 
> > > Yes, that is a problem, but the only way to handle that is to always
> > > recalcuate all resource references at probe time. I don't feel good
> > > about handling that in the core. I'd rather move drivers away from
> > > referencing the resources table directly and instead use an API. Then
> > > the resources table could be missing entirely.
> > 
> > Are you suggesting something like this?
> > 
> > ---
> > 
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 3a94b799f166..c894d1af3a5e 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/string.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/of_device.h>
> > +#include <linux/of_irq.h>
> >  #include <linux/module.h>
> >  #include <linux/init.h>
> >  #include <linux/dma-mapping.h>
> > @@ -87,7 +88,12 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
> >                 return -ENXIO;
> >         return dev->archdata.irqs[num];
> >  #else
> > -       struct resource *r = platform_get_resource(dev, IORESOURCE_IRQ, num);
> > +       struct resource *r;
> > +
> > +       if (IS_ENABLED(CONFIG_OF) && dev->dev.of_node)
> > +               return irq_of_parse_and_map(dev->dev.of_node, num);
> > +
> > +       r = platform_get_resource(dev, IORESOURCE_IRQ, num);
> 
> Yes. Or even more generically we could have a device_get_irq() function:
> 
> int device_get_irq(struct device *dev, unsigned int num)
> {
> 	if (IS_ENABLED(CONFIG_OF) && dev->of_node)
> 		return irq_of_parse_and_map(dev->of_node, num);
> 	/* An ACPI hook could go here */
> 	return 0
> }
> 
> It would be callable by any device driver, and platform_get_irq() could
> call it too.

So how about we make the platform_get_irq() modification for starters,
so that the OMAP issues can be resolved and then turn our attention to
coming up with a more generic approach. If indeed we end up with what
you're proposing we can easily switch platform_get_irq() to use it.

One of the things I'm not so sure about is how to handle other types of
resources, since they'll be somewhat more specific to the type of
device. That's true also for devices other than platform devices. Let's
look at I2C devices for instance. The way to get at the IRQ number is
via the i2c_client->irq member.

device_get_irq() breaks down at that point because unless you want to
add special cases for all sorts of devices you have no way of getting at
the data if it hasn't been instantiated from DT (or ACPI). Actually, all
devices instantiated from platform data will suffer from this if I'm not
mistaken.

If you're saying that the device_get_irq() API should only cover cases
where some sort of firmware interface exists such as DT or ACPI, then I
suppose it could be made to work and drivers could rely on the subsystem
specific locations as fallback. I guess for I2C drivers you'd have to do
something like this:

	err = device_get_irq(&client->dev, 0);
	if (err >= 0)
		client->irq = err;

And then continue to use client->irq as usual. That obviously has the
side-effect of having to do this for every single driver, whereas the
original patches were meant to solve this in the core.

Given enough time we could probably migrate everyone to the new
interfaces, but it certainly is a lot of churn. Perhaps another
alternative would be to unify this some more by making each subsystem
provide special hooks that device_get_irq() and friends can call for
fallback when none of the "firmware" functions were successful.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131211/cb4c6144/attachment-0001.sig>
