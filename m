From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 20 Aug 2015 10:10:30 +0530
Subject: [PATCH v3 08/14] phy: Add driver for rockchip Display Port PHY
In-Reply-To: <1439995877-18496-1-git-send-email-ykk@rock-chips.com>
References: <1439995728-18046-1-git-send-email-ykk@rock-chips.com>
 <1439995877-18496-1-git-send-email-ykk@rock-chips.com>
Message-ID: <55D55A3E.8090905@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 19 August 2015 08:21 PM, Yakir Yang wrote:
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>

where's the commit message?
> ---
> Changes in v3:
> - Take Heiko suggest, add rockchip dp phy driver,
>   collect the phy clocks and power control.
> 
> Changes in v2: None
> 
>  .../devicetree/bindings/phy/rockchip-dp-phy.txt    |  26 +++
>  drivers/phy/Kconfig                                |   7 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/phy-rockchip-dp.c                      | 185 +++++++++++++++++++++
>  4 files changed, 219 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt
>  create mode 100644 drivers/phy/phy-rockchip-dp.c
> 
> diff --git a/Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt b/Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt
> new file mode 100644
> index 0000000..5de1088
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt
> @@ -0,0 +1,26 @@
> +Rockchip Soc Seroes Display Port PHY
> +------------------------------------
> +
> +Required properties:
> +- compatible : should be one of the following supported values:
> +	 - "rockchip.rk3288-dp-phy"
> +
> +- reg : a list of registers used by phy driver
> +- clocks: from common clock binding: handle to dp clock.
> +	of memory mapped region.
> +- clock-names: from common clock binding:
> +	Required elements: "sclk_dp" "sclk_dp_24m"
> +
> +- rockchip,grf: this soc should set GRF regs, so need get grf here.
> +- #phy-cells : from the generic PHY bindings, must be 0;
> +
> +Example:
> +
> +edp_phy: phy at ff770274 {
> +	compatilble = "rockchip,rk3288-dp-phy";
> +	reg = <0xff770274 4>;
> +	rockchip,grf = <&grf>;
> +	clocks = <&cru SCLK_EDP_24M>;
> +	clock-names = "24m";
> +	#phy-cells = <0>;
> +}
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 6b8dd16..da00440 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -297,6 +297,13 @@ config PHY_ROCKCHIP_USB
>  	help
>  	  Enable this to support the Rockchip USB 2.0 PHY.
>  
> +config PHY_ROCKCHIP_DP
> +	tristate "Rockchip Display Port PHY Driver"
> +	depends on ARCH_ROCKCHIP && OF
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support the Rockchip Display Port PHY.
> +
>  config PHY_ST_SPEAR1310_MIPHY
>  	tristate "ST SPEAR1310-MIPHY driver"
>  	select GENERIC_PHY
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index f344e1b..35e3ce6 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -33,6 +33,7 @@ phy-exynos-usb2-$(CONFIG_PHY_S5PV210_USB2)	+= phy-s5pv210-usb2.o
>  obj-$(CONFIG_PHY_EXYNOS5_USBDRD)	+= phy-exynos5-usbdrd.o
>  obj-$(CONFIG_PHY_QCOM_APQ8064_SATA)	+= phy-qcom-apq8064-sata.o
>  obj-$(CONFIG_PHY_ROCKCHIP_USB) += phy-rockchip-usb.o
> +obj-$(CONFIG_PHY_ROCKCHIP_DP)		+= phy-rockchip-dp.o
>  obj-$(CONFIG_PHY_QCOM_IPQ806X_SATA)	+= phy-qcom-ipq806x-sata.o
>  obj-$(CONFIG_PHY_ST_SPEAR1310_MIPHY)	+= phy-spear1310-miphy.o
>  obj-$(CONFIG_PHY_ST_SPEAR1340_MIPHY)	+= phy-spear1340-miphy.o
> diff --git a/drivers/phy/phy-rockchip-dp.c b/drivers/phy/phy-rockchip-dp.c
> new file mode 100644
> index 0000000..4759111
> --- /dev/null
> +++ b/drivers/phy/phy-rockchip-dp.c
> @@ -0,0 +1,185 @@
> +/*
> + * Rockchip DP PHY driver
> + *
> + * Copyright (C) 2015 FuZhou Rockchip Co., Ltd.
> + * Author: Yakir Yang <ykk@@rock-chips.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License.
> + */
> +
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/clk.h>
> +#include <linux/phy/phy.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/platform_device.h>
> +
> +#define GRF_SOC_CON12                   0x0274
> +#define GRF_EDP_REF_CLK_SEL_INTER       BIT(4)
> +
> +#define DP_PHY_SIDDQ_WRITE_EN           BIT(21)
> +#define DP_PHY_SIDDQ_ON                 0
> +#define DP_PHY_SIDDQ_OFF                BIT(5)
> +
> +struct rockchip_dp_phy {
> +	struct device  *dev;
> +	struct regmap  *grf;
> +	void __iomem   *regs;
> +	struct clk     *phy_24m;
> +};
> +
> +static int rockchip_dp_phy_clk_enable(struct rockchip_dp_phy *dp)
> +{
> +	int ret = 0;
> +
> +	ret = clk_set_rate(dp->phy_24m, 24000000);
> +	if (ret < 0) {
> +		dev_err(dp->dev, "cannot set clock phy_24m %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(dp->phy_24m);
> +	if (ret < 0) {
> +		dev_err(dp->dev, "cannot enable clock phy_24m %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rockchip_dp_phy_clk_disable(struct rockchip_dp_phy *dp)
> +{
> +	clk_disable_unprepare(dp->phy_24m);
> +
> +	return 0;
> +}
> +
> +static int rockchip_set_phy_state(struct phy *phy, bool enable)
> +{
> +	struct rockchip_dp_phy *dp = phy_get_drvdata(phy);
> +
> +	if (enable) {
> +		rockchip_dp_phy_clk_enable(dp);
> +		writel(DP_PHY_SIDDQ_WRITE_EN | DP_PHY_SIDDQ_ON, dp->regs);
> +	} else {
> +		rockchip_dp_phy_clk_disable(dp);
> +		writel(DP_PHY_SIDDQ_WRITE_EN | DP_PHY_SIDDQ_OFF, dp->regs);
> +	}
> +
> +	return 0;
> +}
> +
> +static int rockchip_dp_phy_power_on(struct phy *phy)
> +{
> +	return rockchip_set_phy_state(phy, true);
> +}
> +
> +static int rockchip_dp_phy_power_off(struct phy *phy)
> +{
> +	return rockchip_set_phy_state(phy, false);
> +}
> +
> +static struct phy_ops rockchip_dp_phy_ops = {
> +	.power_on	= rockchip_dp_phy_power_on,
> +	.power_off	= rockchip_dp_phy_power_off,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static int rockchip_dp_phy_init(struct rockchip_dp_phy *dp)
> +{
> +	struct device *dev = dp->dev;
> +	struct device_node *np = dev->of_node;
> +	int ret;
> +
> +	dp->phy_24m = devm_clk_get(dev, "24m");
> +	if (IS_ERR(dp->phy_24m)) {
> +		dev_err(dev, "cannot get clock 24m\n");
> +		return PTR_ERR(dp->phy_24m);
> +	}
> +
> +	ret = rockchip_dp_phy_clk_enable(dp);
> +	if (ret < 0) {
> +		dev_err(dp->dev, "cannot enable dp phy clk %d\n", ret);
> +		return ret;
> +	}
> +
> +	dp->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
> +	if (IS_ERR(dp->grf)) {
> +		dev_err(dev, "rk3288-dp needs rockchip,grf property\n");
> +		return PTR_ERR(dp->grf);
> +	}
> +
> +	ret = regmap_write(dp->grf, GRF_SOC_CON12,
> +			   GRF_EDP_REF_CLK_SEL_INTER |
> +			   (GRF_EDP_REF_CLK_SEL_INTER << 16));
> +	if (ret != 0) {
> +		dev_err(dp->dev, "Could not config GRF edp ref clk: %d\n", ret);
> +		return ret;
> +	}

This function can be split to do only clk_get and syscon_regmap_lookup in
probe, clk_enable and regmap_write in phy_init?
> +
> +	return 0;
> +}
> +
> +static int rockchip_dp_phy_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct phy_provider *phy_provider;
> +	struct rockchip_dp_phy *dp;
> +	struct resource *res;
> +	struct phy *phy;
> +	int ret;
> +
> +	dp = devm_kzalloc(dev, sizeof(*dp), GFP_KERNEL);
> +	if (IS_ERR(dp))
> +		return -ENOMEM;
> +
> +	dp->dev = dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	dp->regs = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(dp->regs))
> +		return PTR_ERR(dp->regs);
> +
> +	ret = rockchip_dp_phy_init(dp);
> +	if (ret)
> +		return ret;
> +
> +	phy = devm_phy_create(dev, NULL, &rockchip_dp_phy_ops, NULL);
> +	if (IS_ERR(phy)) {
> +		dev_err(dev, "failed to create phy\n");
> +		return PTR_ERR(phy);
> +	}
> +	phy_set_drvdata(phy, dp);
> +
> +	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +
> +	return PTR_ERR_OR_ZERO(phy_provider);
> +}
> +
> +static const struct of_device_id rockchip_dp_phy_dt_ids[] = {
> +	{ .compatible = "rockchip,rk3288-dp-phy" },
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(of, rockchip_dp_phy_dt_ids);
> +
> +static struct platform_driver rockchip_dp_phy_driver = {
> +	.probe		= rockchip_dp_phy_probe,
> +	.driver		= {
> +		.name	= "rockchip-dp-phy",
> +		.owner	= THIS_MODULE,

owner is not required here.

Thanks
Kishon
