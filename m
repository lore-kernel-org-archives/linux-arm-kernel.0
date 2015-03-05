From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 5 Mar 2015 16:32:27 +0000
Subject: [PATCH v2 5/6] watchdog: at91sam9: request the irq with
 IRQF_NO_SUSPEND
In-Reply-To: <CAJZ5v0h8vn26BeWPVhC4e_KNhBu15-mshnbq0K=OQ1M36vPQEQ@mail.gmail.com>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
 <1425287898-15093-6-git-send-email-boris.brezillon@free-electrons.com>
 <20150304183809.GD22156@leverpostej>
 <14143668.0aRkeVrc3Q@vostro.rjw.lan>
 <20150305105729.GB13617@leverpostej>
 <CAJZ5v0h8vn26BeWPVhC4e_KNhBu15-mshnbq0K=OQ1M36vPQEQ@mail.gmail.com>
Message-ID: <20150305163227.GF14093@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

> enable_irq_wake() has no effect on IRQF_NO_SUSPEND interrupts, so if the
> driver uses IRQF_NO_SUSPEND, it does not need to use enable_irq_wake()
> in addition to that.

That's not generally true -- certainly not for irq_chips without the
IRQCHIP_SKIP_SET_WAKE flag.

Consider systems where the suspended state results in power to the CPU
being cut, and we rely on an external piece of logic attached to the
irq_chip to detect wakeup IRQs and restore power.

In those cases irq_chip::irq_set_wake() must be called to ensure that
the wakeup logic is configured. If the wakeup logic is not configured to
look out for an IRQ, then when the IRQ is asserted by a device the
wakeup logic may not trigger. Thus the CPU power never gets restored, so
the CPU cannot handle the interrupt.

This is handled in enable_irq_wake() -- either the chip has the
IRQCHIP_SKIP_SET_WAKE flag set or chip->irq_set_wake() must succeed. If
neither is true enable_irq_wake() will return an error code to indicate
we can't use the IRQ for wakeup.

The request_irq path never results in a call to chip->irq_set_wake(),
even with the IRQF_NO_SUSPEND flag. So requesting an irq with
IRQF_NO_SUSPEND does not guarantee wakeup; it only guarantees that the
CPU can take the interrupt _around_ the suspended state, not necessarily
while _in_ the suspended state.

> Drivers using IRQF_COND_SUSPEND generally should use enable_irq_wake() too
> in case they end up in a situation without sharing a NO_SUSPEND interrupt, in
> which case their interrupt handlers won't be called after suspend_device_irqs(),
> so they need to rely on the core to do the wakeup.
> 
> > I agree that if problematic, it's an existing bug. Given Boris's
> > comments in the other thread this may just a minor semantic issue w.r.t.
> > IRQF_NO_SUSPEND vs IRQF_COND_SUSPEND.
> 
> It depends on whether or not the watchdog's interrupt handler has to be
> called immediately after receiving an interrupt (IRQF_NO_SUSPEND is
> better then) or it can be deferred till the resume_device_irqs() time.

We seem to be conflating some related properties:

[a] The IRQ will be left unmasked.
[b] The IRQ will be handled immediately when taken.
[c] The IRQ will wake the system from suspend.

Requesting an IRQ with IRQF_NO_SUSPEND guarantees [a,b], but does not
guarantee [c].

A successful enable_irq_wake() on an IRQ guarantees [a,c], but usually
does not give [b] unless the IRQ was requested with IRQF_COND_SUSPEND
and happens to be shared with an IRQF_NO_SUSPEND user.

It sounds like for this kind of watchdog device we want [a,b,c], even if
the IRQ is not shared with an IRQF_NO_SUSPEND user.

Thanks,
Mark.
