From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Mon, 19 Feb 2018 22:50:10 +0530
Subject: [PATCH 08/10] gpio: Add gpio driver for Actions OWL S900 SoC
In-Reply-To: <CAHp75Vcmtq_mpkqx4+Yr24nRQEHJZmcypbOJLukZpdXVYzizNQ@mail.gmail.com>
References: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org>
 <20180217204433.3095-9-manivannan.sadhasivam@linaro.org>
 <CAHp75Vcmtq_mpkqx4+Yr24nRQEHJZmcypbOJLukZpdXVYzizNQ@mail.gmail.com>
Message-ID: <20180219172010.ph34dvpdhhkmemdg@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,
On Sun, Feb 18, 2018 at 04:45:09PM +0200, Andy Shevchenko wrote:
> On Sat, Feb 17, 2018 at 10:44 PM, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> > Add gpio driver for Actions Semi OWL family S900 SoC. Set of registers
> > controlling the gpio shares the same register range with pinctrl block.
> >
> > GPIO registers are organized as 6 banks and each bank controls the
> > maximum of 32 gpios.
> 
> > +#include <linux/init.h>
> 
> > +#include <linux/module.h>
> 
> Choose one of them.
> 
Will drop <linux/init.h>
> > +       val = readl(gpio_base + GPIO_OUTEN);
> > +       val |= BIT(offset);
> > +       writel(val, gpio_base + GPIO_OUTEN);
> 
> out_en()
> 
> > +       val = readl(gpio_base + GPIO_OUTEN);
> > +       val &= ~BIT(offset);
> > +       writel(val, gpio_base + GPIO_OUTEN);
> 
> out_dis()
> 
> > +       val = readl(gpio_base + GPIO_INEN);
> > +       val &= ~BIT(offset);
> > +       writel(val, gpio_base + GPIO_INEN);
> 
> in_dis()
> 
> > +       val = readl(gpio_base + GPIO_OUTEN);
> > +       val &= ~BIT(offset);
> > +       writel(val, gpio_base + GPIO_OUTEN);
> 
> out_dis()
> 
> > +       val = readl(gpio_base + GPIO_INEN);
> > +       val |= BIT(offset);
> > +       writel(val, gpio_base + GPIO_INEN);
> 
> in_en()
> 
> 
> > +       val = readl(gpio_base + GPIO_INEN);
> > +       val &= ~BIT(pin);
> > +       writel(val, gpio_base + GPIO_INEN);
> 
> in_dis()
> 
> > +       val = readl(gpio_base + GPIO_OUTEN);
> > +       val |= BIT(pin);
> > +       writel(val, gpio_base + GPIO_OUTEN);
> 
> out_en()
> 
> Find above code duplication.
> 
Sure. Will add a common function like owl_gpio_set_reg for setting register
values.
> > +static int owl_gpio_probe(struct platform_device *pdev)
> > +{
> 
> > +       gpio->base = of_iomap(pdev->dev.of_node, 0);
> > +       if (IS_ERR(gpio->base))
> > +               return PTR_ERR(gpio->base);
> 
> 
> > +       gpio->gpio.of_node = pdev->dev.of_node;
> 
> Isn't this done by GPIO library?
> 
Yes. Will drop this.
> > +static int owl_gpio_remove(struct platform_device *pdev)
> > +{
> > +       return 0;
> > +}
> 
> Useless stub.
> 
Okay.

Also, in the next revision of the driver I will be making all the banks
as its own gpio-controller as opposed to the single controller since all
have their own interrupt domain.

For this case, MMIO can't be used because the banks have irregular number
of gpios.

Thanks,
Mani
> -- 
> With Best Regards,
> Andy Shevchenko
