From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 12 Jun 2015 12:20:48 +0200
Subject: [PATCH v2 2/2] pwm: add MediaTek display PWM driver support
In-Reply-To: <1432214964-40644-3-git-send-email-yh.huang@mediatek.com>
References: <1432214964-40644-1-git-send-email-yh.huang@mediatek.com>
 <1432214964-40644-3-git-send-email-yh.huang@mediatek.com>
Message-ID: <20150612102046.GF19400@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 09:29:24PM +0800, YH Huang wrote:
> Add display PWM driver support to modify backlight for MT8173.
> 
> Signed-off-by: YH Huang <yh.huang@mediatek.com>
> ---
>  drivers/pwm/Kconfig        |  10 ++
>  drivers/pwm/Makefile       |   1 +
>  drivers/pwm/pwm-mtk-disp.c | 228 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 239 insertions(+)
>  create mode 100644 drivers/pwm/pwm-mtk-disp.c
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index b1541f4..90e3c079 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -211,6 +211,16 @@ config PWM_LPSS_PLATFORM
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-lpss-platform.
>  
> +config PWM_MTK_DISP
> +	tristate "MediaTek display PWM driver"
> +	depends on HAS_IOMEM
> +	help
> +	  Generic PWM framework driver for MediaTek disp-pwm device.
> +	  The PWM is used to control the backlight brightness for display.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-mtk-disp.
> +
>  config PWM_MXS
>  	tristate "Freescale MXS PWM support"
>  	depends on ARCH_MXS && OF
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index ec50eb5..99c9e75 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
>  obj-$(CONFIG_PWM_LPSS)		+= pwm-lpss.o
>  obj-$(CONFIG_PWM_LPSS_PCI)	+= pwm-lpss-pci.o
>  obj-$(CONFIG_PWM_LPSS_PLATFORM)	+= pwm-lpss-platform.o
> +obj-$(CONFIG_PWM_MTK_DISP)	+= pwm-mtk-disp.o
>  obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
>  obj-$(CONFIG_PWM_PCA9685)	+= pwm-pca9685.o
>  obj-$(CONFIG_PWM_PUV3)		+= pwm-puv3.o
> diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
> new file mode 100644
> index 0000000..d4e4cb6
> --- /dev/null
> +++ b/drivers/pwm/pwm-mtk-disp.c
> @@ -0,0 +1,228 @@
> +/*
> + * MediaTek display pulse-width-modulation controller driver.
> + * Copyright (c) 2015 MediaTek Inc.
> + * Author: YH Huang <yh.huang@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/pwm.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#define DISP_PWM_EN		0x0
> +#define PWM_ENABLE_MASK		0x1
> +
> +#define DISP_PWM_COMMIT		0x08
> +#define PWM_COMMIT_MASK		0x1
> +
> +#define DISP_PWM_CON_0		0x10
> +#define PWM_CLKDIV_SHIFT	16
> +#define PWM_CLKDIV_MASK		(0x3ff << PWM_CLKDIV_SHIFT)
> +#define PWM_CLKDIV_MAX		0x000003ff

I think you should make this:

	#define PWM_CLKDIV_MAX 0x3ff
	#define PWM_CLKDIV_MASK (PWM_CLKDIV_MAX << PWM_CLKDIV_SHIFT)

Just to show that these belong together.

> +
> +#define DISP_PWM_CON_1		0x14
> +#define PWM_PERIOD_MASK		0xfff
> +#define PWM_PERIOD_MAX		0x00000fff

Same here. PWM_PERIOD_MAX isn't actually used anywhere, so perhaps just
drop it altogether. But see also below...

> +/* Shift log2(PWM_PERIOD_MAX + 1) as divisor */
> +#define PWM_PERIOD_BIT_SHIFT	12

I wasn't very clear about this in my earlier review, so let me try to
explain why I think this is confusing. You use this as a divisor, but
you encode it as a shift. It's also PWM_PERIOD_MAX + 1, so I think it
would make more sense to drop this, keep PWM_PERIOD_MAX as above and
then replace the

	>> PWM_PERIOD_BIT_SHIFT
	
below by

	/ (PWM_PERIOD_MAX + 1)

> +#define PWM_HIGH_WIDTH_SHIFT	16
> +#define PWM_HIGH_WIDTH_MASK	(0x1fff << PWM_HIGH_WIDTH_SHIFT)

