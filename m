From: ryder.lee@mediatek.com (Ryder Lee)
Date: Wed, 3 Jan 2018 20:24:27 +0800
Subject: [PATCH 05/12] mfd: mtk-audsys: add MediaTek audio subsystem driver
In-Reply-To: <20180102163103.dqxsl4bylqwn6o5b@dell>
References: <cover.1514881870.git.ryder.lee@mediatek.com>
 <fbe22b0d78c41b121f04202dcbfcd0cc23a7590d.1514881870.git.ryder.lee@mediatek.com>
 <20180102163103.dqxsl4bylqwn6o5b@dell>
Message-ID: <1514982267.23243.40.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-01-02 at 16:31 +0000, Lee Jones wrote:
> On Tue, 02 Jan 2018, Ryder Lee wrote:
> 
> > Add a common driver for the top block of the MediaTek audio subsystem.
> > This is a wrapper which manages resources for audio components.
> > 
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

> > diff --git a/drivers/mfd/mtk-audsys.c b/drivers/mfd/mtk-audsys.c
> > new file mode 100644
> > index 0000000..89399e1
> > --- /dev/null
> > +++ b/drivers/mfd/mtk-audsys.c
> > @@ -0,0 +1,138 @@
> > +/*
> > + * Mediatek audio subsystem core driver
> > + *
> > + *  Copyright (c) 2017 MediaTek Inc.
> > + *
> > + * Author: Ryder Lee <ryder.lee@mediatek.com>
> > + *
> > + * For licencing details see kernel-base/COPYING
> 
> You can't do that.
> 
> Grep for SPDX to see what is expected.

Okay.
> > + *
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/module.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +
> > +#define AUDSYS_MAX_CLK_NUM 3
> 
> When is this not 3?

If other subsystems have different clocks numbers.

> > +struct sys_dev {
> > +	struct device *dev;
> > +	struct regmap *regmap;
> > +	int clk_num;
> > +	struct clk *clks[];
> > +};
> > +
> > +static const struct regmap_config aud_regmap_config = {
> > +	.reg_bits = 32,
> > +	.reg_stride = 4,
> > +	.val_bits = 32,
> > +	.max_register = 0x15e0,
> > +	.cache_type = REGCACHE_NONE,
> > +};
> > +
> > +static int mtk_subsys_enable(struct sys_dev *sys)
> > +{
> > +	struct device *dev = sys->dev;
> 
> I would remove dev and regmap from the sys_dev struct and pass in pdev
> directly into this function.  Then use platform_get_drvdata() as you
> did in .remove().
> 
> > +	struct clk *clk;
> > +	int i, ret;
> > +
> > +	for (i = 0; i < sys->clk_num; i++) {
> > +		clk = of_clk_get(dev->of_node, i);
> > +		if (IS_ERR(clk)) {
> > +			if (PTR_ERR(clk) == -EPROBE_DEFER)
> > +				return -EPROBE_DEFER;
> > +			break;
> > +		}
> > +		sys->clks[i] = clk;
> > +	}
> > +
> > +	for (i = 0; i < sys->clk_num && sys->clks[i]; i++) {
> 
> Why do you need a separate loop for this?
> 
> Just prepare and enable valid clocks in the for() loop above.

Ohh, it's a mistake. Thanks for reminding me.

> > +		ret = clk_prepare_enable(sys->clks[i]);
> > +		if (ret)
> > +			goto err_enable_clks;
> > +	}
> > +
> > +	return 0;
> > +
> > +err_enable_clks:
> > +	while (--i >= 0)
> > +		clk_disable_unprepare(sys->clks[i]);
> > +
> > +	return ret;
> > +}
> > +
> > +static int mtk_subsys_probe(struct platform_device *pdev)
> > +{
> > +	struct sys_dev *sys;
> > +	struct resource *res;
> > +	void __iomem *mmio;
> > +	int num, ret;
> > +
> > +	num = (int)of_device_get_match_data(&pdev->dev);
> > +	if (!num)
> > +		return -EINVAL;
> 
> This is a very rigid method of achieving your aim.  Please find a way
> to make this more dynamic.  You're probably better off counting the
> elements within the property, checking to ensure there aren't more
> than the maximum pre-allocated/allowed clocks, then using the number
> gleaned directly from the Device Tree.

Just in case other MTK subsystems can reuse this driver and set their
own clock numbers in SoC data table, but yes, it's too rigid.

> > +	sys = devm_kzalloc(&pdev->dev, sizeof(*sys) +
> > +			   sizeof(struct clk *) * num, GFP_KERNEL);
> 
> You need to add bracketing here for clarity.

Okay.

> > +	if (!sys)
> > +		return -ENOMEM;
> > +
> > +	sys->clk_num = num;
> > +	sys->dev = &pdev->dev;
> 
> Why are you saving the device pointer?

will remove it.

> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	mmio = devm_ioremap_resource(sys->dev, res);
> > +	if (IS_ERR(mmio))
> > +		return PTR_ERR(mmio);
> > +
> > +	sys->regmap = devm_regmap_init_mmio(sys->dev, mmio,
> > +					    &aud_regmap_config);
> 
> Why are you saving a devm'ed regmap pointer?

We don't really need this 'sys->regmap" in driver, but need to
initialize mmio so that its subnodes can obtain regmap through
dev_get_regmap().

> > +	if (IS_ERR(sys->regmap))
> > +		return PTR_ERR(sys->regmap);
> > +
> > +	platform_set_drvdata(pdev, sys);
> > +
> > +	/* Enable top level clocks */
> > +	ret = mtk_subsys_enable(sys);
> 
> mtk_subsys_enable_clks()

Okay.
> > +	if (ret)
> > +		return ret;
> > +
> > +	return devm_of_platform_populate(sys->dev);
> > +};
> > +
> > +static int mtk_subsys_remove(struct platform_device *pdev)
> > +{
> > +	struct sys_dev *sys = platform_get_drvdata(pdev);
> > +	int i;
> > +
> > +	for (i = sys->clk_num - 1; i >= 0; i--)
> > +		if (sys->clks[i])
> 
> This check is superfluous as the clk subsystem does this for you.
> 
> > +			clk_disable_unprepare(sys->clks[i]);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id of_match_audsys[] = {
> > +	{
> > +	  .compatible = "mediatek,mt2701-audsys-core",
> > +	  .data = (void *)AUDSYS_MAX_CLK_NUM,
> 
> You can remove this line.

Okay
> > +	},
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(platform, of_match_audsys);
> > +
> > +static struct platform_driver audsys_drv = {
> > +	.probe = mtk_subsys_probe,
> > +	.remove	= mtk_subsys_remove,
> > +	.driver = {
> > +		.name = "mediatek-audsys-core",
> > +		.of_match_table = of_match_ptr(of_match_audsys),
> > +	},
> > +};
> > +
> > +builtin_platform_driver(audsys_drv);
> > +
> > +MODULE_DESCRIPTION("Mediatek audio subsystem core driver");
> 
> > +MODULE_LICENSE("GPL");
> 
> <just_checking>
>   Are you sure this is what you want?
> </just_checking>
> 

The reason to add this driver is some MTK subsystem blocks expose more
than a single functionality but register those in different kernel
subsystems (e.g., AUDSYS includes audio components and clock part).

But I think I should just add a property "simple-mfd" in DTS instead of
adding this driver.

Thanks.
