From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 6 May 2014 17:53:30 -0300
Subject: [PATCH v3 17/20] phy: Add support for USB cluster on the Armada
 375 SoC
In-Reply-To: <1399335255-589-18-git-send-email-gregory.clement@free-electrons.com>
References: <1399335255-589-1-git-send-email-gregory.clement@free-electrons.com>
 <1399335255-589-18-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140506205330.GA27308@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On 06 May 02:14 AM, Gregory CLEMENT wrote:
> +
> +#define USB2_PHY_CONFIG_ENABLE BIT(0) /* active low */
> +

I still think it's more readable to use USB2_PHY_CONFIG_DISABLE.
It's just a nitpick, though.

> +static int armada375_usb_phy_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct phy *phy;
> +	struct device_node *np = dev->of_node;
> +	struct phy_provider *phy_provider;
> +	void __iomem *usb_cluster_base;
> +	struct device_node *xhci_node;
> +	int i;
> +
> +	usb_cluster_base = of_iomap(np, 0);
> +	BUG_ON(!usb_cluster_base);
> +

Isn't a bit extreme to call BUG_ON (and thus bring down the whole system)
in a phy driver?

> +	for (i = 0; i < NB_PHY; i++) {
> +		phy = devm_phy_create(dev, &armada375_usb_phy_ops, NULL);
> +		if (IS_ERR(phy))
> +			dev_err(dev, "failed to create PHY n%d\n", i);
> +

I think you're missing a continue/break here.

> +		usb_cluster_phy[i].phy = phy;
> +		usb_cluster_phy[i].reg = usb_cluster_base;
> +		usb_cluster_phy[i].enable = false;
> +		phy_set_drvdata(phy, &usb_cluster_phy[i]);
> +	}
> +
> +	usb_cluster_phy[PHY_USB2].use_usb3 = false;
> +	usb_cluster_phy[PHY_USB3].use_usb3 = true;
> +
[..]
> +
> +MODULE_DESCRIPTION("Armada 375 USB cluster driver");
> +MODULE_AUTHOR("Gregory CLEMENT <gregory.clement@free-electrons.com>");
> +MODULE_LICENSE("GPL");

GPL v2 ?

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
