From: hzpeterchen@gmail.com (Peter Chen)
Date: Fri, 4 Mar 2016 09:53:26 +0800
Subject: [PATCH 2/3] usb: chipidea: host: let the hcd know's parent
 device node
In-Reply-To: <20160303144247.GH15541@lunn.ch>
References: <1456999276-6315-1-git-send-email-peter.chen@nxp.com>
 <1456999276-6315-3-git-send-email-peter.chen@nxp.com>
 <20160303144247.GH15541@lunn.ch>
Message-ID: <20160304015326.GA30272@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2016 at 03:42:47PM +0100, Andrew Lunn wrote:
> On Thu, Mar 03, 2016 at 06:01:15PM +0800, Peter Chen wrote:
> > From: Peter Chen <peter.chen@freescale.com>
> > 
> > Since the hcd (chipidea core device) has no device node, so
> > if we want to describe the child node under the hcd, we had
> > to put it under its parent's node (glue layer device), and
> > in the code, we need to let the hcd knows glue layer's code,
> > then the USB core can handle this node.
> > 
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > ---
> >  drivers/usb/chipidea/host.c | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
> > index 053bac9..55120ef 100644
> > --- a/drivers/usb/chipidea/host.c
> > +++ b/drivers/usb/chipidea/host.c
> > @@ -109,15 +109,25 @@ static int host_start(struct ci_hdrc *ci)
> >  	struct ehci_hcd *ehci;
> >  	struct ehci_ci_priv *priv;
> >  	int ret;
> > +	struct device *dev = ci->dev;
> >  
> > -	if (usb_disabled())
> > +	if (usb_disabled() || !dev)
> >  		return -ENODEV;
> >  
> > -	hcd = usb_create_hcd(&ci_ehci_hc_driver, ci->dev, dev_name(ci->dev));
> > +	/*
> > +	 * USB Core will try to get child node under roothub,
> > +	 * but chipidea core has no of_node, and the child node
> > +	 * for controller is located at glue layer's node which
> > +	 * is chipidea core's parent.
> > +	 */
> > +	if (dev->parent && dev->parent->of_node)
> > +		dev->of_node = dev->parent->of_node;
> 
> Is this a good idea? Two devices with the same of_node?
> 

This is only for chipidea driver whose host controller device
doesn't have entry at dts, but other host controller driver which
supports device tree should have its entry at dts.

> I know the networking code assumes of_node values are unique, and uses
> it to find a device. Are you 100% sure the USB code does not make this
> assumption.
> 

The controller device is the root for USB device, the common
USB code will not touch its glue layer device (controller's parent).

-- 

Best Regards,
Peter Chen
