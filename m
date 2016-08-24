From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Wed, 24 Aug 2016 14:02:21 +0200
Subject: [PATCH v2 1/5] ethernet: add sun8i-emac driver
In-Reply-To: <20160725195455.GQ7419@lukather>
References: <1469001800-11615-1-git-send-email-clabbe.montjoie@gmail.com>
 <1469001800-11615-2-git-send-email-clabbe.montjoie@gmail.com>
 <20160725195455.GQ7419@lukather>
Message-ID: <20160824120221.GB29212@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +/* Set Management Data Clock, must be call after device reset */
> > +static void sun8i_emac_set_mdc(struct net_device *ndev)
> > +{
> > +	struct sun8i_emac_priv *priv = netdev_priv(ndev);
> > +	unsigned long rate;
> > +	u32 reg;
> > +
> > +	rate = clk_get_rate(priv->ahb_clk);
> > +	if (rate > 160000000)
> > +		reg = 0x3 << 20; /* AHB / 128 */
> > +	else if (rate > 80000000)
> > +		reg = 0x2 << 20; /* AHB / 64 */
> > +	else if (rate > 40000000)
> > +		reg = 0x1 << 20; /* AHB / 32 */
> > +	else
> > +		reg = 0x0 << 20; /* AHB / 16 */
> > +	netif_dbg(priv, link, ndev, "MDC auto : %x\n", reg);
> > +	writel(reg, priv->base + SUN8I_EMAC_MDIO_CMD);
> 
> You could also expose that as a clock.
> 

For which purpose ?
No ethernet driver expose the MDC as clock and I dont see any interest:
- I dont think that tuning it give any gain
- Knowing it's value is of little interest

Regards
