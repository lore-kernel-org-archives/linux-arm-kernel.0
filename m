From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 26 Jul 2017 18:14:13 +0200
Subject: [PATCH net-next 05/18] net: mvpp2: initialize the GMAC when
 using a port
In-Reply-To: <20170724134848.19330-6-antoine.tenart@free-electrons.com>
References: <20170724134848.19330-1-antoine.tenart@free-electrons.com>
 <20170724134848.19330-6-antoine.tenart@free-electrons.com>
Message-ID: <20170726161413.GH12049@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +	} else if (port->phy_interface == PHY_INTERFACE_MODE_RGMII) {

Don't forget:
   PHY_INTERFACE_MODE_RGMII_ID,
   PHY_INTERFACE_MODE_RGMII_RXID,
   PHY_INTERFACE_MODE_RGMII_TXID,

> +		val = readl(port->base + MVPP22_GMAC_CTRL_4_REG);
> +		val |= MVPP22_CTRL4_EXT_PIN_GMII_SEL |
> +		       MVPP22_CTRL4_SYNC_BYPASS_DIS |
> +		       MVPP22_CTRL4_QSGMII_BYPASS_ACTIVE;
> +		val &= ~MVPP22_CTRL4_DP_CLK_SEL;
> +		writel(val, port->base + MVPP22_GMAC_CTRL_4_REG);
> +
> +		val = readl(port->base + MVPP2_GMAC_CTRL_2_REG);
> +		val &= ~MVPP2_GMAC_DISABLE_PADDING;
> +		writel(val, port->base + MVPP2_GMAC_CTRL_2_REG);
> +	}
> +
> +	/* The port is connected to a copper PHY */
> +	val = readl(port->base + MVPP2_GMAC_CTRL_0_REG);
> +	val &= ~MVPP2_GMAC_PORT_TYPE_MASK;
> +	writel(val, port->base + MVPP2_GMAC_CTRL_0_REG);
> +
> +	val = readl(port->base + MVPP2_GMAC_AUTONEG_CONFIG);
> +	val |= MVPP2_GMAC_IN_BAND_AUTONEG |
> +	       MVPP2_GMAC_IN_BAND_AUTONEG_BYPASS |
> +	       MVPP2_GMAC_AN_SPEED_EN | MVPP2_GMAC_FLOW_CTRL_AUTONEG |
> +	       MVPP2_GMAC_AN_DUPLEX_EN;
> +	writel(val, port->base + MVPP2_GMAC_AUTONEG_CONFIG);
> +}
> +
> +static void mvpp2_port_mii_gmac_configure(struct mvpp2_port *port)
> +{
> +	u32 val;
> +
> +	/* Force link down */
> +	val = readl(port->base + MVPP2_GMAC_AUTONEG_CONFIG);
> +	val |= MVPP2_GMAC_FORCE_LINK_DOWN;
> +	writel(val, port->base + MVPP2_GMAC_AUTONEG_CONFIG);
> +
> +	/* Set the GMAC in a reset state */
> +	val = readl(port->base + MVPP2_GMAC_CTRL_2_REG);
> +	val |= MVPP2_GMAC_PORT_RESET_MASK;
> +	writel(val, port->base + MVPP2_GMAC_CTRL_2_REG);
> +
> +	/* Configure the PCS and in-band AN */
> +	val = readl(port->base + MVPP2_GMAC_CTRL_2_REG);
> +	if (port->phy_interface == PHY_INTERFACE_MODE_SGMII) {
> +	        val |= MVPP2_GMAC_INBAND_AN_MASK | MVPP2_GMAC_PCS_ENABLE_MASK;
> +	} else if (port->phy_interface == PHY_INTERFACE_MODE_RGMII) {

phy_interface_is_rgmii()

	Andrew
