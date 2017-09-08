From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 8 Sep 2017 16:00:20 +0200
Subject: [PATCH v5 10/10] net: stmmac: dwmac-sun8i: Handle
 integrated/external MDIOs
In-Reply-To: <20170908132632.GA3037@Red>
References: <20170908071156.5115-1-clabbe.montjoie@gmail.com>
 <20170908071156.5115-11-clabbe.montjoie@gmail.com>
 <20170908130520.GA11248@lunn.ch> <20170908132632.GA3037@Red>
Message-ID: <20170908140020.GC25219@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > +static int mdio_mux_syscon_switch_fn(int current_child, int desired_child,
> > > +				     void *data)
> > > +{
> > > +	struct stmmac_priv *priv = data;
> > > +	struct sunxi_priv_data *gmac = priv->plat->bsp_priv;
> > > +	u32 reg, val;
> > > +	int ret = 0;
> > > +	bool need_reset = false;
> > > +
> > > +	if (current_child ^ desired_child) {
> > > +		regmap_read(gmac->regmap, SYSCON_EMAC_REG, &reg);
> > > +		switch (desired_child) {
> > > +		case DWMAC_sUN8I_MDIO_MUX_INTERNAL_ID:
> > > +			dev_info(priv->device, "Switch mux to internal PHY");
> > > +			val = (reg & ~H3_EPHY_MUX_MASK) | H3_EPHY_SELECT;
> > > +			if (gmac->use_internal_phy)
> > > +				need_reset = true;
> > > +			break;
> > 
> > This i don't get. Why do you need use_internal_phy? Isn't that
> > implicit from DWMAC_sUN8I_MDIO_MUX_INTERNAL_ID? Is it even possible to
> > use an external PHY on the internal MDIO bus?
> > 
> 
> On my H3 box with external PHY, the MDIO mux library first select (for scan ?) the internal MDIO.
> Without use_internal_phy usage, this board will launch a reset to use the internal MDIO... and this reset timeout/fail.

Do you know why the reset times out/fails?

   Andrew
