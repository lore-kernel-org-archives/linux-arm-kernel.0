From: jbrunet@baylibre.com (Jerome Brunet)
Date: Fri, 21 Oct 2016 11:06:38 +0200
Subject: [PATCH 4/9] pinctrl: meson: allow gpio to request irq
In-Reply-To: <CACRpkdaCZPS45t3eTcjJExOu=YT_YkjNkdpg09jQqvLQOJH=Qw@mail.gmail.com>
References: <1476871709-8359-1-git-send-email-jbrunet@baylibre.com>
 <1476871709-8359-5-git-send-email-jbrunet@baylibre.com>
 <CACRpkdaCZPS45t3eTcjJExOu=YT_YkjNkdpg09jQqvLQOJH=Qw@mail.gmail.com>
Message-ID: <1477040798.15560.96.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-10-20 at 21:21 +0200, Linus Walleij wrote:
> On Wed, Oct 19, 2016 at 12:08 PM, Jerome Brunet <jbrunet@baylibre.com
> > wrote:
> 
> > 
> > Add the ability for gpio to request irq from the gpio interrupt
> > controller
> > if present. We have to specificaly that the parent interrupt
> > controller is
> > the gpio interrupt controller because gpio on meson SoCs can't
> > generate
> > interrupt directly on the GIC.
> > 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> (...)
> > 
> > +???????select IRQ_DOMAIN
> > ????????select OF_GPIO
> > +???????select OF_IRQ
> (...)
> > 
> > +static int meson_gpio_to_hwirq(struct meson_bank *bank, unsigned
> > int offset)
> > +{
> > +???????unsigned int hwirq;
> > +
> > +???????if (bank->irq_first < 0)
> > +???????????????/* this bank cannot generate irqs */
> > +???????????????return -1;
> > +
> > +???????hwirq = offset - bank->first + bank->irq_first;
> > +
> > +???????if (hwirq > bank->irq_last)
> > +???????????????/* this pin cannot generate irqs */
> > +???????????????return -1;
> > +
> > +???????return hwirq;
> > +}
> 
> This is reimplementing irqdomain.
> 
> > 
> > +static int meson_gpio_to_irq(struct gpio_chip *chip, unsigned int
> > offset)
> > +{
> (...)
> > 
> > +???????hwirq = meson_gpio_to_hwirq(bank, offset);
> > +???????if (hwirq < 0) {
> > +???????????????dev_dbg(pc->dev, "no interrupt for pin %u\n",
> > offset);
> > +???????????????return 0;
> > +???????}
> 
> Isn't this usecase (also as described in the cover letter) a textbook
> example of when you should be using hierarchical irqdomain?
> 
> Please check with Marc et al on hierarchical irqdomains.

Linus,
Do you mean I should create a new hierarchical?irqdomains in each of
the two pinctrl instances we have in these SoC, these domains being
stacked on the one I just added for controller in irqchip ?

I did not understand this is what you meant when I asked you the
question at ELCE.

> 
> Yours,
> Linus Walleij
