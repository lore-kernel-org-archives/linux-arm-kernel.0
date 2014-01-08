From: ynvich@gmail.com (Sergei Ianovich)
Date: Wed, 08 Jan 2014 23:01:01 +0400
Subject: [PATCH v3 11/21] ARM: pxa: support ICP DAS LP-8x4x FPGA irq
In-Reply-To: <CACRpkdaY7xpoeeUqBBqUS2swe6Y5gKt67VYNvNRrsbFhyU=ATw@mail.gmail.com>
References: <1386901645-28895-1-git-send-email-ynvich@gmail.com>
 <1387309071-22382-1-git-send-email-ynvich@gmail.com>
 <1387309071-22382-12-git-send-email-ynvich@gmail.com>
 <CACRpkdaY7xpoeeUqBBqUS2swe6Y5gKt67VYNvNRrsbFhyU=ATw@mail.gmail.com>
Message-ID: <1389207661.10754.42.camel@host5.omatika.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-01-02 at 13:32 +0100, Linus Walleij wrote:
> On Tue, Dec 17, 2013 at 8:37 PM, Sergei Ianovich <ynvich@gmail.com> wrote:
> Usually combined GPIO+IRQ controllers are put into drivers/gpio but
> this is a bit special as it seems to handle also non-GPIO-related IRQs
> so let's get some input on this.

This one is a plain IRQ controller. It has simple input lines, not GPIO
pins. The chip reports its status to upper level interrupt controller.
The upper level controller is PXA GPIO in this case.

(...)

> > +static struct irq_chip lp8x4x_irq_chip = {
> > +       .name                   = "FPGA",
> > +       .irq_ack                = lp8x4x_mask_irq,
> > +       .irq_mask               = lp8x4x_mask_irq,
> > +       .irq_mask_ack           = lp8x4x_mask_irq,
> > +       .irq_unmask             = lp8x4x_unmask_irq,
> > +};
> 
> After you have added your state container you will have
> a handle to your struct gpio_chip in the cookie passed to
> as irqdata.
> 
> Then you need to mark the GPIO lines used for IRQs by
> doing something similar to this patch in your startup()
> and shutdown() callbacks:
> http://marc.info/?l=linux-gpio&m=138547223832167&w=2

The chip requires no GPIO initialization. 

(...)

> > +       iowrite8(0, base + EOI);
> 
> This looks dangerous, what are you doing here?

This is done in kernel source which comes with the device. The
controller won't work without this line.

I cannot know for sure, as I don't have board datasheets or drawings. I
suspect, this clears GPIO line which reports interrupts to the upper
level controller.

(...)

> > +static int __init lp8x4x_irq_init(void)
> > +{
> > +       return platform_driver_register(&lp8x4x_irq_driver);
> > +}
> > +postcore_initcall(lp8x4x_irq_init);
> 
> Do you *have* to do it this early? I guess if it's used for
> the UARTs then yes, but make a case for it...

PXA isn't DT-only at the moment. As a result, it is impossible
to use IRQCHIP_DECLARE(). So drivers for the on-CPU IRQs and GPIO-IRQs
are loaded using postcore_initcall(). We need to have all irq domain
drivers loaded prior to DT parsing in order to allow normal
initialization of IRQ resources with DT. I'll update the commit message.

The rest of review comment are implemented. The changes don't affect any
other patches in the series. Should I repost the whole series?

Or only this patch?

Thanks.
