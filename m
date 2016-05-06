From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Fri, 6 May 2016 14:44:14 +0300
Subject: [PATCH v7 2/3] gpio: mmio: add DT support for memory-mapped GPIOs
In-Reply-To: <50f7f506364f84effd5224677b21726fd2e511a4.1462372360.git.chunkeey@googlemail.com>
References: <cover.1462372360.git.chunkeey@googlemail.com>
 <50f7f506364f84effd5224677b21726fd2e511a4.1462372360.git.chunkeey@googlemail.com>
Message-ID: <CAHp75VcDPY+LbV5+j9DUMJ8Ws=O9=+KmAa9Nog-JuKkPGAM6Cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 6, 2016 at 2:10 PM, Christian Lamparter
<chunkeey@googlemail.com> wrote:
> From: ?lvaro Fern?ndez Rojas <noltari@gmail.com>
>
> This patch adds support for defining memory-mapped GPIOs which
> are compatible with the existing gpio-mmio interface. The generic
> library provides support for many memory-mapped GPIO controllers
> that are found in various on-board FPGA and ASIC solutions that
> are used to control board's switches, LEDs, chip-selects,
> Ethernet/USB PHY power, etc.
>
> For setting GPIO's there are three configurations:
>         1. single input/output register resource (named "dat"),
>         2. set/clear pair (named "set" and "clr"),
>         3. single output register resource and single input resource
>            ("set" and dat").
>
> The configuration is detected by which resources are present.
> For the single output register, this drives a 1 by setting a bit
> and a zero by clearing a bit.  For the set clr pair, this drives
> a 1 by setting a bit in the set register and clears it by setting
> a bit in the clear register. The configuration is detected by
> which resources are present.
>
> For setting the GPIO direction, there are three configurations:
>         a. simple bidirectional GPIOs that requires no configuration.
>         b. an output direction register (named "dirout")
>            where a 1 bit indicates the GPIO is an output.
>         c. an input direction register (named "dirin")
>            where a 1 bit indicates the GPIO is an input.
>
> The first user for this binding is "wd,mbl-gpio".

Some (mostly) style issues below.

> @@ -569,6 +571,89 @@ static void __iomem *bgpio_map(struct platform_device *pdev,
>         return devm_ioremap_resource(&pdev->dev, r);
>  }
>
> +#ifdef CONFIG_OF
> +static int bgpio_basic_mmio_parse_dt(struct platform_device *pdev,
> +                                    struct bgpio_pdata *pdata,
> +                                    unsigned long *flags)
> +{
> +       struct device *dev = &pdev->dev;
> +       int err;
> +
> +       pdata->base = -1;

+ empty line

> +       /* If ngpio property is not specified, of_property_read_u32
> +        * will return -EINVAL. In this case the number of GPIOs is
> +        * automatically determined by the register width. Any
> +        * other error of of_property_read_u32 is due bad data and
> +        * needs to be dealt with.

Couple style issues:
/*
 * First sentence starts here. func() are going with parens.
 */

> +        */
> +       err = of_property_read_u32(dev->of_node, "ngpio", &pdata->ngpio);
> +       if (err && err != -EINVAL)
> +               return err;
> +
> +       if (of_device_is_big_endian(dev->of_node))
> +               *flags |= BGPIOF_BIG_ENDIAN_BYTE_ORDER;
> +
> +       if (of_property_read_bool(dev->of_node, "unreadable-reg-set"))
> +               *flags |= BGPIOF_UNREADABLE_REG_SET;
> +
> +       if (of_property_read_bool(dev->of_node, "unreadable-reg-dir"))
> +               *flags |= BGPIOF_UNREADABLE_REG_DIR;
> +
> +       if (of_property_read_bool(dev->of_node, "big-endian-byte-order"))
> +               *flags |= BGPIOF_BIG_ENDIAN;
> +
> +       if (of_property_read_bool(dev->of_node, "read-output-reg-set"))
> +               *flags |= BGPIOF_READ_OUTPUT_REG_SET;
> +
> +       if (of_property_read_bool(dev->of_node, "no-output"))
> +               *flags |= BGPIOF_NO_OUTPUT;
> +       return 0;
> +}
> +
> +#define ADD_GPIO_OF(_name, _func) { .compatible = _name, .data = _func }
> +
> +static const struct of_device_id bgpio_of_match[] = {
> +       ADD_GPIO_OF("wd,mbl-gpio", bgpio_basic_mmio_parse_dt),
> +       { }
> +};
> +#undef ADD_GPIO_OF
> +MODULE_DEVICE_TABLE(of, bgpio_of_match);
> +
> +static struct bgpio_pdata *bgpio_parse_dt(struct platform_device *pdev,
> +                                         unsigned long *flags)
> +{
> +       const int (*parse_dt)(struct platform_device *,
> +                             struct bgpio_pdata *, unsigned long *);
> +       const struct device_node *node = pdev->dev.of_node;
> +       const struct of_device_id *of_id;
> +       struct bgpio_pdata *pdata;
> +       int err = -ENODEV;

(1)

> +
> +       of_id = of_match_node(bgpio_of_match, node);
> +       if (!of_id)
> +               return NULL;

(2)

Why so?

> +
> +       pdata = devm_kzalloc(&pdev->dev, sizeof(struct bgpio_pdata),
> +                            GFP_KERNEL);
> +       if (!pdata)
> +               return ERR_PTR(-ENOMEM);
> +
> +       parse_dt = (const void *)of_id->data;
> +       if (parse_dt)
> +               err = parse_dt(pdev, pdata, flags);
> +       if (err)
> +               return ERR_PTR(err);
> +
> +       return pdata;
> +}
> +#else
> +static struct bgpio_pdata *bgpio_parse_dt(struct platform_device *pdev,
> +                                         unsigned long *flags)
> +{
> +       return NULL;
> +}
> +#endif /* CONFIG_OF */



-- 
With Best Regards,
Andy Shevchenko
