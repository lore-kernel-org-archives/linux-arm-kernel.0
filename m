From: guodong.xu@linaro.org (Guodong Xu)
Date: Wed, 7 Jun 2017 15:04:51 +0800
Subject: [PATCH v4 4/8] mfd: hi6421-pmic: add support for HiSilicon
 Hi6421v530
In-Reply-To: <20170606135446.ceqow7bfdlhk4kuv@dell>
References: <20170606085143.13154-1-guodong.xu@linaro.org>
 <20170606085143.13154-5-guodong.xu@linaro.org>
 <20170606135446.ceqow7bfdlhk4kuv@dell>
Message-ID: <CAFGCpxxkseX0DnvbMva3ZEUJ0xuv1NA=QFKdn8Z3rN7wCzF7Bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 6, 2017 at 9:54 PM, Lee Jones <lee.jones@linaro.org> wrote:
>
> On Tue, 06 Jun 2017, Guodong Xu wrote:
>
> > Add support for HiSilicon Hi6421v530 PMIC. Hi6421v530 communicates with
> > main SoC via memory-mapped I/O.
> >
> > Hi6421v530 and Hi6421 are PMIC chips from the same vendor, HiSilicon,
> > but at different revisions. They share the same memory-mapped I/O
> > design. They differ in integrated devices, such as regulator details,
> > LDO voltage points.
> >
> > Signed-off-by: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>
> > Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
> > ---
> >  drivers/mfd/hi6421-pmic-core.c  | 68 ++++++++++++++++++++++++++++++-----------
> >  include/linux/mfd/hi6421-pmic.h |  5 +++
> >  2 files changed, 55 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/mfd/hi6421-pmic-core.c b/drivers/mfd/hi6421-pmic-core.c
> > index b1139d4..4568a43 100644
> > --- a/drivers/mfd/hi6421-pmic-core.c
> > +++ b/drivers/mfd/hi6421-pmic-core.c
>
> [...]
>
> >  static int hi6421_pmic_probe(struct platform_device *pdev)
> >  {
> >       struct hi6421_pmic *pmic;
> >       struct resource *res;
> > +     const struct of_device_id *id;
> > +     const struct mfd_cell *subdevs;
> >       void __iomem *base;
> > -     int ret;
> > +     int n_subdevs, ret;
> > +
> > +     id = of_match_device(of_hi6421_pmic_match, &pdev->dev);
> > +     if (!id)
> > +             return -EINVAL;
> >
> >       pmic = devm_kzalloc(&pdev->dev, sizeof(*pmic), GFP_KERNEL);
> >       if (!pmic)
> > @@ -57,18 +80,33 @@ static int hi6421_pmic_probe(struct platform_device *pdev)
> >               return PTR_ERR(pmic->regmap);
> >       }
> >
> > -     /* set over-current protection debounce 8ms */
> > -     regmap_update_bits(pmic->regmap, HI6421_OCP_DEB_CTRL_REG,
> > +     platform_set_drvdata(pdev, pmic);
> > +
> > +     switch ((unsigned long)id->data) {
>
> Whilst this is not a blocker, it would be nicer to place this into a
> 'type' variable, in order to clarify what data you are using.
>

I will add that.
enum hi6421_type type;


>
> > +     case HI6421:
> > +             /* set over-current protection debounce 8ms */
> > +             regmap_update_bits(pmic->regmap, HI6421_OCP_DEB_CTRL_REG,
> >                               (HI6421_OCP_DEB_SEL_MASK
> >                                | HI6421_OCP_EN_DEBOUNCE_MASK
> >                                | HI6421_OCP_AUTO_STOP_MASK),
> >                               (HI6421_OCP_DEB_SEL_8MS
> >                                | HI6421_OCP_EN_DEBOUNCE_ENABLE));
> >
> > -     platform_set_drvdata(pdev, pmic);
> > +             subdevs = hi6421_devs;
> > +             n_subdevs = ARRAY_SIZE(hi6421_devs);
> > +             break;
> > +     case HI6421_V530:
> > +             subdevs = hi6421v530_devs;
> > +             n_subdevs = ARRAY_SIZE(hi6421v530_devs);
> > +             break;
> > +     default:
> > +             dev_err(&pdev->dev, "Unknown device type %ld\n",
> > +                                             (unsigned long)id->data);
> > +             return -EINVAL;
> > +     }
> >
> > -     ret = devm_mfd_add_devices(&pdev->dev, 0, hi6421_devs,
> > -                                ARRAY_SIZE(hi6421_devs), NULL, 0, NULL);
> > +     ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
> > +                                subdevs, n_subdevs, NULL, 0, NULL);
> >       if (ret) {
> >               dev_err(&pdev->dev, "Failed to add child devices: %d\n", ret);
> >               return ret;
> > @@ -77,16 +115,10 @@ static int hi6421_pmic_probe(struct platform_device *pdev)
> >       return 0;
> >  }
> >
> > -static const struct of_device_id of_hi6421_pmic_match_tbl[] = {
> > -     { .compatible = "hisilicon,hi6421-pmic", },
> > -     { },
> > -};
> > -MODULE_DEVICE_TABLE(of, of_hi6421_pmic_match_tbl);
> > -
> >  static struct platform_driver hi6421_pmic_driver = {
> >       .driver = {
> > -             .name   = "hi6421_pmic",
> > -             .of_match_table = of_hi6421_pmic_match_tbl,
> > +             .name = "hi6421_pmic",
> > +             .of_match_table = of_hi6421_pmic_match,
> >       },
> >       .probe  = hi6421_pmic_probe,
> >  };
> > diff --git a/include/linux/mfd/hi6421-pmic.h b/include/linux/mfd/hi6421-pmic.h
> > index 587273e..2457438 100644
> > --- a/include/linux/mfd/hi6421-pmic.h
> > +++ b/include/linux/mfd/hi6421-pmic.h
> > @@ -38,4 +38,9 @@ struct hi6421_pmic {
> >       struct regmap           *regmap;
> >  };
> >
> > +enum hi6421_type {
> > +     HI6421      = 1,
> > +     HI6421_V530 = 2,
> > +};
> > +
>
> As programmers we usually start counting at 0.  Then you can rely on
> the C standard to populate the remaining values.
>
> Something like:
>
> enum hi6421_type {
>         HI6421 = 0,
>         HI6421_V530,
> };
>
> ... is more normal.


:) sure. thanks. I will do.

-Guodong

>
>
> >  #endif               /* __HI6421_PMIC_H */
>
> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org ? Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