Why is the mask wider than for the period? That would imply that the
duty cycle can be longer than a period, which doesn't make any sense.
Can you clarify?

> +struct mtk_disp_pwm {
> +	struct pwm_chip chip;
> +	struct device *dev;
> +	struct clk *clk_main;
> +	struct clk *clk_mm;
> +	void __iomem *mmio_base;

I think "base" will do just fine.

> +};
> +
> +static inline struct mtk_disp_pwm *to_mtk_disp_pwm(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct mtk_disp_pwm, chip);
> +}
> +
> +static void mtk_disp_pwm_update_bits(void __iomem *address, u32 mask, u32 value)
> +{
> +	u32 val;
> +
> +	val = readl(address);
> +	val &= ~mask;
> +	val |= value;
> +	writel(val, address);
> +}
> +
> +static int mtk_disp_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +			       int duty_ns, int period_ns)
> +{
> +	struct mtk_disp_pwm *mdp;
> +	u64 div, rate;
> +	u32 clk_div, period, high_width, value;
> +
> +	/*
> +	 * Find period, high_width and clk_div to suit duty_ns and period_ns.
> +	 * Calculate proper div value to keep period value in the bound.
> +	 *
> +	 * period_ns = 10^9 * (clk_div + 1) * (period +1) / PWM_CLK_RATE

Nit: should have a space between '+' and '1'.

> +	 * duty_ns = 10^9 * (clk_div + 1) * (high_width + 1) / PWM_CLK_RATE
> +	 *
> +	 * period = (PWM_CLK_RATE * period_ns) / (10^9 * (clk_div + 1)) - 1
> +	 * high_width = (PWM_CLK_RATE * duty_ns) / (10^9 * (clk_div + 1)) - 1
> +	 */
> +	mdp = to_mtk_disp_pwm(chip);

Please put this on the same line as the variable declaration:

	struct mtk_disp_pwm *mdp = to_mtk_disp_pwm(chip);

> +	rate = clk_get_rate(mdp->clk_main);
> +	clk_div = div_u64(rate * period_ns, NSEC_PER_SEC) >>
> +			  PWM_PERIOD_BIT_SHIFT;
> +	if (clk_div > PWM_CLKDIV_MAX)
> +		return -EINVAL;
> +
> +	div = clk_div + 1;

Perhaps make this:

	div = NSEC_PER_SEC * (clk_div + 1);

to avoid the two multiplication below.

> +	period = div64_u64(rate * period_ns, NSEC_PER_SEC * div);

So this would become:

	period = div64_u64(rate * period_ns, div);

> +	if (period > 0)
> +		period--;
> +
> +	high_width = div64_u64(rate * duty_ns, NSEC_PER_SEC * div);

And this:

	high_width = div64_u64(rate * duty_ns, div);

> +	if (high_width > 0)
> +		high_width--;
> +
> +	mtk_disp_pwm_update_bits(mdp->mmio_base + DISP_PWM_CON_0,
> +				 PWM_CLKDIV_MASK, clk_div << PWM_CLKDIV_SHIFT);
> +
> +	value = period | (high_width << PWM_HIGH_WIDTH_SHIFT);
> +	mtk_disp_pwm_update_bits(mdp->mmio_base + DISP_PWM_CON_1,
> +				 PWM_PERIOD_MASK | PWM_HIGH_WIDTH_MASK, value);
> +
> +	mtk_disp_pwm_update_bits(mdp->mmio_base + DISP_PWM_COMMIT,
> +				 PWM_COMMIT_MASK, 1);
> +	mtk_disp_pwm_update_bits(mdp->mmio_base + DISP_PWM_COMMIT,
> +				 PWM_COMMIT_MASK, 0);
> +
> +	return 0;
> +}
> +
> +static int mtk_disp_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct mtk_disp_pwm *mdp;
> +
> +	mdp = to_mtk_disp_pwm(chip);

The above three lines should be collapsed.

> +	mtk_disp_pwm_update_bits(mdp->mmio_base + DISP_PWM_EN,
> +				 PWM_ENABLE_MASK, 1);
> +
> +	return 0;
> +}
> +
> +static void mtk_disp_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct mtk_disp_pwm *mdp;
> +
> +	mdp = to_mtk_disp_pwm(chip);

