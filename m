From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 27 Feb 2013 11:10:03 +0800
Subject: [PATCH v8 8/8] usb: chipidea: udc: fix the oops when plugs in
 usb cable after rmmod gadget
In-Reply-To: <20130226182141.GB2626@arwen.pp.htv.fi>
References: <1360051215-27722-1-git-send-email-peter.chen@freescale.com>
 <1360051215-27722-9-git-send-email-peter.chen@freescale.com>
 <20130213084128.GB2426@arwen.pp.htv.fi>
 <20130217030951.GA1588@nchen-desktop>
 <20130226182141.GB2626@arwen.pp.htv.fi>
Message-ID: <20130227031002.GB20402@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 26, 2013 at 08:21:41PM +0200, Felipe Balbi wrote:
> Hi,
> 
> On Sun, Feb 17, 2013 at 11:09:53AM +0800, Peter Chen wrote:
> > @@ -1373,6 +1375,8 @@ static int ci13xxx_vbus_session(struct usb_gadget *_gadget, int is_active)
> >  			hw_device_state(ci, ci->ep0out->qh.dma);
> >  			dev_dbg(ci->dev, "Connected to host\n");
> >  		} else {
> > +			if (ci->driver)
> > +				ci->driver->disconnect(&ci->gadget);
> 
> This looks wrong. Why do you need to call ->disconnect() here ?

When we disconnect usb cable from the host, we need to notify gadget module 
disconnection occurs, the gadget module may not be unloaded in future.

If the disconnection is not notified, the gadget module may still call
struct usb_ep_ops's API to visit hardware at its thread but the controller 
may already enter low power mode.

In fact, a common problem is how can we make sure the gadget will not
visit register if the controller enters low power mode, currently,
there is no prefect solution.  
> 
> -- 
> balbi



-- 

Best Regards,
Peter Chen
