From: chunkeey@googlemail.com (Christian Lamparter)
Date: Fri, 06 May 2016 14:22:23 +0200
Subject: [PATCH v7 2/3] gpio: mmio: add DT support for memory-mapped GPIOs
In-Reply-To: <CAHp75VcDPY+LbV5+j9DUMJ8Ws=O9=+KmAa9Nog-JuKkPGAM6Cw@mail.gmail.com>
References: <cover.1462372360.git.chunkeey@googlemail.com>
 <50f7f506364f84effd5224677b21726fd2e511a4.1462372360.git.chunkeey@googlemail.com>
 <CAHp75VcDPY+LbV5+j9DUMJ8Ws=O9=+KmAa9Nog-JuKkPGAM6Cw@mail.gmail.com>
Message-ID: <2264861.CW2OZaRj2L@debian64>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, May 06, 2016 02:44:14 PM Andy Shevchenko wrote:
> > +       /* If ngpio property is not specified, of_property_read_u32
> > +        * will return -EINVAL. In this case the number of GPIOs is
> > +        * automatically determined by the register width. Any
> > +        * other error of of_property_read_u32 is due bad data and
> > +        * needs to be dealt with.
> 
> Couple style issues:
> /*
>  * First sentence starts here. func() are going with parens.
>  */
Ack, I'm used to drivers/net. I have to remove the ngpio in a future
version, so the comment is removed as well.

> > +
> > +static struct bgpio_pdata *bgpio_parse_dt(struct platform_device *pdev,
> > +                                         unsigned long *flags)
> > +{
> > +       const int (*parse_dt)(struct platform_device *,
> > +                             struct bgpio_pdata *, unsigned long *);
> > +       const struct device_node *node = pdev->dev.of_node;
> > +       const struct of_device_id *of_id;
> > +       struct bgpio_pdata *pdata;
> > +       int err = -ENODEV;
> 
> (1)
> 
> > +
> > +       of_id = of_match_node(bgpio_of_match, node);
> > +       if (!of_id)
> > +               return NULL;
> 
> (2)
> 
> Why so?

This is because of existing arch code in /arch/arm/mach-clps711x/board-p720t.c.
You remember there's a driver with a device-tree binding "cirrus,clps711x-gpio"
for it. But the current kernel arch code still registers a platform_device and
it doesn't look like it has any device tree support. So this is necessary for
those partially converted archs to co-exist with the driver. I'll update the
-ENODEV to -EINVAL.

> > +
> > +       pdata = devm_kzalloc(&pdev->dev, sizeof(struct bgpio_pdata),
> > +                            GFP_KERNEL);
> > +       if (!pdata)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       parse_dt = (const void *)of_id->data;
> > +       if (parse_dt)
> > +               err = parse_dt(pdev, pdata, flags);
> > +       if (err)
> > +               return ERR_PTR(err);
> > +
> > +       return pdata;
> > +}
> > +#else
> > +static struct bgpio_pdata *bgpio_parse_dt(struct platform_device *pdev,
> > +                                         unsigned long *flags)
> > +{
> > +       return NULL;
> > +}
> > +#endif /* CONFIG_OF */
