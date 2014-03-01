From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Sat, 1 Mar 2014 23:07:56 +0530
Subject: [PATCH v4] PHY: sunxi: Add driver for sunxi usb phy
In-Reply-To: <1393693766-15352-2-git-send-email-hdegoede@redhat.com>
References: <1393693766-15352-1-git-send-email-hdegoede@redhat.com>
 <1393693766-15352-2-git-send-email-hdegoede@redhat.com>
Message-ID: <53121AF4.4080802@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Saturday 01 March 2014 10:39 PM, Hans de Goede wrote:
> The Allwinner A1x / A2x SoCs have 2 or 3 usb phys which are all accessed
> through a single set of registers. Besides this there are also some other
> phy related bits which need poking, which are per phy, but shared between the
> ohci and ehci controllers, so these are also controlled from this new phy
> driver.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>   .../devicetree/bindings/phy/sun4i-usb-phy.txt      |  26 ++
>   drivers/phy/Kconfig                                |  11 +
>   drivers/phy/Makefile                               |   1 +
>   drivers/phy/phy-sun4i-usb.c                        | 331 +++++++++++++++++++++
>   4 files changed, 369 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
>   create mode 100644 drivers/phy/phy-sun4i-usb.c
>
..
<snip>
.
.

> +static int sun4i_usb_phy_init(struct phy *_phy)
> +{
> +	struct sun4i_usb_phy *phy = phy_get_drvdata(_phy);
> +	struct sun4i_usb_phy_data *data = to_sun4i_usb_phy_data(phy);
> +	int ret;
> +
> +	ret = clk_prepare_enable(data->clk);
> +	if (ret)
dev_err here?
> +		return ret;
> +
> +	ret = reset_control_deassert(phy->reset);
> +	if (ret) {

here too..
> +		clk_disable_unprepare(data->clk);
> +		return ret;
> +	}
> +
> +	/* Adjust PHY's magnitude and rate */
> +	sun4i_usb_phy_write(phy, PHY_TX_AMPLITUDE_TUNE, 0x14, 5);
> +
> +	/* Disconnect threshold adjustment */
> +	sun4i_usb_phy_write(phy, PHY_DISCON_TH_SEL, data->disc_thresh, 2);
> +
> +	sun4i_usb_phy_passby(phy, 1);
> +
> +	return 0;
> +}
> +
> +static int sun4i_usb_phy_exit(struct phy *_phy)
> +{
> +	struct sun4i_usb_phy *phy = phy_get_drvdata(_phy);
> +	struct sun4i_usb_phy_data *data = to_sun4i_usb_phy_data(phy);
> +
> +	sun4i_usb_phy_passby(phy, 0);
> +	reset_control_assert(phy->reset);
> +	clk_disable_unprepare(data->clk);
> +
> +	return 0;
> +}
> +
> +static int sun4i_usb_phy_power_on(struct phy *_phy)
> +{
> +	struct sun4i_usb_phy *phy = phy_get_drvdata(_phy);
> +	int ret = 0;
> +
> +	if (phy->vbus)
> +		ret = regulator_enable(phy->vbus);
dev_err here too..
> +
> +	return ret;
> +}
> +
> +static int sun4i_usb_phy_power_off(struct phy *_phy)
> +{
> +	struct sun4i_usb_phy *phy = phy_get_drvdata(_phy);
> +
> +	if (phy->vbus)
> +		regulator_disable(phy->vbus);
> +
> +	return 0;
> +}
> +
> +static struct phy_ops sun4i_usb_phy_ops = {
> +	.init		= sun4i_usb_phy_init,
> +	.exit		= sun4i_usb_phy_exit,
> +	.power_on	= sun4i_usb_phy_power_on,
> +	.power_off	= sun4i_usb_phy_power_off,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static struct phy *sun4i_usb_phy_xlate(struct device *dev,
> +					struct of_phandle_args *args)
> +{
> +	struct sun4i_usb_phy_data *data = dev_get_drvdata(dev);
> +
> +	if (WARN_ON(args->args[0] == 0 || args->args[0] >= data->num_phys))
> +		return ERR_PTR(-ENODEV);
> +
> +	return data->phys[args->args[0]].phy;
> +}
> +
> +static int sun4i_usb_phy_probe(struct platform_device *pdev)
> +{
> +	struct sun4i_usb_phy_data *data;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	void __iomem *pmu = NULL;
> +	struct phy_provider *phy_provider;
> +	struct reset_control *reset;
> +	struct regulator *vbus;
> +	struct resource *res;
> +	struct phy *phy;
> +	char name[16];
> +	int i;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	mutex_init(&data->mutex);
> +
> +	if (of_device_is_compatible(np, "allwinner,sun5i-a13-usb-phy"))
> +		data->num_phys = 2;
> +	else
> +		data->num_phys = 3;
> +
> +	if (of_device_is_compatible(np, "allwinner,sun4i-a10-usb-phy"))
> +		data->disc_thresh = 3;
> +	else
> +		data->disc_thresh = 2;

These 'data' can actually be part of 'of_device_id' table and can be 
obtained by using 'of_match_device'.

Thanks
Kishon
