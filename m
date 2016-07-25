From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 25 Jul 2016 13:14:43 +0200
Subject: [RFC 6/6] bus: Add support for Tegra NOR controller
In-Reply-To: <1468935397-11926-7-git-send-email-mirza.krak@gmail.com>
References: <1468935397-11926-1-git-send-email-mirza.krak@gmail.com>
 <1468935397-11926-7-git-send-email-mirza.krak@gmail.com>
Message-ID: <20160725111443.GB21170@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2016 at 03:36:37PM +0200, Mirza Krak wrote:
> From: Mirza Krak <mirza.krak@gmail.com>
> 
> The NOR bus can be used to connect high-speed devices such as NOR flash,
> FPGAs, DSPs, CAN chips, Wi-Fi chips etc.
> 
> Signed-off-by: Mirza Krak <mirza.krak@gmail.com>
> ---
>  drivers/bus/Kconfig     |   7 +++
>  drivers/bus/Makefile    |   1 +
>  drivers/bus/tegra-nor.c | 118 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 126 insertions(+)
>  create mode 100644 drivers/bus/tegra-nor.c
> 
> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> index 3b205e2..b74be7d8 100644
> --- a/drivers/bus/Kconfig
> +++ b/drivers/bus/Kconfig
> @@ -145,6 +145,13 @@ config TEGRA_ACONNECT
>  	  Driver for the Tegra ACONNECT bus which is used to interface with
>  	  the devices inside the Audio Processing Engine (APE) for Tegra210.
> 
> +config TEGRA_NOR
> +	tristate "Nvidia Tegra NOR flash bus driver a.k.a GMI/SNOR"
> +		depends on ARCH_TEGRA_2x_SOC || ARCH_TEGRA_3x_SOC

I think an ARCH_TEGRA dependency is enough here.

> +		depends on OF

You can drop this because Tegra has been OF-only for a long time now.

