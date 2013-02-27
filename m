From: balbi@ti.com (Felipe Balbi)
Date: Wed, 27 Feb 2013 10:42:18 +0200
Subject: [PATCH v8 8/8] usb: chipidea: udc: fix the oops when plugs in
 usb cable after rmmod gadget
In-Reply-To: <20130227031002.GB20402@nchen-desktop>
References: <1360051215-27722-1-git-send-email-peter.chen@freescale.com>
 <1360051215-27722-9-git-send-email-peter.chen@freescale.com>
 <20130213084128.GB2426@arwen.pp.htv.fi>
 <20130217030951.GA1588@nchen-desktop>
 <20130226182141.GB2626@arwen.pp.htv.fi>
 <20130227031002.GB20402@nchen-desktop>
Message-ID: <20130227084218.GL8016@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 11:10:03AM +0800, Peter Chen wrote:
> On Tue, Feb 26, 2013 at 08:21:41PM +0200, Felipe Balbi wrote:
> > Hi,
> > 
> > On Sun, Feb 17, 2013 at 11:09:53AM +0800, Peter Chen wrote:
> > > @@ -1373,6 +1375,8 @@ static int ci13xxx_vbus_session(struct usb_gadget *_gadget, int is_active)
> > >  			hw_device_state(ci, ci->ep0out->qh.dma);
> > >  			dev_dbg(ci->dev, "Connected to host\n");
> > >  		} else {
> > > +			if (ci->driver)
> > > +				ci->driver->disconnect(&ci->gadget);
> > 
> > This looks wrong. Why do you need to call ->disconnect() here ?
> 
> When we disconnect usb cable from the host, we need to notify gadget module 
> disconnection occurs, the gadget module may not be unloaded in future.

ok, I get it now, after reading the code I see that this gets called
from your VBUS IRQ handler (actually you queue an unnecessary workqueue
for that).

> If the disconnection is not notified, the gadget module may still call
> struct usb_ep_ops's API to visit hardware at its thread but the controller 
> may already enter low power mode.
> 
> In fact, a common problem is how can we make sure the gadget will not
> visit register if the controller enters low power mode, currently,
> there is no prefect solution.  

yeah, I have an idea for that, but won't happen for v3.10 I'm afraid...

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130227/085bf7dd/attachment.sig>
