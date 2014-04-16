From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 16 Apr 2014 17:40:43 +0200
Subject: [PATCH v3 3/4] USB: ohci-pxa27x: Add support for external vbus
 regulators
In-Reply-To: <Pine.LNX.4.44L0.1404161102020.1334-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1404161102020.1334-100000@iolanthe.rowland.org>
Message-ID: <3809376.jpq2vXsk1Y@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,

On Wednesday 16 April 2014 11:07:34 Alan Stern wrote:
> On Wed, 16 Apr 2014, Laurent Pinchart wrote:
> > Override the hub control operation to enable and disable external
> > regulators for the ports vbus power supply in response to clear/set
> > USB_PORT_FEAT_POWER requests.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > @@ -417,6 +467,16 @@ int usb_hcd_pxa27x_probe (const struct hc_driver
> > *driver, struct platform_device> 
> >  	pxa_ohci->clk = usb_clk;
> >  	pxa_ohci->mmio_base = (void __iomem *)hcd->regs;
> > 
> > +	for (i = 0; i < 3; ++i) {
> > +		char name[6];
> > +
> > +		if (!(inf->flags & (ENABLE_PORT1 << i)))
> > +			continue;
> > +
> > +		sprintf(name, "vbus%u", i + 1);
> > +		pxa_ohci->vbus[i] = devm_regulator_get(&pdev->dev, name);
> > +	}
> > +
> > 
> >  	retval = pxa27x_start_hc(pxa_ohci, &pdev->dev);
> >  	if (retval < 0) {
> >  	
> >  		pr_debug("pxa27x_start_hc failed");
> > 
> > @@ -462,6 +522,10 @@ int usb_hcd_pxa27x_probe (const struct hc_driver
> > *driver, struct platform_device> 
> >  void usb_hcd_pxa27x_remove (struct usb_hcd *hcd, struct platform_device
> >  *pdev) {
> >  
> >  	struct pxa27x_ohci *pxa_ohci = to_pxa27x_ohci(hcd);
> > 
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < 3; ++i)
> > +		pxa27x_ohci_set_vbus_power(pxa_ohci, i, false);
> > 
> >  	usb_remove_hcd(hcd);
> >  	pxa27x_stop_hc(pxa_ohci, &pdev->dev);
> 
> You probably should leave the port power enabled until after
> usb_remove_hcd() returns.  Apart from that,
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Good point, I'll fix that and submit v4. Thank you.

-- 
Regards,

Laurent Pinchart
