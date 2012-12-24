From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 24 Dec 2012 17:02:12 +0800
Subject: [PATCH v3 3/7] usb: chipidea: add otg id switch and vbus
 connect/disconnect detect
In-Reply-To: <87k3t4mqh9.fsf@ashishki-desk.ger.corp.intel.com>
References: <1353921068-15673-1-git-send-email-peter.chen@freescale.com>
 <1353921068-15673-4-git-send-email-peter.chen@freescale.com>
 <87k3t4mqh9.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <20121224090211.GC21391@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 29, 2012 at 04:30:10PM +0200, Alexander Shishkin wrote:
> Peter Chen <peter.chen@freescale.com> writes:
> 
> > +static void ci_otg_work(struct work_struct *work)
> > +{
> > +	struct ci13xxx *ci = container_of(work, struct ci13xxx, work);
> > +
> > +	if (test_bit(CI_ID, &ci->events)) {
> > +		clear_bit(CI_ID, &ci->events);
> > +		ci_handle_id_switch(ci);
> > +	} else if (test_bit(CI_B_SESS_VALID, &ci->events)) {
> > +		clear_bit(CI_B_SESS_VALID, &ci->events);
> > +		ci_handle_vbus_change(ci);
> > +	} else
> > +		dev_err(ci->dev, "unexpected event occurs at %s\n", __func__);
> > +
> > +	enable_irq(ci->irq);
> > +}
> 
> if (ci->id) {
> 	ci->id = false;
> 	ci_handle_id_switch(ci);
> } else if (ci->vbus_valid) {
> 	ci->vbus_valid = false;
> 	ci_handle_vbus_change(ci);
> } ...
> 
> is so much easier on the eyes. We really don't have any reasons to have
> events in a bitmask.

Ok, then I keep several flags (currently, it is two) as otg events.
> > @@ -321,19 +422,36 @@ static irqreturn_t ci_irq(int irq, void *data)
> >  	irqreturn_t ret = IRQ_NONE;
> >  	u32 otgsc = 0;
> >  
> > -	if (ci->is_otg)
> > -		otgsc = hw_read(ci, OP_OTGSC, ~0);
> > -
> > -	if (ci->role != CI_ROLE_END)
> > -		ret = ci_role(ci)->irq(ci);
> > +	otgsc = hw_read(ci, OP_OTGSC, ~0);
> >  
> > -	if (ci->is_otg && (otgsc & OTGSC_IDIS)) {
> > +	/*
> > +	 * Handle id change interrupt, it indicates device/host function
> > +	 * switch.
> > +	 */
> > +	if (ci->is_otg && (otgsc & OTGSC_IDIE) && (otgsc & OTGSC_IDIS)) {
> > +		set_bit(CI_ID, &ci->events);
> >  		hw_write(ci, OP_OTGSC, OTGSC_IDIS, OTGSC_IDIS);
> 
> A thought: we're setting and unsetting IDIS/IDIE and BSVIS/BSVIE that we
> might use a helper function for it.
ci_clear_otg_status/ci_enable_otg_interrupt/ci_disable_otg_interrupt?

> 
> >  		disable_irq_nosync(ci->irq);
> >  		queue_work(ci->wq, &ci->work);
> > -		ret = IRQ_HANDLED;
> > +		return IRQ_HANDLED;
> > +	}
> > +
> > +	/*
> > +	 * Handle vbus change interrupt, it indicates device connection
> > +	 * and disconnection events.
> > +	 */
> > +	if ((otgsc & OTGSC_BSVIE) && (otgsc & OTGSC_BSVIS)) {
> > +		set_bit(CI_B_SESS_VALID, &ci->events);
> > +		hw_write(ci, OP_OTGSC, OTGSC_BSVIS, OTGSC_BSVIS);
> > +		disable_irq_nosync(ci->irq);
> > +		queue_work(ci->wq, &ci->work);
> > +		return IRQ_HANDLED;
> >  	}
> >  
> > +	/* Handle device/host interrupt */
> > +	if (ci->role != CI_ROLE_END)
> > +		ret = ci_role(ci)->irq(ci);
> > +
> >  	return ret;
> >  }
> >  
> > @@ -397,6 +515,7 @@ static int __devinit ci_hdrc_probe(struct platform_device *pdev)
> >  	struct resource	*res;
> >  	void __iomem	*base;
> >  	int		ret;
> > +	u32		otgsc;
> >  
> >  	if (!dev->platform_data) {
> >  		dev_err(dev, "platform data missing\n");
> > @@ -421,6 +540,7 @@ static int __devinit ci_hdrc_probe(struct platform_device *pdev)
> >  		return -ENOMEM;
> >  	}
> >  
> > +	ci->events = 0;
> 
> "ci" has just been kzalloc'ed.
will change.
> 
> >  	ci->dev = dev;
> >  	ci->platdata = dev->platform_data;
> >  	if (ci->platdata->phy)
> > @@ -442,12 +562,20 @@ static int __devinit ci_hdrc_probe(struct platform_device *pdev)
> >  		return -ENODEV;
> >  	}
> >  
> > -	INIT_WORK(&ci->work, ci_role_work);
> > +	INIT_WORK(&ci->work, ci_otg_work);
> > +	INIT_DELAYED_WORK(&ci->dwork, ci_delayed_work);
> >  	ci->wq = create_singlethread_workqueue("ci_otg");
> >  	if (!ci->wq) {
> >  		dev_err(dev, "can't create workqueue\n");
> >  		return -ENODEV;
> >  	}
> > +	/* Disable all interrupts bits */
> > +	hw_write(ci, OP_USBINTR, 0xffffffff, 0);
> > +	hw_write(ci, OP_OTGSC, OTGSC_INT_EN_BITS, 0);
> > +
> > +	/* Clear all interrupts status bits*/
> > +	hw_write(ci, OP_USBSTS, 0xffffffff, 0xffffffff);
> > +	hw_write(ci, OP_OTGSC, OTGSC_INT_STATUS_BITS, OTGSC_INT_STATUS_BITS);
> 
> How about moving these to hw_device_init()?

