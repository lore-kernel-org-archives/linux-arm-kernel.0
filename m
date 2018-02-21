From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 21 Feb 2018 21:13:53 +0200
Subject: [PATCH v2 08/10] gpio: Add gpio driver for Actions OWL S900 SoC
In-Reply-To: <20180221160044.15089-9-manivannan.sadhasivam@linaro.org>
References: <20180221160044.15089-1-manivannan.sadhasivam@linaro.org>
 <20180221160044.15089-9-manivannan.sadhasivam@linaro.org>
Message-ID: <CAHp75VfLkmZp7HwX-du4EYdtJ8h=y59OrSbu53Ltf-_kFfpczg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 21, 2018 at 6:00 PM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> Add gpio driver for Actions Semi OWL family S900 SoC. Set of registers
> controlling the gpio shares the same register range with pinctrl block.
>
> GPIO registers are organized as 6 banks and each bank controls the
> maximum of 32 gpios.

> +static void owl_gpio_set_reg(void __iomem *base, unsigned int pin, int flag)
> +{
> +       u32 val;
> +
> +       if (flag) {
> +               val = readl(base);
> +               val |= BIT(pin);
> +               writel(val, base);
> +       } else {
> +               val = readl(base);
> +               val &= ~BIT(pin);
> +               writel(val, base);
> +       }
> +}

Why not to use the same pattern as below?

readl()
if ()
 ...
else
...
writel()

?

> +static void owl_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
> +{
> +       struct owl_gpio *gpio = gpiochip_get_data(chip);
> +       const struct owl_gpio_port *port = gpio->port;
> +       void __iomem *gpio_base = gpio->base + port->offset;
> +       u32 val;
> +
> +       val = readl(gpio_base + GPIO_DAT);
> +
> +       if (value)
> +               val |= BIT(offset);
> +       else
> +               val &= ~BIT(offset);
> +
> +       writel(val, gpio_base + GPIO_DAT);
> +}


-- 
With Best Regards,
Andy Shevchenko
