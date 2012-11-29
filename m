From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Thu, 29 Nov 2012 16:30:10 +0200
Subject: [PATCH v3 3/7] usb: chipidea: add otg id switch and vbus
 connect/disconnect detect
In-Reply-To: <1353921068-15673-4-git-send-email-peter.chen@freescale.com>
References: <1353921068-15673-1-git-send-email-peter.chen@freescale.com>
 <1353921068-15673-4-git-send-email-peter.chen@freescale.com>
Message-ID: <87k3t4mqh9.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Chen <peter.chen@freescale.com> writes:

> +static void ci_otg_work(struct work_struct *work)
> +{
> +	struct ci13xxx *ci = container_of(work, struct ci13xxx, work);
> +
> +	if (test_bit(CI_ID, &ci->events)) {
> +		clear_bit(CI_ID, &ci->events);
> +		ci_handle_id_switch(ci);
> +	} else if (test_bit(CI_B_SESS_VALID, &ci->events)) {
> +		clear_bit(CI_B_SESS_VALID, &ci->events);
> +		ci_handle_vbus_change(ci);
> +	} else
> +		dev_err(ci->dev, "unexpected event occurs at %s\n", __func__);
> +
> +	enable_irq(ci->irq);
> +}

if (ci->id) {
	ci->id = false;
	ci_handle_id_switch(ci);
} else if (ci->vbus_valid) {
	ci->vbus_valid = false;
	ci_handle_vbus_change(ci);
} ...

is so much easier on the eyes. We really don't have any reasons to have
events in a bitmask.

