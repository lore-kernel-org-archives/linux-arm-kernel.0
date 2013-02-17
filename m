From: peter.chen@freescale.com (Peter Chen)
Date: Sun, 17 Feb 2013 11:09:53 +0800
Subject: [PATCH v8 8/8] usb: chipidea: udc: fix the oops when plugs in
 usb cable after rmmod gadget
In-Reply-To: <20130213084128.GB2426@arwen.pp.htv.fi>
References: <1360051215-27722-1-git-send-email-peter.chen@freescale.com>
 <1360051215-27722-9-git-send-email-peter.chen@freescale.com>
 <20130213084128.GB2426@arwen.pp.htv.fi>
Message-ID: <20130217030951.GA1588@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 13, 2013 at 10:41:28AM +0200, Felipe Balbi wrote:
> Hi,
> 
> > 
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > 
> > diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
> > index b57b735..8319d7e 100644
> > --- a/drivers/usb/chipidea/udc.c
> > +++ b/drivers/usb/chipidea/udc.c
> > @@ -1575,12 +1575,17 @@ static int ci13xxx_stop(struct usb_gadget *gadget,
> >  
> >  	spin_lock_irqsave(&ci->lock, flags);
> >  
> > +	/* 
> > +	 * Put it at the beginning due to avoid calling gadget 
> > +	 * disconnect at _gadget_stop_activity
> > +	 */
> > +	ci->driver = NULL;
> > +
> >  	if (ci->vbus_active) {
> >  		hw_device_state(ci, 0);
> >  		if (ci->platdata->notify_event)
> >  			ci->platdata->notify_event(ci,
> >  			CI13XXX_CONTROLLER_STOPPED_EVENT);
> > -		ci->driver = NULL;
> >  		spin_unlock_irqrestore(&ci->lock, flags);
> >  		_gadget_stop_activity(&ci->gadget);
> >  		spin_lock_irqsave(&ci->lock, flags);
> 
> NACK, this isn't the real problem. The real problem is that chipidea
> shouldn't be calling ->disconnect() by itself when we unload a gadget
> driver.

Yes, you point the root cause, besides, we also need to notify gadget
when the disconnect occurs even the gadget is still there. Below patch
is tested:

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index b57b735..e355914 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -579,9 +579,6 @@ static int _gadget_stop_activity(struct usb_gadget *gadget)
 	usb_ep_fifo_flush(&ci->ep0out->ep);
 	usb_ep_fifo_flush(&ci->ep0in->ep);
 
-	if (ci->driver)
-		ci->driver->disconnect(gadget);
-
 	/* make sure to disable all endpoints */
 	gadget_for_each_ep(ep, gadget) {
 		usb_ep_disable(ep);
@@ -612,6 +609,11 @@ __acquires(ci->lock)
 
 	dbg_event(0xFF, "BUS RST", 0);
 
+	if (ci->gadget.speed != USB_SPEED_UNKNOWN) {
+		if (ci->driver)
+			ci->driver->disconnect(&ci->gadget);
+	}
+
 	spin_unlock(&ci->lock);
 	retval = _gadget_stop_activity(&ci->gadget);
 	if (retval)
@@ -1373,6 +1375,8 @@ static int ci13xxx_vbus_session(struct usb_gadget *_gadget, int is_active)
 			hw_device_state(ci, ci->ep0out->qh.dma);
 			dev_dbg(ci->dev, "Connected to host\n");
 		} else {
+			if (ci->driver)
+				ci->driver->disconnect(&ci->gadget);
 			hw_device_state(ci, 0);
 			if (ci->platdata->notify_event)
 				ci->platdata->notify_event(ci,
@@ -1580,13 +1584,14 @@ static int ci13xxx_stop(struct usb_gadget *gadget,
 		if (ci->platdata->notify_event)
 			ci->platdata->notify_event(ci,
 			CI13XXX_CONTROLLER_STOPPED_EVENT);
-		ci->driver = NULL;
 		spin_unlock_irqrestore(&ci->lock, flags);
 		_gadget_stop_activity(&ci->gadget);
 		spin_lock_irqsave(&ci->lock, flags);
 		pm_runtime_put(&ci->gadget.dev);
 	}
 
+	ci->driver = NULL;
+
 	spin_unlock_irqrestore(&ci->lock, flags);
 
 	return 0;
-- 

Best Regards,
Peter Chen
