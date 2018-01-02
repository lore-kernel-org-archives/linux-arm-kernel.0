From: david@lechnology.com (David Lechner)
Date: Tue, 2 Jan 2018 15:31:10 -0600
Subject: [PATCH v4 5/7] clk: Introduce davinci clocks
In-Reply-To: <1514763588-31560-6-git-send-email-david@lechnology.com>
References: <1514763588-31560-1-git-send-email-david@lechnology.com>
 <1514763588-31560-6-git-send-email-david@lechnology.com>
Message-ID: <42102b7d-4e3c-d5fc-b0db-48a1203757ba@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Forgot to cc linux-clk, so doing that now...


On 12/31/2017 05:39 PM, David Lechner wrote:
> This introduces new drivers for arch/arm/mach-davinci. The code is based
> on the clock drivers from there and adapted to use the common clock
> framework.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>   drivers/clk/Makefile                      |   1 +
>   drivers/clk/davinci/Makefile              |   3 +
>   drivers/clk/davinci/da8xx-cfgchip-clk.c   | 380 ++++++++++++++++++++++++++++++
>   drivers/clk/davinci/pll.c                 | 333 ++++++++++++++++++++++++++
>   drivers/clk/davinci/psc.c                 | 217 +++++++++++++++++
>   include/linux/clk/davinci.h               |  46 ++++
>   include/linux/platform_data/davinci_clk.h |  25 ++
>   7 files changed, 1005 insertions(+)
>   create mode 100644 drivers/clk/davinci/Makefile
>   create mode 100644 drivers/clk/davinci/da8xx-cfgchip-clk.c
>   create mode 100644 drivers/clk/davinci/pll.c
>   create mode 100644 drivers/clk/davinci/psc.c
>   create mode 100644 include/linux/clk/davinci.h
>   create mode 100644 include/linux/platform_data/davinci_clk.h
> 
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index f7f761b..c865fd0 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -60,6 +60,7 @@ obj-$(CONFIG_ARCH_ARTPEC)		+= axis/
>   obj-$(CONFIG_ARC_PLAT_AXS10X)		+= axs10x/
>   obj-y					+= bcm/
>   obj-$(CONFIG_ARCH_BERLIN)		+= berlin/
> +obj-$(CONFIG_ARCH_DAVINCI)		+= davinci/
>   obj-$(CONFIG_H8300)			+= h8300/
>   obj-$(CONFIG_ARCH_HISI)			+= hisilicon/
>   obj-y					+= imgtec/
> diff --git a/drivers/clk/davinci/Makefile b/drivers/clk/davinci/Makefile
> new file mode 100644
> index 0000000..5efbdcd
> --- /dev/null
> +++ b/drivers/clk/davinci/Makefile
> @@ -0,0 +1,3 @@
> +obj-$(CONFIG_PHY_DA8XX_USB) += da8xx-cfgchip-clk.o
> +obj-y += pll.o
> +obj-y += psc.o
> \ No newline at end of file
> diff --git a/drivers/clk/davinci/da8xx-cfgchip-clk.c b/drivers/clk/davinci/da8xx-cfgchip-clk.c
> new file mode 100644
> index 0000000..780bb25
> --- /dev/null
> +++ b/drivers/clk/davinci/da8xx-cfgchip-clk.c
> @@ -0,0 +1,380 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * da8xx-cfgchip-clk - TI DaVinci DA8xx CFGCHIP clocks driver
> + *
> + * Copyright (C) 2017 David Lechner <david@lechnology.com>
> + *
> + * This driver exposes the USB PHY clocks on DA8xx/AM18xx/OMAP-L13x SoCs.
> + * The clocks consist of two muxes and a PLL. The USB 2.0 PHY mux and PLL are
> + * combined into a single clock in Linux. The USB 1.0 PHY clock just consists
> + * of a mux. These clocks are controlled through CFGCHIP2, which is accessed
> + * as a syscon regmap since it is shared with other devices.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/mfd/da8xx-cfgchip.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/platform_data/davinci_clk.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +/**
> + * da8xx_cfgchip_clk
> + * @usb0_hw: The USB 2.0 PHY clock (mux + PLL)
> + * @usb1_hw: The USB 1.1 PHY clock (mux)
> + * @usb0_clk: The USB 2.0 subsystem PSC clock
> + * @regmap: The CFGCHIP syscon regmap
> + */
> +struct da8xx_cfgchip_clk {
> +	struct clk_hw usb0_hw;
> +	struct clk_hw usb1_hw;
> +	struct clk *usb0_clk;
> +	struct regmap *regmap;
> +};
> +
> +/* The USB 2.0 PHY can use either USB_REFCLKIN or AUXCLK */
> +enum usb0_phy_clk_parent {
> +	USB20_PHY_CLK_PARENT_USB_REFCLKIN,
> +	USB20_PHY_CLK_PARENT_PLL0_AUX,
> +};
> +
> +/* The USB 1.1 PHY can use either the PLL output from the USB 2.0 PHY or
> + * USB_REFCLKIN
> + */
> +enum usb1_phy_clk_parent {
> +	USB1_PHY_CLK_PARENT_USB_REFCLKIN,
> +	USB1_PHY_CLK_PARENT_USB0_PHY_PLL,
> +};
> +
> +/* --- USB 2.0 PHY clock --- */
> +
> +static int usb0_phy_clk_prepare(struct clk_hw *hw)
> +{
> +	struct da8xx_cfgchip_clk *clk =
> +			container_of(hw, struct da8xx_cfgchip_clk, usb0_hw);
> +
> +	/* The USB 2.0 PSC clock is only needed temporarily during the USB 2.0
> +	 * PHY clock enable, but since clk_prepare() can't be called in an
> +	 * atomic context (i.e. in clk_enable()), we have to prepare it here.
> +	 */
> +	return clk_prepare(clk->usb0_clk);
> +}
> +
> +static void usb0_phy_clk_unprepare(struct clk_hw *hw)
> +{
> +	struct da8xx_cfgchip_clk *clk =
> +			container_of(hw, struct da8xx_cfgchip_clk, usb0_hw);
> +
> +	clk_unprepare(clk->usb0_clk);
> +}
> +
> +static int usb0_phy_clk_enable(struct clk_hw *hw)
> +{
> +	struct da8xx_cfgchip_clk *clk =
> +			container_of(hw, struct da8xx_cfgchip_clk, usb0_hw);
> +	unsigned int mask, val;
> +	int ret;
> +
> +	/* Locking the USB 2.O PLL requires that the USB 2.O PSC is enabled
> +	 * temporaily. It can be turned back off once the PLL is locked.
> +	 */
> +	clk_enable(clk->usb0_clk);
> +
> +	/* Turn on the USB 2.0 PHY, but just the PLL, and not OTG. The USB 1.1
> +	 * PHY may use the USB 2.0 PLL clock without USB 2.0 OTG being used.
> +	 */
> +	mask = CFGCHIP2_RESET | CFGCHIP2_PHYPWRDN | CFGCHIP2_PHY_PLLON;
> +	val = CFGCHIP2_PHY_PLLON;
> +
> +	regmap_write_bits(clk->regmap, CFGCHIP(2), mask, val);
> +	ret = regmap_read_poll_timeout(clk->regmap, CFGCHIP(2), val,
> +				       val & CFGCHIP2_PHYCLKGD, 0, 500000);
> +
> +	clk_disable(clk->usb0_clk);
> +
> +	return ret;
> +}
> +
> +static void usb0_phy_clk_disable(struct clk_hw *hw)
> +{
> +	struct da8xx_cfgchip_clk *clk =
> +			container_of(hw, struct da8xx_cfgchip_clk, usb0_hw);
> +	unsigned int val;
> +
> +	val = CFGCHIP2_PHYPWRDN;
> +	regmap_write_bits(clk->regmap, CFGCHIP(2), val, val);
> +}
> +
> +static unsigned long usb0_phy_clk_recalc_rate(struct clk_hw *hw,
> +					      unsigned long parent_rate)
> +{
> +	struct da8xx_cfgchip_clk *clk =
> +			container_of(hw, struct da8xx_cfgchip_clk, usb0_hw);
> +	unsigned int mask, val;
> +
> +	/* The parent clock rate must be one of the following */
> +	mask = CFGCHIP2_REFFREQ_MASK;
> +	switch (parent_rate) {
> +	case 12000000:
> +		val = CFGCHIP2_REFFREQ_12MHZ;
> +		break;
> +	case 13000000:
> +		val = CFGCHIP2_REFFREQ_13MHZ;
> +		break;
> +	case 19200000:
> +		val = CFGCHIP2_REFFREQ_19_2MHZ;
> +		break;
> +	case 20000000:
> +		val = CFGCHIP2_REFFREQ_20MHZ;
> +		break;
> +	case 24000000:
> +		val = CFGCHIP2_REFFREQ_24MHZ;
> +		break;
> +	case 26000000:
> +		val = CFGCHIP2_REFFREQ_26MHZ;
> +		break;
> +	case 38400000:
> +		val = CFGCHIP2_REFFREQ_38_4MHZ;
> +		break;
> +	case 40000000:
> +		val = CFGCHIP2_REFFREQ_40MHZ;
> +		break;
> +	case 48000000:
> +		val = CFGCHIP2_REFFREQ_48MHZ;
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	regmap_write_bits(clk->regmap, CFGCHIP(2), mask, val);
> +
> +	/* USB 2.0 PLL always supplies 48MHz */
> +	return 48000000;
> +}
> +
> +static long usb0_phy_clk_round_rate(struct clk_hw *hw, unsigned long rate,
> +				    unsigned long *parent_rate)
> +{
> +	return 48000000;
> +}
> +
> +static int usb0_phy_clk_set_parent(struct clk_hw *hw, u8 index)
> +{
> +	struct da8xx_cfgchip_clk *clk =
> +			container_of(hw, struct da8xx_cfgchip_clk, usb0_hw);
> +	unsigned int mask, val;
> +
> +	/* Set the mux depending on the parent clock. */
> +	mask = CFGCHIP2_USB2PHYCLKMUX;
> +	switch (index) {
> +	case USB20_PHY_CLK_PARENT_USB_REFCLKIN:
> +		val = 0;
> +		break;
> +	case USB20_PHY_CLK_PARENT_PLL0_AUX:
> +		val = CFGCHIP2_USB2PHYCLKMUX;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	regmap_write_bits(clk->regmap, CFGCHIP(2), mask, val);
> +
> +	return 0;
> +}
> +
> +static u8 usb0_phy_clk_get_parent(struct clk_hw *hw)
> +{
> +	struct da8xx_cfgchip_clk *clk =
> +			container_of(hw, struct da8xx_cfgchip_clk, usb0_hw);
> +	unsigned int val;
> +
> +	regmap_read(clk->regmap, CFGCHIP(2), &val);
> +
> +	if (val & CFGCHIP2_USB2PHYCLKMUX)
> +		return USB20_PHY_CLK_PARENT_PLL0_AUX;
> +
> +	return USB20_PHY_CLK_PARENT_USB_REFCLKIN;
> +}
> +
> +static const struct clk_ops usb0_phy_clk_ops = {
> +	.prepare	= usb0_phy_clk_prepare,
> +	.unprepare	= usb0_phy_clk_unprepare,
> +	.enable		= usb0_phy_clk_enable,
> +	.disable	= usb0_phy_clk_disable,
> +	.recalc_rate	= usb0_phy_clk_recalc_rate,
> +	.round_rate	= usb0_phy_clk_round_rate,
> +	.set_parent	= usb0_phy_clk_set_parent,
> +	.get_parent	= usb0_phy_clk_get_parent,
> +};
> +
> +static const char * const usb0_phy_clk_parent_names[] = {
> +	[USB20_PHY_CLK_PARENT_USB_REFCLKIN]	= "usb_refclkin",
> +	[USB20_PHY_CLK_PARENT_PLL0_AUX]		= "pll0_aux_clk",
> +};
> +
> +static const struct clk_init_data usb0_phy_clk_init_data = {
> +	.name		= "usb0_phy_clk",
> +	.ops		= &usb0_phy_clk_ops,
> +	.parent_names	= usb0_phy_clk_parent_names,
> +	.num_parents	= ARRAY_SIZE(usb0_phy_clk_parent_names),
> +};
> +
> +/* --- USB 1.1 PHY clock --- */
> +
> +static int usb1_phy_clk_set_parent(struct clk_hw *hw, u8 index)
> +{
> +	struct da8xx_cfgchip_clk *clk =
> +			container_of(hw, struct da8xx_cfgchip_clk, usb1_hw);
> +	unsigned int mask, val;
> +
> +	/* Set the USB 1.1 PHY clock mux based on the parent clock. */
> +	mask = CFGCHIP2_USB1PHYCLKMUX;
> +	switch (index) {
> +	case USB1_PHY_CLK_PARENT_USB_REFCLKIN:
> +		val = CFGCHIP2_USB1PHYCLKMUX;
> +		break;
> +	case USB1_PHY_CLK_PARENT_USB0_PHY_PLL:
> +		val = 0;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	regmap_write_bits(clk->regmap, CFGCHIP(2), mask, val);
> +
> +	return 0;
> +}
> +
> +static u8 usb1_phy_clk_get_parent(struct clk_hw *hw)
> +{
> +	struct da8xx_cfgchip_clk *clk =
> +			container_of(hw, struct da8xx_cfgchip_clk, usb1_hw);
> +	unsigned int val;
> +
> +	regmap_read(clk->regmap, CFGCHIP(2), &val);
> +
> +	if (val & CFGCHIP2_USB1PHYCLKMUX)
> +		return USB1_PHY_CLK_PARENT_USB_REFCLKIN;
> +
> +	return USB1_PHY_CLK_PARENT_USB0_PHY_PLL;
> +}
> +
> +static const struct clk_ops usb1_phy_clk_ops = {
> +	.set_parent	= usb1_phy_clk_set_parent,
> +	.get_parent	= usb1_phy_clk_get_parent,
> +};
> +
> +static const char * const usb1_phy_clk_parent_names[] = {
> +	[USB1_PHY_CLK_PARENT_USB_REFCLKIN]	= "usb_refclkin",
> +	[USB1_PHY_CLK_PARENT_USB0_PHY_PLL]	= "usb0_phy_clk",
> +};
> +
> +static struct clk_init_data usb1_phy_clk_init_data = {
> +	.name		= "usb1_phy_clk",
> +	.ops		= &usb1_phy_clk_ops,
> +	.parent_names	= usb1_phy_clk_parent_names,
> +	.num_parents	= ARRAY_SIZE(usb1_phy_clk_parent_names),
> +};
> +
> +/* --- platform driver --- */
> +
> +static int da8xx_cfgchip_clk_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct da8xx_cfgchip_clk_data *pdata = dev->platform_data;
> +	struct da8xx_cfgchip_clk *phy_clk;
> +	const char *parent_name;
> +	struct clk *parent;
> +	int ret;
> +
> +	if (!pdata)
> +		return -EINVAL;
> +
> +	phy_clk = devm_kzalloc(dev, sizeof(*phy_clk), GFP_KERNEL);
> +	if (!phy_clk)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, phy_clk);
> +
> +	phy_clk->regmap = syscon_regmap_lookup_by_pdevname("syscon");
> +	if (IS_ERR(phy_clk->regmap)) {
> +		dev_err(dev, "Failed to get syscon\n");
> +		return PTR_ERR(phy_clk->regmap);
> +	}
> +
> +	/* USB 2.0 subsystem PSC clock - needed to lock PLL */
> +	phy_clk->usb0_clk = clk_get(dev, "usb20");
> +	if (IS_ERR(phy_clk->usb0_clk)) {
> +		dev_err(dev, "Failed to get usb20 clock\n");
> +		return PTR_ERR(phy_clk->usb0_clk);
> +	}
> +
> +	phy_clk->usb0_hw.init = &usb0_phy_clk_init_data;
> +	ret = devm_clk_hw_register(dev, &phy_clk->usb0_hw);
> +	if (ret) {
> +		dev_err(dev, "Failed to register usb0_phy_clk\n");
> +		return ret;
> +	}
> +
> +	phy_clk->usb1_hw.init = &usb1_phy_clk_init_data;
> +	ret = devm_clk_hw_register(dev, &phy_clk->usb1_hw);
> +	if (ret) {
> +		dev_err(dev, "Failed to register usb1_phy_clk\n");
> +		return ret;
> +	}
> +
> +	parent_name = pdata->usb0_use_refclkin ? "usb_refclkin" : "pll0_aux";
> +	parent = devm_clk_get(dev, parent_name);
> +	if (IS_ERR(parent)) {
> +		dev_err(dev, "Failed to get usb0 parent clock %s\n",
> +			parent_name);
> +		return PTR_ERR(parent);
> +	}
> +
> +	ret = clk_set_parent(phy_clk->usb0_hw.clk, parent);
> +	if (ret) {
> +		dev_err(dev, "Failed to set usb0 parent clock to %s\n",
> +			parent_name);
> +		return ret;
> +	}
> +
> +	clk_hw_register_clkdev(&phy_clk->usb0_hw, NULL, "da8xx-cfgchip-clk");
> +
> +	parent_name = pdata->usb1_use_refclkin ? "usb_refclkin" : "usb0_phy_clk";
> +	parent = devm_clk_get(dev, parent_name);
> +	if (IS_ERR(parent)) {
> +		dev_err(dev, "Failed to get usb1 parent clock %s\n",
> +			parent_name);
> +		return PTR_ERR(parent);
> +	}
> +
> +	ret = clk_set_parent(phy_clk->usb1_hw.clk, parent);
> +	if (ret) {
> +		dev_err(dev, "Failed to set usb1 parent clock to %s\n",
> +			parent_name);
> +		return ret;
> +	}
> +
> +	clk_hw_register_clkdev(&phy_clk->usb0_hw, "usb20_phy", "da8xx-usb-phy");
> +	clk_hw_register_clkdev(&phy_clk->usb1_hw, "usb11_phy", "da8xx-usb-phy");
> +
> +	return 0;
> +}
> +
> +static struct platform_driver da8xx_cfgchip_clk_driver = {
> +	.probe = da8xx_cfgchip_clk_probe,
> +	.driver = {
> +		.name = "da8xx-cfgchip-clk",
> +	},
> +};
> +module_platform_driver(da8xx_cfgchip_clk_driver);
> +
> +MODULE_ALIAS("platform:da8xx-cfgchip-clk");
> +MODULE_AUTHOR("David Lechner <david@lechnology.com>");
> +MODULE_DESCRIPTION("TI DA8xx CFGCHIP clock driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
> new file mode 100644
> index 0000000..035cd91
> --- /dev/null
> +++ b/drivers/clk/davinci/pll.c
> @@ -0,0 +1,333 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PLL clock driver for Davinci devices
> + *
> + * Copyright (C) 2017 David Lechner <david@lechnology.com>
> + *
> + * Based on drivers/clk/keystone/pll.c
> + * Copyright (C) 2013 Texas Instruments Inc.
> + *	Murali Karicheri <m-karicheri2@ti.com>
> + *	Santosh Shilimkar <santosh.shilimkar@ti.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +
> +#define REVID		0x000
> +#define PLLCTL		0x100
> +#define OCSEL		0x104
> +#define PLLSECCTL	0x108
> +#define PLLM		0x110
> +#define PREDIV		0x114
> +#define PLLDIV1		0x118
> +#define PLLDIV2		0x11c
> +#define PLLDIV3		0x120
> +#define OSCDIV		0x124
> +#define POSTDIV		0x128
> +#define BPDIV		0x12c
> +#define PLLCMD		0x138
> +#define PLLSTAT		0x13c
> +#define ALNCTL		0x140
> +#define DCHANGE		0x144
> +#define CKEN		0x148
> +#define CKSTAT		0x14c
> +#define SYSTAT		0x150
> +#define PLLDIV4		0x160
> +#define PLLDIV5		0x164
> +#define PLLDIV6		0x168
> +#define PLLDIV7		0x16c
> +#define PLLDIV8		0x170
> +#define PLLDIV9		0x174
> +
> +#define PLLM_MASK		0x1f
> +#define PREDIV_RATIO_MASK	0x1f
> +#define PLLDIV_RATIO_WIDTH	5
> +#define PLLDIV_ENABLE_SHIFT	15
> +#define OSCDIV_RATIO_WIDTH	5
> +#define POSTDIV_RATIO_MASK	0x1f
> +#define BPDIV_RATIO_SHIFT	0
> +#define BPDIV_RATIO_WIDTH	5
> +#define CKEN_OBSCLK_SHIFT	1
> +#define CKEN_AUXEN_SHIFT	0
> +
> +/**
> + * struct davinci_pll_clk - Main PLL clock
> + * @hw: clk_hw for the pll
> + * @base: Base memory address
> + * @parent_rate: Saved parent rate used by some child clocks
> + */
> +struct davinci_pll_clk {
> +	struct clk_hw hw;
> +	void __iomem *base;
> +};
> +
> +#define to_davinci_pll_clk(_hw) container_of((_hw), struct davinci_pll_clk, hw)
> +
> +static unsigned long davinci_pll_clk_recalc(struct clk_hw *hw,
> +					    unsigned long parent_rate)
> +{
> +	struct davinci_pll_clk *pll = to_davinci_pll_clk(hw);
> +	unsigned long rate = parent_rate;
> +	u32 prediv, mult, postdiv;
> +
> +	prediv = readl(pll->base + PREDIV) & PREDIV_RATIO_MASK;
> +	mult = readl(pll->base + PLLM) & PLLM_MASK;
> +	postdiv = readl(pll->base + POSTDIV) & POSTDIV_RATIO_MASK;
> +
> +	rate /= prediv + 1;
> +	rate *= mult + 1;
> +	rate /= postdiv + 1;
> +
> +	return rate;
> +}
> +
> +#ifdef CONFIG_DEBUG_FS
> +#include <linux/debugfs.h>
> +
> +#define DEBUG_REG(n)	\
> +{			\
> +	.name	= #n,	\
> +	.offset	= n,	\
> +}
> +
> +static const struct debugfs_reg32 davinci_pll_regs[] = {
> +	DEBUG_REG(REVID),
> +	DEBUG_REG(PLLCTL),
> +	DEBUG_REG(OCSEL),
> +	DEBUG_REG(PLLSECCTL),
> +	DEBUG_REG(PLLM),
> +	DEBUG_REG(PREDIV),
> +	DEBUG_REG(PLLDIV1),
> +	DEBUG_REG(PLLDIV2),
> +	DEBUG_REG(PLLDIV3),
> +	DEBUG_REG(OSCDIV),
> +	DEBUG_REG(POSTDIV),
> +	DEBUG_REG(BPDIV),
> +	DEBUG_REG(PLLCMD),
> +	DEBUG_REG(PLLSTAT),
> +	DEBUG_REG(ALNCTL),
> +	DEBUG_REG(DCHANGE),
> +	DEBUG_REG(CKEN),
> +	DEBUG_REG(CKSTAT),
> +	DEBUG_REG(SYSTAT),
> +	DEBUG_REG(PLLDIV4),
> +	DEBUG_REG(PLLDIV5),
> +	DEBUG_REG(PLLDIV6),
> +	DEBUG_REG(PLLDIV7),
> +	DEBUG_REG(PLLDIV8),
> +	DEBUG_REG(PLLDIV9),
> +};
> +
> +static int davinci_pll_debug_init(struct clk_hw *hw, struct dentry *dentry)
> +{
> +	struct davinci_pll_clk *pll = to_davinci_pll_clk(hw);
> +	struct debugfs_regset32 *regset;
> +	struct dentry *d;
> +
> +	regset = kzalloc(sizeof(regset), GFP_KERNEL);
> +	if (!regset)
> +		return -ENOMEM;
> +
> +	regset->regs = davinci_pll_regs;
> +	regset->nregs = ARRAY_SIZE(davinci_pll_regs);
> +	regset->base = pll->base;
> +
> +	d = debugfs_create_regset32("registers", 0400, dentry, regset);
> +	if (IS_ERR(d)) {
> +		kfree(regset);
> +		return PTR_ERR(d);
> +	}
> +
> +	return 0;
> +}
> +#else
> +#define davinci_pll_debug_init NULL
> +#endif
> +
> +static const struct clk_ops davinci_pll_clk_ops = {
> +	.recalc_rate	= davinci_pll_clk_recalc,
> +	.debug_init	= davinci_pll_debug_init,
> +};
> +
> +/**
> + * davinci_pll_clk_register - Register a PLL clock
> + * @name: The clock name
> + * @parent_name: The parent clock name
> + * @base: The PLL's memory region
> + */
> +struct clk *davinci_pll_clk_register(const char *name,
> +				     const char *parent_name,
> +				     void __iomem *base)
> +{
> +	struct clk_init_data init;
> +	struct davinci_pll_clk *pll;
> +	struct clk *clk;
> +
> +	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
> +	if (!pll)
> +		return ERR_PTR(-ENOMEM);
> +
> +	init.name = name;
> +	init.ops = &davinci_pll_clk_ops;
> +	init.parent_names = (parent_name ? &parent_name : NULL);
> +	init.num_parents = (parent_name ? 1 : 0);
> +
> +	pll->base = base;
> +	pll->hw.init = &init;
> +
> +	clk = clk_register(NULL, &pll->hw);
> +	if (IS_ERR(clk))
> +		kfree(pll);
> +
> +	return clk;
> +}
> +
> +struct davinci_pll_aux_clk {
> +	struct clk_hw hw;
> +	struct davinci_pll_clk *pll;
> +};
> +
> +/**
> + * davinci_pll_aux_clk_register - Register bypass clock (AUXCLK)
> + * @name: The clock name
> + * @parent_name: The parent clock name (usually "ref_clk" since this bypasses
> + *               the PLL)
> + * @base: The PLL memory region
> + */
> +struct clk *davinci_pll_aux_clk_register(const char *name,
> +					 const char *parent_name,
> +					 void __iomem *base)
> +{
> +	return clk_register_gate(NULL, name, parent_name, 0, base + CKEN,
> +				 CKEN_AUXEN_SHIFT, 0, NULL);
> +}
> +
> +/**
> + * davinci_pll_bpdiv_clk_register - Register bypass divider clock (SYSCLKBP)
> + * @name: The clock name
> + * @parent_name: The parent clock name (usually "ref_clk" since this bypasses
> + *               the PLL)
> + * @base: The PLL memory region
> + */
> +struct clk *davinci_pll_bpdiv_clk_register(const char *name,
> +					   const char *parent_name,
> +					   void __iomem *base)
> +{
> +	return clk_register_divider(NULL, name, parent_name, 0, base + BPDIV,
> +				    BPDIV_RATIO_SHIFT, BPDIV_RATIO_WIDTH,
> +				    CLK_DIVIDER_READ_ONLY, NULL);
> +}
> +
> +/**
> + * davinci_pll_obs_clk_register - Register oscillator divider clock (OBSCLK)
> + * @name: The clock name
> + * @parent_names: The parent clock names
> + * @num_parents: The number of paren clocks
> + * @base: The PLL memory region
> + * @table: A table of values cooresponding to the parent clocks (see OCSEL
> + *         register in SRM for values)
> + */
> +struct clk *davinci_pll_obs_clk_register(const char *name,
> +					 const char * const *parent_names,
> +					 u8 num_parents,
> +					 void __iomem *base,
> +					 u32 *table)
> +{
> +	struct clk_mux *mux;
> +	struct clk_gate *gate;
> +	struct clk_divider *divider;
> +	struct clk *clk;
> +
> +	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
> +	if (!mux)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mux->reg = base + OCSEL;
> +	mux->table = table;
> +
> +	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
> +	if (!gate) {
> +		kfree(mux);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	gate->reg = base + CKEN;
> +	gate->bit_idx = CKEN_OBSCLK_SHIFT;
> +
> +	divider = kzalloc(sizeof(*divider), GFP_KERNEL);
> +	if (!divider) {
> +		kfree(gate);
> +		kfree(mux);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	divider->reg = base + OSCDIV;
> +	divider->width = OSCDIV_RATIO_WIDTH;
> +
> +	clk = clk_register_composite(NULL, name, parent_names, num_parents,
> +				     &mux->hw, &clk_mux_ops,
> +				     &divider->hw, &clk_divider_ops,
> +				     &gate->hw, &clk_gate_ops, 0);
> +	if (IS_ERR(clk)) {
> +		kfree(divider);
> +		kfree(gate);
> +		kfree(mux);
> +	}
> +
> +	return clk;
> +}
> +
> +/**
> + * davinci_pll_div_clk_register - Register a PLLDIV (SYSCLK) clock
> + * @name: The clock name
> + * @parent_name: The parent clock name
> + * @base: The PLL memory region
> + * @id: The id of the divider (n in PLLDIVn)
> + */
> +struct clk *davinci_pll_div_clk_register(const char *name,
> +					 const char *parent_name,
> +					 void __iomem *base,
> +					 u32 id)
> +{
> +	const char * const *parent_names = (parent_name ? &parent_name : NULL);
> +	int num_parents = (parent_name ? 1 : 0);
> +	struct clk_gate *gate;
> +	struct clk_divider *divider;
> +	struct clk *clk;
> +	u32 reg;
> +
> +	/* PLLDIVn registers are not entirely consecutive */
> +	if (id < 4)
> +		reg = PLLDIV1 + 4 * (id - 1);
> +	else
> +		reg = PLLDIV4 + 4 * (id - 4);
> +
> +	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
> +	if (!gate)
> +		return ERR_PTR(-ENOMEM);
> +
> +	gate->reg = base + reg;
> +	gate->bit_idx = PLLDIV_ENABLE_SHIFT;
> +
> +	divider = kzalloc(sizeof(*divider), GFP_KERNEL);
> +	if (!divider) {
> +		kfree(gate);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	divider->reg = base + reg;
> +	divider->width = PLLDIV_RATIO_WIDTH;
> +	divider->flags = CLK_DIVIDER_READ_ONLY;
> +
> +	clk = clk_register_composite(NULL, name, parent_names, num_parents,
> +				     NULL, NULL, &divider->hw, &clk_divider_ops,
> +				     &gate->hw, &clk_gate_ops, 0);
> +	if (IS_ERR(clk)) {
> +		kfree(divider);
> +		kfree(gate);
> +	}
> +
> +	return clk;
> +}
> diff --git a/drivers/clk/davinci/psc.c b/drivers/clk/davinci/psc.c
> new file mode 100644
> index 0000000..8ae85ee
> --- /dev/null
> +++ b/drivers/clk/davinci/psc.c
> @@ -0,0 +1,217 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Clock driver for DA8xx/AM17xx/AM18xx/OMAP-L13x PSC controllers
> + *
> + * Copyright (C) 2017 David Lechner <david@lechnology.com>
> + *
> + * Based on: drivers/clk/keystone/gate.c
> + * Copyright (C) 2013 Texas Instruments.
> + *	Murali Karicheri <m-karicheri2@ti.com>
> + *	Santosh Shilimkar <santosh.shilimkar@ti.com>
> + *
> + * And: arch/arm/mach-davinci/psc.c
> + * Copyright (C) 2006 Texas Instruments.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +
> +/* PSC register offsets */
> +#define EPCPR			0x070
> +#define PTCMD			0x120
> +#define PTSTAT			0x128
> +#define PDSTAT			0x200
> +#define PDCTL			0x300
> +#define MDSTAT			0x800
> +#define MDCTL			0xa00
> +
> +/* PSC module states */
> +enum davinci_psc_state {
> +	PSC_STATE_SWRSTDISABLE	= 0,
> +	PSC_STATE_SYNCRST	= 1,
> +	PSC_STATE_DISABLE	= 2,
> +	PSC_STATE_ENABLE	= 3,
> +};
> +
> +#define MDSTAT_STATE_MASK	0x3f
> +#define MDSTAT_MCKOUT		BIT(12)
> +#define PDSTAT_STATE_MASK	0x1f
> +#define MDCTL_FORCE		BIT(31)
> +#define MDCTL_LRESET		BIT(8)
> +#define PDCTL_EPCGOOD		BIT(8)
> +#define PDCTL_NEXT		BIT(0)
> +
> +/**
> + * struct davinci_psc_clk - PSC clock structure
> + * @hw: clk_hw for the psc
> + * @psc_data: PSC driver specific data
> + * @lpsc: Local PSC number (module id)
> + * @pd: Power domain
> + */
> +struct davinci_psc_clk {
> +	struct clk_hw hw;
> +	void __iomem *base;
> +	u32 lpsc;
> +	u32 pd;
> +};
> +
> +#define to_davinci_psc_clk(_hw) container_of(_hw, struct davinci_psc_clk, hw)
> +
> +static void psc_config(struct davinci_psc_clk *psc,
> +		       enum davinci_psc_state next_state)
> +{
> +	u32 epcpr, ptcmd, pdstat, pdctl, mdstat, mdctl, ptstat;
> +
> +	mdctl = readl(psc->base + MDCTL + 4 * psc->lpsc);
> +	mdctl &= ~MDSTAT_STATE_MASK;
> +	mdctl |= next_state;
> +	/* TODO: old davinci clocks for da850 set MDCTL_FORCE bit for sata and
> +	 * dsp here. Is this really needed?
> +	 */
> +	writel(mdctl, psc->base + MDCTL + 4 * psc->lpsc);
> +
> +	pdstat = readl(psc->base + PDSTAT + 4 * psc->pd);
> +	if ((pdstat & PDSTAT_STATE_MASK) == 0) {
> +		pdctl = readl(psc->base + PDSTAT + 4 * psc->pd);
> +		pdctl |= PDCTL_NEXT;
> +		writel(pdctl, psc->base + PDSTAT + 4 * psc->pd);
> +
> +		ptcmd = BIT(psc->pd);
> +		writel(ptcmd, psc->base + PTCMD);
> +
> +		do {
> +			epcpr = __raw_readl(psc->base + EPCPR);
> +		} while (!(epcpr & BIT(psc->pd)));
> +
> +		pdctl = __raw_readl(psc->base + PDCTL + 4 * psc->pd);
> +		pdctl |= PDCTL_EPCGOOD;
> +		__raw_writel(pdctl, psc->base + PDCTL + 4 * psc->pd);
> +	} else {
> +		ptcmd = BIT(psc->pd);
> +		writel(ptcmd, psc->base + PTCMD);
> +	}
> +
> +	do {
> +		ptstat = readl(psc->base + PTSTAT);
> +	} while (ptstat & BIT(psc->pd));
> +
> +	do {
> +		mdstat = readl(psc->base + MDSTAT + 4 * psc->lpsc);
> +	} while (!((mdstat & MDSTAT_STATE_MASK) == next_state));
> +}
> +
> +static int davinci_psc_clk_enable(struct clk_hw *hw)
> +{
> +	struct davinci_psc_clk *psc = to_davinci_psc_clk(hw);
> +
> +	psc_config(psc, PSC_STATE_ENABLE);
> +
> +	return 0;
> +}
> +
> +static void davinci_psc_clk_disable(struct clk_hw *hw)
> +{
> +	struct davinci_psc_clk *psc = to_davinci_psc_clk(hw);
> +
> +	psc_config(psc, PSC_STATE_DISABLE);
> +}
> +
> +static int davinci_psc_clk_is_enabled(struct clk_hw *hw)
> +{
> +	struct davinci_psc_clk *psc = to_davinci_psc_clk(hw);
> +	u32 mdstat;
> +
> +	mdstat = readl(psc->base + MDSTAT + 4 * psc->lpsc);
> +
> +	return (mdstat & MDSTAT_MCKOUT) ? 1 : 0;
> +}
> +
> +static const struct clk_ops davinci_psc_clk_ops = {
> +	.enable		= davinci_psc_clk_enable,
> +	.disable	= davinci_psc_clk_disable,
> +	.is_enabled	= davinci_psc_clk_is_enabled,
> +};
> +
> +/**
> + * davinci_psc_clk_register - register psc clock
> + * @dev: device that is registering this clock
> + * @name: name of this clock
> + * @parent_name: name of clock's parent
> + * @base: memory mapped register for the PSC
> + * @lpsc: local PSC number
> + * @pd: power domain
> + */
> +struct clk *davinci_psc_clk_register(const char *name,
> +				     const char *parent_name,
> +				     void __iomem *base,
> +				     u32 lpsc, u32 pd)
> +{
> +	struct clk_init_data init;
> +	struct davinci_psc_clk *psc;
> +	struct clk *clk;
> +
> +	psc = kzalloc(sizeof(*psc), GFP_KERNEL);
> +	if (!psc)
> +		return ERR_PTR(-ENOMEM);
> +
> +	init.name = name;
> +	init.ops = &davinci_psc_clk_ops;
> +	init.flags = 0;
> +	init.parent_names = (parent_name ? &parent_name : NULL);
> +	init.num_parents = (parent_name ? 1 : 0);
> +
> +	psc->base = base;
> +	psc->hw.init = &init;
> +	psc->lpsc = lpsc;
> +	psc->pd = pd;
> +
> +	clk = clk_register(NULL, &psc->hw);
> +	if (IS_ERR(clk))
> +		kfree(psc);
> +
> +	return clk;
> +}
> +
> +/* FIXME: This needs to be converted to a reset controller. But, the reset
> + * framework is currently device tree only.
> + */
> +
> +DEFINE_SPINLOCK(davinci_psc_reset_lock);
> +
> +static int davinci_psc_clk_reset(struct davinci_psc_clk *psc, bool reset)
> +{
> +	unsigned long flags;
> +	u32 mdctl;
> +
> +	if (IS_ERR_OR_NULL(psc))
> +		return -EINVAL;
> +
> +	spin_lock_irqsave(&davinci_psc_reset_lock, flags);
> +	mdctl = readl(psc->base + MDCTL + 4 * psc->lpsc);
> +	if (reset)
> +		mdctl &= ~MDCTL_LRESET;
> +	else
> +		mdctl |= MDCTL_LRESET;
> +	writel(mdctl, psc->base + MDCTL + 4 * psc->lpsc);
> +	spin_unlock_irqrestore(&davinci_psc_reset_lock, flags);
> +
> +	return 0;
> +}
> +
> +int davinci_clk_reset_assert(struct clk *clk)
> +{
> +	struct davinci_psc_clk *psc = to_davinci_psc_clk(__clk_get_hw(clk));
> +
> +	return davinci_psc_clk_reset(psc, true);
> +}
> +EXPORT_SYMBOL(davinci_clk_reset_assert);
> +
> +int davinci_clk_reset_deassert(struct clk *clk)
> +{
> +	struct davinci_psc_clk *psc = to_davinci_psc_clk(__clk_get_hw(clk));
> +
> +	return davinci_psc_clk_reset(psc, false);
> +}
> +EXPORT_SYMBOL(davinci_clk_reset_deassert);
> diff --git a/include/linux/clk/davinci.h b/include/linux/clk/davinci.h
> new file mode 100644
> index 0000000..c5d2181
> --- /dev/null
> +++ b/include/linux/clk/davinci.h
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TI Davinci clocks
> + *
> + * Copyright (C) 2017 David Lechner <david@lechnology.com>
> + */
> +#ifndef __LINUX_CLK_DAVINCI_H__
> +#define __LINUX_CLK_DAVINCI_H__
> +
> +#include <linux/clk-provider.h>
> +#include <linux/types.h>
> +
> +struct clk *davinci_pll_clk_register(const char *name,
> +				     const char *parent_name,
> +				     void __iomem *base);
> +struct clk *davinci_pll_aux_clk_register(const char *name,
> +					 const char *parent_name,
> +					 void __iomem *base);
> +struct clk *davinci_pll_bpdiv_clk_register(const char *name,
> +					   const char *parent_name,
> +					   void __iomem *base);
> +struct clk *davinci_pll_obs_clk_register(const char *name,
> +					 const char * const *parent_names,
> +					 u8 num_parents,
> +					 void __iomem *base,
> +					 u32 *table);
> +struct clk *davinci_pll_div_clk_register(const char *name,
> +					 const char *parent_name,
> +					 void __iomem *base,
> +					 u32 id);
> +struct clk *davinci_psc_clk_register(const char *name,
> +				     const char *parent_name,
> +				     void __iomem *base,
> +				     u32 lpsc, u32 pd);
> +
> +/* convience macros for board declaration files */
> +#define EXT_CLK(n, r) clk_register_fixed_rate(NULL, (n), NULL, 0, (r))
> +#define FIX_CLK(n, p) clk_register_fixed_factor(NULL, (n), (p), 0, 1, 1)
> +#define PLL_CLK davinci_pll_clk_register
> +#define PLL_DIV_CLK davinci_pll_div_clk_register
> +#define PLL_AUX_CLK davinci_pll_aux_clk_register
> +#define PLL_BP_CLK davinci_pll_bpdiv_clk_register
> +#define PLL_OBS_CLK davinci_pll_obs_clk_register
> +#define PSC_CLK davinci_psc_clk_register
> +
> +#endif /* __LINUX_CLK_DAVINCI_H__ */
> diff --git a/include/linux/platform_data/davinci_clk.h b/include/linux/platform_data/davinci_clk.h
> new file mode 100644
> index 0000000..7576ace
> --- /dev/null
> +++ b/include/linux/platform_data/davinci_clk.h
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TI DaVinci Clock support
> + *
> + * Copyright (C) 2017 David Lechner <david@lechnology.com>
> + */
> +
> +#ifndef __PLATFORM_DATA_DAVINCI_CLK_H
> +#define __PLATFORM_DATA_DAVINCI_CLK_H
> +
> +#include <linux/types.h>
> +
> +/**
> + * da8xx_cfgchip_clk_data - DA8xx CFGCHIP clock platform data
> + * @usb0_use_refclkin: when true, use USB_REFCLKIN, otherwise use AUXCLK for
> + *                     USB 2.0 PHY clock
> + * @usb1_use_refclkin: when true, use USB_REFCLKIN, otherwise use USB 2.0 PHY
> + *                     PLL for USB 1.1 PHY clock
> + */
> +struct da8xx_cfgchip_clk_data {
> +	bool usb0_use_refclkin;
> +	bool usb1_use_refclkin;
> +};
> +
> +#endif /* __PLATFORM_DATA_DAVINCI_CLK_H */
> 
