From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 7 Mar 2012 18:34:37 +0100
Subject: [PATCH 1/1] of: add dma-mask binding
In-Reply-To: <4F5793E9.9010100@gmail.com>
References: <1331119575-6638-1-git-send-email-plagnioj@jcrosoft.com>
 <4F5793E9.9010100@gmail.com>
Message-ID: <20120307173437.GC17087@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:59 Wed 07 Mar     , Rob Herring wrote:
> On 03/07/2012 05:26 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > This will allow each device to specify its dma-mask
> > The microblaze architecture hook is keep temporary if no dma-mask is specified
> > int the DT
> > 
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > ---
> >  drivers/of/platform.c |   26 +++++++++++++++++++++++++-
> >  1 files changed, 25 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > index cae9477..bb22194 100644
> > --- a/drivers/of/platform.c
> > +++ b/drivers/of/platform.c
> > @@ -121,6 +121,26 @@ void of_device_make_bus_id(struct device *dev)
> >  	dev_set_name(dev, "%s.%d", node->name, magic - 1);
> >  }
> >  
> > +static u64* of_get_dma_mask(struct device_node *np)
> > +{
> > +	const __be32 *prop;
> > +	int len;
> > +	u64 *dma_mask;
> > +
> > +	prop = of_get_property(np, "dma-mask", &len);
> 
> This would need some documentation. There is already "dma-ranges"
> defined for OF which nay do what's needed.
what is dma-ranges I see no doc about it
but I don't think it could be used for the dma mask
> 
> > +
> > +	if (!prop)
> > +		return NULL;
> > +
> > +	dma_mask = kzalloc(sizeof(u64), GFP_KERNEL);
> 
> This seems kind of wasteful for 1 u64.
no choice dma_mask must be a pointer
> 
> > +	if (!dma_mask)
> > +		return NULL;
> > +
> > +	*dma_mask = of_read_number(prop, len / 4);
> > +
> > +	return dma_mask;
> > +}
> > +
> >  /**
> >   * of_device_alloc - Allocate and initialize an of_device
> >   * @np: device node to assign to device
> > @@ -161,10 +181,14 @@ struct platform_device *of_device_alloc(struct device_node *np,
> >  		WARN_ON(of_irq_to_resource_table(np, res, num_irq) != num_irq);
> >  	}
> >  
> > +	dev->dev.dma_mask = of_get_dma_mask(np);
> >  	dev->dev.of_node = of_node_get(np);
> > +
> >  #if defined(CONFIG_MICROBLAZE)
> > -	dev->dev.dma_mask = &dev->archdata.dma_mask;
> 
> And doing it this way for didn't get a warm reception either:
> 
> http://lists.ozlabs.org/pipermail/devicetree-discuss/2011-April/005285.html
> 
> Do you really need this to be something other than ~0UL and if so does
> it need to be per device or system wide?
> 
> You can solve this with bus notifiers in your at91 code. Here's an
> example which I did (but no longer need):
> 
> static u64 highbank_dma_mask = DMA_BIT_MASK(32);
IIRC on at91 all of them that need it have a DMA_BIT_MASK(32)


> 
> static int highbank_platform_notifier(struct notifier_block *nb,
> 				  unsigned long event, void *__dev)
> {
> 	struct device *dev = __dev;
> 
> 	if (event != BUS_NOTIFY_ADD_DEVICE)
> 		return NOTIFY_DONE;
> 
> 	if (of_device_is_compatible(dev->of_node, "calxeda,hb-nfc"))
> 		dev->dma_mask = &highbank_dma_mask;
execpt as example today I need it on 2 node (OHCI & EHCI)

and if more device need I don't want to end up with more fixup

I really prefer to set it via DT

Best Regards,
J.
