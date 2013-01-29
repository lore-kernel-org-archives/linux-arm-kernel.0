From: florian@openwrt.org (Florian Fainelli)
Date: Tue, 29 Jan 2013 21:41:45 +0100
Subject: [PATCH 4/5] net: mvmdio: allow Device Tree and platform device to
 coexist
In-Reply-To: <20130129175912.GE25646@obsidianresearch.com>
References: <1359473048-26551-1-git-send-email-florian@openwrt.org>
 <1359473048-26551-5-git-send-email-florian@openwrt.org>
 <20130129175912.GE25646@obsidianresearch.com>
Message-ID: <201301292141.45931.florian@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le mardi 29 janvier 2013 18:59:12, Jason Gunthorpe a ?crit :
> On Tue, Jan 29, 2013 at 04:24:07PM +0100, Florian Fainelli wrote:
> > -	dev->err_interrupt = irq_of_parse_and_map(pdev->dev.of_node, 0);
> > +	if (pdev->dev.of_node) {
> > +		dev->regs = of_iomap(pdev->dev.of_node, 0);
> > +		if (!dev->regs) {
> > +			dev_err(&pdev->dev, "No SMI register address given in 
DT\n");
> > +			ret = -ENODEV;
> > +			goto out_free;
> > +		}
> > +
> > +		dev->err_interrupt = irq_of_parse_and_map(pdev->dev.of_node, 0);
> > +	} else {
> > +		r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +
> > +		dev->regs = ioremap(r->start, resource_size(r));
> > +		if (!dev->regs) {
> > +			dev_err(&pdev->dev, "No SMI register address given\n");
> > +			ret = -ENODEV;
> > +			goto out_free;
> > +		}
> > +
> > +		dev->err_interrupt = platform_get_irq(pdev, 0);
> > +	}
> 
> Why do you have these different paths for OF and platform? AFAIK these
> days when a OF device is automatically converted into a platform
> device all the struct resources are created too, so you can't you just
> use platform_get_resource and devm_request_and_ioremap for both flows?
> 
> Ditto for the interrupt - platform_get_irq should work in both cases?

There was no particular reason and I updated the patchset to do that precisely 
in version 2.
-- 
Florian
