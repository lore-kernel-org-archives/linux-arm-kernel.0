From: petr.cvek@tul.cz (Petr Cvek)
Date: Thu, 23 Feb 2017 02:34:58 +0100
Subject: [RFC] usb: gadget: scheduling while atomic in pxa27x_udc,
 IS_ERR_OR_NULL test, duplicated definition
In-Reply-To: <87mvdex8b8.fsf@belgarion.home>
References: <e33b2bdb-f365-28d0-768a-c8e94a7794f9@tul.cz>
 <87mvdex8b8.fsf@belgarion.home>
Message-ID: <91f0847e-3d17-eaa2-7b3c-84ad4a9fef27@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 22.2.2017 v 21:46 Robert Jarzmik napsal(a):
> Petr Cvek <petr.cvek@tul.cz> writes:
> 
> Hi Petr,
> 
>> I found a few problems with the PXA27x UDC.
>>
>> 	usb_function_activate() in drivers/usb/gadget/composite.c
>>
>> does spin_lock_irqsave() and then calls 
>>
>> 	gadget->ops->pullup() in drivers/usb/gadget/udc/core.c
>>
>> which is set to pxa_udc_pullup(), which should be called not in interrupt
>>
>> 	/**
>> 	 * pxa_udc_pullup - Offer manual D+ pullup control
>> 	 * @_gadget: usb gadget using the control
>> 	 * @is_active: 0 if disconnect, else connect D+ pullup resistor
>> 	 * Context: !in_interrupt()
>> 	 *
>> 	 * Returns 0 if OK, -EOPNOTSUPP if udc driver doesn't handle D+ pullup
>> 	 */
>>
>> This finally causes fail at
>>
>> 	udc_enable() in drivers/usb/gadget/udc/pxa27x_udc.c
>> 	
>> at code
>>
>> 	/*
>> 	 * Caller must be able to sleep in order to cope with startup transients
>> 	 */
>> 	msleep(100);
>>
>> with a following error (with CONFIG_DEBUG_PREEMPT on):
>>
>> 	BUG: scheduling while atomic: v4l_id/360/0x00000002
>>
>> With the msleep changed to mdelay, the code (specified as !in_interrupt()) seems to work fine
>> (after torture reloads). Can the caller (udc core) be changed to be able to
>> sleep?
> 
> This question is for Felipe. From the several years back when I wrote this code
> I think it was granted that the pullup() callback was not in interrupt context,
> but Felipe knows better.
> 

Well now it is definitely inside spin_lock_irqsave()

	http://lxr.free-electrons.com/source/drivers/usb/gadget/composite.c#L374


>> 	if (of_have_populated_dt()) {
>> 		udc->transceiver =
>> 			devm_usb_get_phy_by_phandle(udc->dev, "phys", 0);
>>
>> 		if (IS_ERR(udc->transceiver))
>> 			return PTR_ERR(udc->transceiver);
>> 	} else {
>> 		udc->transceiver = usb_get_phy(USB_PHY_TYPE_USB2);
>> 	}
>>
>> One branch returns on error and second one is fine, udc->transceiver then can hold an error,
>> but this is fine for the rest of driver (tested). Question is does it have to return from a first
>> branch (e.g. my device does not have phy)?
> In the devicetree context (first branch), even if you don't have a phy, you'll
> instanciate a "nop" phy, ie. "usb-nop-xceiv". From a hardware perspective, you
> have a phy, it's just that you don't have to do anything from a software
> perspective to activate your phy.
> 
> In the platform_data context (second branch), an error is the common path, as
> there is no phy in many old platforms, and pxa27x are old ... hence no check of
> error.
> 

OK so no problem there.

>> And finally it seems definitions from drivers/usb/gadget/udc/pxa27x_udc.c are duplicated:
>>
>> 	static void udc_enable(struct pxa_udc *udc);
>> 	static void udc_disable(struct pxa_udc *udc);
>>
>> I will send patch series as soon as we agree on solutions.
> Excellent.

OK mdelay/msleep problem will take longer, so I will send that two patches now.

Petr
