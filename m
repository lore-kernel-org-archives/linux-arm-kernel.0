From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 25 Aug 2015 08:49:24 +0100
Subject: [PATCH-v2 5/5] mfd: 88pm800: Add support for clk subdevice
In-Reply-To: <55DBFC40.3010603@samsung.com>
References: <1440442594-3102-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1440442594-3102-7-git-send-email-vaibhav.hiremath@linaro.org>
 <55DBFC40.3010603@samsung.com>
Message-ID: <20150825074924.GD19409@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Aug 2015, Krzysztof Kozlowski wrote:

> On 25.08.2015 03:56, Vaibhav Hiremath wrote:
> > This patch adds mfd_cell/clk-subdevice for 88PM800 MFD
> > (and family of devices).
> > 
> > Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> > ---
> >  drivers/mfd/88pm800.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
> > index c4e097d..a928eed 100644
> > --- a/drivers/mfd/88pm800.c
> > +++ b/drivers/mfd/88pm800.c
> > @@ -173,6 +173,14 @@ static const struct mfd_cell regulator_devs[] = {
> >  	},
> >  };
> >  
> > +static struct mfd_cell clk_devs[] = {
> > +	{
> > +		.name = "88pm80x-clk",
> > +		.of_compatible = "marvell,88pm800-clk",
> > +		.id = -1,
> 
> The "-1" here stands for PLATFORM_DEVID_NONE?

Right.  Please use the define, but use it in the mfd_add_devices()
call, rather than individual cells.

> > +	},
> > +};
> > +
> >  static const struct regmap_irq pm800_irqs[] = {
> >  	/* INT0 */
> >  	[PM800_IRQ_ONKEY] = {
> > @@ -344,6 +352,17 @@ static int device_regulator_init(struct pm80x_chip *chip)
> >  			ARRAY_SIZE(regulator_devs), NULL, 0, NULL);
> >  }
> >  
> > +static int device_clk_init(struct pm80x_chip *chip)
> > +{
> > +	if (chip->type == CHIP_PM800)
> > +		clk_devs[0].name = "88pm800-clk";
> > +	else if (chip->type == CHIP_PM860)
> > +		clk_devs[0].name = "88pm860-clk";
> > +
> > +	return mfd_add_devices(chip->dev, 0, &clk_devs[0],
> > +			ARRAY_SIZE(clk_devs), NULL, 0, NULL);
> > +}
> > +
> >  static int device_irq_init_800(struct pm80x_chip *chip)
> >  {
> >  	struct regmap *map = chip->regmap;
> > @@ -511,6 +530,12 @@ static int device_800_init(struct pm80x_chip *chip)
> >  		goto out;
> >  	}
> >  
> > +	ret = device_clk_init(chip);
> > +	if (ret) {
> > +		dev_err(chip->dev, "Failed to add clk subdev\n");
> > +		goto out;
> > +	}
> > +
> >  	return 0;
> >  out_dev:
> >  	mfd_remove_devices(chip->dev);
> > 
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
