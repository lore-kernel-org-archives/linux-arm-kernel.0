From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 13 Feb 2014 20:37:02 +0100
Subject: [PATCH 4/6] net: cpsw: Use cpsw-ctrl-macid driver
In-Reply-To: <1387385242-1161-5-git-send-email-mpa@pengutronix.de>
References: <1387385242-1161-1-git-send-email-mpa@pengutronix.de>
 <1387385242-1161-5-git-send-email-mpa@pengutronix.de>
Message-ID: <20140213193702.GE17650@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Markus,

On Wed, Dec 18, 2013 at 05:47:20PM +0100, Markus Pargmann wrote:
> Use ctrl-macid driver to obtain the macids stored in the processor. This
> is only done when defined in DT.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/net/cpsw.txt |  5 +++++
>  drivers/net/ethernet/ti/cpsw.c                 | 18 ++++++++++++++----
>  drivers/net/ethernet/ti/cpsw.h                 |  2 ++
>  3 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/cpsw.txt b/Documentation/devicetree/bindings/net/cpsw.txt
> index c39f077..b95c38b 100644
> --- a/Documentation/devicetree/bindings/net/cpsw.txt
> +++ b/Documentation/devicetree/bindings/net/cpsw.txt
> @@ -34,6 +34,11 @@ Required properties:
>  Optional properties:
>  - dual_emac_res_vlan	: Specifies VID to be used to segregate the ports
>  - mac-address		: Specifies slave MAC address
> +- ti,mac-address-ctrl	: When cpsw-ctrl-macid support is compiledin, this can
> +			  be set to a phandle with one argument, see
> +			  cpsw-ctrl-macid.txt. If this method fails, cpsw falls
> +			  back to mac-address or random mac-address.
> +
>  
>  Note: "ti,hwmods" field is used to fetch the base address and irq
>  resources from TI, omap hwmod data base during device registration.
> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
> index 5120d9c..382d793 100644
> --- a/drivers/net/ethernet/ti/cpsw.c
> +++ b/drivers/net/ethernet/ti/cpsw.c
> @@ -1804,9 +1804,16 @@ static int cpsw_probe_dt(struct cpsw_platform_data *data,
>  		snprintf(slave_data->phy_id, sizeof(slave_data->phy_id),
>  			 PHY_ID_FMT, mdio->name, phyid);
>  
> -		mac_addr = of_get_mac_address(slave_node);
> -		if (mac_addr)
> -			memcpy(slave_data->mac_addr, mac_addr, ETH_ALEN);
> +		ret = cpsw_ctrl_macid_read(slave_node, slave_data->mac_addr);
> +		if (ret) {
> +			if (ret == -EPROBE_DEFER)
> +				return ret;
> +
> +			mac_addr = of_get_mac_address(slave_node);
> +			if (mac_addr)
> +				memcpy(slave_data->mac_addr, mac_addr,
> +						ETH_ALEN);
> +		}
I'd do it the other way round: Use the contents from an explicit
"mac-address" or "local-mac-address" property (i.e. of_get_mac_address)
and if that doesn't return anything use the mac-address-ctrl as
fallback.

>  
>  		slave_data->phy_if = of_get_phy_mode(slave_node);
>  
> @@ -1946,10 +1953,13 @@ static int cpsw_probe(struct platform_device *pdev)
>  	/* Select default pin state */
>  	pinctrl_pm_select_default_state(&pdev->dev);
>  
> -	if (cpsw_probe_dt(&priv->data, pdev)) {
> +	ret = cpsw_probe_dt(&priv->data, pdev);
> +	if (ret == -EINVAL) {
>  		pr_err("cpsw: platform data missing\n");
>  		ret = -ENODEV;
>  		goto clean_runtime_disable_ret;
> +	} else if (ret) {
> +		goto clean_runtime_disable_ret;
>  	}
>  	data = &priv->data;
>  
> diff --git a/drivers/net/ethernet/ti/cpsw.h b/drivers/net/ethernet/ti/cpsw.h
> index 1b71067..222eebe 100644
> --- a/drivers/net/ethernet/ti/cpsw.h
> +++ b/drivers/net/ethernet/ti/cpsw.h
> @@ -42,4 +42,6 @@ struct cpsw_platform_data {
>  
>  void cpsw_phy_sel(struct device *dev, phy_interface_t phy_mode, int slave);
>  
> +int cpsw_ctrl_macid_read(struct device_node *np, u8 *mac_addr);
> +
>  #endif /* __CPSW_H__ */
> -- 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
