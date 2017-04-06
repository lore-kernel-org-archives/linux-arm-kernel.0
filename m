From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 6 Apr 2017 16:07:55 +0530
Subject: [PATCH 1/3] phy: rockchip-usb: Add vbus regulator support.
In-Reply-To: <20170405140613.4444-2-sjoerd.simons@collabora.co.uk>
References: <20170405140613.4444-1-sjoerd.simons@collabora.co.uk>
 <20170405140613.4444-2-sjoerd.simons@collabora.co.uk>
Message-ID: <59ed8834-75d4-2001-73d4-6081d42d2aeb@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 05 April 2017 07:36 PM, Sjoerd Simons wrote:
> On rockchip devices vbus is supplied by a separate power supply, often
> through a regulator. Add support for describing the the regulator in
> device-tree following the same convention as several other usb phy's.
> 
merged, thanks.

-Kishon
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> ---
> 
>  .../devicetree/bindings/phy/rockchip-usb-phy.txt      |  1 +
>  drivers/phy/phy-rockchip-usb.c                        | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt b/Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt
> index 57dc388e2fa2..4ed569046daf 100644
> --- a/Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt
> @@ -30,6 +30,7 @@ Optional Properties:
>  - reset-names: Only allow the following entries:
>   - phy-reset
>  - resets: Must contain an entry for each entry in reset-names.
> +- vbus-supply: power-supply phandle for vbus power source
>  
>  Example:
>  
> diff --git a/drivers/phy/phy-rockchip-usb.c b/drivers/phy/phy-rockchip-usb.c
> index 734987fa0ad7..3378eeb7a562 100644
> --- a/drivers/phy/phy-rockchip-usb.c
> +++ b/drivers/phy/phy-rockchip-usb.c
> @@ -66,6 +66,7 @@ struct rockchip_usb_phy {
>  	struct phy	*phy;
>  	bool		uart_enabled;
>  	struct reset_control *reset;
> +	struct regulator *vbus;
>  };
>  
>  static int rockchip_usb_phy_power(struct rockchip_usb_phy *phy,
> @@ -88,6 +89,9 @@ static void rockchip_usb_phy480m_disable(struct clk_hw *hw)
>  						    struct rockchip_usb_phy,
>  						    clk480m_hw);
>  
> +	if (phy->vbus)
> +		regulator_disable(phy->vbus);
> +
>  	/* Power down usb phy analog blocks by set siddq 1 */
>  	rockchip_usb_phy_power(phy, 1);
>  }
> @@ -143,6 +147,14 @@ static int rockchip_usb_phy_power_on(struct phy *_phy)
>  	if (phy->uart_enabled)
>  		return -EBUSY;
>  
> +	if (phy->vbus) {
> +		int ret;
> +
> +		ret = regulator_enable(phy->vbus);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return clk_prepare_enable(phy->clk480m);
>  }
>  
> @@ -268,6 +280,13 @@ static int rockchip_usb_phy_init(struct rockchip_usb_phy_base *base,
>  	}
>  	phy_set_drvdata(rk_phy->phy, rk_phy);
>  
> +	rk_phy->vbus = devm_regulator_get_optional(&rk_phy->phy->dev, "vbus");
> +	if (IS_ERR(rk_phy->vbus)) {
> +		if (PTR_ERR(rk_phy->vbus) == -EPROBE_DEFER)
> +			return PTR_ERR(rk_phy->vbus);
> +		rk_phy->vbus = NULL;
> +	}
> +
>  	/*
>  	 * When acting as uart-pipe, just keep clock on otherwise
>  	 * only power up usb phy when it use, so disable it when init
> 
