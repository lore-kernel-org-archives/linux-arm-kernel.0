From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sat, 10 Mar 2018 20:41:00 +0200
Subject: [PATCH v5 7/9] gpio: Add gpio driver for Actions OWL S900 SoC
In-Reply-To: <20180309051345.1011-8-manivannan.sadhasivam@linaro.org>
References: <20180309051345.1011-1-manivannan.sadhasivam@linaro.org>
 <20180309051345.1011-8-manivannan.sadhasivam@linaro.org>
Message-ID: <CAHp75Vdecdw-Qp_cdfCTUcMFQtFosUhgNKehHHJfPTNM9FrrBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 9, 2018 at 7:13 AM, Manivannan Sadhasivam
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
> +       val = readl_relaxed(base);
> +
> +       if (flag)
> +               val |= BIT(pin);
> +       else
> +               val &= ~BIT(pin);
> +
> +       writel_relaxed(val, base);
> +}

The name is confusing. It's not exclusively set, it's an update.

> +static void owl_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
> +{
> +       struct owl_gpio *gpio = gpiochip_get_data(chip);
> +       u32 val;
> +
> +       val = readl_relaxed(gpio->base + GPIO_DAT);
> +
> +       if (value)
> +               val |= BIT(offset);
> +       else
> +               val &= ~BIT(offset);
> +
> +       writel_relaxed(val, gpio->base + GPIO_DAT);

Forgot to replace?

> +}

-- 
With Best Regards,
Andy Shevchenko
