From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 28 Feb 2015 11:48:32 +0100
Subject: [PATCH 1/8] irqchip: armada-370-xp: Simplify interrupt map, mask
 and unmask
In-Reply-To: <54EF1722.8090201@free-electrons.com>
References: <1424945593-20320-1-git-send-email-maxime.ripard@free-electrons.com>
 <1424945593-20320-2-git-send-email-maxime.ripard@free-electrons.com>
 <54EEF83C.40003@free-electrons.com>
 <20150226110919.GC29241@lukather>
 <54EF1722.8090201@free-electrons.com>
Message-ID: <20150228104832.GC7390@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 26, 2015 at 01:52:50PM +0100, Gregory CLEMENT wrote:
> Hi Maxime,
> 
> On 26/02/2015 12:09, Maxime Ripard wrote:
> > Hi Gregory,
> > 
> > On Thu, Feb 26, 2015 at 11:41:00AM +0100, Gregory CLEMENT wrote:
> >> Hi Maxime,
> >>
> >> On 26/02/2015 11:13, Maxime Ripard wrote:
> >>> From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> >>>
> >>> The map, mask and unmask is unnecessarily complicated, with a different
> >>> implementation for shared and per CPU interrupts. The current code does
> >>> the following:
> >>>
> >>> At probe time, all interrupts are disabled and masked on all CPUs.
> >>>
> >>> Shared interrupts:
> >>>
> >>>  * When the interrupt is mapped(), it gets disabled and unmasked on the
> >>>    calling CPU.
> >>>
> >>>  * When the interrupt is unmasked(), masked(), it gets enabled and
> >>>    disabled.
> >>>
> >>> Per CPU interrupts:
> >>>
> >>>  * When the interrupt is mapped, it gets masked on the calling CPU and
> >>>    enabled.
> >>>
> >>>  * When the interrupt is unmasked(), masked(), it gets unmasked and masked,
> >>>    on the calling CPU.
> >>>
> >>> This commit simplifies this code, with a much simpler implementation, common
> >>> to shared and per CPU interrupts.
> >>>
> >>>  * When the interrupt is mapped, it's enabled.
> >>>
> >>>  * When the interrupt is unmasked(), masked(), it gets unmasked and masked,
> >>>    on the calling CPU.
> >>>
> >>> Tested on a Armada XP SoC with SMP and UP configurations, with chained and
> >>> regular interrupts.
> >>
> >> This patch doesn't only simplify the driver it changes also its
> >> behavior and especially for the affinity.
> > 
> > The affinity itself is not changed by that patch. The default CPU the
> > interrupt handler is running on might, but as far as I know, there's
> > no guarantee on the affinity of an interrupt when irq_set_affinity has
> > not been called.
> 
> Actually as soon as a driver do a request_irq the affinity is set in the
> __setup_irq function.
> 
> 
> > 
> >> If a driver call irq_enable() then this functions will call
> >> irq_enable() and as we didn't implement a .enable() operation, it will
> >> call only our unmask() function.
> >>
> >> So if the IRQ was unmasked on a CPU and a driver call an irq_enable()
> >> from an other CPU then we will end up with the IRQ enabled on 2
> >> different CPUs. It is a problem for 2 reasons:
> > 
> > I guess you're talking about SPIs here, right?
> 
> yes
> 
> > 
> >> - the hardware don't handle a IRQ enable on more than one CPU
> > 
> > Oh. I would have expected one CPU to get a spurious interrupt, and the
> > other to handle the interrupt as expected.
> 
> Unfortunately it is not the case and the behavior is unpredictable if an
> IRQ is set for more than one CPU.
> 
> > 
> >> - it will modify the affinity at the hardware level because a new CPU
> >>   will be able to receive an IRQ whereas we setup the affinity on only
> >>   one CPU.
> > 
> > I'm not seure what you mean here.
> > 
> > The affinity is controlled by the INT_SOURCE_CTL register set, that is
> > left untouched by this patch.
> 
> INT_SOURCE_CTL register and ARMADA_370_XP_INT_*_MASK_OFFS register are two
> way to access exactly the same value. So as you modify the use of the
> ARMADA_370_XP_INT_*_MASK_OFFS register you modify the affinity.
> 
> With ARMADA_370_XP_INT_*_MASK_OFFS you have one register per CPU and you
> write the number of the IRQ you want to enable or disable for this CPU. Whereas
> you have one INT_SOURCE_CTL register per interrupt and there you write the CPU
> mask. But in the hardware you modify the same thing.
> 
> In the case has an SPI the interrupt masks are controlled by two register, one
> at a global level and the other at the CPU level.
> 
> CPU0--INT_*_MASK_OFFS--|
>                        |
> CPU1--INT_*_MASK_OFFS--|
>                        |---INT_*_ENABLE_OFFS----IRQ
> CPU2--INT_*_MASK_OFFS--|
>                        |
> CPU3--INT_*_MASK_OFFS--|
> 
> So currently we only modify the INT_*_ENABLE_OFFS register for the irq_mask/unmask
> operation. And we only modify INT_*_MASK_OFFS(or INT_SOURCE_CTL as it modifies the
> same value) for the affinity.
> 
> With this patch, the INT_*_ENABLE_OFFS is removed and INT_*_MASK_OFFS are modified
> in the same time for affinity and for irq_mask/unmask which could lead to some
> unexpected behaviors.
> 
> For the PPI, there is no INT_*_ENABLE_OFFS register but for them we don't use
> affinity. That why the way to handle them is different from the SPI.

Ok. I'll drop this patch then.

> By the way the current code in irq_mask/unmask is bogus, instead of
> if (hwirq != ARMADA_370_XP_TIMER0_PER_CPU_IRQ)
> we should have
> if (hwirq >  ARMADA_370_XP_MAX_PER_CPU_IRQS)

Indeed, but since we hacked a bit to have some PPIs behaving like SPIs
(for the mvneta for example), I don't think we can do that right now.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150228/8a10a912/attachment-0001.sig>
