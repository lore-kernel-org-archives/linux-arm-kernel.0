From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 18 Mar 2013 14:52:42 +0800
Subject: [PATCH 14/14] usb: udc-core: add judgement logic for
 usb_gadget_connect
In-Reply-To: <20130315103701.GA21445@arwen.pp.htv.fi>
References: <1363240242-25775-1-git-send-email-peter.chen@freescale.com>
 <1363240242-25775-15-git-send-email-peter.chen@freescale.com>
 <20130314090005.GB14443@arwen.pp.htv.fi>
 <20130314092438.GB26420@nchen-desktop>
 <20130314101904.GD32369@arwen.pp.htv.fi>
 <20130315060615.GB28361@nchen-desktop>
 <20130315075128.GF5074@arwen.pp.htv.fi>
 <20130315100408.GG28361@nchen-desktop>
 <20130315103701.GA21445@arwen.pp.htv.fi>
Message-ID: <20130318065241.GG6491@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 15, 2013 at 12:37:01PM +0200, Felipe Balbi wrote:
> Hi,
> 
> On Fri, Mar 15, 2013 at 06:04:08PM +0800, Peter Chen wrote:
> > On Fri, Mar 15, 2013 at 09:51:29AM +0200, Felipe Balbi wrote:
> > > 
> > > that's all wrong and needs to be fixed. UDC-core has to be the central
> > > point for all these details. We start with the easiest way (call connect
> > > unconditionally after gadget driver is loaded) and optimize it as we go
> > > (making sure that there is VBUS before connecting pullups); but we can't
> > > bypass UDC-core and call usb_gadget_connect() directly from UDC driver.
> > 
> > I have an idea that let the gadget driver call usb_gadget_connect/disconnect,
> > and make a refcount for calling .pullup at usb_gadget_connect/disconnect.
> > Below is an initial idea for it, I think it can also cover both udc 
> > and uvc case.
> > 
> >  drivers/usb/chipidea/udc.c     |    6 ++----
> >  drivers/usb/gadget/composite.c |    6 ++++++
> >  include/linux/usb/gadget.h     |   21 +++++++++++++++++++--
> >  3 files changed, 27 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
> > index 81184b9..4b6b2d8 100644
> > --- a/drivers/usb/chipidea/udc.c
> > +++ b/drivers/usb/chipidea/udc.c
> > @@ -1386,17 +1386,15 @@ static int ci13xxx_vbus_session(struct usb_gadget *_gadget, int is_active)
> >  			pm_runtime_get_sync(&_gadget->dev);
> >  			hw_device_reset(ci, USBMODE_CM_DC);
> >  			hw_device_state(ci, ci->ep0out->qh.dma);
> > -			ci13xxx_pullup(_gadget, true);
> > +			ci->driver->connect(&ci->gadget);
> >  			dev_dbg(ci->dev, "Connected to host\n");
> >  		} else {
> > -			if (ci->driver)
> > -				ci->driver->disconnect(&ci->gadget);
> > +			ci->driver->disconnect(&ci->gadget);
> >  			hw_device_state(ci, 0);
> >  			if (ci->platdata->notify_event)
> >  				ci->platdata->notify_event(ci,
> >  				CI13XXX_CONTROLLER_STOPPED_EVENT);
> >  			_gadget_stop_activity(&ci->gadget);
> > -			ci13xxx_pullup(_gadget, false);
> >  			pm_runtime_put_sync(&_gadget->dev);
> >  			dev_dbg(ci->dev, "Disconnected from host\n");
> >  		}
> > diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
> > index 7c821de..b7bf5ae 100644
> > --- a/drivers/usb/gadget/composite.c
> > +++ b/drivers/usb/gadget/composite.c
> > @@ -1479,6 +1479,11 @@ done:
> >  	return value;
> >  }
> >  
> > +void composite_connect(struct usb_gadget *gadget)
> > +{
> > +	usb_gadget_connect(gadget);
> > +}
> > +
> >  void composite_disconnect(struct usb_gadget *gadget)
> >  {
> >  	struct usb_composite_dev	*cdev = get_gadget_data(gadget);
> > @@ -1492,6 +1497,7 @@ void composite_disconnect(struct usb_gadget *gadget)
> >  		reset_config(cdev);
> >  	if (cdev->driver->disconnect)
> >  		cdev->driver->disconnect(cdev);
> > +	usb_gadget_disconnect(gadget);
> >  	spin_unlock_irqrestore(&cdev->lock, flags);
> >  }
> >  
> > diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> > index 7e373a2..7f7e6bf 100644
> > --- a/include/linux/usb/gadget.h
> > +++ b/include/linux/usb/gadget.h
> > @@ -536,6 +536,7 @@ struct usb_gadget {
> >  	struct device			dev;
> >  	unsigned			out_epnum;
> >  	unsigned			in_epnum;
> > +	int				connection;
> >  };
> >  
> >  static inline void set_gadget_data(struct usb_gadget *gadget, void *data)
> > @@ -722,9 +723,16 @@ static inline int usb_gadget_vbus_disconnect(struct usb_gadget *gadget)
> >   */
> >  static inline int usb_gadget_connect(struct usb_gadget *gadget)
> >  {
> > +	int ret = 0;
> >  	if (!gadget->ops->pullup)
> >  		return -EOPNOTSUPP;
> > -	return gadget->ops->pullup(gadget, 1);
> > +
> > +	if (gadget->connection == 0)
> > +		ret = gadget->ops->pullup(gadget, 1);
> > +	if (!ret)
> > +		gadget->connection ++;
> > +
> > +	return ret;
> >  }
> >  
> >  /**
> > @@ -744,9 +752,18 @@ static inline int usb_gadget_connect(struct usb_gadget *gadget)
> >   */
> >  static inline int usb_gadget_disconnect(struct usb_gadget *gadget)
> >  {
> > +	int ret = 0;
> > +
> >  	if (!gadget->ops->pullup)
> >  		return -EOPNOTSUPP;
> > -	return gadget->ops->pullup(gadget, 0);
> > +
> > +	if (gadget->connection == 1)
> > +		ret = gadget->ops->pullup(gadget, 0);
> > +
> > +	if (!ret)
> > +		gadget->connection --;
> > +
> > +	return ret;
> >  }
> 
> this might be a good idea. But we already have something similar,
> although it's managed at composite device level. Maybe we need to move
> that to the gadget layer. Still, I don't want to let UDC drivers call
> usb_gadget_connect()/disconnect() directly.
> 
> It's easy enough for udc-core to handle that.
> 

Not so easy, how let udc-core know vbus interrupt?

And we need to consider the udc drivers which support or not
support vbus interrupt together.
-- 

Best Regards,
Peter Chen
