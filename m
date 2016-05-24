From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Tue, 24 May 2016 10:22:09 +0800
Subject: [PATCH 2/3] soc: rockchip: add driver handling grf setup
In-Reply-To: <1464015539-19521-3-git-send-email-heiko@sntech.de>
References: <1464015539-19521-1-git-send-email-heiko@sntech.de>
 <1464015539-19521-3-git-send-email-heiko@sntech.de>
Message-ID: <6a6e87ee-688d-90a3-2407-22847bd80971@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 2016/5/23 22:58, Heiko Stuebner wrote:
> The General Register Files are an area of registers containing a lot
> of single-bit settings for numerous components as well full components
> like usbphy control. Therefore all used components are accessed
> via the syscon provided by the grf nodes or from the sub-devices
> created through the simple-mfd created from the grf node.
>
> Some settings are not used by anything but will need to be set up
> according to expectations on the kernel side.
>
> Best example is the force_jtag setting, which defaults to on and
> results in the soc switching the pin-outputs between jtag and sdmmc
> automatically depending on the card-detect status. This conflicts
> heavily with how the dw_mmc driver expects to do its work and also
> with the clock-controller, which has most likely deactivated the
> jtag clock due to it being unused.

I agree we should disable force_jtag for real product. But on my local
branch we add a callback to parse a tag from cmdline. Sometime it's
useful for debugging in case of we need to setup JTAG for reproducing
and comfirming serious issue in which state the CPU cannot reponse to
any console input or FIQ-debug triggering.

Should we need it for upstream as you move all related code in this
new driver?  I'm not sure.

