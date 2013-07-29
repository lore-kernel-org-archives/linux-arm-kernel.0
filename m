From: tony@atomide.com (Tony Lindgren)
Date: Mon, 29 Jul 2013 01:50:21 -0700
Subject: [PATCH 2/4] pinctrl: single: Add hardware specific hooks for
 IRQ and GPIO wake-up events
In-Reply-To: <CACRpkdZNGHRJX3_HRCAfKgrRGLMVbqNzFBfu7wP-3YrhOUESkw@mail.gmail.com>
References: <20130607203936.16513.57494.stgit@localhost>
 <20130607205040.16513.36794.stgit@localhost>
 <CAN1soZznJ1YxWhaFZ4rhQx+uk3aCigAcVeuLpOU+3oPzmfXF6w@mail.gmail.com>
 <20130610153637.GK8164@atomide.com>
 <CACRpkdZNGHRJX3_HRCAfKgrRGLMVbqNzFBfu7wP-3YrhOUESkw@mail.gmail.com>
Message-ID: <20130729085020.GV7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [130722 14:50]:
> On Mon, Jun 10, 2013 at 5:36 PM, Tony Lindgren <tony@atomide.com> wrote:
> 
> > At least on omaps, each board typically has at least one device
> > configured as wake-up capable from deeper idle modes. In the
> > deeper idle modes the normal interrupt wake-up path won't work
> > as the logic is powered off and separate wake-up hardware is
> > available either via IO ring or GPIO hardware.
> 
> What I do not understand is why the irq_set_wake() should
> not fall through to that IO ring / GPIO hardware.

That certainly makes sense.

> For example: a composite GPIO+irqchip driver should surely
> set the wake up for a certain line for irq_set_wake()?

Yes we might be able to make it all transparent to consumer
drivers. Although irq_set_wake() is for suspend/resume only
AFAIK, but ideally we would not have to configure anything
from the consumer drivers for runtime PM.

For the GPIO wake-up events, GPIO + irqchip driver is not
enough as we also need the mapping between pinctrl registers
and GPIO numbers. And to stay out of the database business,
that mapping should ideally come from device tree as it's
only needed for the pins used, not for all hundreds of pins
on a SoC.
 
> > The wake-up
> > event can be device specific, or may need to be dynamically
> > remuxed to GPIO input for wake-up events. When the wake-up
> > event happens, it's IRQ need to be called so the device won't
> > lose interrupts.
> 
> I recognize this hardware type. The name I use for these
> things are "latent interrupts".

OK
 
> What I think is that they should maybe be modeled as
> irqchip from end to end, so that we don't orthogonally use
> any pinctrl states to set this up.

OK I'll take a look.

Regards,

Tony
