From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 27 Jan 2010 12:37:45 -0500
Subject: [patch 2/2] at91_udc.c use spinlocks instead of local_irq_xxx
In-Reply-To: <20100127163115.337384288@gmail.com>>
References: <20100127163000.406832266@gmail.com>>
	<20100127163115.337384288@gmail.com>>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE1909020E94E2@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, January 27, 2010 9:30 AM, Harro Haan wrote:

Just a couple comments on the locking.

The spinlock is stored in the at91_udc structure.  The structure
is referenced multiple times using different variable names.
Sometimes its:

	struct at91_udc *udc;

Othertimes it's:

	struct at91_udc *dev;

For consistency (and better grepping) it would be better to keep
the same use throughout the file.

> The locking code of this driver is reworked for preempt-rt.
> 
> Signed-off-by: Harro Haan <hrhaan@gmail.com>
> ---
>  drivers/usb/gadget/at91_udc.c |  102 ++++++++++++++++++++++++++++++------------
>  drivers/usb/gadget/at91_udc.h |    1 
>  2 files changed, 74 insertions(+), 29 deletions(-)
> 
> Index: linux-2.6.31/drivers/usb/gadget/at91_udc.h
> ===================================================================
> --- linux-2.6.31.orig/drivers/usb/gadget/at91_udc.h
> +++ linux-2.6.31/drivers/usb/gadget/at91_udc.h
> @@ -144,6 +144,7 @@ struct at91_udc {
>  	struct proc_dir_entry		*pde;
>  	void __iomem			*udp_baseaddr;
>  	int				udp_irq;
> +	spinlock_t			lock;
>  };
>  
>  static inline struct at91_udc *to_udc(struct usb_gadget *g)
> Index: linux-2.6.31/drivers/usb/gadget/at91_udc.c
> ===================================================================
> --- linux-2.6.31.orig/drivers/usb/gadget/at91_udc.c
> +++ linux-2.6.31/drivers/usb/gadget/at91_udc.c
> @@ -102,8 +102,9 @@ static void proc_ep_show(struct seq_file
>  	u32			csr;
>  	struct at91_request	*req;
>  	unsigned long	flags;
> +	struct at91_udc	*udc = ep->udc;
>  
> -	local_irq_save(flags);
> +	spin_lock_irqsave(&dev->lock, flags);

This one should be &udc->lock

>  	csr = __raw_readl(ep->creg);
>  
> @@ -147,7 +148,7 @@ static void proc_ep_show(struct seq_file
>  				&req->req, length,
>  				req->req.length, req->req.buf);
>  	}
> -	local_irq_restore(flags);
> +	spin_unlock_irqrestore(&udc->lock, flags);
>  }
>  
>  static void proc_irq_show(struct seq_file *s, const char *label, u32 mask)
> @@ -272,7 +273,9 @@ static void done(struct at91_ep *ep, str
>  		VDBG("%s done %p, status %d\n", ep->ep.name, req, status);
>  
>  	ep->stopped = 1;
> +	spin_unlock(&udc->lock);
>  	req->req.complete(&ep->ep, &req->req);
> +	spin_lock(&udc->lock);
>  	ep->stopped = stopped;
>  
>  	/* ep0 is always ready; other endpoints need a non-empty queue */
> @@ -552,7 +555,7 @@ bogus_max:
>  	}
>  
>  ok:
> -	local_irq_save(flags);
> +	spin_lock_irqsave(&dev->lock, flags);

This on is correct as &dev->lock

>  
>  	/* initialize endpoint to match this descriptor */
>  	ep->is_in = usb_endpoint_dir_in(desc);
> @@ -574,7 +577,7 @@ ok:
>  	at91_udp_write(dev, AT91_UDP_RST_EP, ep->int_mask);
>  	at91_udp_write(dev, AT91_UDP_RST_EP, 0);
>  
> -	local_irq_restore(flags);
> +	spin_unlock_irqrestore(&dev->lock, flags);

Again, this one is correct as &dev->lock.

