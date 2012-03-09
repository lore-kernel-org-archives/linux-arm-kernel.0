From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 08 Mar 2012 17:59:23 -0700
Subject: [PATCH 1/1] of: add dma-mask binding
In-Reply-To: <20120307173437.GC17087@game.jcrosoft.org>
References: <1331119575-6638-1-git-send-email-plagnioj@jcrosoft.com>
 <4F5793E9.9010100@gmail.com> <20120307173437.GC17087@game.jcrosoft.org>
Message-ID: <20120309005923.2E04F3E0901@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[cc'ing Russell and Ben because my dma-mask-foo is weak]

On Wed, 7 Mar 2012 18:34:37 +0100, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:
> On 10:59 Wed 07 Mar     , Rob Herring wrote:
> > On 03/07/2012 05:26 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > This will allow each device to specify its dma-mask
> > > The microblaze architecture hook is keep temporary if no dma-mask is specified
> > > int the DT
> > > 
> > > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > > ---
> > >  drivers/of/platform.c |   26 +++++++++++++++++++++++++-
> > >  1 files changed, 25 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > > index cae9477..bb22194 100644
> > > --- a/drivers/of/platform.c
> > > +++ b/drivers/of/platform.c
> > > @@ -121,6 +121,26 @@ void of_device_make_bus_id(struct device *dev)
> > >  	dev_set_name(dev, "%s.%d", node->name, magic - 1);
> > >  }
> > >  
> > > +static u64* of_get_dma_mask(struct device_node *np)
> > > +{
> > > +	const __be32 *prop;
> > > +	int len;
> > > +	u64 *dma_mask;
> > > +
> > > +	prop = of_get_property(np, "dma-mask", &len);
> > 
> > This would need some documentation. There is already "dma-ranges"
> > defined for OF which nay do what's needed.
> what is dma-ranges I see no doc about it
> but I don't think it could be used for the dma mask

As Rob says, it's documented in ePAPR.

> > 
> > > +
> > > +	if (!prop)
> > > +		return NULL;
> > > +
> > > +	dma_mask = kzalloc(sizeof(u64), GFP_KERNEL);
> > 
> > This seems kind of wasteful for 1 u64.
> no choice dma_mask must be a pointer

We could merely add an empty dma_mask u64 to the containing struct
platform_device and then assign the pointer to dev.dma_mask if it is
needed.  That would eliminate the malloc.  Or we could by default
use dev->dev.dma_mask = &dev->dev.coherent_dma_mask;  Drivers or
notifier code could override whatever we setup here as the default.

dma-ranges really is the property that should be used for this, but
dma-ranges can describe a different set of permutations than dma_mask.
The former can have any number of valid DMA windows, but dma_mask
is based on per-address-line values.  (The whole dma_mask approach
appears insufficient to me, but I don't understand all the background
details as to why it is implemented that way).

I'd like to avoid defining a new mechanism for describing the valid
dma layout if at all possible.  This could be done with a new function
to fetch and parse each of the dma-ranges tuples and extract the
intersect of the ranges.  It will never be a perfect translation,
particularly because RAM doesn't start at 0 on a lot of platforms.

So, let's call the base of ram X, and the top of ram X+S.  Then let's
assume that dma_mask is intended to filter out high address (instead
of broken DMA low addresses) and that the DMA limitations are based
on attached address lines, not arbitrary start-end addresses, so if
we let number of address lines be 'A', then dma_mask = 2^A-1
(ideally).  Individual bits could also be blanked out, but what that
really means in a practical sense is that those address lines must be
0.  There isn't a way to constrain address bits that must be set to 1.

Okay, so if we assume that linux will never choose a dma address below
X (because there is no RAM there; except in the iommu case which can
put dma addresses where it needs to regardless), then we only need to
worry about the upper range for a device.  We could derive a dma_mask
by calling of_translate_address on the base address of each dma-ranges
tuple and finding the one that starts at or below the base of memory.
Then the default dma_mask can perhaps be calculated thusly (using 'Y'
for top of the chosen dma-range tuple):

	dma_mask = (2 ^ fls64(Y)) - 1;

Alternately, we could simply decide to do as you suggest and define a
dma-mask property because that approach is sufficient for a lot of
hardware and is therefore is a reasonable binding.

Thoughts?

> > 
> > > +	if (!dma_mask)
> > > +		return NULL;
> > > +
> > > +	*dma_mask = of_read_number(prop, len / 4);
> > > +
> > > +	return dma_mask;
> > > +}
> > > +
> > >  /**
> > >   * of_device_alloc - Allocate and initialize an of_device
> > >   * @np: device node to assign to device
> > > @@ -161,10 +181,14 @@ struct platform_device *of_device_alloc(struct device_node *np,
> > >  		WARN_ON(of_irq_to_resource_table(np, res, num_irq) != num_irq);
> > >  	}
> > >  
> > > +	dev->dev.dma_mask = of_get_dma_mask(np);
> > >  	dev->dev.of_node = of_node_get(np);
> > > +
> > >  #if defined(CONFIG_MICROBLAZE)
> > > -	dev->dev.dma_mask = &dev->archdata.dma_mask;
> > 
> > And doing it this way for didn't get a warm reception either:
> > 
> > http://lists.ozlabs.org/pipermail/devicetree-discuss/2011-April/005285.html
> > 
> > Do you really need this to be something other than ~0UL and if so does
> > it need to be per device or system wide?
> > 
> > You can solve this with bus notifiers in your at91 code. Here's an
> > example which I did (but no longer need):
> > 
> > static u64 highbank_dma_mask = DMA_BIT_MASK(32);
> IIRC on at91 all of them that need it have a DMA_BIT_MASK(32)
> 
> 
> > 
> > static int highbank_platform_notifier(struct notifier_block *nb,
> > 				  unsigned long event, void *__dev)
> > {
> > 	struct device *dev = __dev;
> > 
> > 	if (event != BUS_NOTIFY_ADD_DEVICE)
> > 		return NOTIFY_DONE;
> > 
> > 	if (of_device_is_compatible(dev->of_node, "calxeda,hb-nfc"))
> > 		dev->dma_mask = &highbank_dma_mask;
> execpt as example today I need it on 2 node (OHCI & EHCI)
> 
> and if more device need I don't want to end up with more fixup
> 
> I really prefer to set it via DT
> 
> Best Regards,
> J.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
email sent from notmuch.vim plugin
