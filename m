From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Tue, 13 May 2014 14:14:50 +0200
Subject: [PATCH v2 1/6] phy: add a driver for the Berlin SATA PHY
In-Reply-To: <1399886217-20474-2-git-send-email-antoine.tenart@free-electrons.com>
References: <1399886217-20474-1-git-send-email-antoine.tenart@free-electrons.com>
 <1399886217-20474-2-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20140513121450.GC3213@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 12, 2014 at 11:16:52AM +0200, Antoine T?nart wrote:

[?]

> +static int phy_berlin_sata_probe(struct platform_device *pdev)
> +{
> +	struct phy *phy;
> +	struct phy_provider *phy_provider;
> +	struct priv *priv;
> +	struct resource *res;
> +	int i;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	priv->base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	phy = devm_phy_create(&pdev->dev, &phy_berlin_sata_ops, NULL);
> +	if (IS_ERR(phy))
> +		return PTR_ERR(phy);

Not needed.

Antoine

> +
> +	dev_set_drvdata(&pdev->dev, priv);
> +	spin_lock_init(&priv->lock);
> +
> +	for (i = 0; i < BERLIN_SATA_PHY_NB; i++) {
> +		struct phy *phy = devm_phy_create(&pdev->dev,
> +						  &phy_berlin_sata_ops, NULL);
> +		if (IS_ERR(phy)) {
> +			dev_err(&pdev->dev, "failed to create PHY %d\n", i);
> +			return PTR_ERR(phy);
> +		}
> +
> +		priv->phys[i].phy = phy;
> +		priv->phys[i].val = desc[i].val;
> +		priv->phys[i].index = i;
> +		phy_set_drvdata(phy, &priv->phys[i]);
> +
> +		/* Make sure the PHY is off */
> +		phy_berlin_sata_power_off(phy);
> +	}
> +
> +	phy_provider = devm_of_phy_provider_register(&pdev->dev,
> +						     berlin_sata_phy_xlate);
> +	if (IS_ERR(phy_provider))
> +		return PTR_ERR(phy_provider);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id phy_berlin_sata_of_match[] = {
> +	{ .compatible = "marvell,berlin-sata-phy" },
> +	{ },
> +};
> +
> +static struct platform_driver phy_berlin_sata_driver = {
> +	.probe	= phy_berlin_sata_probe,
> +	.driver	= {
> +		.name		= "phy-berlin-sata",
> +		.owner		= THIS_MODULE,
> +		.of_match_table	= phy_berlin_sata_of_match,
> +	},
> +};
> +module_platform_driver(phy_berlin_sata_driver);
> +
> +MODULE_DESCRIPTION("Marvell Berlin SATA PHY driver");
> +MODULE_AUTHOR("Antoine T?nart <antoine.tenart@free-electrons.com>");
> +MODULE_LICENSE("GPL");
> -- 
> 1.9.1
> 

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
