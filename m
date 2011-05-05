From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 5 May 2011 12:00:27 +0200
Subject: AT91: Convert WDT driver to be independent of processor
	base-address
In-Reply-To: <20110504211229.GA31808@n2100.arm.linux.org.uk>
References: <1304110090.14210.2.camel@redbox>
	<20110504211229.GA31808@n2100.arm.linux.org.uk>
Message-ID: <20110505100027.GA11267@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22:12 Wed 04 May     , Russell King - ARM Linux wrote:
> On Fri, Apr 29, 2011 at 10:48:10PM +0200, Andrew Victor wrote:
> > @@ -248,11 +250,17 @@ static struct miscdevice at91wdt_miscdev = {
> >  
> >  static int __init at91wdt_probe(struct platform_device *pdev)
> >  {
> > +	struct resource	*r;
> >  	int res;
> >  
> > +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!r)
> > +		return -ENODEV;
> > +
> >  	if (at91wdt_miscdev.parent)
> >  		return -EBUSY;
> >  	at91wdt_miscdev.parent = &pdev->dev;
> > +	at91wdt_private.regbase = (void __force __iomem *) r->start;
> 
> Passing virtual addresses through iomem resources really isn't nice - they
> get added to the resource tree as bus addresses, which actually being
> virtual addresses can conflict with real bus addresses.
> 
> The proper way to handle this is like every other platform driver, and to
> use ioremap() on the resource to obtain a virtual mapping for the device.
> 
> If you wish to reuse your fixed io mapping, then override ioremap() in
> a similar way to OMAP and arrange for bus addresses in the fixed io
> mapping to return an appropriate iomem pointer for those.
ok will update

Best Regards,
J.
