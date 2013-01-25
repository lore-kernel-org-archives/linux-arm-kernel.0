From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 25 Jan 2013 14:13:22 +0800
Subject: [RESEND PATCH v5 3/7] usb: chipidea: add otg id switch and
 vbus connect/disconnect detect
In-Reply-To: <87622moetj.fsf@ashishki-desk.ger.corp.intel.com>
References: <1358733418-17969-1-git-send-email-peter.chen@freescale.com>
 <1358733418-17969-4-git-send-email-peter.chen@freescale.com>
 <87622moetj.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <20130125061320.GC29795@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 24, 2013 at 04:06:48PM +0200, Alexander Shishkin wrote:
> Peter Chen <peter.chen@freescale.com> writes:
> 
> >  static ssize_t show_role(struct device *dev, struct device_attribute *attr,
> >  			 char *buf)
> >  {
> > @@ -321,19 +430,36 @@ static irqreturn_t ci_irq(int irq, void *data)
> >  	irqreturn_t ret = IRQ_NONE;
> >  	u32 otgsc = 0;
> >  
> > -	if (ci->is_otg)
> > -		otgsc = hw_read(ci, OP_OTGSC, ~0);
> > +	otgsc = hw_read(ci, OP_OTGSC, ~0);
> 
> My spec says that in non-otg implementations OTGSC is reserved. We
> probably shouldn't try any of this for such devices.

OK, will change.

> >  
> > +	otgsc = hw_read(ci, OP_OTGSC, ~0);
> > +	/*
> > +	 * if it is device mode:
> > +	 * - Enable vbus detect
> > +	 * - If it has already connected to host, notify udc
> > +	 */
> > +	if (ci->role == CI_ROLE_GADGET) {
> > +		ci_enable_otg_interrupt(ci, OTGSC_BSVIE);
> 
> We should only do this for otg capable devices, otherwise OTGSC is
> reserved.
We can consider all device mode supported device is otg capable
devices for chipidea controller, do you think so? There should be
no devcie-only capable device. Besides, vbus is indicated at OTGSC,
we need to use it to know connect and disconnect.

> 
> > +		ci_handle_vbus_change(ci);
> 
> Shouldn't this be part of the gadget role start like I suggested a
> couple of months back? Maybe ci_enable_otg_interrupt() can go there too.

Role start/stop will only be called during role switch (ID switch interrupt).
This code is used to handle the case that boots up board with usb cable
connects to pc, then insmod gadget module. In this case, the vbus interrupt
will not occur due to no vbus change, so the ci->vbus_active is not set,
then, after insmod gadget module, the hw_device_reset will not be called,
then, the enumeration will not be begun due to run/stop bit is not set.

In fact, it only do set ci->vbus_active. This code can be replaced with:
	ci->vbus_active = 1.
If you prefer this way, I will change.

-- 

Best Regards,
Peter Chen
