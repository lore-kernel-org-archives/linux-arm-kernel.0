From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 4 May 2017 14:50:55 +0200
Subject: [PATCH v6 02/13] clk: sunxi-ng: add support for DE2 CCU
In-Reply-To: <20170504114858.9008-3-icenowy@aosc.io>
References: <20170504114858.9008-1-icenowy@aosc.io>
 <20170504114858.9008-3-icenowy@aosc.io>
Message-ID: <20170504125055.uvcl4ov4bxzis4um@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 04, 2017 at 07:48:47PM +0800, Icenowy Zheng wrote:
> The "Display Engine 2.0" in Allwinner newer SoCs contains a clock
> management unit for its subunits, like the DE CCU in A80.
> 
> Add a sunxi-ng style driver for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v5:
> - Removed dt-bindings headers (they're now in patch 1).
> Changes in v4:
> - Fixed the inconsistence between mixer_div clocks' number and real clock.
> Changes in v2:
> - Rename sunxi-de2-ccu to sun8i-de2-ccu.
> 
>  drivers/clk/sunxi-ng/Kconfig         |   5 +
>  drivers/clk/sunxi-ng/Makefile        |   1 +
>  drivers/clk/sunxi-ng/ccu-sun8i-de2.c | 218 +++++++++++++++++++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu-sun8i-de2.h |  28 +++++
>  4 files changed, 252 insertions(+)
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-de2.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-de2.h
> 
> diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
> index 64088e599404..2e4d804fbf61 100644
> --- a/drivers/clk/sunxi-ng/Kconfig
> +++ b/drivers/clk/sunxi-ng/Kconfig
> @@ -140,6 +140,11 @@ config SUN8I_V3S_CCU
>  	default MACH_SUN8I
>  	depends on MACH_SUN8I || COMPILE_TEST
>  
> +config SUN8I_DE2_CCU
> +	bool "Support for the Allwinner SoCs DE2 CCU"
> +	select SUNXI_CCU_DIV
> +	select SUNXI_CCU_GATE
> +
>  config SUN9I_A80_CCU
>  	bool "Support for the Allwinner A80 CCU"
>  	select SUNXI_CCU_DIV
> diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> index 0ec02fe14c50..be616279450e 100644
> --- a/drivers/clk/sunxi-ng/Makefile
> +++ b/drivers/clk/sunxi-ng/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_SUN8I_A23_CCU)	+= ccu-sun8i-a23.o
>  obj-$(CONFIG_SUN8I_A33_CCU)	+= ccu-sun8i-a33.o
>  obj-$(CONFIG_SUN8I_H3_CCU)	+= ccu-sun8i-h3.o
>  obj-$(CONFIG_SUN8I_V3S_CCU)	+= ccu-sun8i-v3s.o
> +obj-$(CONFIG_SUN8I_DE2_CCU)	+= ccu-sun8i-de2.o
>  obj-$(CONFIG_SUN8I_R_CCU)	+= ccu-sun8i-r.o
>  obj-$(CONFIG_SUN9I_A80_CCU)	+= ccu-sun9i-a80.o
>  obj-$(CONFIG_SUN9I_A80_CCU)	+= ccu-sun9i-a80-de.o
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
> new file mode 100644
> index 000000000000..adb2c344692a
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
> @@ -0,0 +1,218 @@
> +/*
> + * Copyright (c) 2017 Icenowy Zheng <icenowy@aosc.io>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +
> +#include "ccu_common.h"
> +#include "ccu_div.h"
> +#include "ccu_gate.h"
> +#include "ccu_reset.h"
> +
> +#include "ccu-sun8i-de2.h"
> +
> +static SUNXI_CCU_GATE(bus_mixer0_clk,	"bus-mixer0",	"bus-de",
> +		      0x04, BIT(0), 0);
> +static SUNXI_CCU_GATE(bus_mixer1_clk,	"bus-mixer1",	"bus-de",
> +		      0x04, BIT(1), 0);
> +static SUNXI_CCU_GATE(bus_wb_clk,	"bus-wb",	"bus-de",
> +		      0x04, BIT(2), 0);
> +
> +static SUNXI_CCU_GATE(mixer0_clk,	"mixer0",	"mixer0-div",
> +		      0x00, BIT(0), CLK_SET_RATE_PARENT);
> +static SUNXI_CCU_GATE(mixer1_clk,	"mixer1",	"mixer1-div",
> +		      0x00, BIT(1), CLK_SET_RATE_PARENT);
> +static SUNXI_CCU_GATE(wb_clk,		"wb",		"wb-div",
> +		      0x00, BIT(2), CLK_SET_RATE_PARENT);
> +
> +static SUNXI_CCU_M(mixer0_div_clk, "mixer0-div", "de", 0x0c, 0, 4,
> +		   CLK_SET_RATE_PARENT);
> +static SUNXI_CCU_M(mixer1_div_clk, "mixer1-div", "de", 0x0c, 4, 4,
> +		   CLK_SET_RATE_PARENT);
> +static SUNXI_CCU_M(wb_div_clk, "wb-div", "de", 0x0c, 8, 4,
> +		   CLK_SET_RATE_PARENT);
> +
> +static struct ccu_common *sunxi_de2_clks[] = {
> +	&mixer0_clk.common,
> +	&mixer1_clk.common,
> +	&wb_clk.common,
> +
> +	&bus_mixer0_clk.common,
> +	&bus_mixer1_clk.common,
> +	&bus_wb_clk.common,
> +
> +	&mixer0_div_clk.common,
> +	&mixer1_div_clk.common,
> +	&wb_div_clk.common,
> +};
> +
> +static struct clk_hw_onecell_data sunxi_de2_hw_clks = {
> +	.hws	= {
> +		[CLK_MIXER0]		= &mixer0_clk.common.hw,
> +		[CLK_MIXER1]		= &mixer1_clk.common.hw,
> +		[CLK_WB]		= &wb_clk.common.hw,
> +
> +		[CLK_BUS_MIXER0]	= &bus_mixer0_clk.common.hw,
> +		[CLK_BUS_MIXER1]	= &bus_mixer1_clk.common.hw,
> +		[CLK_BUS_WB]		= &bus_wb_clk.common.hw,
> +
> +		[CLK_MIXER0_DIV]	= &mixer0_div_clk.common.hw,
> +		[CLK_MIXER1_DIV]	= &mixer1_div_clk.common.hw,
> +		[CLK_WB_DIV]		= &wb_div_clk.common.hw,
> +	},
> +	.num	= CLK_NUMBER,
> +};
> +
> +static struct ccu_reset_map sun8i_a83t_de2_resets[] = {
> +	[RST_MIXER0]	= { 0x08, BIT(0) },
> +	/*
> +	 * For A83T, H3 and R40, mixer1 reset line is shared with wb, so
> +	 * only RST_WB is exported here.
> +	 */
> +	[RST_WB]	= { 0x08, BIT(2) },
> +};
> +
> +static struct ccu_reset_map sun50i_a64_de2_resets[] = {
> +	[RST_MIXER0]	= { 0x08, BIT(0) },
> +	[RST_MIXER1]	= { 0x08, BIT(1) },
> +	[RST_WB]	= { 0x08, BIT(2) },
> +};
> +
> +static const struct sunxi_ccu_desc sun8i_a83t_de2_clk_desc = {
> +	.ccu_clks	= sunxi_de2_clks,
> +	.num_ccu_clks	= ARRAY_SIZE(sunxi_de2_clks),
> +
> +	.hw_clks	= &sunxi_de2_hw_clks,
> +
> +	.resets		= sun8i_a83t_de2_resets,
> +	.num_resets	= ARRAY_SIZE(sun8i_a83t_de2_resets),
> +};
> +
> +static const struct sunxi_ccu_desc sun50i_a64_de2_clk_desc = {
> +	.ccu_clks	= sunxi_de2_clks,
> +	.num_ccu_clks	= ARRAY_SIZE(sunxi_de2_clks),
> +
> +	.hw_clks	= &sunxi_de2_hw_clks,
> +
> +	.resets		= sun50i_a64_de2_resets,
> +	.num_resets	= ARRAY_SIZE(sun50i_a64_de2_resets),
> +};
> +
> +static int sunxi_de2_clk_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct clk *bus_clk, *mod_clk;
> +	struct reset_control *rstc;
> +	void __iomem *reg;
> +	const struct sunxi_ccu_desc *ccu_desc;
> +	int ret;
> +
> +	ccu_desc = of_device_get_match_data(&pdev->dev);
> +	if (!ccu_desc)
> +		return -EINVAL;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	reg = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(reg))
> +		return PTR_ERR(reg);
> +
> +	bus_clk = devm_clk_get(&pdev->dev, "bus");
> +	if (IS_ERR(bus_clk)) {
> +		ret = PTR_ERR(bus_clk);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "Couldn't get bus clk: %d\n", ret);
> +		return ret;
> +	}
> +
> +	mod_clk = devm_clk_get(&pdev->dev, "mod");
> +	if (IS_ERR(mod_clk)) {
> +		ret = PTR_ERR(mod_clk);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "Couldn't get mod clk: %d\n", ret);
> +		return ret;
> +	}
> +
> +	rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> +	if (IS_ERR(rstc)) {
> +		ret = PTR_ERR(bus_clk);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&pdev->dev,
> +				"Couldn't get reset control: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* The clocks need to be enabled for us to access the registers */
> +	ret = clk_prepare_enable(bus_clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Couldn't enable bus clk: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(mod_clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Couldn't enable mod clk: %d\n", ret);
> +		return ret;

You're leaving the bus clock enabled here if it fails.

> +	}
> +
> +	/* The reset control needs to be asserted for the controls to work */
> +	ret = reset_control_deassert(rstc);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"Couldn't deassert reset control: %d\n", ret);
> +		goto err_disable_clk;
> +	}
> +
> +	ret = sunxi_ccu_probe(pdev->dev.of_node, reg, ccu_desc);
> +	if (ret)
> +		goto err_assert_reset;
> +
> +	return 0;
> +
> +err_assert_reset:
> +	reset_control_assert(rstc);

And here you're leaving the mod_clk enabled

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170504/753c7810/attachment-0001.sig>
