From: robh@kernel.org (Rob Herring)
Date: Wed, 25 Nov 2015 16:11:06 -0600
Subject: [PATCH v3 2/2] phy-sun4i-usb: Add support for the host usb-phys
 found on the H3 SoC
In-Reply-To: <1448470202-3628-2-git-send-email-hdegoede@redhat.com>
References: <1448470202-3628-1-git-send-email-hdegoede@redhat.com>
 <1448470202-3628-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20151125221046.GA25917@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 05:50:02PM +0100, Hans de Goede wrote:
> From: Reinder de Haan <patchesrdh@mveas.com>
> 
> Note this commit only adds support for phys 1-3, phy 0, the otg phy, is
> not yet (fully) supported after this commit.

Shouldn't the OTG phy have a different compatible string?

> 
> Signed-off-by: Reinder de Haan <patchesrdh@mveas.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Change break; after dev_err() to return, as intended, fixing a compiler
>  warning (the dev_err case should never be reached)
> Changes in v3:
> -Use of_match_node to get model specific config data
> ---
>  .../devicetree/bindings/phy/sun4i-usb-phy.txt      |  1 +
>  drivers/phy/phy-sun4i-usb.c                        | 46 +++++++++++++++++-----
>  2 files changed, 38 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
> index 0cebf74..95736d7 100644
> --- a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
> @@ -9,6 +9,7 @@ Required properties:
>    * allwinner,sun7i-a20-usb-phy
>    * allwinner,sun8i-a23-usb-phy
>    * allwinner,sun8i-a33-usb-phy
> +  * allwinner,sun8i-h3-usb-phy
>  - reg : a list of offset + length pairs
>  - reg-names :
>    * "phy_ctrl"
> diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
> index 1d8f85d..2aed482 100644
> --- a/drivers/phy/phy-sun4i-usb.c
> +++ b/drivers/phy/phy-sun4i-usb.c
> @@ -46,6 +46,9 @@
>  #define REG_PHYBIST			0x08
>  #define REG_PHYTUNE			0x0c
>  #define REG_PHYCTL_A33			0x10
> +#define REG_PHY_UNK_H3			0x20
> +
> +#define REG_PMU_UNK_H3			0x10
>  
>  #define PHYCTL_DATA			BIT(7)
>  
> @@ -79,7 +82,7 @@
>  #define PHY_DISCON_TH_SEL		0x2a
>  #define PHY_SQUELCH_DETECT		0x3c
>  
> -#define MAX_PHYS			3
> +#define MAX_PHYS			4
>  
>  /*
>   * Note do not raise the debounce time, we must report Vusb high within 100ms
> @@ -91,6 +94,7 @@
>  enum sun4i_usb_phy_type {
>  	sun4i_a10_phy,
>  	sun8i_a33_phy,
> +	sun8i_h3_phy,
>  };
>  
>  struct sun4i_usb_phy_cfg {
> @@ -101,6 +105,7 @@ struct sun4i_usb_phy_cfg {
>  };
>  
>  struct sun4i_usb_phy_data {
> +	struct device *dev;
>  	void __iomem *base;
>  	const struct sun4i_usb_phy_cfg *cfg;
>  	struct mutex mutex;
> @@ -183,6 +188,9 @@ static void sun4i_usb_phy_write(struct sun4i_usb_phy *phy, u32 addr, u32 data,
>  		/* A33 needs us to set phyctl to 0 explicitly */
>  		writel(0, phyctl);
>  		break;
> +	case sun8i_h3_phy:
> +		dev_err(phy_data->dev, "H3 usb_phy_write is not supported\n");
> +		return;
>  	}
>  
>  	for (i = 0; i < len; i++) {
> @@ -243,6 +251,7 @@ static int sun4i_usb_phy_init(struct phy *_phy)
>  	struct sun4i_usb_phy *phy = phy_get_drvdata(_phy);
>  	struct sun4i_usb_phy_data *data = to_sun4i_usb_phy_data(phy);
>  	int ret;
> +	u32 val;
>  
>  	ret = clk_prepare_enable(phy->clk);
>  	if (ret)
> @@ -254,16 +263,26 @@ static int sun4i_usb_phy_init(struct phy *_phy)
>  		return ret;
>  	}
>  
> -	/* Enable USB 45 Ohm resistor calibration */
> -	if (phy->index == 0)
> -		sun4i_usb_phy_write(phy, PHY_RES45_CAL_EN, 0x01, 1);
> +	if (data->cfg->type == sun8i_h3_phy) {
> +		if (phy->index == 0) {
> +			val = readl(data->base + REG_PHY_UNK_H3);
> +			writel(val & ~1, data->base + REG_PHY_UNK_H3);
> +		}
>  
> -	/* Adjust PHY's magnitude and rate */
> -	sun4i_usb_phy_write(phy, PHY_TX_AMPLITUDE_TUNE, 0x14, 5);
> +		val = readl(phy->pmu + REG_PMU_UNK_H3);
> +		writel(val & ~2, phy->pmu + REG_PMU_UNK_H3);
> +	} else {
> +		/* Enable USB 45 Ohm resistor calibration */
> +		if (phy->index == 0)
> +			sun4i_usb_phy_write(phy, PHY_RES45_CAL_EN, 0x01, 1);
>  
> -	/* Disconnect threshold adjustment */
> -	sun4i_usb_phy_write(phy, PHY_DISCON_TH_SEL,
> -			    data->cfg->disc_thresh, 2);
> +		/* Adjust PHY's magnitude and rate */
> +		sun4i_usb_phy_write(phy, PHY_TX_AMPLITUDE_TUNE, 0x14, 5);
> +
> +		/* Disconnect threshold adjustment */
> +		sun4i_usb_phy_write(phy, PHY_DISCON_TH_SEL,
> +				    data->cfg->disc_thresh, 2);
> +	}
>  
>  	sun4i_usb_phy_passby(phy, 1);
>  
> @@ -555,6 +574,13 @@ static const struct sun4i_usb_phy_cfg sun8i_a33_cfg = {
>  	.dedicated_clocks = true,
>  };
>  
> +static const struct sun4i_usb_phy_cfg sun8i_h3_cfg = {
> +	.num_phys = 4,
> +	.disc_thresh = 3,
> +	.type = sun8i_h3_phy,
> +	.dedicated_clocks = true,
> +};
> +
>  static const struct of_device_id sun4i_usb_phy_of_match[] = {
>  	{ .compatible = "allwinner,sun4i-a10-usb-phy", .data = &sun4i_a10_cfg },
>  	{ .compatible = "allwinner,sun5i-a13-usb-phy", .data = &sun5i_a13_cfg },
> @@ -562,6 +588,7 @@ static const struct of_device_id sun4i_usb_phy_of_match[] = {
>  	{ .compatible = "allwinner,sun7i-a20-usb-phy", .data = &sun7i_a20_cfg },
>  	{ .compatible = "allwinner,sun8i-a23-usb-phy", .data = &sun8i_a23_cfg },
>  	{ .compatible = "allwinner,sun8i-a33-usb-phy", .data = &sun8i_a33_cfg },
> +	{ .compatible = "allwinner,sun8i-h3-usb-phy", .data = &sun8i_h3_cfg },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, sun4i_usb_phy_of_match);
> @@ -595,6 +622,7 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
>  	mutex_init(&data->mutex);
>  	INIT_DELAYED_WORK(&data->detect, sun4i_usb_phy0_id_vbus_det_scan);
>  	dev_set_drvdata(dev, data);
> +	data->dev = dev;
>  	data->cfg = match->data;
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy_ctrl");
> -- 
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
