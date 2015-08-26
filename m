From: balbi@ti.com (Felipe Balbi)
Date: Wed, 26 Aug 2015 15:24:29 -0500
Subject: CONFIG_DEBUG_SHIRQ and PM
In-Reply-To: <CAAEAJfB3iiRENEKm6xx-kLae5AR6BV0XVo0KNkb8-okvLjhFhg@mail.gmail.com>
References: <20150825195830.GH27534@saruman.tx.rr.com>
 <CAAEAJfCY1BRuoQCWfD2pCq36E54vDB5Coy2S7rz3RfL2BVLGaw@mail.gmail.com>
 <20150826193820.GT14625@saruman.tx.rr.com>
 <CAAEAJfAPVgxhRnfYJYzebFJDRJ4Ooam6n+0B5HJ-+uLJ0exTLA@mail.gmail.com>
 <20150826200300.GU14625@saruman.tx.rr.com>
 <CAAEAJfB3iiRENEKm6xx-kLae5AR6BV0XVo0KNkb8-okvLjhFhg@mail.gmail.com>
Message-ID: <20150826202429.GV14625@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 26, 2015 at 05:15:51PM -0300, Ezequiel Garcia wrote:

<snip>

> >> be prepared to handle it any time, coming from any sources (not only
> >> your device). And CONFIG_DEBUG_SHIRQ does exactly that, in order to
> >> make sure all the drivers passing IRQF_SHARED comply with that rule.
> >
> > you need to be sure of that with non-shared IRQs anyway.
> 
> Not entirely. If your IRQ is not shared, then you usually have a register
> to enable or unmask your peripheral interrupts. So the driver is in control
> of when it will get interrupts.
> 
> If the IRQ is shared, this won't do. This is what I mean by "shared IRQs
> must be prepared to receive an interrupt any time", in the sense that
> the driver has no way of preventing IRQs (because they may be
> coming from any source).

right, the problem is much less likely on non-shared lines but the fine
that a line is shared or not is a function of HW integration, not the
e.g. USB Controller, so that knowledge really doesn't fit the driver in
a sense.

We might as well get rid of IRQF_SHARED and assume all lines are
shareable.

> In the same sense, shared IRQs handlers need to double-check
> the IRQ is coming to the current device by checking some IRQ
> status register to see if there's pending work.

you should the status register even on non-shared IRQs to catch spurious
right ?

> > Also, an IRQ
> > which isn't shared in SoC A, might become shared in SoC B which uses the
> > same IP.
> >
> >> So you either avoid using devm_request_irq, or you prepare your handler
> >> accordingly to be ready to handle an interrupt _any time_.
> >
> > the handler is ready to handle at any time, what isn't correct is the
> > fact that clocks get gated before IRQ is freed.
> >
> > There should be no such special case as "if your handler is shared,
> > don't use devm_request_*irq()" because if we just disable PM_RUNTIME, it
> > works as expected anyway.
> >
> 
> Yeah, I meant to say: if you use devm_request_irq with IRQF_SHARED
> then you _must_ be prepared to get an IRQ *after* your remove() has
> been called.
> 
> Let's consider this snippet from tw68:
> 
> static irqreturn_t tw68_irq(int irq, void *dev_id)
> {
>         struct tw68_dev *dev = dev_id;
>         u32 status, orig;
>         int loop;
> 
>         status = orig = tw_readl(TW68_INTSTAT) & dev->pci_irqmask;

Now try to read that register when your clock is gated. That's the
problem I'm talking about. Everything about the handler is functioning
correctly; however clocks are gated in ->remove() and free_irq() is
only called *AFTER* ->remove() has returned.

>         [etc]
> }
> 
> The IRQ handler accesses the device struct and then
> reads through PCI. So if you use devm_request_irq
> you need to make sure the device struct is still allocated
> after remove(), and the PCI read won't stall or crash.

dude, that's not the problem I'm talking about. I still have my
private_data around, what I don't have is:

              _            _    
  __ _    ___| | ___   ___| | __
 / _` |  / __| |/ _ \ / __| |/ /
| (_| | | (__| | (_) | (__|   < 
 \__,_|  \___|_|\___/ \___|_|\_\
                                

> Interestingly, tw68 uses devm_request_irq with IRQF_SHARED :-)
> 
> Still, I don't think that's a good idea, since it relies on
> the IRQ being freed *before* the device struct.

that's not an issue at all. If you're using devm_request_irq() you're
likely using devm_kzalloc() for the device struct anyway. Also, you
called devm_kzalloc() before devm_request_irq() so IRQ *will* be freed
before your private data; there's nothing wrong there.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150826/7edc4eeb/attachment.sig>