Same here.

> +	mtk_disp_pwm_update_bits(mdp->mmio_base + DISP_PWM_EN,
> +				 PWM_ENABLE_MASK, 0);
> +}
> +
> +static const struct pwm_ops mtk_disp_pwm_ops = {
> +	.config = mtk_disp_pwm_config,
> +	.enable = mtk_disp_pwm_enable,
> +	.disable = mtk_disp_pwm_disable,
> +	.owner = THIS_MODULE,
> +};
> +
> +static int mtk_disp_pwm_probe(struct platform_device *pdev)
> +{
> +	struct mtk_disp_pwm *mdp;
> +	struct resource *r;
> +	int ret;
> +
> +	mdp = devm_kzalloc(&pdev->dev, sizeof(*mdp), GFP_KERNEL);
> +	if (!mdp)
> +		return -ENOMEM;
> +
> +	mdp->dev = &pdev->dev;
> +
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	mdp->mmio_base = devm_ioremap_resource(&pdev->dev, r);
> +	if (IS_ERR(mdp->mmio_base))
> +		return PTR_ERR(mdp->mmio_base);
> +
> +	mdp->clk_main = devm_clk_get(&pdev->dev, "main");
> +	if (IS_ERR(mdp->clk_main))
> +		return PTR_ERR(mdp->clk_main);
> +
> +	mdp->clk_mm = devm_clk_get(&pdev->dev, "mm");
> +	if (IS_ERR(mdp->clk_mm))
> +		return PTR_ERR(mdp->clk_mm);
> +
> +	ret = clk_prepare_enable(mdp->clk_main);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = clk_prepare_enable(mdp->clk_mm);
> +	if (ret < 0) {
> +		clk_disable_unprepare(mdp->clk_main);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, mdp);
> +
> +	mdp->chip.dev = &pdev->dev;
> +	mdp->chip.ops = &mtk_disp_pwm_ops;
> +	mdp->chip.base = -1;
> +	mdp->chip.npwm = 1;
> +
> +	ret = pwmchip_add(&mdp->chip);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
> +		clk_disable_unprepare(mdp->clk_main);
> +		clk_disable_unprepare(mdp->clk_mm);
> +		return ret;
> +	}
> +
> +	return 0;
> +}

It's customary to collect the error cleanup code in an unwinding section
at the bottom of the function, like so:

	ret = clk_prepare_enable(mdp->clk_mm);
	if (ret < 0)
		goto disable_clk_main;

	...

	ret = pwmchip_add(&mdp->chip);
	if (ret < 0) {
		dev_err(&pdev->dev, ...);
		goto disable_clk_mm;
	}

	return 0;

disable_clk_mm:
	clk_disable_unprepare(mdp->clk_mm);
disable_clk_main:
	clk_disable_unprepare(mdp->clk_main);
	return ret;

This makes sure that you undo things in the proper order and eliminates
the need to duplicate cleanup code in all failure paths.

> +
> +static int mtk_disp_pwm_remove(struct platform_device *pdev)
> +{
> +	struct mtk_disp_pwm *mdp;
> +	int ret;
> +
> +	mdp = platform_get_drvdata(pdev);

Should be on the same line as the variable declaration.

> +	ret = pwmchip_remove(&mdp->chip);
> +	clk_disable_unprepare(mdp->clk_main);
> +	clk_disable_unprepare(mdp->clk_mm);
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id mtk_disp_pwm_of_match[] = {
> +	{ .compatible = "mediatek,mt8173-disp-pwm" },
> +	{ .compatible = "mediatek,mt6595-disp-pwm" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, mtk_disp_pwm_of_match);
> +
> +static struct platform_driver mtk_disp_pwm_driver = {
> +	.driver = {
> +		.name = "mediatek-disp-pwm",
> +		.of_match_table = mtk_disp_pwm_of_match,
> +	},
> +	.probe = mtk_disp_pwm_probe,
> +	.remove = mtk_disp_pwm_remove,
> +};
> +module_platform_driver(mtk_disp_pwm_driver);
> +
> +MODULE_AUTHOR("YH Huang <yh.huang@mediatek.com>");
> +MODULE_DESCRIPTION("MediaTek SoC display PWM driver");
> +MODULE_LICENSE("GPL v2");

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150612/7777b0b9/attachment.sig>
