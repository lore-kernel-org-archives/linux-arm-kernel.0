From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 16 Jan 2017 15:11:58 +0530
Subject: [PATCH 2/5] phy: meson: add USB2 and USB3 PHY support for Meson
 GXL
In-Reply-To: <20161126145635.24488-3-martin.blumenstingl@googlemail.com>
References: <20161126145635.24488-1-martin.blumenstingl@googlemail.com>
 <20161126145635.24488-3-martin.blumenstingl@googlemail.com>
Message-ID: <587C9566.7080306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Saturday 26 November 2016 08:26 PM, Martin Blumenstingl wrote:
> This adds two new USB PHY drivers found on Meson GXL and GXM SoCs.

Please send them as separate drivers.
> 
> The registers for the USB2 PHY block handle a maximum of 4 ports (newer
> SoCs may allow more ports, the driver handles this as long as the
> register length is adjusted in the .dts). The PHY block theoretically
> allows powering down each PHY port separately (by putting it into
> "reset" state). Unfortunately this does not work (my board has 2 USB
> ports, connected to port 1 and 2 of the dwc3's internal hub. When
> leaving the third USB PHY disabled then the hub sees that a device is
> plugged in, but it does not work: "usb usb1-port2: connect-debounce
> failed").
> The USB3 PHY will take care of enabling/disabling all available ports,
> because the USB3 PHY also manages the mode of the USB2 PHYs.
> 
> The USB3 PHY actually has three purposes:
> - it provides the USB3 PHY
> - it handles the OTG device/host mode detection interrupt
> - it notifies the corresponding USB2 PHYs of the OTG mode changes
> On GXL and GXM SoCs one references all available USB2 PHY ports in the
> USB3 PHY because all are connected to the same USB controller (thus the
> mode will always match). This behavior is configurable via devicetree,
> by passing (or not passing) a list of other ("child") PHYs which should
> be configured by the USB3 PHY.
> 
> Unfortunately there are no datasheets available for any of these PHYs.
> Both drivers were written by reading the reference drivers provided by
> Amlogic and analyzing the registers on the kernel that was shipped with
> my board.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/phy/Kconfig              |  13 ++
>  drivers/phy/Makefile             |   2 +
>  drivers/phy/phy-meson-gxl-usb2.c | 374 ++++++++++++++++++++++++++++++++++++++
>  drivers/phy/phy-meson-gxl-usb3.c | 377 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 766 insertions(+)
>  create mode 100644 drivers/phy/phy-meson-gxl-usb2.c
>  create mode 100644 drivers/phy/phy-meson-gxl-usb3.c
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 728e03f..ea74843 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -502,4 +502,17 @@ config PHY_MESON8B_USB2
>  	  and GXBB SoCs.
>  	  If unsure, say N.
>  
> +config PHY_MESON_GXL_USB
> +	tristate "Meson GXL USB2 and USB3 PHY drivers"
> +	default ARCH_MESON
> +	depends on OF && (ARCH_MESON || COMPILE_TEST)
> +	depends on USB_SUPPORT
> +	select USB_COMMON
> +	select GENERIC_PHY
> +	select REGMAP_MMIO
> +	help
> +	  Enable this to support the Meson USB2 and USB3 PHYs found in
> +	  Meson GXL SoCs.
> +	  If unsure, say N.
> +
>  endmenu
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index 0c7fdae..960a96e 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -61,3 +61,5 @@ obj-$(CONFIG_PHY_CYGNUS_PCIE)		+= phy-bcm-cygnus-pcie.o
>  obj-$(CONFIG_ARCH_TEGRA) += tegra/
>  obj-$(CONFIG_PHY_NS2_PCIE)		+= phy-bcm-ns2-pcie.o
>  obj-$(CONFIG_PHY_MESON8B_USB2)		+= phy-meson8b-usb2.o
> +obj-$(CONFIG_PHY_MESON_GXL_USB)		+= phy-meson-gxl-usb2.o
> +obj-$(CONFIG_PHY_MESON_GXL_USB)		+= phy-meson-gxl-usb3.o
> diff --git a/drivers/phy/phy-meson-gxl-usb2.c b/drivers/phy/phy-meson-gxl-usb2.c
> new file mode 100644
> index 0000000..c081ce3
> --- /dev/null
> +++ b/drivers/phy/phy-meson-gxl-usb2.c
> @@ -0,0 +1,374 @@
> +/*
> + * Meson GXL USB2 PHY driver
> + *
> + * Copyright (C) 2016 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/usb/of.h>
> +
> +/* bits [31:27] are read-only */
> +#define U2P_R0							0x0
> +	#define U2P_R0_BYPASS_SEL				BIT(0)
> +	#define U2P_R0_BYPASS_DM_EN				BIT(1)
> +	#define U2P_R0_BYPASS_DP_EN				BIT(2)
> +	#define U2P_R0_TXBITSTUFF_ENH				BIT(3)
> +	#define U2P_R0_TXBITSTUFF_EN				BIT(4)
> +	#define U2P_R0_DM_PULLDOWN				BIT(5)
> +	#define U2P_R0_DP_PULLDOWN				BIT(6)
> +	#define U2P_R0_DP_VBUS_VLD_EXT_SEL			BIT(7)
> +	#define U2P_R0_DP_VBUS_VLD_EXT				BIT(8)
> +	#define U2P_R0_ADP_PRB_EN				BIT(9)
> +	#define U2P_R0_ADP_DISCHARGE				BIT(10)
> +	#define U2P_R0_ADP_CHARGE				BIT(11)
> +	#define U2P_R0_DRV_VBUS					BIT(12)
> +	#define U2P_R0_ID_PULLUP				BIT(13)
> +	#define U2P_R0_LOOPBACK_EN_B				BIT(14)
> +	#define U2P_R0_OTG_DISABLE				BIT(15)
> +	#define U2P_R0_COMMON_ONN				BIT(16)
> +	#define U2P_R0_FSEL_SHIFT				17
> +	#define U2P_R0_FSEL_MASK				GENMASK(19, 17)
> +	#define U2P_R0_REF_CLK_SEL_SHIFT			20
> +	#define U2P_R0_REF_CLK_SEL_MASK				GENMASK(21, 20)
> +	#define U2P_R0_POWER_ON_RESET				BIT(22)
> +	#define U2P_R0_V_ATE_TEST_EN_B_SHIFT			23
> +	#define U2P_R0_V_ATE_TEST_EN_B_MASK			GENMASK(24, 23)
> +	#define U2P_R0_ID_SET_ID_DQ				BIT(25)
> +	#define U2P_R0_ATE_RESET				BIT(26)
> +	#define U2P_R0_FSV_MINUS				BIT(27)
> +	#define U2P_R0_FSV_PLUS					BIT(28)
> +	#define U2P_R0_BYPASS_DM_DATA				BIT(29)
> +	#define U2P_R0_BYPASS_DP_DATA				BIT(30)
> +
> +#define U2P_R1							0x4
> +	#define U2P_R1_BURN_IN_TEST				BIT(0)
> +	#define U2P_R1_ACA_ENABLE				BIT(1)
> +	#define U2P_R1_DCD_ENABLE				BIT(2)
> +	#define U2P_R1_VDAT_SRC_EN_B				BIT(3)
> +	#define U2P_R1_VDAT_DET_EN_B				BIT(4)
> +	#define U2P_R1_CHARGES_SEL				BIT(5)
> +	#define U2P_R1_TX_PREEMP_PULSE_TUNE			BIT(6)
> +	#define U2P_R1_TX_PREEMP_AMP_TUNE_SHIFT			7
> +	#define U2P_R1_TX_PREEMP_AMP_TUNE_MASK			GENMASK(8, 7)
> +	#define U2P_R1_TX_RES_TUNE_SHIFT			9
> +	#define U2P_R1_TX_RES_TUNE_MASK				GENMASK(10, 9)
> +	#define U2P_R1_TX_RISE_TUNE_SHIFT			11
> +	#define U2P_R1_TX_RISE_TUNE_MASK			GENMASK(12, 11)
> +	#define U2P_R1_TX_VREF_TUNE_SHIFT			13
> +	#define U2P_R1_TX_VREF_TUNE_MASK			GENMASK(16, 13)
> +	#define U2P_R1_TX_FSLS_TUNE_SHIFT			17
> +	#define U2P_R1_TX_FSLS_TUNE_MASK			GENMASK(20, 17)
> +	#define U2P_R1_TX_HSXV_TUNE_SHIFT			21
> +	#define U2P_R1_TX_HSXV_TUNE_MASK			GENMASK(22, 21)
> +	#define U2P_R1_OTG_TUNE_SHIFT				23
> +	#define U2P_R1_OTG_TUNE_MASK				GENMASK(25, 23)
> +	#define U2P_R1_SQRX_TUNE_SHIFT				26
> +	#define U2P_R1_SQRX_TUNE_MASK				GENMASK(28, 26)
> +	#define U2P_R1_COMP_DIS_TUNE_SHIFT			29
> +	#define U2P_R1_COMP_DIS_TUNE_MASK			GENMASK(31, 29)
> +
> +/* bits [31:14] are read-only */
> +#define U2P_R2							0x8
> +	#define U2P_R2_DATA_IN_SHIFT				0
> +	#define U2P_R2_DATA_IN_MASK				GENMASK(3, 0)
> +	#define U2P_R2_DATA_IN_EN_SHIFT				4
> +	#define U2P_R2_DATA_IN_EN_MASK				GENMASK(7, 4)
> +	#define U2P_R2_ADDR_SHIFT				8
> +	#define U2P_R2_ADDR_MASK				GENMASK(11, 8)
> +	#define U2P_R2_DATA_OUT_SEL				BIT(12)
> +	#define U2P_R2_CLK					BIT(13)
> +	#define U2P_R2_DATA_OUT_SHIFT				14
> +	#define U2P_R2_DATA_OUT_MASK				GENMASK(17, 14)
> +	#define U2P_R2_ACA_PIN_RANGE_C				BIT(18)
> +	#define U2P_R2_ACA_PIN_RANGE_B				BIT(19)
> +	#define U2P_R2_ACA_PIN_RANGE_A				BIT(20)
> +	#define U2P_R2_ACA_PIN_GND				BIT(21)
> +	#define U2P_R2_ACA_PIN_FLOAT				BIT(22)
> +	#define U2P_R2_CHARGE_DETECT				BIT(23)
> +	#define U2P_R2_DEVICE_SESSION_VALID			BIT(24)
> +	#define U2P_R2_ADP_PROBE				BIT(25)
> +	#define U2P_R2_ADP_SENSE				BIT(26)
> +	#define U2P_R2_SESSION_END				BIT(27)
> +	#define U2P_R2_VBUS_VALID				BIT(28)
> +	#define U2P_R2_B_VALID					BIT(29)
> +	#define U2P_R2_A_VALID					BIT(30)
> +	#define U2P_R2_ID_DIG					BIT(31)
> +
> +#define U2P_R3							0xc
> +
> +#define PHY_PORT_RESOURCE_SIZE					0x20
> +
> +#define RESET_COMPLETE_TIME				500
> +
> +struct phy_meson_gxl_usb2_priv {
> +	struct regmap		*regmap;
> +	enum phy_mode		mode;
> +};
> +
> +struct phy_meson_gxl_usb2_drv {
> +	void __iomem		*base;
> +	int			num_ports;
> +	struct phy		**ports;
> +	struct clk		*clk_usb;
> +	struct clk		*clk_usb_ddr;
> +};
> +
> +static const struct regmap_config phy_meson_gxl_usb2_regmap_conf = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = U2P_R3,
> +};
> +
> +static int phy_meson_gxl_usb2_set_mode(struct phy *phy, enum phy_mode mode)
> +{
> +	struct phy_meson_gxl_usb2_priv *priv = phy_get_drvdata(phy);
> +
> +	switch (mode) {
> +	case PHY_MODE_USB_HOST:
> +	case PHY_MODE_USB_OTG:
> +		regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_DM_PULLDOWN,
> +				   U2P_R0_DM_PULLDOWN);
> +		regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_DP_PULLDOWN,
> +				   U2P_R0_DP_PULLDOWN);
> +		regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_ID_PULLUP, 0);
> +		break;
> +
> +	case PHY_MODE_USB_DEVICE:
> +		regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_DM_PULLDOWN,
> +				   0);
> +		regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_DP_PULLDOWN,
> +				   0);
> +		regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_ID_PULLUP,
> +				   U2P_R0_ID_PULLUP);
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* reset the PHY and wait until settings are stabilized */
> +	regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_POWER_ON_RESET,
> +			   U2P_R0_POWER_ON_RESET);
> +	udelay(RESET_COMPLETE_TIME);
> +	regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_POWER_ON_RESET, 0);
> +	udelay(RESET_COMPLETE_TIME);
> +
> +	priv->mode = mode;
> +
> +	return 0;
> +}
> +
> +static int phy_meson_gxl_usb2_power_off(struct phy *phy)
> +{
> +	struct phy_meson_gxl_usb2_drv *drv_priv =
> +		dev_get_drvdata(phy->dev.parent);
> +	struct phy_meson_gxl_usb2_priv *priv = phy_get_drvdata(phy);
> +
> +	/* power off the PHY by putting it into reset mode */
> +	regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_POWER_ON_RESET,
> +			   U2P_R0_POWER_ON_RESET);
> +
> +	clk_disable_unprepare(drv_priv->clk_usb_ddr);
> +	clk_disable_unprepare(drv_priv->clk_usb);
> +
> +	return 0;
> +}
> +
> +static int phy_meson_gxl_usb2_power_on(struct phy *phy)
> +{
> +	struct phy_meson_gxl_usb2_drv *drv_priv =
> +		dev_get_drvdata(phy->dev.parent);
> +	struct phy_meson_gxl_usb2_priv *priv = phy_get_drvdata(phy);
> +	int ret;
> +
> +	ret = clk_prepare_enable(drv_priv->clk_usb);
> +	if (ret) {
> +		dev_err(&phy->dev, "Failed to enable USB clock\n");
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(drv_priv->clk_usb_ddr);
> +	if (ret) {
> +		clk_disable_unprepare(drv_priv->clk_usb);
> +
> +		dev_err(&phy->dev, "Failed to enable USB DDR clock\n");
> +		return ret;
> +	}
> +
> +	/* power on the PHY by taking it out of reset mode */
> +	regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_POWER_ON_RESET, 0);
> +
> +	ret = phy_meson_gxl_usb2_set_mode(phy, priv->mode);
> +	if (ret) {
> +		phy_meson_gxl_usb2_power_off(phy);
> +
> +		dev_err(&phy->dev, "Failed to initialize PHY with mode %d\n",
> +			priv->mode);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops phy_meson_gxl_usb2_ops = {
> +	.power_on	= phy_meson_gxl_usb2_power_on,
> +	.power_off	= phy_meson_gxl_usb2_power_off,
> +	.set_mode	= phy_meson_gxl_usb2_set_mode,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static struct phy *phy_meson_gxl_usb2_of_xlate(struct device *dev,
> +					       struct of_phandle_args *args)
> +{
> +	struct phy_meson_gxl_usb2_drv *priv = dev_get_drvdata(dev);
> +	int port;
> +
> +	if (args->args_count != 1) {
> +		dev_err(dev, "Invalid number of cells in 'phy' property\n");
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	port = args->args[0];
> +	if (WARN_ON(port >= priv->num_ports))
> +		return ERR_PTR(-ENODEV);
> +
> +	return priv->ports[port];
> +}

Please model every port as a sub-node and get rid of custom xlate implementation.

> +
> +static int phy_meson_gxl_usb2_probe_port(struct device *dev, int port)
> +{
> +	struct phy_meson_gxl_usb2_drv *drv_priv = dev_get_drvdata(dev);
> +	struct phy_meson_gxl_usb2_priv *phy_priv;
> +	struct phy *phy;
> +	void __iomem *port_base;
> +
> +	phy_priv = devm_kzalloc(dev, sizeof(*phy_priv), GFP_KERNEL);
> +	if (!phy_priv)
> +		return -ENOMEM;
> +
> +	switch (of_usb_get_dr_mode_by_phy(dev->of_node, port)) {
> +	case USB_DR_MODE_PERIPHERAL:
> +		phy_priv->mode = PHY_MODE_USB_DEVICE;
> +		break;
> +	case USB_DR_MODE_OTG:
> +		phy_priv->mode = PHY_MODE_USB_OTG;
> +		break;
> +	case USB_DR_MODE_HOST:
> +	default:
> +		phy_priv->mode = PHY_MODE_USB_HOST;
> +		break;
> +	}
> +
> +	phy = devm_phy_create(dev, NULL, &phy_meson_gxl_usb2_ops);
> +	if (IS_ERR(phy)) {
> +		dev_err(dev, "failed to create PHY port %d\n", port);
> +		return PTR_ERR(phy);
> +	}
> +
> +	port_base = drv_priv->base + (port * PHY_PORT_RESOURCE_SIZE);
> +	phy_priv->regmap = devm_regmap_init_mmio(&phy->dev, port_base,
> +						 &phy_meson_gxl_usb2_regmap_conf);
> +	if (IS_ERR(phy_priv->regmap))
> +		return PTR_ERR(phy_priv->regmap);
> +
> +	phy_set_drvdata(phy, phy_priv);
> +
> +	drv_priv->ports[port] = phy;
> +
> +	return 0;
> +}
> +
> +static int phy_meson_gxl_usb2_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct phy_meson_gxl_usb2_drv *priv;
> +	struct phy_provider *phy_provider;
> +	struct resource *res;
> +	int i, ret;
> +
> +	ret = device_reset(dev);
> +	if (ret) {
> +		dev_err(dev, "failed to reset device\n");
> +		return ret;
> +	}
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	priv->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	priv->num_ports = resource_size(res) / PHY_PORT_RESOURCE_SIZE;
> +	if (priv->num_ports < 1) {
> +		dev_err(dev, "specified memory range is too small\n");
> +		return -EINVAL;
> +	}
> +
> +	priv->ports = devm_kcalloc(dev, priv->num_ports, sizeof(*priv->ports),
> +				   GFP_KERNEL);
> +	if (!priv->ports)
> +		return -ENOMEM;
> +
> +	priv->clk_usb = devm_clk_get(dev, "usb");
> +	if (IS_ERR(priv->clk_usb)) {
> +		dev_err(dev, "failed to get USB clock\n");
> +		return PTR_ERR(priv->clk_usb);
> +	}
> +
> +	priv->clk_usb_ddr = devm_clk_get(dev, "usb_ddr");
> +	if (IS_ERR(priv->clk_usb_ddr)) {
> +		dev_err(dev, "failed to get USB DDR clock\n");
> +		return PTR_ERR(priv->clk_usb_ddr);
> +	}
> +
> +	for (i = 0; i < priv->num_ports; i++) {
> +		ret = phy_meson_gxl_usb2_probe_port(dev, i);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	phy_provider = devm_of_phy_provider_register(dev,
> +						     phy_meson_gxl_usb2_of_xlate);
> +
> +	return PTR_ERR_OR_ZERO(phy_provider);
> +}
> +
> +static const struct of_device_id phy_meson_gxl_usb2_of_match[] = {
> +	{ .compatible = "amlogic,meson-gxl-usb2-phy", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, phy_meson_gxl_usb2_of_match);
> +
> +static struct platform_driver phy_meson_gxl_usb2_driver = {
> +	.probe	= phy_meson_gxl_usb2_probe,
> +	.driver	= {
> +		.name		= "phy-meson-gxl-usb2",
> +		.of_match_table	= phy_meson_gxl_usb2_of_match,
> +	},
> +};
> +module_platform_driver(phy_meson_gxl_usb2_driver);
> +
> +MODULE_AUTHOR("Martin Blumenstingl <martin.blumenstingl@googlemail.com>");
> +MODULE_DESCRIPTION("Meson GXL USB2 PHY driver");
> +MODULE_LICENSE("GPL");

GPL v2 to match with the file header.
> diff --git a/drivers/phy/phy-meson-gxl-usb3.c b/drivers/phy/phy-meson-gxl-usb3.c
> new file mode 100644
> index 0000000..90a4028
> --- /dev/null
> +++ b/drivers/phy/phy-meson-gxl-usb3.c
> @@ -0,0 +1,377 @@
> +/*
> + * Meson GXL USB3 PHY driver
> + *
> + * Copyright (C) 2016 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/reset.h>
> +#include <linux/regmap.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/usb/of.h>
> +#include <linux/workqueue.h>
> +
> +#define USB_R0							0x00
> +	#define USB_R0_P30_FSEL_SHIFT				0
> +	#define USB_R0_P30_FSEL_MASK				GENMASK(5, 0)
> +	#define USB_R0_P30_PHY_RESET				BIT(6)
> +	#define USB_R0_P30_TEST_POWERDOWN_HSP			BIT(7)
> +	#define USB_R0_P30_TEST_POWERDOWN_SSP			BIT(8)
> +	#define USB_R0_P30_ACJT_LEVEL_SHIFT			9
> +	#define USB_R0_P30_ACJT_LEVEL_MASK			GENMASK(13, 9)
> +	#define USB_R0_P30_TX_BOOST_LEVEL_SHIFT			14
> +	#define USB_R0_P30_TX_BOOST_LEVEL_MASK			GENMASK(16, 14)
> +	#define USB_R0_P30_LANE0_TX2RX_LOOPBACK			BIT(17)
> +	#define USB_R0_P30_LANE0_EXT_PCLK_REQ			BIT(18)
> +	#define USB_R0_P30_PCS_RX_LOS_MASK_VAL_SHIFT		19
> +	#define USB_R0_P30_PCS_RX_LOS_MASK_VAL_MASK		GENMASK(28, 19)
> +	#define USB_R0_U2D_SS_SCALEDOWN_MODE_SHIFT		29
> +	#define USB_R0_U2D_SS_SCALEDOWN_MODE_MASK		GENMASK(30, 29)
> +	#define USB_R0_U2D_ACT					BIT(31)
> +
> +#define USB_R1							0x04
> +	#define USB_R1_U3H_BIGENDIAN_GS				BIT(0)
> +	#define USB_R1_U3H_PME_ENABLE				BIT(1)
> +	#define USB_R1_U3H_HUB_PORT_OVERCURRENT_SHIFT		2
> +	#define USB_R1_U3H_HUB_PORT_OVERCURRENT_MASK		GENMASK(6, 2)
> +	#define USB_R1_U3H_HUB_PORT_PERM_ATTACH_SHIFT		7
> +	#define USB_R1_U3H_HUB_PORT_PERM_ATTACH_MASK		GENMASK(11, 7)
> +	#define USB_R1_U3H_HOST_U2_PORT_DISABLE_SHIFT		12
> +	#define USB_R1_U3H_HOST_U2_PORT_DISABLE_MASK		GENMASK(15, 12)
> +	#define USB_R1_U3H_HOST_U3_PORT_DISABLE			BIT(16)
> +	#define USB_R1_U3H_HOST_PORT_POWER_CONTROL_PRESENT	BIT(17)
> +	#define USB_R1_U3H_HOST_MSI_ENABLE			BIT(18)
> +	#define USB_R1_U3H_FLADJ_30MHZ_REG_SHIFT		19
> +	#define USB_R1_U3H_FLADJ_30MHZ_REG_MASK			GENMASK(24, 19)
> +	#define USB_R1_P30_PCS_TX_SWING_FULL_SHIFT		25
> +	#define USB_R1_P30_PCS_TX_SWING_FULL_MASK		GENMASK(31, 25)
> +
> +#define USB_R2							0x08
> +	#define USB_R2_P30_CR_DATA_IN_SHIFT			0
> +	#define USB_R2_P30_CR_DATA_IN_MASK			GENMASK(15, 0)
> +	#define USB_R2_P30_CR_READ				BIT(16)
> +	#define USB_R2_P30_CR_WRITE				BIT(17)
> +	#define USB_R2_P30_CR_CAP_ADDR				BIT(18)
> +	#define USB_R2_P30_CR_CAP_DATA				BIT(19)
> +	#define USB_R2_P30_PCS_TX_DEEMPH_3P5DB_SHIFT		20
> +	#define USB_R2_P30_PCS_TX_DEEMPH_3P5DB_MASK		GENMASK(25, 20)
> +	#define USB_R2_P30_PCS_TX_DEEMPH_6DB_SHIFT		26
> +	#define USB_R2_P30_PCS_TX_DEEMPH_6DB_MASK		GENMASK(31, 26)
> +
> +#define USB_R3							0x0c
> +	#define USB_R3_P30_SSC_ENABLE				BIT(0)
> +	#define USB_R3_P30_SSC_RANGE_SHIFT			1
> +	#define USB_R3_P30_SSC_RANGE_MASK			GENMASK(3, 1)
> +	#define USB_R3_P30_SSC_REF_CLK_SEL_SHIFT		4
> +	#define USB_R3_P30_SSC_REF_CLK_SEL_MASK			GENMASK(12, 4)
> +	#define USB_R3_P30_REF_SSP_EN				BIT(13)
> +	#define USB_R3_P30_LOS_BIAS_SHIFT			16
> +	#define USB_R3_P30_LOS_BIAS_MASK			GENMASK(18, 16)
> +	#define USB_R3_P30_LOS_LEVEL_SHIFT			19
> +	#define USB_R3_P30_LOS_LEVEL_MASK			GENMASK(23, 19)
> +	#define USB_R3_P30_MPLL_MULTIPLIER_SHIFT		24
> +	#define USB_R3_P30_MPLL_MULTIPLIER_MASK			GENMASK(30, 24)
> +
> +#define USB_R4							0x10
> +	#define USB_R4_P21_PORT_RESET_0				BIT(0)
> +	#define USB_R4_P21_SLEEP_M0				BIT(1)
> +	#define USB_R4_MEM_PD_SHIFT				2
> +	#define USB_R4_MEM_PD_MASK				GENMASK(3, 2)
> +	#define USB_R4_P21_ONLY					BIT(4)
> +
> +#define USB_R5							0x14
> +	#define USB_R5_ID_DIG_SYNC				BIT(0)
> +	#define USB_R5_ID_DIG_REG				BIT(1)
> +	#define USB_R5_ID_DIG_CFG_SHIFT				2
> +	#define USB_R5_ID_DIG_CFG_MASK				GENMASK(3, 2)
> +	#define USB_R5_ID_DIG_EN_0				BIT(4)
> +	#define USB_R5_ID_DIG_EN_1				BIT(5)
> +	#define USB_R5_ID_DIG_CURR				BIT(6)
> +	#define USB_R5_ID_DIG_IRQ				BIT(7)
> +	#define USB_R5_ID_DIG_TH_SHIFT				8
> +	#define USB_R5_ID_DIG_TH_MASK				GENMASK(15, 8)
> +	#define USB_R5_ID_DIG_CNT_SHIFT				16
> +	#define USB_R5_ID_DIG_CNT_MASK				GENMASK(23, 16)
> +
> +/* read-only register */
> +#define USB_R6							0x18
> +	#define USB_R6_P30_CR_DATA_OUT_SHIFT			0
> +	#define USB_R6_P30_CR_DATA_OUT_MASK			GENMASK(15, 0)
> +	#define USB_R6_P30_CR_ACK				BIT(16)
> +
> +#define RESET_COMPLETE_TIME				500
> +
> +struct phy_meson_gxl_usb3_priv {
> +	struct regmap		*regmap;
> +	struct delayed_work	otg_work;
> +	struct phy		*this_phy;
> +	int			num_usb2_phys;
> +	struct phy		**usb2_phys;
> +};
> +
> +static const struct regmap_config phy_meson_gxl_usb3_regmap_conf = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = USB_R6,
> +};
> +
> +static int phy_meson_gxl_usb3_update_mode(struct phy *phy)
> +{
> +	struct phy_meson_gxl_usb3_priv *priv = phy_get_drvdata(phy);
> +	u32 val;
> +	enum phy_mode mode;
> +	int i, ret;
> +
> +	ret = regmap_read(priv->regmap, USB_R5, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val & USB_R5_ID_DIG_CURR) {
> +		mode = PHY_MODE_USB_DEVICE;
> +
> +		regmap_update_bits(priv->regmap, USB_R0, USB_R0_U2D_ACT,
> +				   USB_R0_U2D_ACT);
> +		regmap_update_bits(priv->regmap, USB_R4, USB_R4_P21_SLEEP_M0,
> +				   USB_R4_P21_SLEEP_M0);
> +	} else {
> +		mode = PHY_MODE_USB_HOST;
> +
> +		regmap_update_bits(priv->regmap, USB_R0, USB_R0_U2D_ACT, 0);
> +		regmap_update_bits(priv->regmap, USB_R4, USB_R4_P21_SLEEP_M0,
> +				   0);
> +	}
> +
> +	/* inform the USB2 PHY that we have changed the mode */
> +	for (i = 0; i < priv->num_usb2_phys; i++) {
> +		ret = phy_set_mode(priv->usb2_phys[i], mode);

I'm finding it difficult to understand this. Why should the mode of one phy be
set from another phy? Maybe this part should be implemented using extcon?

> +		if (ret) {
> +			dev_err(&phy->dev,
> +				"Failed to update usb2-phy #%d mode to %d\n",
> +				i, mode);
> +			return ret;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static void phy_meson_gxl_usb3_work(struct work_struct *data)
> +{
> +	struct phy_meson_gxl_usb3_priv *priv =
> +		container_of(data, struct phy_meson_gxl_usb3_priv,
> +			     otg_work.work);
> +
> +	phy_meson_gxl_usb3_update_mode(priv->this_phy);
> +
> +	/* unmask IRQs which may have arrived in the meantime */
> +	regmap_update_bits(priv->regmap, USB_R5, USB_R5_ID_DIG_IRQ, 0);
> +}
> +
> +static int phy_meson_gxl_usb3_init(struct phy *phy)
> +{
> +	struct phy_meson_gxl_usb3_priv *priv = phy_get_drvdata(phy);
> +	int i, ret;
> +
> +	for (i = 0; i < priv->num_usb2_phys; i++) {
> +		ret = phy_init(priv->usb2_phys[i]);
> +		if (ret) {
> +			dev_err(&phy->dev,
> +				"Failed to initialize related usb2-phy #%d\n",
> +				i);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int phy_meson_gxl_usb3_exit(struct phy *phy)
> +{
> +	struct phy_meson_gxl_usb3_priv *priv = phy_get_drvdata(phy);
> +	int i, ret;
> +
> +	for (i = 0; i < priv->num_usb2_phys; i++) {
> +		ret = phy_exit(priv->usb2_phys[i]);
> +		if (ret) {
> +			dev_err(&phy->dev,
> +				"Failed to exit related usb2-phy #%d\n", i);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int phy_meson_gxl_usb3_power_on(struct phy *phy)
> +{
> +	struct phy_meson_gxl_usb3_priv *priv = phy_get_drvdata(phy);
> +	int i, ret;
> +
> +	for (i = 0; i < priv->num_usb2_phys; i++) {
> +		ret = phy_power_on(priv->usb2_phys[i]);
> +		if (ret) {
> +			dev_err(&phy->dev,
> +				"Failed to power on related usb2-phy #%d\n",
> +				i);
> +			return ret;
> +		}
> +	}
> +
> +	regmap_update_bits(priv->regmap, USB_R1,
> +			   USB_R1_U3H_FLADJ_30MHZ_REG_MASK,
> +			   0x20 << USB_R1_U3H_FLADJ_30MHZ_REG_SHIFT);
> +
> +	regmap_update_bits(priv->regmap, USB_R5, USB_R5_ID_DIG_EN_0,
> +			   USB_R5_ID_DIG_EN_0);
> +	regmap_update_bits(priv->regmap, USB_R5, USB_R5_ID_DIG_EN_1,
> +			   USB_R5_ID_DIG_EN_1);
> +	regmap_update_bits(priv->regmap, USB_R5, USB_R5_ID_DIG_TH_MASK,
> +			   0xff << USB_R5_ID_DIG_TH_SHIFT);
> +
> +	return phy_meson_gxl_usb3_update_mode(phy);
> +}
> +
> +static int phy_meson_gxl_usb3_power_off(struct phy *phy)
> +{
> +	struct phy_meson_gxl_usb3_priv *priv = phy_get_drvdata(phy);
> +	int i, ret;
> +
> +	for (i = 0; i < priv->num_usb2_phys; i++) {
> +		ret = phy_power_off(priv->usb2_phys[i]);
> +		if (ret) {
> +			dev_err(&phy->dev,
> +				"Failed to power off related usb2-phy #%d\n",
> +				i);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static irqreturn_t phy_meson_gxl_usb3_irq(int irq, void *data)
> +{
> +	u32 val;
> +	struct phy_meson_gxl_usb3_priv *priv = data;
> +
> +	regmap_read(priv->regmap, USB_R5, &val);
> +	if (!(val & USB_R5_ID_DIG_IRQ)) {
> +		dev_err(&priv->this_phy->dev, "spurious interrupt\n");
> +		return IRQ_NONE;
> +	}
> +
> +	schedule_delayed_work(&priv->otg_work, msecs_to_jiffies(10));
> +
> +	/* acknowledge the IRQ */
> +	regmap_update_bits(priv->regmap, USB_R5, USB_R5_ID_DIG_IRQ, 0);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct phy_ops phy_meson_gxl_usb3_ops = {
> +	.init		= phy_meson_gxl_usb3_init,
> +	.exit		= phy_meson_gxl_usb3_exit,
> +	.power_on	= phy_meson_gxl_usb3_power_on,
> +	.power_off	= phy_meson_gxl_usb3_power_off,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static int phy_meson_gxl_usb3_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct phy_meson_gxl_usb3_priv *priv;
> +	struct resource *res;
> +	struct phy *phy;
> +	struct phy_provider *phy_provider;
> +	void __iomem *base;
> +	int i, irq;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	priv->regmap = devm_regmap_init_mmio(dev, base,
> +					     &phy_meson_gxl_usb3_regmap_conf);
> +	if (IS_ERR(priv->regmap))
> +		return PTR_ERR(priv->regmap);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq >= 0) {
> +		INIT_DELAYED_WORK(&priv->otg_work, phy_meson_gxl_usb3_work);
> +
> +		irq = devm_request_irq(dev, irq, phy_meson_gxl_usb3_irq,
> +				       IRQF_SHARED, dev_name(dev),
> +				       priv);
> +		if (irq < 0) {
> +			dev_err(dev, "could not register IRQ handler (%d)\n",
> +				irq);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	priv->num_usb2_phys = of_count_phandle_with_args(np, "phys",
> +							 "#phy-cells");
> +
> +	priv->usb2_phys = devm_kcalloc(dev, priv->num_usb2_phys,
> +				       sizeof(*priv->usb2_phys), GFP_KERNEL);
> +	if (!priv->usb2_phys)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < priv->num_usb2_phys; i++) {
> +		priv->usb2_phys[i] = devm_of_phy_get_by_index(dev, np, i);

I'm not sure if referencing usb2_phy from here is the right approach.

Thanks
Kishon
