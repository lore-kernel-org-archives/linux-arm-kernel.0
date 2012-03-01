From: jason@lakedaemon.net (Jason)
Date: Thu, 1 Mar 2012 16:26:20 -0500
Subject: [PATCH 3/4] ARM: kirkwood: convert rtc-mv to fdt.
In-Reply-To: <201203011935.58503.arnd@arndb.de>
References: <cover.1330625877.git.jason@lakedaemon.net>
 <2c985a303f3b9b0cfcead25634b7e1db68d34ee3.1330625878.git.jason@lakedaemon.net>
 <201203011935.58503.arnd@arndb.de>
Message-ID: <20120301212620.GD11986@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2012 at 07:35:58PM +0000, Arnd Bergmann wrote:
> On Thursday 01 March 2012, Jason Cooper wrote:
> > The comment at mach-kirkwood/common.c:469, says this device is in every
> > kirkwood board.  So, it is placed in kirkwood.dtsi.
> >
> > @@ -218,10 +220,15 @@ static int __devinit mv_rtc_probe(struct platform_device *pdev)
> >  {
> >  	struct resource *res;
> >  	struct rtc_plat_data *pdata;
> > +	struct device_node *np = pdev->dev.of_node;
> >  	resource_size_t size;
> >  	u32 rtc_time;
> >  
> >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +
> > +	if (np)
> > +		of_address_to_resource(np, 0, res);
> > +
> >  	if (!res)
> >  		return -ENODEV;
> >  
> > @@ -257,6 +264,8 @@ static int __devinit mv_rtc_probe(struct platform_device *pdev)
> >  
> >  	pdata->irq = platform_get_irq(pdev, 0);
> >  
> > +	of_property_read_u32(np, "interrupts", &pdata->irq);
> > +
> >  	platform_set_drvdata(pdev, pdata);
> >  
> >  	if (pdata->irq >= 0) {
> 
> The two additions here don't seem necessary, the second one not even
> correct: Any interrupts and register properties automatically get
> turned into platform resources when the device is instatiated.
> 
> The interrupt number should not be taken verbatim from the device tree
> because it is always local to the "interrupt-parent" node, so you would
> have to use irq_of_parse_and map rather than reading the property
> directly, but as I said you don't even need to do that for platform
> devices.

Learning everyday... :-)

thx,

Jason.
