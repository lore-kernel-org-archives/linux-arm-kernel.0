From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 15 Mar 2013 14:06:16 +0800
Subject: [PATCH 14/14] usb: udc-core: add judgement logic for
 usb_gadget_connect
In-Reply-To: <20130314101904.GD32369@arwen.pp.htv.fi>
References: <1363240242-25775-1-git-send-email-peter.chen@freescale.com>
 <1363240242-25775-15-git-send-email-peter.chen@freescale.com>
 <20130314090005.GB14443@arwen.pp.htv.fi>
 <20130314092438.GB26420@nchen-desktop>
 <20130314101904.GD32369@arwen.pp.htv.fi>
Message-ID: <20130315060615.GB28361@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 14, 2013 at 12:19:04PM +0200, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Mar 14, 2013 at 05:24:39PM +0800, Peter Chen wrote:
> > > > @@ -278,7 +278,10 @@ static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *dri
> > > >  		driver->unbind(gadget);
> > > >  		goto err1;
> > > >  	}
> > > > -	usb_gadget_connect(gadget);
> > > > +	if (!gadget->ops->vbus_session ||
> > > > +			(gadget->ops->vbus_session
> > > > +				&& gadget->vbus_active))
> > > > +		usb_gadget_connect(gadget);
> > > >  
> > > >  	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
> > > >  	return 0;
> > > > @@ -384,7 +387,10 @@ static ssize_t usb_udc_softconn_store(struct device *dev,
> > > >  
> > > >  	if (sysfs_streq(buf, "connect")) {
> > > >  		usb_gadget_udc_start(gadget, udc->driver);
> > > > -		usb_gadget_connect(gadget);
> > > > +		if (!gadget->ops->vbus_session ||
> > > > +				(gadget->ops->vbus_session
> > > > +					&& gadget->vbus_active))
> > > > +			usb_gadget_connect(gadget);
> > > 
> > > this patch is incomplete. What happens if this test fails ? Who will
> > > connect pullup then ?
> > 
> > gadget->ops->vbus_session will handle it when the vbus interrupt comes
> 
> for your driver, what about all the others ?

All drivers have .vbus_session will try to pullup, but some still check
if .pullup (using .softconnect) is called beforehand, it is duplicated
with this patch. Sorry, my careless.
If you have a look with these drivers, even usb_gadget_connect is called
at udc_bind_to_driver, they will NOT pull up if vbus is not there.

The most strict condition is : 
gadget_is_loaded && vbus_session_is_called && pullup_is_called

In fact, calling usb_gadget_connect(gadget) unconditionally at udc-core
may hang system if low power is enabled as udc will enter low
power mode after udc_start if no vbus is there.

> Also, we shouldn't allow
> this ping-pong between who handles pullup and who handles vbus_session.
> 
> It should all be managed by udc-core with UDC drivers just providing
> enough hooks. If we allow the UDC driver to connect pullups when VBUS
> IRQ comes, we could fall into all sorts of traps:
> 
> a) we could connect cable with no gadget driver loaded

In that case, the pullup will not be called, it will check if gadget module
is loaded.

> b) there will be code duplication among all UDC drivers to call
> 	usb_gadge_connect() from vbus_session

Yes

> c) we might screw up the usb_function_activate()/deactivate() counter
> 

why?

> Need to be very careful with all these details, there are many, many
> users to udc-core with different requirements. So unless we can come up
> with a way which wouldn't cause code duplication or regressions, I don't
> think we can solve the real problem.

Yes, udc has vendor specific, no uniform spec like host.

> 
> I guess the best solution to all problems is to start deferring
> pullup to when gadget driver says it's ok to connect them. It's far more
> likely that we will already have connection to a host and VBUS will be
> alive.

I still think (gadget_is_loaded && vbus_is_there) is enough.

> 
> Also, I'm not sure what does this all mean for SRP. Should we connect
> pullup before or after SRP ?

I am not familiar with SRP, but I think vbus is pre-condition.

-- 

Best Regards,
Peter Chen
