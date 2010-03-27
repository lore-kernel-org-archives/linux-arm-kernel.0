From: ulf.samuelsson@atmel.com (Ulf Samuelsson)
Date: Sat, 27 Mar 2010 08:01:41 +0100
Subject: request_irq in I2C driver causes kernel to freeze during probe,
	but if done later - no problem!
In-Reply-To: <20100327011223.GG31126@trinity.fluff.org>
References: <4BAD406A.7070208@atmel.com>	<20100326232421.GG29179@n2100.arm.linux.org.uk>	<4BAD4FDE.2010904@atmel.com>
	<4BAD5450.7020605@atmel.com>
	<20100327011223.GG31126@trinity.fluff.org>
Message-ID: <4BADAD55.1080304@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben Dooks skrev:
> On Sat, Mar 27, 2010 at 01:41:52AM +0100, Ulf Samuelsson wrote:
>> Ulf Samuelsson skrev:
>>> Russell King - ARM Linux skrev:
>>>> On Sat, Mar 27, 2010 at 12:16:58AM +0100, Ulf Samuelsson wrote:
>>>>> If the interrupt is executing, then we would see some I2C communication
>>>>> as a result, but we do not see this, before the kernel freezes.
>>>>>
>>>>> The interrupt is (and should be) called on the falling edge of the
>>>>> interrupt.
>>>>>
>>>>> I am currently scratching my head, and need help with ideas...
>>>> Do you always return IRQ_HANDLED from this handler, or do you return
>>>> IRQ_NONE if it does no work?
>>>>
>>>> If you always return IRQ_HANDLED even if no work was done, it could be
>>>> that you're spinning on this interrupt, and because you're returning
>>>> IRQ_HANDLED, the core interrupt handling code thinks progress is being
>>>> made.
>>>>
>>>> If you return IRQ_NONE, then the "bad IRQ" detection code will kick in
>>>> and disable the IRQ, which should result in some further progress.
>>>>
>>> Thanks for fast reply.
>>>
>>> This is my interrupt routine, which always return IRQ_HANDLED.
>>> sysfs shows that "mxt->invalid_irq_counter" is never incremented
>>> even after I successfully enable the interrupt in sysfs.
>>>
>>> mxt->dwork will always access the I2C bus but we dont see that.
>>>
>>> static irqreturn_t mxt_irq_handler(int irq, void *_mxt)
>>> {
>>> 	struct	mxt_data *mxt = _mxt;
>>> 	unsigned long	flags;
>>> 	mxt->irq_counter++;
>>> 	spin_lock_irqsave(&mxt->lock, flags);
>>>
>>> 	if (mxt_valid_interrupt()) {
>>> 		/* Macro, always returning 1  on these boards */
>>> 		cancel_delayed_work(&mxt->dwork);
>>> 		schedule_delayed_work(&mxt->dwork, 0);
>>> 		mxt->valid_irq_counter++;
>>> 	} else {
>>> 		mxt->invalid_irq_counter++;
>>> 	}
>>> 	spin_unlock_irqrestore(&mxt->lock, flags);
>>>
>>> 	return IRQ_HANDLED;
>>> }
>>>
>> I tried doing an I2C transfer inside the interrupt routine
>> (this is my only way of logging)
>> and then the I2C probe routine locked up already when
>> doing the request_irq.
> 
> i2c transfers can sleep, thus you need somet thread or work-queue to
> process them. 

OK, We quickly came to the conlusion that this was a bad idea...

> 
>> The interrupt line will, after asserted low, remain low
>> until a status register is read over the I2C bus,
>> and the interrupt is triggered by falling edge
>> so I assume that the interrupt should only be called once.
> 
> are you sure the controller is setting the proper irq mode? 

The "request_irq" requests IRQF_TRIGGER_FALLING.
Is this what you mean?

> have
> you tried adding a disable_irq_nosync() to the handler?
> 

No,
I assume that, since I request interrupt on falling edge
the interrupt will not be activated until the target
provides a new falling edge on the interrupt line.

Sine you need to access the chip over I2C for the chip
to do so, and we do not see such packets on the sniffer,
the interrupt should not be reactivated.

Even if I return IRQ_HANDLED, should the low interrupt
cause new interrupts to happen?

One difference between the Beagleboard implementation
which works, and the Snapdragon which does not work,
is that there are multiple targets on the bus of the latter.

Unfortunately, I have no access to the Snapdragon hardware until
after Easter holidays but I will try some ideas from you guys ASAP.
Thanks.

BR
Ulf

>> If the interrupt is enabled by the register_irq, and it does
>> occur during the probe, and not afterwards,
>> can this affect the mxt_worker routine?
>>
>> The probe does a significant amount of i2c communication
>> after the register_irq, and if the interrupt has been asserted
>> already, the interrupt will be deasserted before the probe exits.
>>
>> Somehow I have a feeling that the freeze occurs because
>> the kernel wants to process the delayed work, sometimes
>> after the probe exits.
>>
>> Maybe the i2c communication should occur before the register irq?
>>
>> BR
>> Ulf Samuelsson
>>
>>
>>> I do
>>> 	INIT_DELAYED_WORK(&mxt->dwork, mxt_worker);
>>> 	spin_lock_init(&mxt->lock);
>>>
>>> before I request the irq
>>>
>>>
>>> BR
>>> Ulf Samuelsson.
>>>
>>>
>>>> _______________________________________________
>>>> linux-arm-kernel mailing list
>>>> linux-arm-kernel at lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
