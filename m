From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sat, 31 Mar 2018 00:04:11 +0300
Subject: [PATCH v6 7/9] gpio: Add gpio driver for Actions OWL S900 SoC
In-Reply-To: <20180328174703.19778-8-manivannan.sadhasivam@linaro.org>
References: <20180328174703.19778-1-manivannan.sadhasivam@linaro.org>
 <20180328174703.19778-8-manivannan.sadhasivam@linaro.org>
Message-ID: <CAHp75VeGv04CA3f1pRDi35DsbRgrdj86TBUBZ3J+27T822cOqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2018 at 8:47 PM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> Add gpio driver for Actions Semi OWL family S900 SoC. Set of registers
> controlling the gpio shares the same register range with pinctrl block.
>
> GPIO registers are organized as 6 banks and each bank controls the
> maximum of 32 gpios.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> +static void owl_gpio_update_reg(void __iomem *base, unsigned int pin, int flag)
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

Hmm... Just realized that this driver misses locking.

Something like
owl_gpio_update_reg_locked()
{
 spin_lock();
 owl_gpio_update_reg();
 spin_unlock();
}

> +
> +static int owl_gpio_request(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct owl_gpio *gpio = gpiochip_get_data(chip);
> +
> +       /*
> +        * GPIOs have higher priority over other modules, so either setting
> +        * them as OUT or IN is sufficient
> +        */
> +       owl_gpio_update_reg(gpio->base + GPIO_OUTEN, offset, true);

...to use in such cases.

> +
> +       return 0;
> +}
> +
> +static void owl_gpio_free(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct owl_gpio *gpio = gpiochip_get_data(chip);
> +
> +       /* disable gpio output */
> +       owl_gpio_update_reg(gpio->base + GPIO_OUTEN, offset, false);
> +
> +       /* disable gpio input */
> +       owl_gpio_update_reg(gpio->base + GPIO_INEN, offset, false);

...or

spin_lock();
owl_gpio_update_reg();
owl_gpio_update_reg();
spin_unlock();

...in this and similar cases.

> +}


-- 
With Best Regards,
Andy Shevchenko