>
> So far the handling of this setting was living in the mach-rockchip
> code for the arm32-based rk3288 but that of course doesn't work
> for arm64 socs and would also look ugly for further arm32 socs.
>
> So introduce a top-level driver for the grf that handles these
> settings that need to be a certain way but nobody cares about.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/soc/rockchip/Kconfig  |  10 +++
>  drivers/soc/rockchip/Makefile |   1 +
>  drivers/soc/rockchip/grf.c    | 138 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 149 insertions(+)
>  create mode 100644 drivers/soc/rockchip/grf.c
>
> diff --git a/drivers/soc/rockchip/Kconfig b/drivers/soc/rockchip/Kconfig
> index 7140ff8..20da55d 100644
> --- a/drivers/soc/rockchip/Kconfig
> +++ b/drivers/soc/rockchip/Kconfig
> @@ -3,6 +3,16 @@ if ARCH_ROCKCHIP || COMPILE_TEST
>  #
>  # Rockchip Soc drivers
>  #
> +
> +config ROCKCHIP_GRF
> +	bool
> +	default y
> +	help
> +	  The General Register Files are a central component providing
> +	  special additional settings registers for a lot of soc-components.
> +	  In a lot of cases there also need to be default settings initialized
> +	  to make some of them conform to expectations of the kernel.
> +
>  config ROCKCHIP_PM_DOMAINS
>          bool "Rockchip generic power domain"
>          depends on PM
> diff --git a/drivers/soc/rockchip/Makefile b/drivers/soc/rockchip/Makefile
> index 3d73d06..c851fa0 100644
> --- a/drivers/soc/rockchip/Makefile
> +++ b/drivers/soc/rockchip/Makefile
> @@ -1,4 +1,5 @@
>  #
>  # Rockchip Soc drivers
>  #
> +obj-$(CONFIG_ROCKCHIP_GRF) += grf.o
>  obj-$(CONFIG_ROCKCHIP_PM_DOMAINS) += pm_domains.o
> diff --git a/drivers/soc/rockchip/grf.c b/drivers/soc/rockchip/grf.c
> new file mode 100644
> index 0000000..25a1fd3
> --- /dev/null
> +++ b/drivers/soc/rockchip/grf.c
> @@ -0,0 +1,138 @@
> +/*
> + * Rockchip Generic Register Files setup
> + *
> + * Copyright (c) 2016 Heiko Stuebner <heiko@sntech.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#define HIWORD_UPDATE(val, mask, shift) \
> +		((val) << (shift) | (mask) << ((shift) + 16))
> +
> +struct rockchip_grf_value {
> +	const char *desc;
> +	u32 reg;
> +	u32 val;
> +};
> +
> +struct rockchip_grf_info {
> +	const struct rockchip_grf_value *values;
> +	int num_values;
> +};
> +
> +#define RK3036_GRF_SOC_CON0		0x140
> +
> +static const struct rockchip_grf_value rk3036_defaults[] = {
> +	/*
> +	 * Disable auto jtag/sdmmc switching that causes issues with the
> +	 * clock-framework and the mmc controllers making them unreliable.
> +	 */
> +	{ "jtag switching", RK3036_GRF_SOC_CON0, HIWORD_UPDATE(0, 1, 11) },
> +};
> +
> +static const struct rockchip_grf_info rk3036_grf = {
> +	.values = rk3036_defaults,
> +	.num_values = ARRAY_SIZE(rk3036_defaults),
> +};
> +
> +#define RK3288_GRF_SOC_CON0		0x244
> +
> +static const struct rockchip_grf_value rk3288_defaults[] = {
> +	{ "jtag switching", RK3288_GRF_SOC_CON0, HIWORD_UPDATE(0, 1, 12) },
> +};
> +
> +static const struct rockchip_grf_info rk3288_grf = {
> +	.values = rk3288_defaults,
> +	.num_values = ARRAY_SIZE(rk3288_defaults),
> +};
> +
> +#define RK3399_GRF_SOC_CON7		0xe21c
> +
> +static const struct rockchip_grf_value rk3399_defaults[] = {
> +	{ "jtag switching", RK3399_GRF_SOC_CON7, HIWORD_UPDATE(0, 1, 12) },
> +
> +};
> +
> +static const struct rockchip_grf_info rk3399_grf = {
> +	.values = rk3399_defaults,
> +	.num_values = ARRAY_SIZE(rk3399_defaults),
> +};
> +
> +static const struct of_device_id rockchip_grf_dt_match[] = {
> +	{
> +		.compatible = "rockchip,rk3036-grf",
> +		.data = (void *)&rk3036_grf,
> +	}, {
> +		.compatible = "rockchip,rk3288-grf",
> +		.data = (void *)&rk3288_grf,
> +	}, {
> +		.compatible = "rockchip,rk3399-grf",
> +		.data = (void *)&rk3399_grf,
> +	},
> +	{ /* sentinel */ },
> +};
> +
> +static int rockchip_grf_probe(struct platform_device *pdev)
> +{
> +	const struct rockchip_grf_info *grf_info;
> +	const struct of_device_id *match;
> +	struct device *dev = &pdev->dev;
> +	struct regmap *grf;
> +	int i;
> +
> +	if (!dev->of_node)
> +		return -ENODEV;
> +
> +	match = of_match_device(rockchip_grf_dt_match, dev);
> +	if (!match || !match->data) {
> +		dev_err(dev, "missing grf data\n");
> +		return -EINVAL;
> +	}
> +
> +	grf_info = match->data;
> +
> +	grf = syscon_node_to_regmap(dev->of_node);
> +	if (IS_ERR(grf)) {
> +		dev_err(dev, "rockchip: could not get grf syscon\n");
> +		return PTR_ERR(grf);
> +	}
> +
> +	for (i = 0; i < grf_info->num_values; i++) {
> +		const struct rockchip_grf_value *val = &grf_info->values[i];
> +
> +		dev_dbg(dev, "adjusting %s in 0x%x to 0x%x\n",
> +			val->desc, val->reg, val->val);
> +		regmap_write(grf, val->reg, val->val);
> +	}
> +
> +	return 0;
> +}
> +
> +static struct platform_driver rockchip_grf_driver = {
> +	.probe = rockchip_grf_probe,
> +	.driver = {
> +		.name   = "rockchip-grf",
> +		.of_match_table = rockchip_grf_dt_match,
> +		/*
> +		 * The General Register Files are a central component
> +		 * accessed by numerous ip blocks and we're setting
> +		 * defaults which should only happen once.
> +		 */
> +		.suppress_bind_attrs = true,
> +	},
> +};
> +
> +static int __init rockchip_grf_drv_register(void)
> +{
> +	return platform_driver_register(&rockchip_grf_driver);
> +}
> +postcore_initcall(rockchip_grf_drv_register);
>


-- 
Best Regards
Shawn Lin
