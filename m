From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 26 Feb 2015 12:09:19 +0100
Subject: [PATCH 1/8] irqchip: armada-370-xp: Simplify interrupt map, mask
 and unmask
In-Reply-To: <54EEF83C.40003@free-electrons.com>
References: <1424945593-20320-1-git-send-email-maxime.ripard@free-electrons.com>
 <1424945593-20320-2-git-send-email-maxime.ripard@free-electrons.com>
 <54EEF83C.40003@free-electrons.com>
Message-ID: <20150226110919.GC29241@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On Thu, Feb 26, 2015 at 11:41:00AM +0100, Gregory CLEMENT wrote:
> Hi Maxime,
> 
> On 26/02/2015 11:13, Maxime Ripard wrote:
> > From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > 
> > The map, mask and unmask is unnecessarily complicated, with a different
> > implementation for shared and per CPU interrupts. The current code does
> > the following:
> > 
> > At probe time, all interrupts are disabled and masked on all CPUs.
> > 
> > Shared interrupts:
> > 
> >  * When the interrupt is mapped(), it gets disabled and unmasked on the
> >    calling CPU.
> > 
> >  * When the interrupt is unmasked(), masked(), it gets enabled and
> >    disabled.
> > 
> > Per CPU interrupts:
> > 
> >  * When the interrupt is mapped, it gets masked on the calling CPU and
> >    enabled.
> > 
> >  * When the interrupt is unmasked(), masked(), it gets unmasked and masked,
> >    on the calling CPU.
> > 
> > This commit simplifies this code, with a much simpler implementation, common
> > to shared and per CPU interrupts.
> > 
> >  * When the interrupt is mapped, it's enabled.
> > 
> >  * When the interrupt is unmasked(), masked(), it gets unmasked and masked,
> >    on the calling CPU.
> > 
> > Tested on a Armada XP SoC with SMP and UP configurations, with chained and
> > regular interrupts.
> 
> This patch doesn't only simplify the driver it changes also its
> behavior and especially for the affinity.

The affinity itself is not changed by that patch. The default CPU the
interrupt handler is running on might, but as far as I know, there's
no guarantee on the affinity of an interrupt when irq_set_affinity has
not been called.

> If a driver call irq_enable() then this functions will call
> irq_enable() and as we didn't implement a .enable() operation, it will
> call only our unmask() function.
> 
> So if the IRQ was unmasked on a CPU and a driver call an irq_enable()
> from an other CPU then we will end up with the IRQ enabled on 2
> different CPUs. It is a problem for 2 reasons:

I guess you're talking about SPIs here, right?

> - the hardware don't handle a IRQ enable on more than one CPU

Oh. I would have expected one CPU to get a spurious interrupt, and the
other to handle the interrupt as expected.

> - it will modify the affinity at the hardware level because a new CPU
>   will be able to receive an IRQ whereas we setup the affinity on only
>   one CPU.

I'm not seure what you mean here.

The affinity is controlled by the INT_SOURCE_CTL register set, that is
left untouched by this patch.

> By only using the mask and unmask the affinity behavior is no more
> reliable. I agree that the current code is not trivial, but adding
> more comment instead of removing this capability should be better.

That can be done too. Especially using the second patch that makes it
a lot easier to extend the list of supported PPIs.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150226/25b544e3/attachment.sig>