> +
> +static void ci_delayed_work(struct work_struct *work)
> +{
> +	struct delayed_work *dwork = to_delayed_work(work);
> +	struct ci13xxx *ci = container_of(dwork, struct ci13xxx, dwork);
> +
> +	otg_set_vbus(&ci->otg, true);
> +
> +}
> +
>  static ssize_t show_role(struct device *dev, struct device_attribute *attr,
>  			 char *buf)
>  {
> @@ -321,19 +422,36 @@ static irqreturn_t ci_irq(int irq, void *data)
>  	irqreturn_t ret = IRQ_NONE;
>  	u32 otgsc = 0;
>  
> -	if (ci->is_otg)
> -		otgsc = hw_read(ci, OP_OTGSC, ~0);
> -
> -	if (ci->role != CI_ROLE_END)
> -		ret = ci_role(ci)->irq(ci);
> +	otgsc = hw_read(ci, OP_OTGSC, ~0);
>  
> -	if (ci->is_otg && (otgsc & OTGSC_IDIS)) {
> +	/*
> +	 * Handle id change interrupt, it indicates device/host function
> +	 * switch.
> +	 */
> +	if (ci->is_otg && (otgsc & OTGSC_IDIE) && (otgsc & OTGSC_IDIS)) {
> +		set_bit(CI_ID, &ci->events);
>  		hw_write(ci, OP_OTGSC, OTGSC_IDIS, OTGSC_IDIS);

A thought: we're setting and unsetting IDIS/IDIE and BSVIS/BSVIE that we
might use a helper function for it.

>  		disable_irq_nosync(ci->irq);
>  		queue_work(ci->wq, &ci->work);
> -		ret = IRQ_HANDLED;
> +		return IRQ_HANDLED;
> +	}
> +
> +	/*
> +	 * Handle vbus change interrupt, it indicates device connection
> +	 * and disconnection events.
> +	 */
> +	if ((otgsc & OTGSC_BSVIE) && (otgsc & OTGSC_BSVIS)) {
> +		set_bit(CI_B_SESS_VALID, &ci->events);
> +		hw_write(ci, OP_OTGSC, OTGSC_BSVIS, OTGSC_BSVIS);
> +		disable_irq_nosync(ci->irq);
> +		queue_work(ci->wq, &ci->work);
> +		return IRQ_HANDLED;
>  	}
>  
> +	/* Handle device/host interrupt */
> +	if (ci->role != CI_ROLE_END)
> +		ret = ci_role(ci)->irq(ci);
> +
>  	return ret;
>  }
>  
> @@ -397,6 +515,7 @@ static int __devinit ci_hdrc_probe(struct platform_device *pdev)
>  	struct resource	*res;
>  	void __iomem	*base;
>  	int		ret;
> +	u32		otgsc;
>  
>  	if (!dev->platform_data) {
>  		dev_err(dev, "platform data missing\n");
> @@ -421,6 +540,7 @@ static int __devinit ci_hdrc_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>  
> +	ci->events = 0;

"ci" has just been kzalloc'ed.

>  	ci->dev = dev;
>  	ci->platdata = dev->platform_data;
>  	if (ci->platdata->phy)
> @@ -442,12 +562,20 @@ static int __devinit ci_hdrc_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> -	INIT_WORK(&ci->work, ci_role_work);
> +	INIT_WORK(&ci->work, ci_otg_work);
> +	INIT_DELAYED_WORK(&ci->dwork, ci_delayed_work);
>  	ci->wq = create_singlethread_workqueue("ci_otg");
>  	if (!ci->wq) {
>  		dev_err(dev, "can't create workqueue\n");
>  		return -ENODEV;
>  	}
> +	/* Disable all interrupts bits */
> +	hw_write(ci, OP_USBINTR, 0xffffffff, 0);
> +	hw_write(ci, OP_OTGSC, OTGSC_INT_EN_BITS, 0);
> +
> +	/* Clear all interrupts status bits*/
> +	hw_write(ci, OP_USBSTS, 0xffffffff, 0xffffffff);
> +	hw_write(ci, OP_OTGSC, OTGSC_INT_STATUS_BITS, OTGSC_INT_STATUS_BITS);

How about moving these to hw_device_init()?

>  
>  	/* initialize role(s) before the interrupt is requested */
>  	ret = ci_hdrc_host_init(ci);
> @@ -465,6 +593,7 @@ static int __devinit ci_hdrc_probe(struct platform_device *pdev)
>  	}
>  
>  	if (ci->roles[CI_ROLE_HOST] && ci->roles[CI_ROLE_GADGET]) {
> +		dev_dbg(dev, "support otg\n");
>  		ci->is_otg = true;
>  		/* ID pin needs 1ms debouce time, we delay 2ms for safe */
>  		mdelay(2);
> @@ -475,13 +604,29 @@ static int __devinit ci_hdrc_probe(struct platform_device *pdev)
>  			: CI_ROLE_GADGET;
>  	}
>  
> +	if (ci->is_otg)
> +		/* if otg is supported, create struct usb_otg */
> +		ci_hdrc_otg_init(ci);

Can this just go the same block where is_otg is set?

> +
>  	ret = ci_role_start(ci, ci->role);
>  	if (ret) {
> -		dev_err(dev, "can't start %s role\n", ci_role(ci)->name);
> +		dev_err(dev, "can't start %s role, ret=%d\n",
> +				ci_role(ci)->name, ret);

This change is not really related to the rest of the patch.

>  		ret = -ENODEV;
>  		goto rm_wq;
>  	}
>  
> +	otgsc = hw_read(ci, OP_OTGSC, ~0);
> +	/*
> +	 * if it is device mode:
> +	 * - Enable vbus detect
> +	 * - If it has already connected to host, notify udc
> +	 */
> +	if (ci->role == CI_ROLE_GADGET) {
> +		hw_write(ci, OP_OTGSC, OTGSC_BSVIE, OTGSC_BSVIE);
> +		ci_handle_vbus_change(ci);
> +	}

This looks like something that belongs to gadget role start, doesn't it?

> +
>  	platform_set_drvdata(pdev, ci);
>  	ret = request_irq(ci->irq, ci_irq, IRQF_SHARED, ci->platdata->name,
>  			  ci);
> @@ -492,8 +637,9 @@ static int __devinit ci_hdrc_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto rm_attr;
>  
> -	if (ci->is_otg)
> -		hw_write(ci, OP_OTGSC, OTGSC_IDIE, OTGSC_IDIE);
> +	/* Handle the situation that usb device at the MicroB to A cable */
> +	if (ci->is_otg && !(otgsc & OTGSC_ID))
> +		queue_delayed_work(ci->wq, &ci->dwork, msecs_to_jiffies(500));
>  
>  	return ret;
>  
> diff --git a/drivers/usb/chipidea/otg.c b/drivers/usb/chipidea/otg.c
> index 7dea3b3..01ae162 100644
> --- a/drivers/usb/chipidea/otg.c
> +++ b/drivers/usb/chipidea/otg.c
> @@ -55,6 +55,7 @@ int ci_hdrc_otg_init(struct ci13xxx *ci)
>  	ci->otg.set_host = ci_otg_set_host;
>  	if (!IS_ERR_OR_NULL(ci->transceiver))
>  		ci->transceiver->otg = &ci->otg;
> +	hw_write(ci, OP_OTGSC, OTGSC_IDIE, OTGSC_IDIE);
>  
>  	return 0;
>  }
> diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
> index d214448..b52cb10 100644
> --- a/drivers/usb/chipidea/udc.c
> +++ b/drivers/usb/chipidea/udc.c
> @@ -1371,6 +1371,7 @@ static int ci13xxx_vbus_session(struct usb_gadget *_gadget, int is_active)
>  			pm_runtime_get_sync(&_gadget->dev);
>  			hw_device_reset(ci, USBMODE_CM_DC);
>  			hw_device_state(ci, ci->ep0out->qh.dma);
> +			dev_dbg(ci->dev, "Connected to host\n");
>  		} else {
>  			hw_device_state(ci, 0);
>  			if (ci->platdata->notify_event)
> @@ -1378,6 +1379,7 @@ static int ci13xxx_vbus_session(struct usb_gadget *_gadget, int is_active)
>  				CI13XXX_CONTROLLER_STOPPED_EVENT);
>  			_gadget_stop_activity(&ci->gadget);
>  			pm_runtime_put_sync(&_gadget->dev);
> +			dev_dbg(ci->dev, "disconnected from host\n");
>  		}
>  	}
>  
> -- 
> 1.7.0.4
