From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Apr 2012 18:09:23 +0200
Subject: [PATCH 02/16] drivers/gpio: gpio-nomadik: Add support for
 irqdomains
In-Reply-To: <1334659448-11521-3-git-send-email-lee.jones@linaro.org>
References: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
 <1334659448-11521-3-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaUDBwHb24eALidivgZGJS=xBpXNoYJUcAWrzCwYqi2ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2012 at 12:43 PM, Lee Jones <lee.jones@linaro.org> wrote:

> diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
> index d11f389..af12139 100644
> --- a/arch/arm/mach-ux500/cpu.c
> +++ b/arch/arm/mach-ux500/cpu.c
> @@ -30,6 +30,7 @@
>
> ?void __iomem *_PRCMU_BASE;
>
> +/* FIXME: should we set up the GPIO domain here? */

Why on earth would we want to do that?

Get rid of the comment simply...

> diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
> index 2c2b53c..1322ca8 100644
> --- a/drivers/gpio/gpio-nomadik.c
> +++ b/drivers/gpio/gpio-nomadik.c
> @@ -22,6 +22,7 @@
> ?#include <linux/spinlock.h>
> ?#include <linux/interrupt.h>
> ?#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> ?#include <linux/slab.h>
>
> ?#include <asm/mach/irq.h>
> @@ -677,7 +678,6 @@ static int nmk_gpio_irq_set_type(struct irq_data *d, unsigned int type)
> ? ? ? ?bitmask = nmk_gpio_get_bitmask(gpio);
> ? ? ? ?if (!nmk_chip)
> ? ? ? ? ? ? ? ?return -EINVAL;
> -
> ? ? ? ?if (type & IRQ_TYPE_LEVEL_HIGH)
> ? ? ? ? ? ? ? ?return -EINVAL;
> ? ? ? ?if (type & IRQ_TYPE_LEVEL_LOW)
> @@ -782,6 +782,33 @@ static void nmk_gpio_secondary_irq_handler(unsigned int irq,
> ? ? ? ?__nmk_gpio_irq_handler(irq, desc, status);
> ?}
>
> +#ifdef CONFIG_IRQ_DOMAIN

No, modify Kconfig to select IRQ_DOMAIN for the driver instead.
We want this also for the non-DT case.

> +int nmk_gpio_irq_map(struct irq_domain *d, unsigned int irq,
> + ? ? ? ? ? ? ? ? ? ? ? ? irq_hw_number_t hwirq)
> +{
> + ? ? ? return 0;
> +}
> +
> +const struct irq_domain_ops nmk_gpio_irq_simple_ops = {
> + ? ? ? .map = nmk_gpio_irq_map,
> + ? ? ? .xlate = irq_domain_xlate_twocell,
> +};

This is just a copy of irq_domain_simple_ops so get rid of that
and use the simple ops directly.

> +
> +struct irq_domain *nmk_gpio_irq_domain_add(struct device_node *np,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct nmk_gpio_platform_data *pdata)
> +{
> + ? ? ? return irq_domain_add_legacy(np, NMK_GPIO_PER_CHIP,
> + ? ? ? ? ? ? ? ? ? ? ? NOMADIK_GPIO_TO_IRQ(pdata->first_gpio),
> + ? ? ? ? ? ? ? ? ? ? ? 0, &nmk_gpio_irq_simple_ops, NULL);

irq_domain_simple_ops then.

> +}
> +#else
> +struct irq_domain *nmk_gpio_irq_domain_add(struct device_node *np,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct nmk_gpio_platform_data *pdata)
> +{
> + ? ? ? return NULL;
> +}
> +#endif

And since this is not going to be #ifdef:ed, just inline it.

> +
> ?static int nmk_gpio_init_irq(struct nmk_gpio_chip *nmk_chip)
> ?{
> ? ? ? ?unsigned int first_irq;
> @@ -1072,6 +1099,7 @@ static int __devinit nmk_gpio_probe(struct platform_device *dev)
> ?{
> ? ? ? ?struct nmk_gpio_platform_data *pdata = dev->dev.platform_data;
> ? ? ? ?struct device_node *np = dev->dev.of_node;
> + ? ? ? struct irq_domain *domain = NULL;
> ? ? ? ?struct nmk_gpio_chip *nmk_chip;
> ? ? ? ?struct gpio_chip *chip;
> ? ? ? ?struct resource *res;
> @@ -1096,13 +1124,20 @@ static int __devinit nmk_gpio_probe(struct platform_device *dev)
> ? ? ? ? ? ? ? ?if (of_property_read_u32(np, "gpio-bank", &dev->id)) {
> ? ? ? ? ? ? ? ? ? ? ? ?dev_err(&dev->dev, "gpio-bank property not found\n");
> ? ? ? ? ? ? ? ? ? ? ? ?ret = -EINVAL;
> - ? ? ? ? ? ? ? ? ? ? ? goto out_dt;
> + ? ? ? ? ? ? ? ? ? ? ? goto out;
> ? ? ? ? ? ? ? ?}
>
> ? ? ? ? ? ? ? ?pdata->first_gpio = dev->id * NMK_GPIO_PER_CHIP;
> ? ? ? ? ? ? ? ?pdata->num_gpio ? = NMK_GPIO_PER_CHIP;
> ? ? ? ?}
>
> + ? ? ? domain = nmk_gpio_irq_domain_add(np, pdata);
> + ? ? ? if (!domain) {
> + ? ? ? ? ? ? ? pr_err("%s: Failed to create irqdomain - required for DT\n",

Not just for DT, let's do this always.

> + ? ? ? ? ? ? ? ? ? ? ? np->full_name);
> + ? ? ? ? ? ? ? return -ENOSYS;
> + ? ? ? }
> +
> ? ? ? ?res = platform_get_resource(dev, IORESOURCE_MEM, 0);
> ? ? ? ?if (!res) {
> ? ? ? ? ? ? ? ?ret = -ENOENT;
> @@ -1189,7 +1224,6 @@ out_release:
> ?out:
> ? ? ? ?dev_err(&dev->dev, "Failure %i for GPIO %i-%i\n", ret,
> ? ? ? ? ? ? ? ? ?pdata->first_gpio, pdata->first_gpio+31);
> -out_dt:
> ? ? ? ?if (np)
> ? ? ? ? ? ? ? ?kfree(pdata);

This patch is not complete:

__nmk_gpio_irq_handler() and friends need to be rewritten to use the mapper.
i.e. no first_irq = NOMADIK_GPIO_TO_IRQ() etc in the interrupt handler, use the
domain to translate the HW IRQ using irq_find_mapping(domain, irq), that's the
whole point of the domain IIRC.

Yours,
Linus Walleij
