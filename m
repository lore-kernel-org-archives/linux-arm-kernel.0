From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Sun, 3 Jun 2018 22:27:23 +0530
Subject: [PATCH 3/3] pinctrl: actions: Add interrupt support for OWL S900
 SoC
In-Reply-To: <CAHp75Ve8ZCbEqnYK0KqtCHQm-EOUWRSyMzi51P+3_7brtXq6dA@mail.gmail.com>
References: <20180602165415.30956-1-manivannan.sadhasivam@linaro.org>
 <20180602165415.30956-4-manivannan.sadhasivam@linaro.org>
 <CAHp75Ve8ZCbEqnYK0KqtCHQm-EOUWRSyMzi51P+3_7brtXq6dA@mail.gmail.com>
Message-ID: <20180603165723.GA14907@Mani-XPS-13-9360>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On Sun, Jun 03, 2018 at 11:37:53AM +0300, Andy Shevchenko wrote:
> On Sat, Jun 2, 2018 at 7:54 PM, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> > Add interrupt support for Actions Semi OWL S900 SoC.
> 
> > +       port = owl_gpio_get_port(pctrl, &gpio);
> > +       if (WARN_ON(port == NULL))
> > +               return;
> 
> At which circumstances the above possible?
> 

Only possible when the requested GPIO exceeds chip->ngpio. I know it is
a kind of redundant check, but it is good to have this during development.

> > +       port = owl_gpio_get_port(pctrl, &gpio);
> > +       if (WARN_ON(port == NULL))
> > +               return;
> 
> Ditto.
>

Same as above.

> > +       port = owl_gpio_get_port(pctrl, &gpio);
> > +       if (WARN_ON(port == NULL))
> > +               return;
> 
> Ditto.
>

Same as above.

> > +       port = owl_gpio_get_port(pctrl, &gpio);
> > +       if (WARN_ON(port == NULL))
> > +               return -ENODEV;
> 
> Ditto.
>

Same as above.

> 
> > +       for (i = 0; i < chip->ngpio; i++) {
> > +               irqno = irq_create_mapping(pctrl->domain, i);
> > +               irq_set_chip_and_handler(irqno, &owl_gpio_irq_chip,
> > +                                        handle_edge_irq);
> > +               irq_set_chip_data(irqno, pctrl);
> > +       }
> 
> I'm not sure the handle_edge_irq() is a correct handler here. It would
> be handle_bad_irq() until IRQ has been requested properly.
> No?
>

Hmmm, good question. Since the handler used in irq_set_chip_and_handler
is superseded by irq_set_chained_handler_and_data, this doesn't matter
anyway. But I would like to hear what Linus suggests here!

> > +/* GPIO TYPE Bit Definition */
> > +#define OWL_GPIO_INT_LEVEL_HIGH                0
> > +#define OWL_GPIO_INT_LEVEL_LOW         1
> > +#define OWL_GPIO_INT_EDGE_RISING       2
> > +#define OWL_GPIO_INT_EDGE_FALLING      3
> 
> > +#define OWL_GPIO_INT_MASK              3
> 
> GENMASK?
>

Ack.

Thanks,
Mani

> -- 
> With Best Regards,
> Andy Shevchenko
