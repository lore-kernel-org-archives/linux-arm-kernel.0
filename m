From: balbi@ti.com (Felipe Balbi)
Date: Thu, 14 Mar 2013 12:19:04 +0200
Subject: [PATCH 14/14] usb: udc-core: add judgement logic for
 usb_gadget_connect
In-Reply-To: <20130314092438.GB26420@nchen-desktop>
References: <1363240242-25775-1-git-send-email-peter.chen@freescale.com>
 <1363240242-25775-15-git-send-email-peter.chen@freescale.com>
 <20130314090005.GB14443@arwen.pp.htv.fi>
 <20130314092438.GB26420@nchen-desktop>
Message-ID: <20130314101904.GD32369@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 14, 2013 at 05:24:39PM +0800, Peter Chen wrote:
> > > @@ -278,7 +278,10 @@ static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *dri
> > >  		driver->unbind(gadget);
> > >  		goto err1;
> > >  	}
> > > -	usb_gadget_connect(gadget);
> > > +	if (!gadget->ops->vbus_session ||
> > > +			(gadget->ops->vbus_session
> > > +				&& gadget->vbus_active))
> > > +		usb_gadget_connect(gadget);
> > >  
> > >  	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
> > >  	return 0;
> > > @@ -384,7 +387,10 @@ static ssize_t usb_udc_softconn_store(struct device *dev,
> > >  
> > >  	if (sysfs_streq(buf, "connect")) {
> > >  		usb_gadget_udc_start(gadget, udc->driver);
> > > -		usb_gadget_connect(gadget);
> > > +		if (!gadget->ops->vbus_session ||
> > > +				(gadget->ops->vbus_session
> > > +					&& gadget->vbus_active))
> > > +			usb_gadget_connect(gadget);
> > 
> > this patch is incomplete. What happens if this test fails ? Who will
> > connect pullup then ?
> 
> gadget->ops->vbus_session will handle it when the vbus interrupt comes

for your driver, what about all the others ? Also, we shouldn't allow
this ping-pong between who handles pullup and who handles vbus_session.

It should all be managed by udc-core with UDC drivers just providing
enough hooks. If we allow the UDC driver to connect pullups when VBUS
IRQ comes, we could fall into all sorts of traps:

a) we could connect cable with no gadget driver loaded
b) there will be code duplication among all UDC drivers to call
	usb_gadge_connect() from vbus_session
c) we might screw up the usb_function_activate()/deactivate() counter

Need to be very careful with all these details, there are many, many
users to udc-core with different requirements. So unless we can come up
with a way which wouldn't cause code duplication or regressions, I don't
think we can solve the real problem.

I guess the best solution to all problems is to start deferring
pullup to when gadget driver says it's ok to connect them. It's far more
likely that we will already have connection to a host and VBUS will be
alive.

Also, I'm not sure what does this all mean for SRP. Should we connect
pullup before or after SRP ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130314/4423ce01/attachment-0001.sig>
