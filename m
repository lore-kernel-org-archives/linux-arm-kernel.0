From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Oct 2015 16:23:33 +0200
Subject: [PATCH 0/5] Fix regression introduced by set_irq_flags() removal
In-Reply-To: <20151020141736.GX32532@n2100.arm.linux.org.uk>
References: <1445347435-2333-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20151020140427.GE3953@io.lakedaemon.net>
 <20151020160828.497fcc80@free-electrons.com>
 <20151020141736.GX32532@n2100.arm.linux.org.uk>
Message-ID: <20151020162333.5b4ca490@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Tue, 20 Oct 2015 15:17:36 +0100, Russell King - ARM Linux wrote:

> However, this is rather worrying.  NOAUTOEN is supposed to avoid enabling
> the interrupt when the interrupt is claimed.
> 
> If, as a result of Rob's patch, we now have a load of IRQs which are
> marked with NOAUTOEN which weren't, that's quite a large regression -
> possibly one which hasn't been properly found (not everyone tests -rc
> kernels) and we may be better to revert Rob's patch to avoid lots of
> breakge being reported when 4.3 is released.

I believe the problem is only for per-CPU interrupts. We have
IRQ_NOAUTOEN set for per-CPU interrupts because:

static inline void irq_set_percpu_devid_flags(unsigned int irq)
{
        irq_set_status_flags(irq,
                             IRQ_NOAUTOEN | IRQ_PER_CPU | IRQ_NOTHREAD |
                             IRQ_NOPROBE | IRQ_PER_CPU_DEVID);
}

Calling set_irq_flags() used to have the effect of *clearing* the
IRQ_NOAUTOEN flag:

-void set_irq_flags(unsigned int irq, unsigned int iflags)
-{
-       unsigned long clr = 0, set = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
-
-       if (irq >= nr_irqs) {
-               pr_err("Trying to set irq flags for IRQ%d\n", irq);
-               return;
-       }
-
-       if (iflags & IRQF_VALID)
-               clr |= IRQ_NOREQUEST;
-       if (iflags & IRQF_PROBE)
-               clr |= IRQ_NOPROBE;
-       if (!(iflags & IRQF_NOAUTOEN))
-               clr |= IRQ_NOAUTOEN;
-       /* Order is clear bits in "clr" then set bits in "set" */
-       irq_modify_status(irq, clr, set & ~clr);
-}

I.e, unless you were passing IRQF_NOAUTOEN in your set_irq_flags()
invocation, set_irq_flags() was automatically clearing the IRQ_NOAUTOEN
bit.

But this is really only a per-CPU interrupt problem, which probably
limits the potential regressions caused by Rob's change.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