>  	return 0;
>  }
>  
> @@ -587,7 +590,7 @@ static int at91_ep_disable (struct usb_e
>  	if (ep == &ep->udc->ep[0])
>  		return -EINVAL;
>  
> -	local_irq_save(flags);
> +	spin_lock_irqsave(&udc->lock, flags);
>  
>  	nuke(ep, -ESHUTDOWN);
>  
> @@ -602,7 +605,7 @@ static int at91_ep_disable (struct usb_e
>  		__raw_writel(0, ep->creg);
>  	}
>  
> -	local_irq_restore(flags);
> +	spin_unlock_irqrestore(&udc->lock, flags);
>  	return 0;
>  }
>  
> @@ -666,7 +669,7 @@ static int at91_ep_queue(struct usb_ep *
>  	_req->status = -EINPROGRESS;
>  	_req->actual = 0;
>  
> -	local_irq_save(flags);
> +	spin_lock_irqsave(&dev->lock, flags);

Again, this one is correct as &dev->lock.

>  
>  	/* try to kickstart any empty and idle queue */
>  	if (list_empty(&ep->queue) && !ep->stopped) {
> @@ -729,28 +732,34 @@ ep0_in_status:
>  		at91_udp_write(dev, AT91_UDP_IER, ep->int_mask);
>  	}
>  done:
> -	local_irq_restore(flags);
> +	spin_unlock_irqrestore(&dev->lock, flags);

Correct as &dev->lock.

>  	return (status < 0) ? status : 0;
>  }
>  
>  static int at91_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
>  {
> -	struct at91_ep	*ep;
> +	struct at91_ep		*ep;
>  	struct at91_request	*req;
> +	unsigned long		flags;

Maybe also add:

	struct at91_udc		*udc;

>  
>  	ep = container_of(_ep, struct at91_ep, ep);
>  	if (!_ep || ep->ep.name == ep0name)
>  		return -EINVAL;

	udc = ep->udc;

>  
> +	spin_lock_irqsave(&ep->udc->lock, flags);
> +

Then change this to:

	spin_lock_irqsave(&udc->lock, flags);

>  	/* make sure it's actually queued on this endpoint */
>  	list_for_each_entry (req, &ep->queue, queue) {
>  		if (&req->req == _req)
>  			break;
>  	}
> -	if (&req->req != _req)
> +	if (&req->req != _req) {
> +		spin_unlock_irqrestore(&ep->udc->lock, flags);

	spin_unlock_irqrestore(&udc->lock, flags);

>  		return -EINVAL;
> +	}
>  
>  	done(ep, req, -ECONNRESET);
> +	spin_unlock_irqrestore(&ep->udc->lock, flags);

	spin_unlock_irqrestore(&udc->lock, flags);

>  	return 0;
>  }
>  
> @@ -767,7 +776,7 @@ static int at91_ep_set_halt(struct usb_e
>  		return -EINVAL;
>  
>  	creg = ep->creg;
> -	local_irq_save(flags);
> +	spin_lock_irqsave(&udc->lock, flags);
>  
>  	csr = __raw_readl(creg);
>  
> @@ -792,7 +801,7 @@ static int at91_ep_set_halt(struct usb_e
>  		__raw_writel(csr, creg);
>  	}
>  
> -	local_irq_restore(flags);
> +	spin_unlock_irqrestore(&udc->lock, flags);
>  	return status;
>  }
>  
> @@ -826,7 +835,7 @@ static int at91_wakeup(struct usb_gadget
>  	unsigned long	flags;
>  
>  	DBG("%s\n", __func__ );
> -	local_irq_save(flags);
> +	spin_lock_irqsave(&udc->lock, flags);
>  
>  	if (!udc->clocked || !udc->suspended)
>  		goto done;
> @@ -840,7 +849,7 @@ static int at91_wakeup(struct usb_gadget
>  	at91_udp_write(udc, AT91_UDP_GLB_STAT, glbstate);
>  
>  done:
> -	local_irq_restore(flags);
> +	spin_unlock_irqrestore(&udc->lock, flags);
>  	return status;
>  }
>  
> @@ -882,8 +891,11 @@ static void stop_activity(struct at91_ud
>  		ep->stopped = 1;
>  		nuke(ep, -ESHUTDOWN);
>  	}
> -	if (driver)
> +	if (driver) {
> +		spin_unlock(&udc->lock);
>  		driver->disconnect(&udc->gadget);
> +		spin_lock(&udc->lock);
> +	}

Strange unlock/lock sequence.  Who does the initial locking and who
does the final unlock?

>  
>  	udc_reinit(udc);
>  }
> @@ -966,13 +978,13 @@ static int at91_vbus_session(struct usb_
>  	unsigned long	flags;
>  
>  	// VDBG("vbus %s\n", is_active ? "on" : "off");

// comment?  If it's really not needed just remove it.

> -	local_irq_save(flags);
> +	spin_lock_irqsave(&udc->lock, flags);
>  	udc->vbus = (is_active != 0);
>  	if (udc->driver)
>  		pullup(udc, is_active);
>  	else
>  		pullup(udc, 0);
> -	local_irq_restore(flags);
> +	spin_unlock_irqrestore(&udc->lock, flags);
>  	return 0;
>  }
>  
> @@ -981,10 +993,10 @@ static int at91_pullup(struct usb_gadget
>  	struct at91_udc	*udc = to_udc(gadget);
>  	unsigned long	flags;
>  
> -	local_irq_save(flags);
> +	spin_lock_irqsave(&udc->lock, flags);
>  	udc->enabled = is_on = !!is_on;
>  	pullup(udc, is_on);
> -	local_irq_restore(flags);
> +	spin_unlock_irqrestore(&udc->lock, flags);
>  	return 0;
>  }
>  
> @@ -993,9 +1005,9 @@ static int at91_set_selfpowered(struct u
>  	struct at91_udc	*udc = to_udc(gadget);
>  	unsigned long	flags;
>  
> -	local_irq_save(flags);
> +	spin_lock_irqsave(&udc->lock, flags);
>  	udc->selfpowered = (is_on != 0);
> -	local_irq_restore(flags);
> +	spin_unlock_irqrestore(&udc->lock, flags);
>  	return 0;
>  }
>  
> @@ -1257,8 +1269,11 @@ static void handle_setup(struct at91_udc
>  #undef w_length
>  
>  	/* pass request up to the gadget driver */
> -	if (udc->driver)
> +	if (udc->driver) {
> +		spin_unlock(&udc->lock);
>  		status = udc->driver->setup(&udc->gadget, &pkt.r);
> +		spin_lock(&udc->lock);

Again strange unlock/lock sequence.

> +	}
>  	else
>  		status = -ENODEV;
>  	if (status < 0) {
> @@ -1409,6 +1424,9 @@ static irqreturn_t at91_udc_irq (int irq
>  	struct at91_udc		*udc = _udc;
>  	u32			rescans = 5;
>  	int			disable_clock = 0;
> +	unsigned long		flags;
> +
> +	spin_lock_irqsave(&udc->lock, flags);

You are in an irq path.  Is this locking and the unlock/lock below
really needed?
 
>  	if (!udc->clocked) {
>  		clk_on(udc);
> @@ -1464,8 +1482,11 @@ static irqreturn_t at91_udc_irq (int irq
>  			 * and then into standby to avoid drawing more than
>  			 * 500uA power (2500uA for some high-power configs).
>  			 */
> -			if (udc->driver && udc->driver->suspend)
> +			if (udc->driver && udc->driver->suspend) {
> +				spin_unlock(&udc->lock);
>  				udc->driver->suspend(&udc->gadget);
> +				spin_lock(&udc->lock);
> +			}
>  
>  		/* host initiated resume */
>  		} else if (status & AT91_UDP_RXRSM) {
> @@ -1482,8 +1503,11 @@ static irqreturn_t at91_udc_irq (int irq
>  			 * would normally want to switch out of slow clock
>  			 * mode into normal mode.
>  			 */
> -			if (udc->driver && udc->driver->resume)
> +			if (udc->driver && udc->driver->resume) {
> +				spin_unlock(&udc->lock);
>  				udc->driver->resume(&udc->gadget);
> +				spin_lock(&udc->lock);
> +			}
>  
>  		/* endpoint IRQs are cleared by handling them */
>  		} else {
> @@ -1505,6 +1529,8 @@ static irqreturn_t at91_udc_irq (int irq
>  	if (disable_clock)
>  		clk_off(udc);
>  
> +	spin_unlock_irqrestore(&udc->lock, flags);
> +
>  	return IRQ_HANDLED;
>  }
>  
> @@ -1605,6 +1631,7 @@ int usb_gadget_register_driver (struct u
>  {
>  	struct at91_udc	*udc = &controller;
>  	int		retval;
> +	unsigned long	flags;
>  
>  	if (!driver
>  			|| driver->speed < USB_SPEED_FULL
> @@ -1636,9 +1663,9 @@ int usb_gadget_register_driver (struct u
>  		return retval;
>  	}
>  
> -	local_irq_disable();
> +	spin_lock_irqsave(&udc->lock, flags);
>  	pullup(udc, 1);
> -	local_irq_enable();
> +	spin_unlock_irqrestore(&udc->lock, flags);
>  
>  	DBG("bound to %s\n", driver->driver.name);
>  	return 0;
> @@ -1648,15 +1675,16 @@ EXPORT_SYMBOL (usb_gadget_register_drive
>  int usb_gadget_unregister_driver (struct usb_gadget_driver *driver)
>  {
>  	struct at91_udc *udc = &controller;
> +	unsigned long	flags;
>  
>  	if (!driver || driver != udc->driver || !driver->unbind)
>  		return -EINVAL;
>  
> -	local_irq_disable();
> +	spin_lock_irqsave(&udc->lock, flags);
>  	udc->enabled = 0;
>  	at91_udp_write(udc, AT91_UDP_IDR, ~0);
>  	pullup(udc, 0);
> -	local_irq_enable();
> +	spin_unlock_irqrestore(&udc->lock, flags);
>  
>  	driver->unbind(&udc->gadget);
>  	udc->gadget.dev.driver = NULL;
> @@ -1672,8 +1700,13 @@ EXPORT_SYMBOL (usb_gadget_unregister_dri
>  
>  static void at91udc_shutdown(struct platform_device *dev)
>  {
> +	struct at91_udc *udc = platform_get_drvdata(dev);
> +	unsigned long	flags;
> +
>  	/* force disconnect on reboot */
> +	spin_lock_irqsave(&udc->lock, flags);
>  	pullup(platform_get_drvdata(dev), 0);
> +	spin_unlock_irqrestore(&udc->lock, flags);
>  }
>  
>  static int __init at91udc_probe(struct platform_device *pdev)
> @@ -1716,6 +1749,7 @@ static int __init at91udc_probe(struct p
>  	udc->board = *(struct at91_udc_data *) dev->platform_data;
>  	udc->pdev = pdev;
>  	udc->enabled = 0;
> +	spin_lock_init(&udc->lock);
>  
>  	/* rm9200 needs manual D+ pullup; off by default */
>  	if (cpu_is_at91rm9200()) {
> @@ -1838,13 +1872,16 @@ static int __exit at91udc_remove(struct 
>  {
>  	struct at91_udc *udc = platform_get_drvdata(pdev);
>  	struct resource *res;
> +	unsigned long	flags;
>  
>  	DBG("remove\n");
>  
>  	if (udc->driver)
>  		return -EBUSY;
>  
> +	spin_lock_irqsave(&udc->lock, flags);
>  	pullup(udc, 0);
> +	spin_unlock_irqrestore(&udc->lock, flags);
>  
>  	device_init_wakeup(&pdev->dev, 0);
>  	remove_debug_file(udc);
> @@ -1874,6 +1911,7 @@ static int at91udc_suspend(struct platfo
>  {
>  	struct at91_udc *udc = platform_get_drvdata(pdev);
>  	int		wake = udc->driver && device_may_wakeup(&pdev->dev);
> +	unsigned long	flags;
>  
>  	/* Unless we can act normally to the host (letting it wake us up
>  	 * whenever it has work for us) force disconnect.  Wakeup requires
> @@ -1883,8 +1921,10 @@ static int at91udc_suspend(struct platfo
>  	if ((!udc->suspended && udc->addr)
>  			|| !wake
>  			|| clk_must_disable(udc->fclk)) {
> +		spin_lock_irqsave(&udc->lock, flags);
>  		pullup(udc, 0);
>  		wake = 0;
> +		spin_unlock_irqrestore(&udc->lock, flags);
>  	} else
>  		enable_irq_wake(udc->udp_irq);
>  
> @@ -1897,6 +1937,7 @@ static int at91udc_suspend(struct platfo
>  static int at91udc_resume(struct platform_device *pdev)
>  {
>  	struct at91_udc *udc = platform_get_drvdata(pdev);
> +	unsigned long	flags;
>  
>  	if (udc->board.vbus_pin > 0 && udc->active_suspend)
>  		disable_irq_wake(udc->board.vbus_pin);
> @@ -1904,8 +1945,11 @@ static int at91udc_resume(struct platfor
>  	/* maybe reconnect to host; if so, clocks on */
>  	if (udc->active_suspend)
>  		disable_irq_wake(udc->udp_irq);
> -	else
> +	else {
> +		spin_lock_irqsave(&udc->lock, flags);
>  		pullup(udc, 1);
> +		spin_unlock_irqrestore(&udc->lock, flags);
> +	}
>  	return 0;
>  }
>  #else

Regards,
Hartley
