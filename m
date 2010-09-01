From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 01 Sep 2010 19:27:11 +0900
Subject: [PATCH v2] MAX8952 PMIC Driver Initial Release
In-Reply-To: <AANLkTinUNXmDc=H16gS5EXEAdrGAU=zK4cjsHSh7UQ8Q@mail.gmail.com>
References: <1282283036-12641-1-git-send-email-myungjoo.ham@samsung.com>
	<20100820095351.GD13668@rakim.wolfsonmicro.main>
	<1282301229.3084.152.camel@odin>
	<011b01cb496a$cfa773d0$6ef65b70$%kim@samsung.com>
	<20100901091519.GA17032@opensource.wolfsonmicro.com>
	<000801cb49ba$3e1e50f0$ba5af2d0$%kim@samsung.com>
	<AANLkTinUNXmDc=H16gS5EXEAdrGAU=zK4cjsHSh7UQ8Q@mail.gmail.com>
Message-ID: <001101cb49c0$3fd715c0$bf854140$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> On Wed, Sep 1, 2010 at 6:44 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Mark Brown wrote:
> >>
> >> On Wed, Sep 01, 2010 at 09:15:36AM +0900, Kukjin Kim wrote:
> >>
> >> > Seems almost same between the operation of max8649 and max8952 except
> >> output
> >> > voltage range.
> >>
> >> > How do you think that can support max8952 with small modifying
max8649?
> >>
> >> Take a look at something like the WM831x drivers for how you can handle
> >> multiple devices with one driver - you can register I2C IDs for
multiple
> >> devices and then select behaviour based on the name that was quoted.
> >
> > MM...but I'm not sure if I can submit other patch for max8952...
> > Actually, Mr. Ham's max8952 code has been applied by Liam.
> >
> > Anyway, could you please see below patch?
> > Basic functions are tested on the board...
> >
> >
> > From: Changhwan Youn <chaos.youn@samsung.com>
> > ---
> > diff --git a/drivers/regulator/max8649.c b/drivers/regulator/max8649.c
> > index 4520ace..a13bf1d 100644
> > --- a/drivers/regulator/max8649.c
> > +++ b/drivers/regulator/max8649.c

(snip)

> > @@ -311,13 +323,13 @@ static int __devinit
max8649_regulator_probe(struct
> > i2c_client *client,
> > ? ? ? ? ? ? ? ?break;
> > ? ? ? ?}
> >
> > - ? ? ? ret = max8649_reg_read(info->i2c, MAX8649_CHIP_ID1);
> > + ? ? ? ret = max8649_reg_read(info->i2c, MAX8649_CHIP_ID2);
> Why do you read the ID2? original code read the ID1. With this change
> don't brake the max8649?

It's no problem, because it is used only in the following printout.

And the reason of changing is that the CHIP_ID1 value of max8649 and max
8952 is same by 0x20.
So cannot distinguish them. If change to CHIP_ID2, can separate them in the
printout.
(The CHIP_ID2 value of max 8649 is '0x0D', max8952 is '0x1A')

> > ? ? ? ?if (ret < 0) {
> > ? ? ? ? ? ? ? ?dev_err(info->dev, "Failed to detect ID of MAX8649:%d\n",
> > ? ? ? ? ? ? ? ? ? ? ? ?ret);
> > ? ? ? ? ? ? ? ?goto out;
> > ? ? ? ?}
> > - ? ? ? dev_info(info->dev, "Detected MAX8649 (ID:%x)\n", ret);
> > + ? ? ? dev_info(info->dev, "Detected %s (ID:%x)\n", id->name, ret);
> >
> > ? ? ? ?/* enable VID0 & VID1 */
> > ? ? ? ?max8649_set_bits(info->i2c, MAX8649_CONTROL, MAX8649_VID_MASK,
> 0);
> > @@ -354,7 +366,7 @@ static int __devinit max8649_regulator_probe(struct
> > i2c_client *client,
> > ? ? ? ? ? ? ? ?goto out;
> > ? ? ? ?}
> >
> > - ? ? ? dev_info(info->dev, "Max8649 regulator device is detected.\n");
> > + ? ? ? dev_info(info->dev, "%s regulator device is detected.\n",
id->name);
> > ? ? ? ?return 0;
> > ?out:
> > ? ? ? ?kfree(info);
> > @@ -376,6 +388,7 @@ static int __devexit max8649_regulator_remove(struct
> > i2c_client *client)
> >
> > ?static const struct i2c_device_id max8649_id[] = {
> > ? ? ? ?{ "max8649", 0 },
> > + ? ? ? { "max8952", 0 },
> > ? ? ? ?{ }
> > ?};
> > ?MODULE_DEVICE_TABLE(i2c, max8649_id);
> > --
> > 1.6.2.5
> >
> >


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