Good idea
> 
> >  
> >  	/* initialize role(s) before the interrupt is requested */
> >  	ret = ci_hdrc_host_init(ci);
> > @@ -465,6 +593,7 @@ static int __devinit ci_hdrc_probe(struct platform_device *pdev)
> >  	}
> >  
> >  	if (ci->roles[CI_ROLE_HOST] && ci->roles[CI_ROLE_GADGET]) {
> > +		dev_dbg(dev, "support otg\n");
> >  		ci->is_otg = true;
> >  		/* ID pin needs 1ms debouce time, we delay 2ms for safe */
> >  		mdelay(2);
> > @@ -475,13 +604,29 @@ static int __devinit ci_hdrc_probe(struct platform_device *pdev)
> >  			: CI_ROLE_GADGET;
> >  	}
> >  
> > +	if (ci->is_otg)
> > +		/* if otg is supported, create struct usb_otg */
> > +		ci_hdrc_otg_init(ci);
> 
> Can this just go the same block where is_otg is set?
Will change
> 
> > +
> >  	ret = ci_role_start(ci, ci->role);
> >  	if (ret) {
> > -		dev_err(dev, "can't start %s role\n", ci_role(ci)->name);
> > +		dev_err(dev, "can't start %s role, ret=%d\n",
> > +				ci_role(ci)->name, ret);
> 
> This change is not really related to the rest of the patch.
It just adds return value output, it can let the user know what kinds of
error occurs during the ci_role_start, meanwhile, it is a small change,
and not deserved a patch.
> 
> >  		ret = -ENODEV;
> >  		goto rm_wq;
> >  	}
> >  
> > +	otgsc = hw_read(ci, OP_OTGSC, ~0);
> > +	/*
> > +	 * if it is device mode:
> > +	 * - Enable vbus detect
> > +	 * - If it has already connected to host, notify udc
> > +	 */
> > +	if (ci->role == CI_ROLE_GADGET) {
> > +		hw_write(ci, OP_OTGSC, OTGSC_BSVIE, OTGSC_BSVIE);
> > +		ci_handle_vbus_change(ci);
> > +	}
> 
> This looks like something that belongs to gadget role start, doesn't it?
Yes, will change.
> 

-- 

Best Regards,
Peter Chen
