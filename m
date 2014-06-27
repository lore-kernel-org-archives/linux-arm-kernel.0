From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 27 Jun 2014 11:18:42 +0200
Subject: [PATCH v4 1/6] mfd: fsl imx25 Touchscreen ADC driver
In-Reply-To: <1403621185-9581-1-git-send-email-denis@eukrea.com>
References: <1403621185-9581-1-git-send-email-denis@eukrea.com>
Message-ID: <CACRpkdbFcgK69yakt+XYOg2q_QT8R263+FrADzz=r+fYNEFPSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 4:46 PM, Denis Carikli <denis@eukrea.com> wrote:

> From: Markus Pargmann <mpa@pengutronix.de>
>
> This is the core driver for imx25 touchscreen/adc driver. The module
> has one shared ADC and two different conversion queues which use the
> ADC. The two queues are identical. Both can be used for general purpose
> ADC but one is meant to be used for touchscreens.
>
> This driver is the core which manages the central components and
> registers of the TSC/ADC unit. It manages the IRQs and forwards them to
> the correct components.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> Acked-by: Jonathan Cameron <jic23@kernel.org>

I think the subject and commit message is misleading. What this
patch does is create a MFD hub to handle spawning devices
and handle chained IRQs for the ADC unit right? It's not a "core driver"
because it's not really driving anything, just proxying things.

> +static int mx25_tsadc_domain_map(struct irq_domain *d, unsigned int irq,
> +                            irq_hw_number_t hwirq)
> +{
> +       struct mx25_tsadc *tsadc = d->host_data;
> +
> +       irq_set_chip_data(irq, tsadc);

You also need to set a unique lockdep class or lockdep will
complain.

static struct lock_class_key my_lock_class;

irq_set_lockdep_class(irq, &my_lock_class);

> +       irq_set_chip_and_handler(irq, &dummy_irq_chip,
> +                                handle_level_irq);
> +       set_irq_flags(irq, IRQF_VALID);

This function only exists on ARM. Unless Kconfig ensures
this is only available on ARM platforms, use

#ifdef CONFIG_ARM
      set_irq_flags(irq, IRQF_VALID);
#else
      irq_set_noprobe(irq);
#endif

(Sorry we have no better way of doing it.)

> +static int mx25_tsadc_probe(struct platform_device *pdev)
> +{
(...)
> +       of_platform_populate(np, NULL, NULL, dev);

This was news2me. Why aren't MFD cells used now that
you're using MFD as a spawning hub?

MFD also has a way of translating IRQs passed as resources
to children, so they arrive at their children readily translated.
Not using MFD cells means you don't use this nice mechanism
right?

Or is there some new nice design style that I'm not
familiar with, like the OF core handling that translation?
(Seems like that, hence asking...)

Yours,
Linus Walleij
