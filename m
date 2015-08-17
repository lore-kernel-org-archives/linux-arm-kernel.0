From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 17 Aug 2015 10:59:33 +0530
Subject: [PATCH v5 3/5] usb: phy: add usb3.0 phy driver for mt65xx SoCs
In-Reply-To: <1438950644-27290-4-git-send-email-chunfeng.yun@mediatek.com>
References: <1438950644-27290-1-git-send-email-chunfeng.yun@mediatek.com>
 <1438950644-27290-4-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <55D1713D.9070107@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday 07 August 2015 06:00 PM, Chunfeng Yun wrote:
> support usb3.0 phy of mt65xx SoCs
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

change $subject to phy:
> ---
>  drivers/phy/Kconfig           |   9 +
>  drivers/phy/Makefile          |   1 +
>  drivers/phy/phy-mt65xx-usb3.c | 467 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 477 insertions(+)
>  create mode 100644 drivers/phy/phy-mt65xx-usb3.c
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index c0e6ede..019cf8b 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -193,6 +193,15 @@ config PHY_HIX5HD2_SATA
>  	help
>  	  Support for SATA PHY on Hisilicon hix5hd2 Soc.
>  
> +config PHY_MT65XX_USB3
> +	tristate "Mediatek USB3.0 PHY Driver"
> +	depends on ARCH_MEDIATEK && OF
> +	select GENERIC_PHY
> +	help
> +	  Say 'Y' here to add support for Mediatek USB3.0 PHY driver
> +	  for mt65xx SoCs. it supports two usb2.0 ports and
> +	  one usb3.0 port.
> +
>  config PHY_SUN4I_USB
>  	tristate "Allwinner sunxi SoC USB PHY driver"
>  	depends on ARCH_SUNXI && HAS_IOMEM && OF
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index f344e1b..3ceff2a 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -22,6 +22,7 @@ obj-$(CONFIG_TI_PIPE3)			+= phy-ti-pipe3.o
>  obj-$(CONFIG_TWL4030_USB)		+= phy-twl4030-usb.o
>  obj-$(CONFIG_PHY_EXYNOS5250_SATA)	+= phy-exynos5250-sata.o
>  obj-$(CONFIG_PHY_HIX5HD2_SATA)		+= phy-hix5hd2-sata.o
> +obj-$(CONFIG_PHY_MT65XX_USB3)		+= phy-mt65xx-usb3.o
>  obj-$(CONFIG_PHY_SUN4I_USB)		+= phy-sun4i-usb.o
>  obj-$(CONFIG_PHY_SUN9I_USB)		+= phy-sun9i-usb.o
>  obj-$(CONFIG_PHY_SAMSUNG_USB2)		+= phy-exynos-usb2.o
> diff --git a/drivers/phy/phy-mt65xx-usb3.c b/drivers/phy/phy-mt65xx-usb3.c
> new file mode 100644
> index 0000000..6835bff
> --- /dev/null
> +++ b/drivers/phy/phy-mt65xx-usb3.c
.
.
<snip>
.
.
> +static struct phy *mt65xx_phy_xlate(struct device *dev,
> +					struct of_phandle_args *args)
> +{
> +	struct mt65xx_u3phy *u3phy = dev_get_drvdata(dev);
> +	struct mt65xx_phy_instance *instance = NULL;
> +	struct device_node *phy_np = args->np;
> +	struct resource res;
> +	int index;
> +	int ret;
> +
> +	if (args->args_count != 1) {
> +		dev_err(dev, "invalid number of cells in 'phy' property\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	for (index = 0; index < u3phy->nphys; index++)
> +		if (phy_np == u3phy->phys[index]->phy->dev.of_node) {
> +			instance = u3phy->phys[index];
> +			break;
> +		}
> +
> +	if (!instance) {
> +		dev_err(dev, "failed to find appropriate phy\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	instance->type = args->args[0];
> +
> +	if (!(instance->type == PHY_TYPE_USB2 ||
> +	      instance->type == PHY_TYPE_USB3)) {
> +		dev_err(dev, "unsupported device type: %d\n", instance->type);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	ret = of_address_to_resource(phy_np, 0, &res);
> +	if (ret) {
> +		dev_err(dev, "failed to get address resource, err-%d (index-%d)\n",
> +			ret, instance->index);
> +		return ERR_PTR(-EINVAL);
> +	}

This should be done in probe itself.
> +
> +	instance->port_base = devm_ioremap_resource(&instance->phy->dev, &res);
> +	if (IS_ERR(instance->port_base)) {
> +		dev_err(dev, "failed to remap sif regs\n");
> +		return instance->port_base;
> +	}

This too should be done in probe.
> +
> +	return instance->phy;
> +}
> +
> +static struct phy_ops mt65xx_u3phy_ops = {
> +	.init		= mt65xx_phy_init,
> +	.power_on	= mt65xx_phy_power_on,
> +	.power_off	= mt65xx_phy_power_off,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static int mt65xx_u3phy_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct device_node *child_np;
> +	struct phy_provider *phy_provider;
> +	struct resource *sif_res;
> +	struct mt65xx_u3phy *u3phy;
> +	int port;
> +
> +	u3phy = devm_kzalloc(dev, sizeof(*u3phy), GFP_KERNEL);
> +	if (!u3phy)
> +		return -ENOMEM;
> +
> +	u3phy->nphys = of_get_child_count(np);
> +	u3phy->phys = devm_kcalloc(dev, u3phy->nphys,
> +				       sizeof(*u3phy->phys), GFP_KERNEL);
> +	if (!u3phy->phys)
> +		return -ENOMEM;
> +
> +	u3phy->dev = dev;
> +	platform_set_drvdata(pdev, u3phy);
> +
> +	sif_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	u3phy->sif_base = devm_ioremap_resource(dev, sif_res);
> +	if (IS_ERR(u3phy->sif_base)) {
> +		dev_err(dev, "failed to remap sif regs\n");
> +		return PTR_ERR(u3phy->sif_base);
> +	}
> +
> +	u3phy->u3phya_ref = devm_clk_get(dev, "u3phya_ref");
> +	if (IS_ERR(u3phy->u3phya_ref)) {
> +		dev_err(dev, "error to get u3phya_ref\n");
> +		return PTR_ERR(u3phy->u3phya_ref);
> +	}
> +
> +	port = 0;
> +	for_each_child_of_node(np, child_np) {
> +		struct mt65xx_phy_instance *instance;
> +		struct phy *phy;
> +
> +		instance = devm_kzalloc(dev, sizeof(*instance), GFP_KERNEL);
> +		if (!instance)
> +			return -ENOMEM;
> +
> +		u3phy->phys[port] = instance;
> +
> +		phy = devm_phy_create(dev, child_np, &mt65xx_u3phy_ops);
> +		if (IS_ERR(phy)) {
> +			dev_err(dev, "failed to create phy\n");
> +			return PTR_ERR(phy);
> +		}
> +		instance->phy = phy;
> +		instance->index = port;

'index' here is not used anywhere.
> +		phy_set_drvdata(phy, instance);
> +		port++;
> +	}
> +
> +	phy_provider = devm_of_phy_provider_register(dev, mt65xx_phy_xlate);
> +	if (IS_ERR(phy_provider)) {
> +		dev_err(dev, "Failed to register phy provider\n");
> +		return PTR_ERR(phy_provider);
> +	}
> +
> +	return u3phy_clk_enable(u3phy);

Can't we clk enable in phy_init or phy-power_on where it is actually needed.

Thanks
Kishon
