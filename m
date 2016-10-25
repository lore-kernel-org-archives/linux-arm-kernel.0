From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 25 Oct 2016 11:20:44 +0200 (CEST)
Subject: Disabling an interrupt in the handler locks the system up
In-Reply-To: <580F17E7.5060603@laposte.net>
References: <580A4460.2090306@free.fr>
 <a79e2d2c-8ec8-744f-50fb-8c39216aa23e@arm.com> <580A60ED.3030307@free.fr>
 <20161021201448.3f4a0a7a@arm.com> <580A70B9.8060507@free.fr>
 <alpine.DEB.2.20.1610212147420.4855@nanos> <580A7A2B.5000702@free.fr>
 <20161022123713.6dc788b3@arm.com> <580BF1D4.2030509@free.fr>
 <580E3308.4050507@free.fr> <alpine.DEB.2.20.1610241847580.5002@nanos>
 <580F17E7.5060603@laposte.net>
Message-ID: <alpine.DEB.2.20.1610251055210.4990@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Oct 2016, Sebastian Frias wrote:
> On 10/24/2016 06:55 PM, Thomas Gleixner wrote:
> > On Mon, 24 Oct 2016, Mason wrote:
> >>
> >> For the record, setting the IRQ_DISABLE_UNLAZY flag for this device
> >> makes the system lock-up disappear.
> > 
> > The way how lazy irq disabling works is:
> > 
> > 1) Interrupt is marked disabled in software, but the hardware is not masked
> > 
> > 2) If the interrupt fires befor the interrupt is reenabled, then it's
> >    masked at the hardware level in the low level interrupt flow handler.
> > 
> Would you mind explaining what is the intention behind?
> Because it does not seem obvious why there isn't a direct map between
> "disable_irq*()" and "mask_irq()"

Two reasons for this:

1) If you mask edge type interrupts then you might race with an incoming
   interrupt which then gets lost and eventually you won't get another
   interrupt from that device. Even if there is no race, then on many irq
   chips edge type interrupts are not latched when the interrupt line is
   masked. That also can result in a stale interrupt line.

   With the lazy disabling we mask only if an interrupt fires while it's
   disabled in software. We note that it is pending and resend it when the
   interrupt gets reenabled.

2) Accessing irq chip hardware can be slow and we have situations where
   interrupts are disabled/enabled fast. So it's an optimization to avoid
   the hardware access, which is sensible as we do not expect an interrupt
   to fire in most cases. If it fires then we mask it when the interrupt
   handler sees the disabled flag.

That should really work on any hardware and the IRQ_DISABLE_UNLAZY flag is
just there to deal with devices which are known to keep the (level based)
irq line active. In that case we know that we always take an interrupt to
mask it right away, so we can avoid the overhead.

Though you should not set that flag on edge type interrupts, unless your
hardware guarantees to avoid the issues described in #1.

Hope that helps.

Thanks,

	tglx
