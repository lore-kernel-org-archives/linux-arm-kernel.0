From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 24 Jan 2015 20:24:26 +0100 (CET)
Subject: [PATCH 3/5] ARM: sa1100: use ioremapped memory to access SC
 registers
In-Reply-To: <CALT56yP+PGCnbUN0BB4QTQ6phxmqL43vRoS_rtoMrgfjAtr3Rw@mail.gmail.com>
References: <1421316574-10022-1-git-send-email-dbaryshkov@gmail.com>
 <1421316574-10022-3-git-send-email-dbaryshkov@gmail.com>
 <alpine.DEB.2.11.1501241846540.5526@nanos>
 <CALT56yP+PGCnbUN0BB4QTQ6phxmqL43vRoS_rtoMrgfjAtr3Rw@mail.gmail.com>
Message-ID: <alpine.DEB.2.11.1501242021210.5526@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 24 Jan 2015, Dmitry Eremin-Solenikov wrote:

> 2015-01-24 20:48 GMT+03:00 Thomas Gleixner <tglx@linutronix.de>:
> > On Thu, 15 Jan 2015, Dmitry Eremin-Solenikov wrote:
> >>  static void sa1100_mask_irq(struct irq_data *d)
> >>  {
> >> -     ICMR &= ~BIT(d->hwirq);
> >> +     u32 reg;
> >> +     unsigned long flags;
> >> +
> >> +     raw_spin_lock_irqsave(&lock, flags);
> >
> > What's the exact point of that lock? And how is it related to the
> > $subject of the patch?
> 
> It is needed to protect ICMR register during RMW cycle, isn't it?

The original code has no protection for the RMW either.

And there is a simple reason for this. These functions are guaranteed
to be called with interrupts disabled and this is a uniprocessor
machine and it will never grow SMP support. So interrupts disabled is
serialization enough.

Thanks,

	tglx
