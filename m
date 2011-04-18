From: will.deacon@arm.com (Will Deacon)
Date: Mon, 18 Apr 2011 20:04:48 +0100
Subject: [PATCH 5/6] ARM: nmk: update GPIO chained IRQ handler to
	entry/exit functions
In-Reply-To: <BANLkTikNANiZm+K3-9SdDb9MOWGxgpEGNg@mail.gmail.com>
References: <1302633340-4795-1-git-send-email-will.deacon@arm.com>
	<1302633340-4795-6-git-send-email-will.deacon@arm.com>
	<BANLkTikNANiZm+K3-9SdDb9MOWGxgpEGNg@mail.gmail.com>
Message-ID: <1303153488.23764.9.camel@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Mon, 2011-04-18 at 19:26 +0100, Linus Walleij wrote:
> 2011/4/12 Will Deacon <will.deacon@arm.com>:
> 
> > This patch updates the Nomadik gpio chained IRQ handler to use the
> > chained IRQ enter/exit functions in order to function correctly on
> > primary controllers with different methods of flow control.
> >
> > Cc: Rabin Vincent <rabin@rab.in>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for the Ack.

> BUT I want it to go through Grants gpio tree. The reason is that
> I plan to consolidate this driver into drivers/gpio/* and I don't want
> collisions in merges.

Ok. Will Grant just pick it up when he's happy with it?

> And wait:
> 
> > +#include <asm/mach/irq.h>
> 
> > -       if (host_chip->irq_mask_ack)
> > -               host_chip->irq_mask_ack(&desc->irq_data);
> > -       else {
> > -               host_chip->irq_mask(&desc->irq_data);
> > -               if (host_chip->irq_ack)
> > -                       host_chip->irq_ack(&desc->irq_data);
> > -       }
> > +       chained_irq_enter(host_chip, desc);
> 
> (...)
> 
> > -       host_chip->irq_unmask(&desc->irq_data);
> > +       chained_irq_exit(host_chip, desc);
> 
> This looks an awful lot like this from drivers/gpio/pl061.c:
> 
> desc->irq_data.chip->irq_ack(&desc->irq_data);
> (...)
> desc->irq_data.chip->irq_unmask(&desc->irq_data);

The chained_{enter,exit} functions are there so that chained handlers
written for multiple parent IRQ chips can cope when the chips differ in
their method of flow control. I'd argue that we shouldn't be promoting
chained handlers like this (there should probably be a separate handler
for each primary chip implementation with which it's designed to work).

The *only* reason I abstracting this pattern is so that platforms can
survive the GIC migration from ACK => FastEOI without being broken in
mainline while the GIC code is in a state of flux.

> It gets me wondering what the proper way is to do this.
> Isn't the proper place for chained_irq_[enter|exit]* in
> include/linux/irq.h rather? It does not really look machine
> or arch specific, is it, really?

There are only a handful of machines under arch/arm/ that suffer from
this problem and need to be able to handle two flow types
simultaneously. If there's a demand for making this stuff more visible,
then fine, but I don't think there is.

Cheers,

Will
