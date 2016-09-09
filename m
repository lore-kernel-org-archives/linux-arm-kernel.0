From: hzpeterchen@gmail.com (Peter Chen)
Date: Fri, 9 Sep 2016 09:37:43 +0800
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <6547614.50rx8ya9lj@wuerfel>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <4934737.egJZVdaLZs@wuerfel>
 <20160908122810.GA14132@b29397-desktop>
 <6547614.50rx8ya9lj@wuerfel>
Message-ID: <20160909013743.GB15637@b29397-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 02:52:29PM +0200, Arnd Bergmann wrote:
> On Thursday, September 8, 2016 8:28:10 PM CEST Peter Chen wrote:
> > On Thu, Sep 08, 2016 at 12:17:21PM +0200, Arnd Bergmann wrote:
> > > On Thursday, September 8, 2016 12:43:06 PM CEST Felipe Balbi wrote:
> > > > Arnd Bergmann <arnd@arndb.de> writes:
> > > > > On Thursday, September 8, 2016 11:29:04 AM CEST Felipe Balbi wrote:
> > > > If we have a parent device, use that as sysdev, otherwise use self as
> > > > sysdev.
> > > 
> > > But there is often a parent device in DT, as the xhci device is
> > > attached to some internal bus that gets turned into a platform_device
> > > as well, so checking whether there is a parent will get the wrong
> > > device node.
> > 
> > From my point, all platform and firmware information at dwc3 are
> > correct, so we don't need to change dwc3/core.c, only changing for
> > xhci-plat.c is ok.
> 
> Ok, thanks. That leaves the PCI glue, right?

If pci's firmware information can only get from dwc3-pci, I was wrong.
I am almost sure your patch covers all 3 cases. dwc3->sysdev covers
dwc3 core and gadget side, hcd->self.sysdev cover host side. The only
possible improvement may be how to detect pci device.

> 
> > diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> > index d2e3f65..563600b 100644
> > --- a/drivers/usb/core/hcd.c
> > +++ b/drivers/usb/core/hcd.c
> > @@ -1118,7 +1118,7 @@ static int register_root_hub(struct usb_hcd *hcd)
> >  		/* Did the HC die before the root hub was registered? */
> >  		if (HCD_DEAD(hcd))
> >  			usb_hc_died (hcd);	/* This time clean up */
> > -		usb_dev->dev.of_node = parent_dev->of_node;
> > +		usb_dev->dev.of_node = parent_dev->sysdev->of_node;
> >  	}
> >  	mutex_unlock(&usb_bus_idr_lock);
> > 
> > At above changes, the root hub's of_node equals to xhci-hcd sysdev's
> > of_node, which is from firmware or from its parent (it is dwc3 core
> > device).
> 
> Just to make sure I understand you right:
> 
> in the qcom,dwc3 -> dwc3 -> xhci hierarchy, this would be the
> dwc3 device, not the qcom,dwc3 device.
> 

Yes, since there is a DT node for dwc3, and firmware information is there,
that's why the original patch (Grygorii Strashko's) can work.

-- 

Best Regards,
Peter Chen
