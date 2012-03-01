From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 1 Mar 2012 09:40:36 +0000
Subject: [PATCH 1/8] gpio: pxa: add OF support
In-Reply-To: <1330582228-12424-2-git-send-email-haojian.zhuang@marvell.com>
References: <1330582228-12424-1-git-send-email-haojian.zhuang@marvell.com>
 <1330582228-12424-2-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <201203010940.37123.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 March 2012, Haojian Zhuang wrote:
> +#ifdef CONFIG_OF
> +static int __devinit pxa_gpio_probe_dt(struct platform_device *pdev,
> +                                      int *irq0, int *irq1, int *irq_mux)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       const __be32 *irq;
> +
> +       irq = of_get_property(np, "mrvl,gpio-irq0", NULL);
> +       if (irq)
> +               *irq0 = be32_to_cpup(irq);
> +       irq = of_get_property(np, "mrvl,gpio-irq1", NULL);
> +       if (irq)
> +               *irq1 = be32_to_cpup(irq);
> +       *irq_mux = platform_get_irq(pdev, 0);
> +       return 0;
> +}
> +#else
> +static int __devinit pxa_gpio_probe_dt(struct platform_device *pdev,
> +                                      int *irq0, int *irq1, int *irq_mux)
> +{
> +       return 1;
> +}
> +#endif
> +

It seems that you are not following the regular IRQ binding. This should
probably use irq_of_parse_and_map().

For other code like the one above, I suggest you use
of_property_read_u32_array(), which will already compile to nothing
if CONFIG_OF is not set, so you don't have to provide two versions of
the fucntion.

	Arnd
