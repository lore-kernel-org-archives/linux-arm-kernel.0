From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 May 2014 15:02:34 +0200
Subject: [PATCH v3 1/6] phy: add a driver for the Berlin SATA PHY
In-Reply-To: <1400060942-10588-2-git-send-email-antoine.tenart@free-electrons.com>
References: <1400060942-10588-1-git-send-email-antoine.tenart@free-electrons.com>
 <1400060942-10588-2-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <16480004.aaDhzlOZgi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 May 2014 11:48:57 Antoine T?nart wrote:
> +static int phy_berlin_sata_power_on(struct phy *phy)
> +{
> +       struct phy_berlin_desc *desc = phy_get_drvdata(phy);
> +       struct phy_berlin_priv *priv = to_berlin_sata_phy_priv(desc);
> +       u32 regval;
> +
> +       spin_lock(&priv->lock);
> +
> +       /* Power up PHY */
> +       writel(CONTROL_REGISTER, priv->base + HOST_VSA_ADDR);
> +       regval = readl(priv->base + HOST_VSA_DATA);
> +       regval &= ~(desc->val);
> +       writel(regval, priv->base + HOST_VSA_DATA);
> +
> +       /* Configure MBus */
> +       writel(MBUS_SIZE_CONTROL, priv->base + HOST_VSA_ADDR);
> +       regval = readl(priv->base + HOST_VSA_DATA);
> +       regval |= MBUS_WRITE_REQUEST_SIZE_128 | MBUS_READ_REQUEST_SIZE_128;
> +       writel(regval, priv->base + HOST_VSA_DATA);
> +
> +       spin_unlock(&priv->lock);
> +
> +       return 0;
> +}
> +
> +static int phy_berlin_sata_power_off(struct phy *phy)
> +{
> +       struct phy_berlin_desc *desc = phy_get_drvdata(phy);
> +       struct phy_berlin_priv *priv = to_berlin_sata_phy_priv(desc);
> +       u32 regval;
> +
> +       spin_lock(&priv->lock);
> +
> +       /* Power down PHY */
> +       writel(CONTROL_REGISTER, priv->base + HOST_VSA_ADDR);
> +       regval = readl(priv->base + HOST_VSA_DATA);
> +       regval |= desc->val;
> +       writel(regval, priv->base + HOST_VSA_DATA);
> +
> +       spin_unlock(&priv->lock);
> +
> +       return 0;

I don't get this part: you have a reference to the phy here,
but then you go poking the phy registers from the SATA driver
rather than calling a PHY API function.


> +                * By default the PHY node is used to request and match a PHY.
> +                * We describe one PHY per sub-node here. Use the right node.
> +                */
> +               phy->dev.of_node = child;
> +
> +               priv->phys[phy_id].phy = phy;
> +               priv->phys[phy_id].val = desc[phy_id].val;
> +               priv->phys[phy_id].index = phy_id;
> +               phy_set_drvdata(phy, &priv->phys[phy_id]);

And here, you set a driver specific value into a structure used by the
PHY.

Both of these are layering violations. You should either use the PHY
interfaces correctly so the SATA driver doesn't have to know about the
specific, or not use a PHY device node at all and do everything in
the SATA front-end.

	Arnd
