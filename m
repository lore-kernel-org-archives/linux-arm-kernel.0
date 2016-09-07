From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Sep 2016 21:45:55 +0200
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <Pine.LNX.4.44L0.1609071158160.2115-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1609071158160.2115-100000@iolanthe.rowland.org>
Message-ID: <2360127.zmY5dTBf6B@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 7, 2016 12:08:20 PM CEST Alan Stern wrote:
> On Wed, 7 Sep 2016, Arnd Bergmann wrote:
> 
> >  drivers/usb/host/ehci-fsl.c    |  4 ++--
> 
> How did this driver end up in the patch?
>
> > diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
> > index 9f5ffb629973..b2419950221f 100644
> > --- a/drivers/usb/host/ehci-fsl.c
> > +++ b/drivers/usb/host/ehci-fsl.c
> > @@ -96,8 +96,8 @@ static int fsl_ehci_drv_probe(struct platform_device *pdev)
> >  	}
> >  	irq = res->start;
> >  
> > -	hcd = usb_create_hcd(&fsl_ehci_hc_driver, &pdev->dev,
> > -				dev_name(&pdev->dev));
> > +	hcd = __usb_create_hcd(&fsl_ehci_hc_driver, &pdev->dev.parent,
> > +				&pdev->dev, dev_name(&pdev->dev), NULL);
> 
> Based on the
> 
> 	if (of_device_is_compatible(dev->parent->of_node,
> 				    "fsl,mpc5121-usb2-dr")) {
> 
> lines in the driver?

No, based on the "fsl-ehci" name, which is only used as a child
of the drivers/usb/host/fsl-mph-dr-of.c dual-role driver.

I looked for drivers that call platform_device_add() and manipulate
the dma_mask of that child.

Sorry for missing this one when I did the description. I believe
it is correct though. The DMA settings on powerpc are probably correct
in this case, but the existing code doesn't allow you to describe
on-board USB devices with additional properties as children of
the dual-role device node.

	Arnd
