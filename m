From: hzpeterchen@gmail.com (Peter Chen)
Date: Thu, 21 Jul 2016 17:20:12 +0800
Subject: [PATCH v3 5/6] usb: chipidea: let chipidea core device of_node
 equal's glue layer device of_node
In-Reply-To: <20160721091438.GL1041@n2100.armlinux.org.uk>
References: <1469007629-31757-1-git-send-email-peter.chen@nxp.com>
 <1469007629-31757-6-git-send-email-peter.chen@nxp.com>
 <20160721091438.GL1041@n2100.armlinux.org.uk>
Message-ID: <20160721092012.GA22749@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2016 at 10:14:38AM +0100, Russell King - ARM Linux wrote:
> On Wed, Jul 20, 2016 at 05:40:28PM +0800, Peter Chen wrote:
> > diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> > index 69426e6..0d05812 100644
> > --- a/drivers/usb/chipidea/core.c
> > +++ b/drivers/usb/chipidea/core.c
> > @@ -914,6 +914,16 @@ static int ci_hdrc_probe(struct platform_device *pdev)
> >  	if (!ci)
> >  		return -ENOMEM;
> >  
> > +	/*
> > +	 * At device tree, we have no device node for chipidea core,
> > +	 * the glue layer's node is the parent node for host and udc
> > +	 * device. But in related driver, the parent device is chipidea
> > +	 * core. So, in order to let the common driver get parent's node,
> > +	 * we let the core's device node equals glue layer's node.
> > +	 */
> > +	if (dev->parent && dev->parent->of_node)
> > +		dev->of_node = dev->parent->of_node;
> 
> This is a dangerous thing to do.  You're changing the dev->of_node of
> _this_ device, which means that _this_ driver will no longer match
> the device if you remove and reinsert the driver module, or unbind
> and try to re-bind the device to this driver.
> 

Thanks for commenting it.

I have tested load/unload, it does not show any problems.

The chipidea core device is created by code at runtime, not by device node.
And we have NO device node for this chipidea core device at dts.

-- 

Best Regards,
Peter Chen
