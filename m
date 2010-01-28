From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Jan 2010 17:44:55 +0000
Subject: IRQF_VALID
In-Reply-To: <aec7e5c31001280134r50b46b0ay809a125989651197@mail.gmail.com>
References: <aec7e5c31001280134r50b46b0ay809a125989651197@mail.gmail.com>
Message-ID: <20100128174455.GA21426@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2010 at 06:34:24PM +0900, Magnus Damm wrote:
> I'm trying to understand the idea behind IRQF_VALID. Ideally I'd like
> to submit a patch to remove IRQF_VALID to make it easier to share
> interrupt code between architectures. Perhaps IRQF_VALID is a left
> over from good old times, or maybe it has some hidden use that only
> more experienced hackers are aware or. Can anyone please shed some
> light?

On ARM, there are no IRQ tables, there is no hardware IRQ demultiplexing.
It's all done by software.  ARM systems tend to have chained interrupt
controllers, and as such NR_IRQS is normally greater than the actual
number of IRQs in the system.

We also have some situations where IRQs are supported by the controller,
but must never be requested (eg, there are some controllers where the
IRQ is permanently asserted and unmasking it will result in a screaming
interrupt.)

So, in order to make things sane, we need to tell the IRQ layer which
IRQs are valid for each platform.

Asking each platform to tell the core which IRQs are not valid is totally
the wrong thing to do - expecting platform X to deal with N additional
IRQs because platform Y is also configured is just insane.

> The ARM default state for interrupts seems to be IRQ_NOREQUEST, so
> mach code is required to call the ARM-specific set_irq_flags() even
> though most of the interrupt handling code is fairly generic using
> CONFIG_GENERIC_HARDIRQS=y. Why this special IRQF_VALID case for ARM?
> >From my point of view defaulting to IRQ_NOREQUEST unset like other
> platforms would make more sense.

genirq came from ARM originally; I've no idea why it was only partially
ported over...

> Today IRQ_NOREQUEST seems to be used for chained interrupt handlers.
> The check in request_threaded_irq() returns -EINVAL if IRQ_NOREQUEST
> is set. This covers request_irq(), but setup_irq() is lacking a check.
> Maybe this is done intentionally, or perhaps it's something I should
> fix?
> 
> If the purpose with IRQF_VALID is to guard against
> request_irq()/setup_irq() on irqs lacking chip backing, then good news
> is that the CONFIG_GENERIC_HARDIRQ already has code to handle this for
> us. Basically, the default in irq_desc_init makes use of &no_irq_chip.
> And the __setup_irq() code is already checking against irqs mapped to
> &no_irq_chip, those are disallowed with a -ENOSYS.
> 
> Is there any point in keeping IRQF_VALID on ARM, or shall I submit a
> patch to clean things up?

I have no real idea - in this respect, the forced conversion of ARM to
this genirq stuff was a half-botched job.  I really can't comment, and
from my point of view what we have we _know_ works for us, and I really
really really do not want to go and change it.

In order to make any change, there's a _huge_ platform base that would
need to be tested.
