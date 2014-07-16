From: varkabhadram@gmail.com (Varka Bhadram)
Date: Wed, 16 Jul 2014 14:49:05 +0530
Subject: [PATCH v3 05/12] phy: add the Berlin USB PHY driver
In-Reply-To: <1405499166-6726-6-git-send-email-antoine.tenart@free-electrons.com>
References: <1405499166-6726-1-git-send-email-antoine.tenart@free-electrons.com>
 <1405499166-6726-6-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <53C64389.3050705@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/2014 01:55 PM, Antoine T?nart wrote:
> +static const struct of_device_id phy_berlin_sata_of_match[] = {
> +	{
> +		.compatible = "marvell,berlin2-usb-phy",
> +		.data = &phy_berlin_pll_dividers[0],
> +	},
> +	{
> +		.compatible = "marvell,berlin2cd-usb-phy",
> +		.data = &phy_berlin_pll_dividers[1],
> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, phy_berlin_sata_of_match);
> +

It looks good if we move this after probe().. So that we can see of_match_table directly...

> +static int phy_berlin_usb_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *match =
> +		of_match_device(phy_berlin_sata_of_match, &pdev->dev);
> +	struct phy_berlin_usb_priv *priv;
> +	struct resource *res;
> +	struct phy_provider *phy_provider;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	priv->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	priv->rst_ctrl = devm_reset_control_get(&pdev->dev, NULL);
> +	if (IS_ERR(priv->rst_ctrl))
> +		return PTR_ERR(priv->rst_ctrl);
> +
> +	priv->pll_divider = *((u32 *)match->data);
> +
> +	priv->phy = devm_phy_create(&pdev->dev, &phy_berlin_usb_ops, NULL);
> +	if (IS_ERR(priv->phy)) {
> +		dev_err(&pdev->dev, "failed to create PHY\n");
> +		return PTR_ERR(priv->phy);
> +	}
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	phy_provider =
> +		devm_of_phy_provider_register(&pdev->dev, of_phy_simple_xlate);
> +	if (IS_ERR(phy_provider))
> +		return PTR_ERR(phy_provider);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver phy_berlin_usb_driver = {
> +	.probe	= phy_berlin_usb_probe,
> +	.driver	= {
> +		.name		= "phy-berlin-usb",
> +		.owner		= THIS_MODULE,

No need to update owner field.

-- 
Regards,
Varka Bhadram.
