From: ulf.samuelsson@atmel.com (Ulf Samuelsson)
Date: Sat, 27 Mar 2010 01:22:54 +0100
Subject: request_irq in I2C driver causes kernel to freeze during	probe,
	but if done later - no problem!
In-Reply-To: <20100326232421.GG29179@n2100.arm.linux.org.uk>
References: <4BAD406A.7070208@atmel.com>
	<20100326232421.GG29179@n2100.arm.linux.org.uk>
Message-ID: <4BAD4FDE.2010904@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux skrev:
> On Sat, Mar 27, 2010 at 12:16:58AM +0100, Ulf Samuelsson wrote:
>> If the interrupt is executing, then we would see some I2C communication
>> as a result, but we do not see this, before the kernel freezes.
>>
>> The interrupt is (and should be) called on the falling edge of the
>> interrupt.
>>
>> I am currently scratching my head, and need help with ideas...
> 
> Do you always return IRQ_HANDLED from this handler, or do you return
> IRQ_NONE if it does no work?
> 
> If you always return IRQ_HANDLED even if no work was done, it could be
> that you're spinning on this interrupt, and because you're returning
> IRQ_HANDLED, the core interrupt handling code thinks progress is being
> made.
> 
> If you return IRQ_NONE, then the "bad IRQ" detection code will kick in
> and disable the IRQ, which should result in some further progress.
> 

Thanks for fast reply.

This is my interrupt routine, which always return IRQ_HANDLED.
sysfs shows that "mxt->invalid_irq_counter" is never incremented
even after I successfully enable the interrupt in sysfs.

mxt->dwork will always access the I2C bus but we dont see that.

static irqreturn_t mxt_irq_handler(int irq, void *_mxt)
{
	struct	mxt_data *mxt = _mxt;
	unsigned long	flags;
	mxt->irq_counter++;
	spin_lock_irqsave(&mxt->lock, flags);

	if (mxt_valid_interrupt()) {
		/* Macro, always returning 1  on these boards */
		cancel_delayed_work(&mxt->dwork);
		schedule_delayed_work(&mxt->dwork, 0);
		mxt->valid_irq_counter++;
	} else {
		mxt->invalid_irq_counter++;
	}
	spin_unlock_irqrestore(&mxt->lock, flags);

	return IRQ_HANDLED;
}


I do
	INIT_DELAYED_WORK(&mxt->dwork, mxt_worker);
	spin_lock_init(&mxt->lock);

before I request the irq


BR
Ulf Samuelsson.


> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
