From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 11 Jan 2016 20:49:23 +0800
Subject: [PATCH v6 6/9] mfd: axp20x: Add support for RSB based AXP223 PMIC
In-Reply-To: <20160111120902.GE19803@x1>
References: <1450283538-25067-1-git-send-email-wens@csie.org>
 <1450283538-25067-7-git-send-email-wens@csie.org> <20160111092427.GI14104@x1>
 <CAGb2v67N_C5bLTPmQs2gcTkpYt=2=Dk8LjWLEzHqGU--qhu+9g@mail.gmail.com>
 <20160111120902.GE19803@x1>
Message-ID: <CAGb2v64iF2DhFPb+bn1obDW2BywByqyV5rB0Nz_oEUfeb2y7nQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2016 at 8:09 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Mon, 11 Jan 2016, Chen-Yu Tsai wrote:
>> On Mon, Jan 11, 2016 at 5:24 PM, Lee Jones <lee.jones@linaro.org> wrote:
>> > On Thu, 17 Dec 2015, Chen-Yu Tsai wrote:
>> >
>> >> The AXP223 is a new PMIC commonly paired with Allwinner A23/A33 SoCs.
>> >> It is functionally identical to AXP221; only the regulator default
>> >> voltage/status and the external host interface are different.
>> >>
>> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> >> ---
>> >>  drivers/mfd/Kconfig        | 11 +++++++
>> >>  drivers/mfd/Makefile       |  1 +
>> >>  drivers/mfd/axp20x-rsb.c   | 78 ++++++++++++++++++++++++++++++++++++++++++++++
>> >>  drivers/mfd/axp20x.c       |  2 ++
>> >>  include/linux/mfd/axp20x.h |  1 +
>> >>  5 files changed, 93 insertions(+)
>> >>  create mode 100644 drivers/mfd/axp20x-rsb.c
>
> [...]
>
>> >> +static int axp20x_rsb_probe(struct sunxi_rsb_device *rdev)
>> >> +{
>> >> +     struct axp20x_dev *axp20x;
>> >> +     int ret;
>> >> +
>> >> +     axp20x = devm_kzalloc(&rdev->dev, sizeof(*axp20x), GFP_KERNEL);
>> >> +     if (!axp20x)
>> >> +             return -ENOMEM;
>> >> +
>> >> +     axp20x->dev = &rdev->dev;
>> >> +     axp20x->irq = rdev->irq;
>> >> +     sunxi_rsb_device_set_drvdata(rdev, axp20x);
>> >
>> > What's the point of this call?  Why do you need a sunxi_ variant?
>>
>> This is an inline call defined in include/linux/sunxi-rsb.h,
>> which is equivalent to dev_set_drvdata(&rdev->dev, data).
>>
>> It seems many subsystems or bus drivers have this pattern.
>>
>>     git grep void.*_set_drvdata include/linux/ | wc -l
>>
>> yields 34, not including dev_set_drvdata itself and this sunxi_rsb
>> variant.
>
> That doesn't answer my question.  Why is it required?
>
> Looks like superfluous churn to me.  Aggregation for the sake of it.

I assumed it better to use functions matching the specific bus, and also
matching sunxi_rsb_device_get_drvdata() in the remove function.

But since we already get "struct device" two lines above, it's already
leaking the implementation, which beats the purpose of the wrapper. I'll
replace it with dev_set_drvdata() in the next version.


Regards
ChenYu

>> >> +     ret = axp20x_match_device(axp20x);
>> >> +     if (ret)
>> >> +             return ret;
>> >> +
>> >> +     axp20x->regmap = devm_regmap_init_sunxi_rsb(rdev, axp20x->regmap_cfg);
>> >> +     if (IS_ERR(axp20x->regmap)) {
>> >> +             ret = PTR_ERR(axp20x->regmap);
>> >> +             dev_err(&rdev->dev, "regmap init failed: %d\n", ret);
>> >> +             return ret;
>> >> +     }
>> >> +
>> >> +     return axp20x_device_probe(axp20x);
>> >> +}
>> >> +
>> >> +static int axp20x_rsb_remove(struct sunxi_rsb_device *rdev)
>> >> +{
>> >> +     struct axp20x_dev *axp20x = sunxi_rsb_device_get_drvdata(rdev);
>> >> +
>> >> +     return axp20x_device_remove(axp20x);
>> >> +}
>> >> +
>> >> +static const struct of_device_id axp20x_rsb_of_match[] = {
>> >> +     { .compatible = "x-powers,axp223", .data = (void *)AXP223_ID },
>> >> +     { },
>> >> +};
>> >> +MODULE_DEVICE_TABLE(of, axp20x_rsb_of_match);
>> >> +
>> >> +static struct sunxi_rsb_driver axp20x_rsb_driver = {
>> >> +     .driver = {
>> >> +             .name   = "axp20x-rsb",
>> >> +             .of_match_table = of_match_ptr(axp20x_rsb_of_match),
>> >> +     },
>> >> +     .probe  = axp20x_rsb_probe,
>> >> +     .remove = axp20x_rsb_remove,
>> >> +};
>> >> +module_sunxi_rsb_driver(axp20x_rsb_driver);
>> >> +
>> >> +MODULE_DESCRIPTION("PMIC MFD sunXi RSB driver for AXP20X");
>> >> +MODULE_AUTHOR("Chen-Yu Tsai <wens@csie.org>");
>> >> +MODULE_LICENSE("GPL v2");
>> >> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
>> >> index 54a00168da26..968d77fb95d8 100644
>> >> --- a/drivers/mfd/axp20x.c
>> >> +++ b/drivers/mfd/axp20x.c
>> >> @@ -33,6 +33,7 @@ static const char * const axp20x_model_names[] = {
>> >>       "AXP202",
>> >>       "AXP209",
>> >>       "AXP221",
>> >> +     "AXP223",
>> >>       "AXP288",
>> >>  };
>> >>
>> >> @@ -616,6 +617,7 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
>> >>               axp20x->regmap_irq_chip = &axp20x_regmap_irq_chip;
>> >>               break;
>> >>       case AXP221_ID:
>> >> +     case AXP223_ID:
>> >>               axp20x->nr_cells = ARRAY_SIZE(axp22x_cells);
>> >>               axp20x->cells = axp22x_cells;
>> >>               axp20x->regmap_cfg = &axp22x_regmap_config;
>> >> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
>> >> index 00697c6ad8b0..d82e7d51372b 100644
>> >> --- a/include/linux/mfd/axp20x.h
>> >> +++ b/include/linux/mfd/axp20x.h
>> >> @@ -18,6 +18,7 @@ enum {
>> >>       AXP202_ID,
>> >>       AXP209_ID,
>> >>       AXP221_ID,
>> >> +     AXP223_ID,
>> >>       AXP288_ID,
>> >>       NR_AXP20X_VARIANTS,
>> >>  };
>> >
>
> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org ? Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
