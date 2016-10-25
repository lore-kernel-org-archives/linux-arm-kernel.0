From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 25 Oct 2016 12:39:02 +0200 (CEST)
Subject: [PATCH 4/9] pinctrl: meson: allow gpio to request irq
In-Reply-To: <CACRpkdYUVXny57AC9rKX3VRAyooEk_2XLvqe9jOuT3rOaE75rg@mail.gmail.com>
References: <1476871709-8359-1-git-send-email-jbrunet@baylibre.com>
 <1476871709-8359-5-git-send-email-jbrunet@baylibre.com>
 <CACRpkdaCZPS45t3eTcjJExOu=YT_YkjNkdpg09jQqvLQOJH=Qw@mail.gmail.com>
 <1477040798.15560.96.camel@baylibre.com>
 <CACRpkdYUVXny57AC9rKX3VRAyooEk_2XLvqe9jOuT3rOaE75rg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1610251137420.4990@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Oct 2016, Linus Walleij wrote:
> On Fri, Oct 21, 2016 at 11:06 AM, Jerome Brunet <jbrunet@baylibre.com> wrote:
> 
> >> Isn't this usecase (also as described in the cover letter) a textbook
> >> example of when you should be using hierarchical irqdomain?
> >>
> >> Please check with Marc et al on hierarchical irqdomains.
> >
> > Linus,
> > Do you mean I should create a new hierarchical irqdomains in each of
> > the two pinctrl instances we have in these SoC, these domains being
> > stacked on the one I just added for controller in irqchip ?
> >
> > I did not understand this is what you meant when I asked you the
> > question at ELCE.
> 
> Honestly, I do not understand when and where to properly use
> hierarchical irqdomain, even after Marc's talk at ELC-E.

Hierarchical irqdomains are used when you have several levels of interrupt
hardware to deliver an interrupt.

For example on x86 we have:

 device --- [IOAPIC] -- [VECTOR]

and we can have this expanded to

 device --- [IOAPIC] -- [IRQ Remapping] -- [VECTOR]

and we have more things hanging off the VECTOR domain

 device --- [IOAPIC] ---
                       |--- [VECTOR]
 device --- [PCIMSI] ---

So with irq remapping this might look like this:

 device --- [IOAPIC] ---
                       |-----------------------
 device --- [PCIMSI] ---                      |
                                              |---[VECTOR]
 device --- [IOAPIC] ---                      |
                       |--[IRQ Remapping]------
 device --- [PCIMSI] ---                      

The important part is that this hierarchy deals with a single Linux virq
and all parts of the hierarchy are required for setup and possibly for
mask/ack/eoi.

This is different from a demultiplex interrupt

 device --- [DEMUX] --- [GIC]

where the demultiplex interrupt is a different virq than the device
virq. The demux interrupt chip can have a parent relation ship, which can
be required to propagate information, e.g. wake on a device behind the
demux must keep the gic as a wake irq as well. But it's not hierarchical in
the sense of our hierarchical irq domains.

Hope that helps.

Thanks,

	tglx
