From: balbi@ti.com (Felipe Balbi)
Date: Fri, 15 Mar 2013 09:51:29 +0200
Subject: [PATCH 14/14] usb: udc-core: add judgement logic for
 usb_gadget_connect
In-Reply-To: <20130315060615.GB28361@nchen-desktop>
References: <1363240242-25775-1-git-send-email-peter.chen@freescale.com>
 <1363240242-25775-15-git-send-email-peter.chen@freescale.com>
 <20130314090005.GB14443@arwen.pp.htv.fi>
 <20130314092438.GB26420@nchen-desktop>
 <20130314101904.GD32369@arwen.pp.htv.fi>
 <20130315060615.GB28361@nchen-desktop>
Message-ID: <20130315075128.GF5074@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Mar 15, 2013 at 02:06:16PM +0800, Peter Chen wrote:
> > > > > @@ -278,7 +278,10 @@ static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *dri
> > > > >  		driver->unbind(gadget);
> > > > >  		goto err1;
> > > > >  	}
> > > > > -	usb_gadget_connect(gadget);
> > > > > +	if (!gadget->ops->vbus_session ||
> > > > > +			(gadget->ops->vbus_session
> > > > > +				&& gadget->vbus_active))
> > > > > +		usb_gadget_connect(gadget);
> > > > >  
> > > > >  	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
> > > > >  	return 0;
> > > > > @@ -384,7 +387,10 @@ static ssize_t usb_udc_softconn_store(struct device *dev,
> > > > >  
> > > > >  	if (sysfs_streq(buf, "connect")) {
> > > > >  		usb_gadget_udc_start(gadget, udc->driver);
> > > > > -		usb_gadget_connect(gadget);
> > > > > +		if (!gadget->ops->vbus_session ||
> > > > > +				(gadget->ops->vbus_session
> > > > > +					&& gadget->vbus_active))
> > > > > +			usb_gadget_connect(gadget);
> > > > 
> > > > this patch is incomplete. What happens if this test fails ? Who will
> > > > connect pullup then ?
> > > 
> > > gadget->ops->vbus_session will handle it when the vbus interrupt comes
> > 
> > for your driver, what about all the others ?
> 
> All drivers have .vbus_session will try to pullup, but some still check
> if .pullup (using .softconnect) is called beforehand, it is duplicated
> with this patch. Sorry, my careless.
> If you have a look with these drivers, even usb_gadget_connect is called
> at udc_bind_to_driver, they will NOT pull up if vbus is not there.

that's all wrong and needs to be fixed. UDC-core has to be the central
point for all these details. We start with the easiest way (call connect
unconditionally after gadget driver is loaded) and optimize it as we go
(making sure that there is VBUS before connecting pullups); but we can't
bypass UDC-core and call usb_gadget_connect() directly from UDC driver.

> The most strict condition is : 
> gadget_is_loaded && vbus_session_is_called && pullup_is_called
> 
> In fact, calling usb_gadget_connect(gadget) unconditionally at udc-core
> may hang system if low power is enabled as udc will enter low
> power mode after udc_start if no vbus is there.

that's a bug in the UDC driver though. It should add proper
pm_runtime_get_sync() and pm_runtime_put() (or put_sync()) around
register accesses, which means that ->pullup() should take care of that
too.

> > Also, we shouldn't allow
> > this ping-pong between who handles pullup and who handles vbus_session.
> > 
> > It should all be managed by udc-core with UDC drivers just providing
> > enough hooks. If we allow the UDC driver to connect pullups when VBUS
> > IRQ comes, we could fall into all sorts of traps:
> > 
> > a) we could connect cable with no gadget driver loaded
> 
> In that case, the pullup will not be called, it will check if gadget
> module is loaded.

I don't see that in your patch.

> > b) there will be code duplication among all UDC drivers to call
> > 	usb_gadge_connect() from vbus_session
> 
> Yes

yeah, we need to avoid it.

> > c) we might screw up the usb_function_activate()/deactivate() counter
> > 
> 
> why?

(USB cable already attached to a host, VBUS alive) gadget driver is
loaded, gadget driver calls usb_function_deactive() to prevent
enumeration until userland is ready, UDC driver calls
usb_gadget_connect() because there is a gadget driver and vbus is alive.

> > Need to be very careful with all these details, there are many, many
> > users to udc-core with different requirements. So unless we can come up
> > with a way which wouldn't cause code duplication or regressions, I don't
> > think we can solve the real problem.
> 
> Yes, udc has vendor specific, no uniform spec like host.

there are plenty of non-uniform hosts as well. MUSB and dwc2 are just
two instances of them. Still usbcore works just fine with those and the
standard ones.

> > I guess the best solution to all problems is to start deferring
> > pullup to when gadget driver says it's ok to connect them. It's far more
> > likely that we will already have connection to a host and VBUS will be
> > alive.
> 
> I still think (gadget_is_loaded && vbus_is_there) is enough.

it's not, see above.

> > Also, I'm not sure what does this all mean for SRP. Should we connect
> > pullup before or after SRP ?
> 
> I am not familiar with SRP, but I think vbus is pre-condition.

hehe, google SRP.

Nah, I'll save you the trouble. SRP is a mechanism for the USB
peripheral to ask the host to enable VBUS. This means that we can keep
the VBUS charge pump disabled, and thus save power, until peripheral
requests for a session.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130315/75ace05b/attachment-0001.sig>
