From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 1 Mar 2012 10:01:00 +0000
Subject: [PATCH 4/8] i2c: pxa: add OF support
In-Reply-To: <1330582228-12424-5-git-send-email-haojian.zhuang@marvell.com>
References: <1330582228-12424-1-git-send-email-haojian.zhuang@marvell.com>
 <1330582228-12424-5-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <201203011001.00289.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 March 2012, Haojian Zhuang wrote:
> +#ifdef CONFIG_OF
> +static int i2c_pxa_probe_dt(struct platform_device *pdev, struct pxa_i2c *i2c,
> +                           enum pxa_i2c_types *i2c_types)
>  {
> +       struct device_node *np = pdev->dev.of_node;
> +       const struct of_device_id *of_id =
> +                       of_match_device(i2c_pxa_dt_ids, &pdev->dev);
> +       const char *status;
> +       int len;
> +
> +       if (of_get_property(np, "mrvl,i2c-polling", NULL))
> +               i2c->use_pio = 1;
> +       status = of_get_property(np, "mrvl,i2c-mode", &len);
> +       if (status && len > 0)
> +               if (!strcmp(status, "fast"))
> +                       i2c->fast_mode = 1;

This would be easier if you made it an empty "mrvl,i2c-fast-mode"
property to get rid of the strcmp.

> +       *i2c_types = ((u32)(of_id->data) - (u32)&pxa_reg_layout[0])
> +                       / sizeof(struct pxa_reg_layout);

This looks unnecessarily complicated. Just put the enum into of_id->data
instead of the pointer, with a cast to unsigned long.

> +       return 0;
> +}
> +#else
> +static int i2c_pxa_probe_dt(struct platform_device *pdev, struct pxa_i2c *i2c,
> +                           enum pxa_i2c_types *i2c_types)
> +{
> +       return 1;
> +}
> +#endif

Again, no need for the #ifdef. Just add in the beginning

	if (!of_id)
		return 1;

And the rest will be optimized out without CONFIG_OF.

	Arnd