> +		help
> +			Driver for NOR flash bus found on Tegra30/20 SOC`s.

Maybe make this "Driver for GMI controller found on NVIDIA Tegra SoCs."
or similar in light of the name change.

>  config UNIPHIER_SYSTEM_BUS
>  	tristate "UniPhier System Bus driver"
>  	depends on ARCH_UNIPHIER && OF
> diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
> index ac84cc4..46d0129 100644
> --- a/drivers/bus/Makefile
> +++ b/drivers/bus/Makefile
> @@ -18,5 +18,6 @@ obj-$(CONFIG_OMAP_OCP2SCP)	+= omap-ocp2scp.o
>  obj-$(CONFIG_SUNXI_RSB)		+= sunxi-rsb.o
>  obj-$(CONFIG_SIMPLE_PM_BUS)	+= simple-pm-bus.o
>  obj-$(CONFIG_TEGRA_ACONNECT)	+= tegra-aconnect.o
> +obj-$(CONFIG_TEGRA_NOR)		+= tegra-nor.o
>  obj-$(CONFIG_UNIPHIER_SYSTEM_BUS)	+= uniphier-system-bus.o
>  obj-$(CONFIG_VEXPRESS_CONFIG)	+= vexpress-config.o
> diff --git a/drivers/bus/tegra-nor.c b/drivers/bus/tegra-nor.c
> new file mode 100644
> index 0000000..1e48113
> --- /dev/null
> +++ b/drivers/bus/tegra-nor.c
> @@ -0,0 +1,118 @@
> +/*
> + * Driver for Nvidia NOR Flash bus a.k.a SNOR/GMI.

Nit: I encourage the use of "NVIDIA" as spelling for consistency.

> + *
> + * Copyright (C) 2016 Host Mobility AB. All rights reserved.
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +
> +#define TEGRA_NOR_TIMING_REG_COUNT	2
> +
> +#define TEGRA_NOR_CONFIG			0x00
> +#define TEGRA_NOR_STATUS			0x04
> +#define TEGRA_NOR_ADDR_PTR			0x08
> +#define TEGRA_NOR_AHB_ADDR_PTR		0x0c
> +#define TEGRA_NOR_TIMING0			0x10
> +#define TEGRA_NOR_TIMING1			0x14
> +#define TEGRA_NOR_MIO_CONFIG		0x18
> +#define TEGRA_NOR_MIO_TIMING		0x1c
> +#define TEGRA_NOR_DMA_CONFIG		0x20
> +#define TEGRA_NOR_CS_MUX_CONFIG		0x24
> +
> +#define TEGRA_NOR_CONFIG_GO				BIT(31)
> +
> +static const struct of_device_id nor_id_table[] = {
> +	/* Tegra30 */
> +	{ .compatible = "nvidia,tegra30-nor", .data = NULL, },
> +	/* Tegra20 */
> +	{ .compatible = "nvidia,tegra20-nor", .data = NULL, },
> +
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, nor_id_table);
> +
> +
> +static int __init nor_parse_dt(struct platform_device *pdev,
> +				void __iomem *base)
> +{
> +	struct device_node *of_node = pdev->dev.of_node;
> +	u32 config, timing[TEGRA_NOR_TIMING_REG_COUNT];
> +	int ret;
> +
> +	ret = of_property_read_u32_array(of_node, "nvidia,cs-timing",
> +					 timing, TEGRA_NOR_TIMING_REG_COUNT);
> +	if (!ret) {
> +		writel(timing[0], base + TEGRA_NOR_TIMING0);
> +		writel(timing[1], base + TEGRA_NOR_TIMING1);
> +	}
> +
> +	ret = of_property_read_u32(of_node, "nvidia,config", &config);
> +	if (ret)
> +		return ret;
> +
> +	config |= TEGRA_NOR_CONFIG_GO;
> +	writel(config, base + TEGRA_NOR_CONFIG);

My preference would be for the tegra_gmi_parse_dt() function not to do
any register programming. Instead I think it would be better to store
any of the parameters inside a struct tegra_gmi and do the programming
from within tegra_gmi_probe() (or via an other function such as
tegra_gmi_initialize(), called from tegra_gmi_probe()).

The reason is that you'll most likely want to do this programming when
you resume from suspend, and you could reuse tegra_gmi_initialize() to
do that.

> +
> +	if (of_get_child_count(of_node))
> +		ret = of_platform_populate(of_node,
> +				   of_default_bus_match_table,
> +				   NULL, &pdev->dev);

Why the extra check? of_platform_populate() is almost a no-op if there
aren't any children anyway. What it will do is set the OF_POPULATED_BUS
flag, but I think we want that irrespective of whether or not there are
any children.

Was there any problem with calling it unconditionally that made you opt
for the extra check?

Also, I think you can call of_platform_default_populate(), which is a
little shorter than the above because you can omit the match table.

> +
> +	return ret;
> +}
> +
> +static int __init nor_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct clk *clk;
> +	void __iomem *base;
> +	int ret;
> +
> +	/* get the resource */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	/* get the clock */
> +	clk = devm_clk_get(&pdev->dev, NULL);

Let's use a consumer name here. The problem with a NULL consumer name is
that it effectively restricts the DT binding. It means that whatever the
clock is its name needs to be the first in a clock-names property. We'll
likely get away with this because there's only one clock, but should we
ever need to add another we'd need to add wording to the device tree
bindings that the "gmi" entry needs to be first.

I'm not sure if that's clear, so I'll try to explain in other words: If
you pass a NULL consumer name to clk_get() it will simply use the first
clock in the clocks property. If you want to later extend the DT binding
by adding a clock in a backwards-compatible way, you'll need to add the
restriction that the "gmi" clock (the one that was previously unnamed)
must be the first in the clock-names and clocks properties.

That's all a little confusing, so let's avoid this by giving it a proper
consumer name to begin with.

> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	ret = clk_prepare_enable(clk);
> +	if (ret)
> +		return ret;
> +
> +	/* parse the device node */
> +	ret = nor_parse_dt(pdev, base);
> +	if (ret) {
> +		dev_err(&pdev->dev, "%s fail to create devices.\n",
> +			pdev->dev.of_node->full_name);
> +		clk_disable_unprepare(clk);
> +		return ret;
> +	}

The good thing if you don't do any programming in tegra_gmi_parse_dt(),
is that you can easily move the clk_prepare_enable() call to here where
things can't fail anymore, so you don't have to add cleanup code.

> +
> +	dev_info(&pdev->dev, "Driver registered.\n");

Please avoid this kind of output. Users expect that everything will work
so you want to let them know when something goes wrong, and be quiet
when all goes as expected.

> +	return 0;
> +}
> +
> +static struct platform_driver nor_driver = {
> +	.driver = {
> +		.name		= "tegra-nor",
> +		.of_match_table	= nor_id_table,
> +	},
> +};
> +module_platform_driver_probe(nor_driver, nor_probe);
> +
> +MODULE_AUTHOR("Mirza Krak <mirza.krak@gmail.com");
> +MODULE_DESCRIPTION("NVIDIA Tegra NOR Bus Driver");
> +MODULE_LICENSE("GPL");

You're header comment says GPL version 2, which means that the
MODULE_LICENSE needs to be "GPL v2". "GPL" means "version 2 or later".

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160725/add9c977/attachment-0001.sig>
