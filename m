From: hzpeterchen@gmail.com (Peter Chen)
Date: Fri, 4 Mar 2016 10:32:33 +0800
Subject: [PATCH 2/3] usb: chipidea: host: let the hcd know's parent
 device node
In-Reply-To: <20160304021730.GA20597@lunn.ch>
References: <1456999276-6315-1-git-send-email-peter.chen@nxp.com>
 <1456999276-6315-3-git-send-email-peter.chen@nxp.com>
 <20160303144247.GH15541@lunn.ch>
 <20160304015326.GA30272@shlinux2.ap.freescale.net>
 <20160304021730.GA20597@lunn.ch>
Message-ID: <20160304023233.GE30272@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 04, 2016 at 03:17:30AM +0100, Andrew Lunn wrote:
> > > > diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
> > > > index 053bac9..55120ef 100644
> > > > --- a/drivers/usb/chipidea/host.c
> > > > +++ b/drivers/usb/chipidea/host.c
> > > > @@ -109,15 +109,25 @@ static int host_start(struct ci_hdrc *ci)
> > > >  	struct ehci_hcd *ehci;
> > > >  	struct ehci_ci_priv *priv;
> > > >  	int ret;
> > > > +	struct device *dev = ci->dev;
> > > >  
> > > > -	if (usb_disabled())
> > > > +	if (usb_disabled() || !dev)
> > > >  		return -ENODEV;
> > > >  
> > > > -	hcd = usb_create_hcd(&ci_ehci_hc_driver, ci->dev, dev_name(ci->dev));
> > > > +	/*
> > > > +	 * USB Core will try to get child node under roothub,
> > > > +	 * but chipidea core has no of_node, and the child node
> > > > +	 * for controller is located at glue layer's node which
> > > > +	 * is chipidea core's parent.
> > > > +	 */
> > > > +	if (dev->parent && dev->parent->of_node)
> > > > +		dev->of_node = dev->parent->of_node;
> > > 
> > > Is this a good idea? Two devices with the same of_node?
> > > 
> > 
> > This is only for chipidea driver whose host controller device
> > doesn't have entry at dts, but other host controller driver which
> > supports device tree should have its entry at dts.
> > 
> > > I know the networking code assumes of_node values are unique, and uses
> > > it to find a device. Are you 100% sure the USB code does not make this
> > > assumption.
> > > 
> > 
> > The controller device is the root for USB device, the common
> > USB code will not touch its glue layer device (controller's parent).
> 
> I'm just thinking about code like:
> 
> of_find_spi_master_by_node(), of_find_net_device_by_node(),
> of_find_backlight_by_node(), etc.
> 
> If somebody was to implement an of_find_usb_host_by_node() are you
> 100% sure the right node will be found? This seems like a bug waiting
> to happen.

Yes, almost 100% sure it is ok since the common USB code will never use
its root's parent node to match or get something.

-- 

Best Regards,
Peter Chen
