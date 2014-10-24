From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Oct 2014 15:46:59 +0200
Subject: [PATCH v1 1/3] gpio: Add APM X-Gene standby GPIO controller driver
In-Reply-To: <CACRpkdY3-Y0eA_o2enfxbqWUpwPoo_5oM9t=uU=QSTAw4MPf9Q@mail.gmail.com>
References: <1412779948-28769-1-git-send-email-yvo@apm.com>
 <1412779948-28769-2-git-send-email-yvo@apm.com>
 <CACRpkdY3-Y0eA_o2enfxbqWUpwPoo_5oM9t=uU=QSTAw4MPf9Q@mail.gmail.com>
Message-ID: <2988580.WvjMBY1UOc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 24 October 2014 14:14:43 Linus Walleij wrote:
> On Wed, Oct 8, 2014 at 4:52 PM, Y Vo <yvo@apm.com> wrote:
> 
> > Add APM X-Gene standby GPIO controller driver.
> >
> > Signed-off-by: Y Vo <yvo@apm.com>
> 
> That's a very terse commit message. Please tell us a bit about the
> hardware and what platforms it is used on, etc.
> 
> For example that is uses ACPI, as seems to be the case.

I think that was just the header file inclusion, but no actual ACPI
support. Al Stone is experimenting with ACPI support for X-Gene, and
some earlier patches from APM had rudimentary support as well, but
we are not adding ACPI support to X-Gene drivers upstream until we
know whether we can support the entire platform in that mode or not.

> So this platform uses some interesting combination of ACPI and device tree
> at the same time? Or alternatively?

Just DT at the moment.

> > +       apm_gc->irq = devm_kzalloc(&pdev->dev, sizeof(u32) * XGENE_MAX_GPIO_DS,
> > +                                  GFP_KERNEL);
> > +       if (!apm_gc->irq)
> > +               return -ENOMEM;
> > +       memset(apm_gc->irq, 0, sizeof(u32) * XGENE_MAX_GPIO_DS);
> (...)
> > +       for (i = 0; i < apm_gc->nirq; i++) {
> > +               apm_gc->irq[default_pins[i]] = platform_get_irq(pdev, i);
> 
> So the IRQs for all the GPIO pins are handled somewhere else instead
> of being a cascaded IRQ controller.
> 
> This means that the IRQ lines from each individual GPIO pin is
> connected to a unique IRQ line on a secondary interrupt controller,
> instead of the GPIO block being a cascaded interrupt controller
> in its own right.
> 
> Is this correct?

See the discussion I had on this. Yes, each line is connected to a
GIC SPI interrupt by itself. I've discussed this with Marc Zyngier
and Thomas Gleixner at the conference last week, and we concluded
that we will need a new generic interface to get data out of the
parent interrupt controller in a proper way. The current implementation
just maps the GIC registers and reads them directly, which of course
is not a proper way to do it.

	Arnd
