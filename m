From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 26 Oct 2016 14:50:39 -0700
Subject: [PATCH 4/5] net: ethernet: bgmac: add NS2 support
In-Reply-To: <1477510561-17035-5-git-send-email-jon.mason@broadcom.com>
References: <1477510561-17035-1-git-send-email-jon.mason@broadcom.com>
 <1477510561-17035-5-git-send-email-jon.mason@broadcom.com>
Message-ID: <eff0c717-ec4b-1dce-992a-ad5e958800f5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/26/2016 12:36 PM, Jon Mason wrote:
> Add support for the variant of amac hardware present in the Broadcom
> Northstar2 based SoCs.  Northstar2 requires an additional register to be
> configured with the port speed/duplexity (NICPM).  This can be added to
> the link callback to hide it from the instances that do not use this.
> Also, the bgmac_chip_reset() was intentionally removed to prevent the
> resetting of the chip to the default values on open.  Finally, clearing
> of the pending interrupts on init is required due to observed issues on
> some platforms.
> 
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
> ---

> +static void bgmac_nicpm_speed_set(struct net_device *net_dev)
> +{
> +	struct bgmac *bgmac = netdev_priv(net_dev);
> +	u32 val;
> +
> +	if (!bgmac->plat.nicpm_base)
> +		return;
> +
> +	val = NICPM_IOMUX_CTRL_INIT_VAL;
> +	switch (bgmac->net_dev->phydev->speed) {
> +	default:
> +		pr_err("Unsupported speed.  Defaulting to 1000Mb\n");
> +	case SPEED_1000:
> +		val |= NICPM_IOMUX_CTRL_SPD_1000M << NICPM_IOMUX_CTRL_SPD_SHIFT;
> +		break;
> +	case SPEED_100:
> +		val |= NICPM_IOMUX_CTRL_SPD_100M << NICPM_IOMUX_CTRL_SPD_SHIFT;
> +		break;
> +	case SPEED_10:
> +		val |= NICPM_IOMUX_CTRL_SPD_10M << NICPM_IOMUX_CTRL_SPD_SHIFT;
> +		break;
> +	}
> +
> +	writel(val, bgmac->plat.nicpm_base + NICPM_IOMUX_CTRL);
> +
> +	usleep_range(10, 100);

Does not seem like a good idea, do you need that sleep?

> +
> +	bgmac_adjust_link(bgmac->net_dev);
> +}
> +
>  static int platform_phy_connect(struct bgmac *bgmac)
>  {
>  	struct phy_device *phy_dev;
>  
> -	phy_dev = of_phy_get_and_connect(bgmac->net_dev, bgmac->dev->of_node,
> -					 bgmac_adjust_link);
> +	if (bgmac->plat.nicpm_base)
> +		phy_dev = of_phy_get_and_connect(bgmac->net_dev,
> +						 bgmac->dev->of_node,
> +						 bgmac_nicpm_speed_set);
> +	else
> +		phy_dev = of_phy_get_and_connect(bgmac->net_dev,
> +						 bgmac->dev->of_node,
> +						 bgmac_adjust_link);
>  	if (!phy_dev) {
>  		dev_err(bgmac->dev, "Phy connect failed\n");
>  		return -ENODEV;
>  	}
>  
> +	if (bgmac->feature_flags & BGMAC_FEAT_LANE_SWAP)
> +		phy_dev->dev_flags |= PHY_BRCM_EXP_LANE_SWAP;
> +
>  	return 0;
>  }
>  
> @@ -140,6 +188,9 @@ static int bgmac_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, bgmac);
>  
> +	if (of_property_read_bool(np, "brcm,enet-phy-lane-swap"))
> +		bgmac->feature_flags |= BGMAC_FEAT_LANE_SWAP;
> +
>  	/* Set the features of the 4707 family */
>  	bgmac->feature_flags |= BGMAC_FEAT_CLKCTLST;
>  	bgmac->feature_flags |= BGMAC_FEAT_NO_RESET;
> @@ -182,6 +233,14 @@ static int bgmac_probe(struct platform_device *pdev)
>  	if (IS_ERR(bgmac->plat.idm_base))
>  		return PTR_ERR(bgmac->plat.idm_base);
>  
> +	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, "nicpm_base");
> +	if (regs) {
> +		bgmac->plat.nicpm_base = devm_ioremap_resource(&pdev->dev,
> +							       regs);
> +		if (IS_ERR(bgmac->plat.nicpm_base))
> +			return PTR_ERR(bgmac->plat.nicpm_base);
> +	}
> +
>  	bgmac->read = platform_bgmac_read;
>  	bgmac->write = platform_bgmac_write;
>  	bgmac->idm_read = platform_bgmac_idm_read;
> @@ -213,6 +272,7 @@ static int bgmac_remove(struct platform_device *pdev)
>  static const struct of_device_id bgmac_of_enet_match[] = {
>  	{.compatible = "brcm,amac",},
>  	{.compatible = "brcm,nsp-amac",},
> +	{.compatible = "brcm,ns2-amac",},
>  	{},
>  };
>  
> diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
> index 38876ec..1796208 100644
> --- a/drivers/net/ethernet/broadcom/bgmac.c
> +++ b/drivers/net/ethernet/broadcom/bgmac.c
> @@ -1082,6 +1082,9 @@ static void bgmac_enable(struct bgmac *bgmac)
>  /* http://bcm-v4.sipsolutions.net/mac-gbit/gmac/chipinit */
>  static void bgmac_chip_init(struct bgmac *bgmac)
>  {
> +	/* Clear any erroneously pending interrupts */
> +	bgmac_write(bgmac, BGMAC_INT_STATUS, ~0);
> +
>  	/* 1 interrupt per received frame */
>  	bgmac_write(bgmac, BGMAC_INT_RECV_LAZY, 1 << BGMAC_IRL_FC_SHIFT);
>  
> @@ -1158,8 +1161,6 @@ static int bgmac_open(struct net_device *net_dev)
>  	struct bgmac *bgmac = netdev_priv(net_dev);
>  	int err = 0;
>  
> -	bgmac_chip_reset(bgmac);
> -

Is this removal intentional? Maybe it should be special cased with
checking for a NS2 BGMAC instance and not do it in that case?
-- 
Florian
