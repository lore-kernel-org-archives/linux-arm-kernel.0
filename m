From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 20 Jan 2015 10:02:06 +0100
Subject: [PATCHv3 2/2] USB: gadget: atmel_usba_udc: Enable/disable USB
 PLL on Vbus change
In-Reply-To: <20150119211532.0759b537@bbrezillon>
References: <20150118175621.6b519cdc@bbrezillon>	<1421601875-9436-1-git-send-email-sylvain.rochet@finsecur.com>	<1421601875-9436-3-git-send-email-sylvain.rochet@finsecur.com>	<54BD36F6.8030408@atmel.com>	<20150119174631.GA26716@gradator.net>
 <20150119211532.0759b537@bbrezillon>
Message-ID: <54BE198E.4040808@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 19/01/2015 21:15, Boris Brezillon a ?crit :
> On Mon, 19 Jan 2015 18:46:31 +0100
> Sylvain Rochet <sylvain.rochet@finsecur.com> wrote:
> 
>> Hello Nicolas,
>>
>>
>> On Mon, Jan 19, 2015 at 05:55:18PM +0100, Nicolas Ferre wrote:
>>> Le 18/01/2015 18:24, Sylvain Rochet a ?crit :
>>>> Prepare_enable on rising edge, disable_unprepare on falling edge. Reduce
>>>
>>> Please re-write which "edge" we are talking about: "... falling edge of
>>> the Vbus signal" for example.
>>>
>>>> power consumption if USB PLL is not already necessary for OHCI or EHCI.
>>>
>>> Is a verb missing in the previous sentence?
>>>
>>>> If USB host is not connected we can sleep with USB PLL stopped.
>>>>
>>>> This driver does not support suspend/resume yet, not suspending if we
>>>> are still attached to an USB host is fine for what I need, this patch
>>>> allow suspending with USB PLL stopped when USB device is not currently
>>>> used.
>>>
>>> Can you please make it more clear. Several separated sentences seem
>>> necessary here.
>>
>> Maybe :)
>>
>>
>> Proposal:
>>
>> Start clocks on rising edge of the Vbus signal, stop clocks on 
>> falling edge of the Vbus signal.
>>
>> If USB PLL is not necessary for other USB drivers (e.g. OHCI and EHCI) 
>> it will reduce power consumption by switching off the USB PLL if no USB 
>> Host is currently connected to this USB Device.
>>
>> We are using Vbus GPIO signal to detect Host presence. If Vbus signal is 
>> not available then the device stay continuously clocked.

Typo: s/stay/stays/

>> Note this driver does not support suspend/resume yet, it may stay 
>> clocked if USB Host is still connected when suspending. For what I need, 
>> forbidding suspend from userland if we are still attached to an USB host 
>> is fine, but we might as well add suspend/resume to this driver in the 
>> future.

Sylvain, thanks for having rephrased this part! It looks clear.


>>>>  	/* May happen if Vbus pin toggles during probe() */
>>>> -	if (!udc->driver)
>>>> +	spin_lock_irqsave(&udc->lock, flags);
>>>> +	if (!udc->driver) {
>>>> +		spin_unlock_irqrestore(&udc->lock, flags);
>>>>  		goto out;
>>>> +	}
>>>> +	spin_unlock_irqrestore(&udc->lock, flags);
>>>
>>> I'm not sure that the protection by spin_lock is needed above.
>>
>> I'm not sure too, it was already in a spinlock area, I obviously kept it 
>> because it was not the purpose of this patch.
> 
> According to the comment placed above this test it's here to prevent
> any action triggered by the vbus pin irq while the driver is not
> properly probed yet.
> You could use:
> 
> set_irq_flags(vbus_irq, IRQF_NOAUTOEN);
> 
> before calling devm_request_threaded_irq.
> This will keep the irq disabled instead of enabling it at request time.
> Moreover, this simplify the vbus_irq request code (which disables the
> irq just after requesting it).
> 
>>
>> This seem to be in mirror of atmel_usba_start() which does:
>>
>>   spin_lock_irqsave(&udc->lock, flags);
>>   udc->devstatus = 1 << USB_DEVICE_SELF_POWERED;
>>   udc->driver = driver;
>>   spin_unlock_irqrestore(&udc->lock, flags);
>>
>> ? but vbus_pin IRQ is not yet enabled.
>>
>>
>> Same for atmel_usba_stop() which disable vbus_pin IRQ before setting 
>> udc->driver to NULL, but without spinlock this time (why?, this should 
>> be consistent IMHO).
>>
>>
>> I don't know if it is guaranteed that IRQ does not fire nor continue to 
>> run after disable_irq() returns, especially for threaded IRQ.
> 
> And yes, disable_irq waits for all irq handler termination, including
> threaded irqs: see [1], [2]. 
> 
>>
>>
>> If the following sequence might happen:
>>   atmel_usba_stop()
>>     disable_irq(vbus)
>>                                   usba_vbus_irq_thread() called lately
>>                                     check for (!udc->driver) and continue
>>     udc->driver = NULL;
>>                                     if (udc->driver->disconnect)
>>                                  *CRASH*
>>
>> Then the patch should be modified to protect udc->driver with the vbus 
>> mutex.
>>
>> In this case the previous implementation wasn't perfect too, the 
>> atmel_usba_stop() does not lock around the NULLification of driver, 
>>
>> Moreover the spinlock is (and was) unlocked in VBUS interrupt just 
>> before calling udc->driver->disconnect, which makes udc->driver actually 
>> not locked anywere.
>>
>> If the previous sequence possible ?  If no, udc->driver does not need 
>> locking, if yes, it is currently not locked enough.
> 
> If you rework the vbus_irq request as I suggested I think you can get
> rid of this !udc->driver test, and thus drop the locking around it ;-).
> 
> Best Regards,
> 
> Boris
> 
> [1]http://lxr.free-electrons.com/source/kernel/irq/manage.c#L432
> [2]http://lxr.free-electrons.com/source/kernel/irq/manage.c#L92

Thanks Sylvain for having described the problem lengthly and Boris for
your detailed explanation and suggestion concerning this sequence.

So, if you can re-send a new version and also add the stable tags as
suggested by Felipe, it would be really cool.

Bye,
-- 
Nicolas Ferre
