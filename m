From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 19 Jan 2015 22:57:34 +0100
Subject: [PATCH v4 2/9] clk: sunxi: Add driver for A80 MMC config
 clocks/resets
In-Reply-To: <1421471974-32719-3-git-send-email-wens@csie.org>
References: <1421471974-32719-1-git-send-email-wens@csie.org>
 <1421471974-32719-3-git-send-email-wens@csie.org>
Message-ID: <20150119215734.GL4367@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jan 17, 2015 at 01:19:27PM +0800, Chen-Yu Tsai wrote:
> On the A80 SoC, the 4 mmc controllers each have a separate register
> controlling their register access clocks and reset controls. These
> registers in turn share a ahb clock gate and reset control.
> 
> This patch adds a platform device driver for these controls. It
> requires both clocks and reset controls to be available, so using
> CLK_OF_DECLARE might not be the best way.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt |  25 ++-
>  drivers/clk/sunxi/Makefile                        |   1 +
>  drivers/clk/sunxi/clk-sun9i-mmc.c                 | 222 ++++++++++++++++++++++
>  3 files changed, 247 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/sunxi/clk-sun9i-mmc.c
> 
> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> index 0dfd018ba47b..60b44285250d 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> @@ -57,6 +57,7 @@ Required properties:
>  	"allwinner,sun5i-a13-mbus-clk" - for the MBUS clock on A13
>  	"allwinner,sun4i-a10-mmc-clk" - for the MMC clock
>  	"allwinner,sun9i-a80-mmc-clk" - for mmc module clocks on A80
> +	"allwinner,sun9i-a80-mmc-config-clk" - for mmc gates + resets on A80
>  	"allwinner,sun4i-a10-mod0-clk" - for the module 0 family of clocks
>  	"allwinner,sun9i-a80-mod0-clk" - for module 0 (storage) clocks on A80
>  	"allwinner,sun8i-a23-mbus-clk" - for the MBUS clock on A23
> @@ -75,7 +76,8 @@ Required properties for all clocks:
>  	the following compatibles where it shall be set to 1:
>  	"allwinner,*-gates-clk", "allwinner,sun4i-pll5-clk",
>  	"allwinner,sun4i-pll6-clk", "allwinner,sun6i-a31-pll6-clk",
> -	"allwinner,*-usb-clk", "allwinner,*-mmc-clk"
> +	"allwinner,*-usb-clk", "allwinner,*-mmc-clk",
> +	"allwinner,*-mmc-config-clk"
>  - clock-output-names : shall be the corresponding names of the outputs.
>  	If the clock module only has one output, the name shall be the
>  	module name.
> @@ -83,6 +85,10 @@ Required properties for all clocks:
>  And "allwinner,*-usb-clk" clocks also require:
>  - reset-cells : shall be set to 1
>  
> +The "allwinner,sun9i-a80-mmc-config-clk" clock also requires:
> +- #reset-cells : shall be set to 1
> +- resets : shall be the reset control phandle for the mmc block.
> +
>  For "allwinner,sun7i-a20-gmac-clk", the parent clocks shall be fixed rate
>  dummy clocks at 25 MHz and 125 MHz, respectively. See example.
>  
> @@ -101,6 +107,10 @@ The "allwinner,*-mmc-clk" clocks have three different outputs: the
>  main clock, with the ID 0, and the output and sample clocks, with the
>  IDs 1 and 2, respectively.
>  
> +The "allwinner,sun9i-a80-mmc-config-clk" clock has one clock/reset output
> +per mmc controller. The number of outputs is determined by the size of
> +the address block, which is related to the overall mmc block.
> +
>  For example:
>  
>  osc24M: clk at 01c20050 {
> @@ -176,3 +186,16 @@ gmac_clk: clk at 01c20164 {
>  	clocks = <&mii_phy_tx_clk>, <&gmac_int_tx_clk>;
>  	clock-output-names = "gmac";
>  };
> +
> +mmc_config_clk: clk at 01c13000 {
> +	compatible = "allwinner,sun9i-a80-mmc-config-clk";
> +	reg = <0x01c13000 0x10>;
> +	clocks = <&ahb0_gates 8>;
> +	clock-names = "ahb";
> +	resets = <&ahb0_resets 8>;
> +	reset-names = "ahb";
> +	#clock-cells = <1>;
> +	#reset-cells = <1>;
> +	clock-output-names = "mmc0_config", "mmc1_config",
> +			     "mmc2_config", "mmc3_config";
> +};
> diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
> index a66953c0f430..3a5292e3fcf8 100644
> --- a/drivers/clk/sunxi/Makefile
> +++ b/drivers/clk/sunxi/Makefile
> @@ -8,6 +8,7 @@ obj-y += clk-a20-gmac.o
>  obj-y += clk-mod0.o
>  obj-y += clk-sun8i-mbus.o
>  obj-y += clk-sun9i-core.o
> +obj-y += clk-sun9i-mmc.o
>  
>  obj-$(CONFIG_MFD_SUN6I_PRCM) += \
>  	clk-sun6i-ar100.o clk-sun6i-apb0.o clk-sun6i-apb0-gates.o \
> diff --git a/drivers/clk/sunxi/clk-sun9i-mmc.c b/drivers/clk/sunxi/clk-sun9i-mmc.c
> new file mode 100644
> index 000000000000..aeb3a52e0a9f
> --- /dev/null
> +++ b/drivers/clk/sunxi/clk-sun9i-mmc.c
> @@ -0,0 +1,222 @@
> +/*
> + * Copyright 2013 Chen-Yu Tsai
> + *
> + * Chen-Yu Tsai	<wens@csie.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/reset.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +#include <linux/spinlock.h>
> +
> +#define SUN9I_MMC_WIDTH		4
> +
> +#define SUN9I_MMC_GATE_BIT	16
> +#define SUN9I_MMC_RESET_BIT	18
> +
> +struct sun9i_mmc_clk_data {
> +	spinlock_t			lock;
> +	void __iomem			*membase;
> +	struct clk			*clk;
> +	struct reset_control		*reset;
> +	struct clk_onecell_data		clk_data;
> +	struct reset_controller_dev	rcdev;
> +};
> +
> +static int sun9i_mmc_reset_assert(struct reset_controller_dev *rcdev,
> +			      unsigned long id)
> +{
> +	struct sun9i_mmc_clk_data *data = container_of(rcdev,
> +						       struct sun9i_mmc_clk_data,
> +						       rcdev);
> +	unsigned long flags;
> +	void __iomem *reg = data->membase + SUN9I_MMC_WIDTH * id;
> +	u32 val;
> +
> +	clk_prepare_enable(data->clk);
> +	spin_lock_irqsave(&data->lock, flags);
> +
> +	val = readl(reg);
> +	writel(val & ~BIT(SUN9I_MMC_RESET_BIT), reg);
> +
> +	spin_unlock_irqrestore(&data->lock, flags);
> +	clk_disable_unprepare(data->clk);
> +
> +	return 0;
> +}
> +
> +static int sun9i_mmc_reset_deassert(struct reset_controller_dev *rcdev,
> +				unsigned long id)
> +{
> +	struct sun9i_mmc_clk_data *data = container_of(rcdev,
> +						       struct sun9i_mmc_clk_data,
> +						       rcdev);
> +	unsigned long flags;
> +	void __iomem *reg = data->membase + SUN9I_MMC_WIDTH * id;
> +	u32 val;
> +
> +	clk_prepare_enable(data->clk);
> +	spin_lock_irqsave(&data->lock, flags);
> +
> +	val = readl(reg);
> +	writel(val | BIT(SUN9I_MMC_RESET_BIT), reg);
> +
> +	spin_unlock_irqrestore(&data->lock, flags);
> +	clk_disable_unprepare(data->clk);
> +
> +	return 0;
> +}
> +
> +static struct reset_control_ops sun9i_mmc_reset_ops = {
> +	.assert		= sun9i_mmc_reset_assert,
> +	.deassert	= sun9i_mmc_reset_deassert,
> +};
> +
> +static int sun9i_a80_mmc_config_clk_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct sun9i_mmc_clk_data *data;
> +	struct clk_onecell_data *clk_data;
> +	const char *clk_name = np->name;
> +	const char *clk_parent;
> +	struct resource *r;
> +	int count, i, ret;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&data->lock);
> +
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	/* one clock/reset pair per word */
> +	count = DIV_ROUND_UP((r->end - r->start + 1), SUN9I_MMC_WIDTH);
> +	data->membase = devm_ioremap_resource(&pdev->dev, r);
> +	if (IS_ERR(data->membase))
> +		return PTR_ERR(data->membase);
> +
> +	clk_data = &data->clk_data;
> +	clk_data->clk_num = count;
> +	clk_data->clks = devm_kcalloc(&pdev->dev, count, sizeof(struct clk *),
> +				      GFP_KERNEL);
> +	if (!clk_data->clks)
> +		return -ENOMEM;
> +
> +	clk_parent = of_clk_get_parent_name(np, 0);
> +	if (!clk_parent)
> +		return -EINVAL;
> +
> +	data->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(data->clk)) {
> +		dev_err(&pdev->dev, "Could not get clock\n");
> +		return PTR_ERR(data->clk);
> +	}

I'm wondering, why are you using of_clk_get_parent_name here, instead
of __clk_get_name on data->clk? That would avoid parsing the DT while
we already have that info.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150119/eb5298d0/attachment-0001.sig>
