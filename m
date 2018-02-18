From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sun, 18 Feb 2018 16:45:09 +0200
Subject: [PATCH 08/10] gpio: Add gpio driver for Actions OWL S900 SoC
In-Reply-To: <20180217204433.3095-9-manivannan.sadhasivam@linaro.org>
References: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org>
 <20180217204433.3095-9-manivannan.sadhasivam@linaro.org>
Message-ID: <CAHp75Vcmtq_mpkqx4+Yr24nRQEHJZmcypbOJLukZpdXVYzizNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 17, 2018 at 10:44 PM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> Add gpio driver for Actions Semi OWL family S900 SoC. Set of registers
> controlling the gpio shares the same register range with pinctrl block.
>
> GPIO registers are organized as 6 banks and each bank controls the
> maximum of 32 gpios.

> +#include <linux/init.h>

> +#include <linux/module.h>

Choose one of them.

> +       val = readl(gpio_base + GPIO_OUTEN);
> +       val |= BIT(offset);
> +       writel(val, gpio_base + GPIO_OUTEN);

out_en()

> +       val = readl(gpio_base + GPIO_OUTEN);
> +       val &= ~BIT(offset);
> +       writel(val, gpio_base + GPIO_OUTEN);

out_dis()

> +       val = readl(gpio_base + GPIO_INEN);
> +       val &= ~BIT(offset);
> +       writel(val, gpio_base + GPIO_INEN);

in_dis()

> +       val = readl(gpio_base + GPIO_OUTEN);
> +       val &= ~BIT(offset);
> +       writel(val, gpio_base + GPIO_OUTEN);

out_dis()

> +       val = readl(gpio_base + GPIO_INEN);
> +       val |= BIT(offset);
> +       writel(val, gpio_base + GPIO_INEN);

in_en()


> +       val = readl(gpio_base + GPIO_INEN);
> +       val &= ~BIT(pin);
> +       writel(val, gpio_base + GPIO_INEN);

in_dis()

> +       val = readl(gpio_base + GPIO_OUTEN);
> +       val |= BIT(pin);
> +       writel(val, gpio_base + GPIO_OUTEN);

out_en()

Find above code duplication.

> +static int owl_gpio_probe(struct platform_device *pdev)
> +{

> +       gpio->base = of_iomap(pdev->dev.of_node, 0);
> +       if (IS_ERR(gpio->base))
> +               return PTR_ERR(gpio->base);


> +       gpio->gpio.of_node = pdev->dev.of_node;

Isn't this done by GPIO library?

> +static int owl_gpio_remove(struct platform_device *pdev)
> +{
> +       return 0;
> +}

Useless stub.

-- 
With Best Regards,
Andy Shevchenko
