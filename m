From: petr.cvek@tul.cz (Petr Cvek)
Date: Wed, 22 Feb 2017 05:44:39 +0100
Subject: [RFC] usb: gadget: scheduling while atomic in pxa27x_udc,
 IS_ERR_OR_NULL test, duplicated definition
Message-ID: <e33b2bdb-f365-28d0-768a-c8e94a7794f9@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I found a few problems with the PXA27x UDC.

	usb_function_activate() in drivers/usb/gadget/composite.c

does spin_lock_irqsave() and then calls 

	gadget->ops->pullup() in drivers/usb/gadget/udc/core.c

which is set to pxa_udc_pullup(), which should be called not in interrupt

	/**
	 * pxa_udc_pullup - Offer manual D+ pullup control
	 * @_gadget: usb gadget using the control
	 * @is_active: 0 if disconnect, else connect D+ pullup resistor
	 * Context: !in_interrupt()
	 *
	 * Returns 0 if OK, -EOPNOTSUPP if udc driver doesn't handle D+ pullup
	 */

This finally causes fail at

	udc_enable() in drivers/usb/gadget/udc/pxa27x_udc.c
	
at code

	/*
	 * Caller must be able to sleep in order to cope with startup transients
	 */
	msleep(100);

with a following error (with CONFIG_DEBUG_PREEMPT on):

	BUG: scheduling while atomic: v4l_id/360/0x00000002
	...
	Preemption disabled at:
	[<bf43be34>] usb_function_activate+0x20/0xa4 [libcomposite]
	CPU: 0 PID: 360 Comm: v4l_id Not tainted 4.10.0-rc5-magician+ #2
	Hardware name: HTC Magician
	[<c000f540>] (unwind_backtrace) from [<c000d3e0>] (show_stack+0x10/0x14)
	[<c000d3e0>] (show_stack) from [<c00363b8>] (__schedule_bug+0x98/0xcc)
	[<c00363b8>] (__schedule_bug) from [<c035d94c>] (__schedule+0x58/0x444)
	[<c035d94c>] (__schedule) from [<c035dde0>] (schedule+0xa8/0xc8)
	[<c035dde0>] (schedule) from [<c0361558>] (schedule_timeout+0x1c8/0x1ec)
	[<c0361558>] (schedule_timeout) from [<c005312c>] (msleep+0x1c/0x20)
	[<c005312c>] (msleep) from [<bf4322e4>] (udc_enable+0x170/0x1d4 [pxa27x_udc])
	[<bf4322e4>] (udc_enable [pxa27x_udc]) from [<bf432560>] (pxa_udc_pullup+0x40/0x68 [pxa27x_udc])
	[<bf432560>] (pxa_udc_pullup [pxa27x_udc]) from [<bf4271c8>] (usb_gadget_connect+0x3c/0x5c [udc_core])
	[<bf4271c8>] (usb_gadget_connect [udc_core]) from [<bf43beac>] (usb_function_activate+0x98/0xa4 [libcomposite])
	[<bf43beac>] (usb_function_activate [libcomposite]) from [<bf44df08>] (uvc_function_connect+0x14/0x38 [usb_f_uvc])
	[<bf44df08>] (uvc_function_connect [usb_f_uvc]) from [<bf44e944>] (uvc_v4l2_open+0x4c/0x60 [usb_f_uvc])
	[<bf44e944>] (uvc_v4l2_open [usb_f_uvc]) from [<bf156420>] (v4l2_open+0x7c/0xc0 [videodev])
	[<bf156420>] (v4l2_open [videodev]) from [<c00b4010>] (chrdev_open+0x198/0x1b0)
	[<c00b4010>] (chrdev_open) from [<c00ad314>] (do_dentry_open.constprop.3+0x1b0/0x2ec)
	[<c00ad314>] (do_dentry_open.constprop.3) from [<c00bdbf0>] (path_openat+0xc10/0xdd4)
	[<c00bdbf0>] (path_openat) from [<c00bdde4>] (do_filp_open+0x30/0x78)
	[<c00bdde4>] (do_filp_open) from [<c00ae340>] (do_sys_open+0xf0/0x1b0)
	[<c00ae340>] (do_sys_open) from [<c000a320>] (ret_fast_syscall+0x0/0x38)

With the msleep changed to mdelay, the code (specified as !in_interrupt()) seems to work fine
(after torture reloads). Can the caller (udc core) be changed to be able to sleep?
	
Second bug was discovered by Robert Jarzmik during discussion in

	[BUG] usb: gadget: Kernel oops with UVC USB gadget and configfs

A call to usb_put_phy(udc->transceiver) in pxa_udc_remove() can be called with  variable
containing error pointer or NULL. So it should be moved to a previous call like this (modified
original suggestion):

	if (!IS_ERR_OR_NULL(udc->transceiver)) {
		usb_unregister_notifier(udc->transceiver, &pxa27x_udc_phy);
		usb_put_phy(udc->transceiver);
	}

And as we talking about it, is this return correct?

	if (of_have_populated_dt()) {
		udc->transceiver =
			devm_usb_get_phy_by_phandle(udc->dev, "phys", 0);

		if (IS_ERR(udc->transceiver))
			return PTR_ERR(udc->transceiver);
	} else {
		udc->transceiver = usb_get_phy(USB_PHY_TYPE_USB2);
	}

One branch returns on error and second one is fine, udc->transceiver then can hold an error,
but this is fine for the rest of driver (tested). Question is does it have to return from a first
branch (e.g. my device does not have phy)?

And finally it seems definitions from drivers/usb/gadget/udc/pxa27x_udc.c are duplicated:

	static void udc_enable(struct pxa_udc *udc);
	static void udc_disable(struct pxa_udc *udc);

I will send patch series as soon as we agree on solutions.

best regards,
Petr
