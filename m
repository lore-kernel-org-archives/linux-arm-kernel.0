From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Thu, 5 Jun 2014 18:56:23 +0200
Subject: [PATCH 1/9] reset: add the Berlin reset controller driver
In-Reply-To: <1401986205.4103.9.camel@paszta.hi.pengutronix.de>
References: <1401983326-19205-1-git-send-email-antoine.tenart@free-electrons.com>
 <1401983326-19205-2-git-send-email-antoine.tenart@free-electrons.com>
 <1401986205.4103.9.camel@paszta.hi.pengutronix.de>
Message-ID: <20140605165623.GB21960@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Thu, Jun 05, 2014 at 06:36:45PM +0200, Philipp Zabel wrote:
> > +#include <linux/platform_device.h>
> 
> Is there a reason this is not actually implemented as platform device?

The node describing this driver is shared with a pin controller and a
clock driver. The pin controller is implemented as a platform device. I
don't think we can have two platform device drivers using the device
tree for the same node. Or I'm maybe missing something.

> 
> > +#include <linux/reset-controller.h>
> > +#include <linux/slab.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/types.h>
> > +
> > +#define BERLIN_RESET_REGISTER		0x104
> 
> How many reset registers are there? (See below).

I don't have lots of information about this. For now only the one used
to reset the USB PHY but others may come later.

> > +
> > +static int berlin_reset_reset(struct reset_controller_dev *rcdev,
> > +			      unsigned long id)
> > +{
> > +	struct berlin_reset_priv *priv = to_berlin_reset_priv(rcdev);
> > +	unsigned long flags;
> > +	int bank = id / BITS_PER_LONG;
> > +	int offset = id % BITS_PER_LONG;
> > +
> > +	spin_lock_irqsave(&priv->lock, flags);
> > +
> > +	writel(BIT(offset), priv->base + bank * 4);
> > +
> > +	spin_unlock_irqrestore(&priv->lock, flags);
> 
> Since this is a single write into an apparently self-clearing
> register, I see no need for the spinlock here.

Sure.

> 
> > +	/* let the reset be effective */
> > +	udelay(10);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct reset_control_ops berlin_reset_ops = {
> > +	.reset	= berlin_reset_reset,
> > +};
> > +
> > +static int __berlin_reset_init(struct device_node *np)
> > +{
> > +	struct berlin_reset_priv *priv;
> > +	struct resource res;
> > +	resource_size_t size;
> > +	int ret;
> > +
> > +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	ret = of_address_to_resource(np, 0, &res);
> > +	if (ret)
> > +		goto err;
> > +
> > +	size = resource_size(&res);
> > +
> > +	priv->base = ioremap(res.start, size);
> > +	if (!priv->base) {
> > +		ret = -ENOMEM;
> > +		goto err;
> > +	}
> 
> A platform driver could use devm_kzalloc, platform_get_resource,
> and devm_ioremap_resource here.
> 
> > +	priv->base += BERLIN_RESET_REGISTER;
> > +
> > +	priv->rcdev.owner = THIS_MODULE;
> > +	priv->rcdev.nr_resets = size * 32;
> 
> This doesn't seem right. The device tree patch shows that
> size = 0x400.

The reg property is shared between drivers using the common chip
controller node. I do not know how many registers are actually used
to reset.

We then could hardcode the size, with the registers actually used here?


Thanks for the review!

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
