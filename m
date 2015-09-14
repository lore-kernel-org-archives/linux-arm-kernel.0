From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 14 Sep 2015 09:12:12 +0100
Subject: [PATCH v2 2/3] mfd: s2mps11: Add manual shutdown method for
 Odroid XU3
In-Reply-To: <CAJKOXPeSH-w1zBLomLiUKqAVbGEQVvTLfGbJ-YFgZ_qw5MsC9Q@mail.gmail.com>
References: <1439287746-14034-1-git-send-email-k.kozlowski.k@gmail.com>
 <1439287746-14034-3-git-send-email-k.kozlowski.k@gmail.com>
 <CAJKOXPeSH-w1zBLomLiUKqAVbGEQVvTLfGbJ-YFgZ_qw5MsC9Q@mail.gmail.com>
Message-ID: <20150914081212.GE27591@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 13 Sep 2015, Krzysztof Kozlowski wrote:
> You acked this patch. However finally it did not go through other tree
> so maybe you could pick it up for 4.4?
> 
> If you want I could reabse and resend it.

Yes, please rebase and resend.

> 2015-08-11 19:09 GMT+09:00 Krzysztof Kozlowski <k.kozlowski.k@gmail.com>:
> >
> > On Odroid XU3 board (with S2MPS11 PMIC) the PWRHOLD bit in CTRL1
> > register must be manually set to 0 before initiating power off sequence.
> >
> > One of usual power down methods for Exynos based devices looks like:
> > 1. PWRHOLD pin of PMIC is connected to PSHOLD of Exynos.
> > 2. Exynos holds up this pin during system operation.
> > 3. ACOKB pin of PMIC is pulled up to VBATT and optionally to pin in
> >    other device.
> > 4. When PWRHOLD/PSHOLD goes low, the PMIC will turn off the power if
> >    ACOKB goes high.
> >
> > On Odroid XU3 family the difference is in (3) - the ACOKB is grounded.
> > This means that PMIC must manually set PWRHOLD field to low and then
> > wait for signal from Application Processor (the usual change in
> > PWRHOLD/PSHOLD pin will actually cut off the power).
> >
> > The patch adds respective binding allowing Odroid XU3 device to be
> > powered off.
> >
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> > Reported-by: Anand Moon <linux.amoon@gmail.com>
> > Tested-by: Anand Moon <linux.amoon@gmail.com>
> > Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> >
> > ---
> >
> > Changes since v1:
> > 1. Split bindings documentation to separate patch (suggested by Lee).
> > 2. Fix additional empty line (suggested by Lee).
> > 3. Add Anand's tested-by, Javier's reviewed-by and Lee's acked-by.
> >
> > Patch is losely based on patch in Hardkernel repository [0] and previous
> > work of Anand Moon [1].
> >
> > [0] https://github.com/hardkernel/linux/commit/6897e62ba328bd1c8c095d918101863250cd73e7
> > [1] http://www.spinics.net/lists/linux-samsung-soc/msg45959.html
> > ---
> >  drivers/mfd/sec-core.c              | 30 ++++++++++++++++++++++++++++++
> >  include/linux/mfd/samsung/core.h    |  2 ++
> >  include/linux/mfd/samsung/s2mps11.h |  1 +
> >  3 files changed, 33 insertions(+)
> >
> > diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
> > index d206a3e8fe87..2d1137a7a0ee 100644
> > --- a/drivers/mfd/sec-core.c
> > +++ b/drivers/mfd/sec-core.c
> > @@ -278,6 +278,8 @@ static struct sec_platform_data *sec_pmic_i2c_parse_dt_pdata(
> >          * not parsed here.
> >          */
> >
> > +       pd->manual_poweroff = of_property_read_bool(dev->of_node,
> > +                                               "samsung,s2mps11-acokb-ground");
> >         return pd;
> >  }
> >  #else
> > @@ -440,6 +442,33 @@ static int sec_pmic_remove(struct i2c_client *i2c)
> >         return 0;
> >  }
> >
> > +static void sec_pmic_shutdown(struct i2c_client *i2c)
> > +{
> > +       struct sec_pmic_dev *sec_pmic = i2c_get_clientdata(i2c);
> > +       unsigned int reg, mask;
> > +
> > +       if (!sec_pmic->pdata->manual_poweroff)
> > +               return;
> > +
> > +       switch (sec_pmic->device_type) {
> > +       case S2MPS11X:
> > +               reg = S2MPS11_REG_CTRL1;
> > +               mask = S2MPS11_CTRL1_PWRHOLD_MASK;
> > +               break;
> > +       default:
> > +               /*
> > +                * Currently only one board with S2MPS11 needs this, so just
> > +                * ignore the rest.
> > +                */
> > +               dev_warn(sec_pmic->dev,
> > +                       "Unsupported device %lu for manual power off\n",
> > +                       sec_pmic->device_type);
> > +               return;
> > +       }
> > +
> > +       regmap_update_bits(sec_pmic->regmap_pmic, reg, mask, 0);
> > +}
> > +
> >  #ifdef CONFIG_PM_SLEEP
> >  static int sec_pmic_suspend(struct device *dev)
> >  {
> > @@ -491,6 +520,7 @@ static struct i2c_driver sec_pmic_driver = {
> >         },
> >         .probe = sec_pmic_probe,
> >         .remove = sec_pmic_remove,
> > +       .shutdown = sec_pmic_shutdown,
> >         .id_table = sec_pmic_id,
> >  };
> >
> > diff --git a/include/linux/mfd/samsung/core.h b/include/linux/mfd/samsung/core.h
> > index 75115384f3fc..aa78957e092f 100644
> > --- a/include/linux/mfd/samsung/core.h
> > +++ b/include/linux/mfd/samsung/core.h
> > @@ -132,6 +132,8 @@ struct sec_platform_data {
> >         int                             buck2_init;
> >         int                             buck3_init;
> >         int                             buck4_init;
> > +       /* Whether or not manually set PWRHOLD to low during shutdown. */
> > +       bool                            manual_poweroff;
> >  };
> >
> >  /**
> > diff --git a/include/linux/mfd/samsung/s2mps11.h b/include/linux/mfd/samsung/s2mps11.h
> > index 7981a9d77d3f..b288965e8101 100644
> > --- a/include/linux/mfd/samsung/s2mps11.h
> > +++ b/include/linux/mfd/samsung/s2mps11.h
> > @@ -179,6 +179,7 @@ enum s2mps11_regulators {
> >  #define S2MPS11_BUCK_N_VOLTAGES (S2MPS11_BUCK_VSEL_MASK + 1)
> >  #define S2MPS11_RAMP_DELAY     25000           /* uV/us */
> >
> > +#define S2MPS11_CTRL1_PWRHOLD_MASK     BIT(4)
> >
> >  #define S2MPS11_BUCK2_RAMP_SHIFT       6
> >  #define S2MPS11_BUCK34_RAMP_SHIFT      4
> >

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
