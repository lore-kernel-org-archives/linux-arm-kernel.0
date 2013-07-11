From: rogerq@ti.com (Roger Quadros)
Date: Thu, 11 Jul 2013 10:30:07 +0300
Subject: [PATCH 5/6] USB: Support wakeup IRQ for suspended controllers
In-Reply-To: <Pine.LNX.4.44L0.1307101440140.1215-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1307101440140.1215-100000@iolanthe.rowland.org>
Message-ID: <51DE5EFF.5080005@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/2013 09:45 PM, Alan Stern wrote:
> On Wed, 10 Jul 2013, Roger Quadros wrote:
> 
>> Some platforms e.g. ehci-omap can generate an interrupt
>> (i.e. remote wakeup) even when the controller is suspended i.e.
>> HW_ACCESSIBLE is cleared.
>>
>> Introduce a flag "has_wakeup_irq" in struct usb_hcd to indicate
>> such cases.
>>
>> We tackle this case by disabling the IRQ, scheduling a
>> hub resume and enabling back the IRQ after the controller has
>> resumed. This ensures that the IRQ handler runs only after the
>> controller is accessible.
> 
>> @@ -2248,7 +2253,21 @@ irqreturn_t usb_hcd_irq (int irq, void *__hcd)
>>  	 */
>>  	local_irq_save(flags);
>>  
>> -	if (unlikely(HCD_DEAD(hcd) || !HCD_HW_ACCESSIBLE(hcd)))
>> +	if (unlikely(HCD_DEAD(hcd)))
>> +		rc = IRQ_NONE;
>> +	else if (unlikely(!HCD_HW_ACCESSIBLE(hcd) && hcd->has_wakeup_irq)) {
>> +		/*
>> +		 * We got a wakeup interrupt while the controller was
>> +		 * suspending or suspended.  We can't handle it now, so
>> +		 * disable the IRQ and resume the root hub (and hence
>> +		 * the controller too).
>> +		 */
>> +		disable_irq_nosync(hcd->irq);
>> +		set_bit(HCD_FLAG_IRQ_DISABLED, &hcd->flags);
>> +		usb_hcd_resume_root_hub(hcd);
>> +
>> +		rc = IRQ_HANDLED;
>> +	} else if (unlikely(!HCD_HW_ACCESSIBLE(hcd)))
>>  		rc = IRQ_NONE;
> 
> In the interest of minimizing the amount of work needed in the most 
> common case, this should be written as:
> 
> 	else if (unlikely(!HCD_HW_ACCESSIBLE(hcd))) {
> 		if (hcd->has_wakeup_irq) {
> 			...
> 		} else
> 			rc = IRQ_NONE;
> 

OK.

>>  	else if (hcd->driver->irq(hcd) == IRQ_NONE)
>>  		rc = IRQ_NONE;
> 
> Apart from that, the patch is okay.  When you rearrange the logic, you 
> can add my Acked-by.
> 
Thanks.

cheers,
-roger
