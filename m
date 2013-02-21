From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Feb 2013 19:50:19 +0100
Subject: [PATCH v3 02/12] gpio: pxa: avoid to use global irq base
In-Reply-To: <1361164358-5845-3-git-send-email-haojian.zhuang@linaro.org>
References: <1361164358-5845-1-git-send-email-haojian.zhuang@linaro.org>
 <1361164358-5845-3-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdYMSK9=w6Ho6vJVkajpB8_SsByQWcp1q86bysC5W9UAcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 18, 2013 at 6:12 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> Avoid to use global irq_base in gpio-pxa driver. Define irq_base in each
> pxa_gpio_chip instead. Then we can avoid to use macro PXA_GPIO_TO_IRQ() &
> MMP_GPIO_TO_IRQ().
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
(...)
> +++ b/drivers/gpio/gpio-pxa.c
(...)
> -static int irq_base;

Nice!

>  #ifdef CONFIG_OF
> -static struct irq_domain *domain;

Nice!

>  static struct device_node *pxa_gpio_of_node;
>  #endif
>
>  struct pxa_gpio_chip {
>         struct gpio_chip chip;
>         void __iomem    *regbase;
> +       unsigned int    irq_base;

I don't get this.

Just put a struct irq_domain *irqdomain here
instead and let that keep track of the irq_base for you.

> -static int pxa_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
> +static int pxa_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
>  {
> -       return chip->base + offset + irq_base;
> +       struct pxa_gpio_chip *chip = NULL;
> +
> +       chip = container_of(gc, struct pxa_gpio_chip, chip);
> +       return chip->irq_base + offset;

No. Use return irq_create_mapping(chip->irqdomain, offset);

> -int pxa_irq_to_gpio(int irq)
> +int pxa_irq_to_gpio(struct irq_data *d)
>  {
> -       return irq - irq_base;
> +       struct pxa_gpio_chip *chip;
> +       int gpio;
> +
> +       chip = (struct pxa_gpio_chip *)d->domain->host_data;
> +       gpio = d->irq - chip->irq_base + chip->chip.base;

Just d->hwirq + chip->chip.base;

> +static int pxa_init_gpio_chip(struct platform_device *pdev, int gpio_end,
> +                             int (*set_wake)(unsigned int, unsigned int))
> +{
> +       int i, gpio, nbanks = gpio_to_bank(gpio_end) + 1;
> +       struct pxa_gpio_chip *chips;
> +
> +       chips = devm_kzalloc(&pdev->dev, nbanks * sizeof(*chips), GFP_KERNEL);
> +       if (chips == NULL) {
> +               pr_err("%s: failed to allocate GPIO chips\n", __func__);
> +               return -ENOMEM;
> +       }
> +
> +       for (i = 0, gpio = 0; i < nbanks; i++, gpio += 32) {
> +               struct gpio_chip *c = &chips[i].chip;
> +
> +               sprintf(chips[i].label, "gpio-%d", i);
> +               chips[i].regbase = gpio_reg_base + BANK_OFF(i);
> +               chips[i].set_wake = set_wake;
> +
> +               c->base  = gpio;
> +               c->label = chips[i].label;
> +
> +               c->direction_input  = pxa_gpio_direction_input;
> +               c->direction_output = pxa_gpio_direction_output;
> +               c->get = pxa_gpio_get;
> +               c->set = pxa_gpio_set;
> +               c->to_irq = pxa_gpio_to_irq;
> +#ifdef CONFIG_OF_GPIO
> +               c->of_node = pxa_gpio_of_node;
> +               c->of_xlate = pxa_gpio_of_xlate;
> +               c->of_gpio_n_cells = 2;
> +#endif
> +
> +               /* number of GPIOs on last bank may be less than 32 */
> +               c->ngpio = (gpio + 31 > gpio_end) ? (gpio_end - gpio + 1) : 32;
> +
> +               chips[i].irq_base = irq_alloc_descs(-1, 0, c->ngpio, 0);
> +               if (chips[i].irq_base < 0)
> +                       return -EINVAL;
> +               if (!irq_domain_add_legacy(pdev->dev.of_node, c->ngpio,
> +                                          chips[i].irq_base, 0,
> +                                          &pxa_irq_domain_ops, &chips[i]))

Don't throw irqdomains away! They are for using.
That is why I ask you to store it in the pxa state struct.

Since you obviously do not care which IRQ descriptors you get
from this, just use irq_domain_add_linear(). The descriptors will
then be allocated dynamically when you call irq_create_mapping().

This is not the first time I see irqdomains being created and then
just thrown away, please don't do this.

Yours,
Linus Walleij
