From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 27 Mar 2010 09:17:37 +0000
Subject: request_irq in I2C driver causes kernel to freeze during probe,
	but if done later - no problem!
In-Reply-To: <4BAD4FDE.2010904@atmel.com>
References: <4BAD406A.7070208@atmel.com>
	<20100326232421.GG29179@n2100.arm.linux.org.uk>
	<4BAD4FDE.2010904@atmel.com>
Message-ID: <20100327091736.GI29179@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 27, 2010 at 01:22:54AM +0100, Ulf Samuelsson wrote:
> This is my interrupt routine, which always return IRQ_HANDLED.
> sysfs shows that "mxt->invalid_irq_counter" is never incremented
> even after I successfully enable the interrupt in sysfs.
> 
> mxt->dwork will always access the I2C bus but we dont see that.
> 
> static irqreturn_t mxt_irq_handler(int irq, void *_mxt)
> {
> 	struct	mxt_data *mxt = _mxt;
> 	unsigned long	flags;
> 	mxt->irq_counter++;
> 	spin_lock_irqsave(&mxt->lock, flags);
> 
> 	if (mxt_valid_interrupt()) {
> 		/* Macro, always returning 1  on these boards */
> 		cancel_delayed_work(&mxt->dwork);
> 		schedule_delayed_work(&mxt->dwork, 0);
> 		mxt->valid_irq_counter++;
> 	} else {
> 		mxt->invalid_irq_counter++;

The other thing is that in this case you should ultimately return
IRQ_NONE from this handler.
