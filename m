From: takahiro.akashi@linaro.org (takahiro.akashi at linaro.org)
Date: Wed, 4 Jul 2018 17:41:25 +0900
Subject: panic kexec broken on ARM64?
In-Reply-To: <86601wzn3h.wl-marc.zyngier@arm.com>
References: <20180605100151.7fd54381@ezekiel.suse.cz>
 <8028219f-0d14-eafd-86b7-359ee927bcd3@arm.com>
 <5e539510-01b7-ebc5-778e-b49a5261f9bc@i2se.com>
 <2865150f-ebca-4c6b-fc4b-93bfab5f0e91@arm.com>
 <86lgbm96dq.wl-marc.zyngier@arm.com>
 <20180703070106.GV23681@linaro.org>
 <86601wzn3h.wl-marc.zyngier@arm.com>
Message-ID: <20180704084123.GC28220@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 03, 2018 at 09:58:44AM +0100, Marc Zyngier wrote:
> On 03/07/18 08:01, takahiro.akashi at linaro.org wrote:
> > Marc, James,
> > 
> > I'd like to re-ignite the discussion.
> > 
> > On Sun, Jun 10, 2018 at 01:24:17PM +0100, Marc Zyngier wrote:
> >> On Wed, 06 Jun 2018 12:37:02 +0100,
> >> James Morse wrote:
> >>>
> >>> Hi Stefan,
> >>>
> >>> On 06/06/18 08:02, Stefan Wahren wrote:
> >>>> Am 05.06.2018 um 19:46 schrieb James Morse:
> >>>>> On 05/06/18 09:01, Petr Tesarik wrote:
> >>>>>> I attached a hardware debugger and found
> >>>>>> out that all CPU cores were stopped except one which was stuck in the
> >>>>>> idle thread. It seems that irq_set_irqchip_state() may sleep, which is
> >>>>>> definitely not safe after a kernel panic.
> >>>
> >>>>> I don't know much about irqchip stuff, but __irq_get_desc_lock() takes a
> >>>>> raw_spin_lock(), and calls gic_irq_get_irqchip_state() which is just poking
> >>>>> around in mmio registers, this should all be safe unless you re-entered the same
> >>>>> code.
> >>>
> >>>>>> If I'm right, then this is broken in general, but I have only ever seen
> >>>>>> it on RPi 3 Model B+ (even RPi3 Model B works fine), so the issue may
> >>>>>> be more subtle.
> >>>
> >>>>> Is there a hardware difference around the interrupt controller on these?
> >>>
> >>>> No, but the RPi 3 B has a different USB network chip on board (smsc95xx, Fast
> >>>> ethernet) instead of lan78xx (Gigabit ethernet).
> >>>
> >>> Bingo: its the lan78xx driver that is sleeping from the irqchip
> >>> callbacks; The smsc95xx driver doesn't have a struct irq_chip, which
> >>> is why the RPi-3-B doesn't do this.
> >>>
> >>> It may be valid for kdump to only teardown the 'root irqdomain' (if
> >>> that even means anything). I assume these secondary irqchip's would
> >>> have a summary-interrupt that goes to another irqchip. But I can't
> >>> see a way to tell them apart..,
> >>
> >> There is none. A cascaded irqchip is just like a root irqchip, just
> >> that its output line is connected to another irqchip. But we have no
> >> easy way to identify the parent. Also, this particular driver looks
> >> quite creative (it reinvents the wheel for chained interrupts -- see
> >> intr_complete and lan78xx_status), meaning that even if we could have
> >> a magic way of identify a chained irqchip, we'd miss that one. Broken.
> >>
> >>> I think we need to wait until after the merge window for Marc's
> >>> wisdom on this!
> >>
> >> Overall, I can't think of an easy fix. We have a few options, but none
> >> of them involve a centralised change:
> >>
> >> 1) We provide a reset infrastructure for irqchips, with an opt-in
> >>    mechanism. This involves changing the way we teardown irqs at
> >>    crash-time, and we'd then need some notion of reset ordering (think
> >>    of the layered ITS and GICv3, for example).
> > 
> > Does this mean that all the irqchips have to be implemented with reset?
> 
> No. Only those that want to be reset at kexec time.

I don't get the point yet. Who should have reset interface?
What is the criteria?

> >>
> >> 2) We provide a way to identify interrupts that are ultimately backed
> >>    by a root controller, which implies walking down the hierarchy for
> > 
> > To be clear, from bottom to top (or root), right?
> 
> I'm not sure I understand your question. The idea is to walk the
> irq_data chain, until we hit a root irqchip. If we do hit one, we
> deactivate/eoi/disable this interrupt. If we don't, we do nothing.

I thought that we would traverse the (chained irq) hierarchy from
bottom to top and call deactivate or others in that order.
Am I wrong here?

> This would avoid the above brokenness, and still ensures that no
> interrupt reaches the CPU.
> 
> > 
> >>    each one of them. Fairly expensive, but minimal in way of changes
> >>    in the crash code. Requires a per-irqchip flag, but ordering comes
> >>    in for free.
> >>
> >> 3) We do the same as (2), but at the irqdomain level. Not sure that's
> >>    any better, and it may be even more complicated and bring back some
> >>    ordering issues.
> > 
> > Do you think that the same thing may happen in case of pci/msi?
> > I have no confidence but MSI has some kind of irq domain hierarchy.
> 
> Anything can happen, as people implement their interrupt infrastructure
> in weird and wonderful ways. So we need to be prepared for the worse.
> 
> I've pushed 3 patches on a branch[1]. It is mostly untested, but it
> should allow the above RPi3 disaster to cope with kexec.

I don't have any hardware that sees this kind of issue and can't test.

-Takahiro AKASHI

> 	M.
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/root-irqchip
> 
> -- 
> Jazz is not dead, it just smell funny.
