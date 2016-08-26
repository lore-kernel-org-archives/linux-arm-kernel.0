From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 26 Aug 2016 22:49:14 +0200
Subject: [PATCH v2 1/5] ethernet: add sun8i-emac driver
In-Reply-To: <20160824120221.GB29212@Red>
References: <1469001800-11615-1-git-send-email-clabbe.montjoie@gmail.com>
 <1469001800-11615-2-git-send-email-clabbe.montjoie@gmail.com>
 <20160725195455.GQ7419@lukather> <20160824120221.GB29212@Red>
Message-ID: <20160826204914.GD3165@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 24, 2016 at 02:02:21PM +0200, LABBE Corentin wrote:
> > > +/* Set Management Data Clock, must be call after device reset */
> > > +static void sun8i_emac_set_mdc(struct net_device *ndev)
> > > +{
> > > +	struct sun8i_emac_priv *priv = netdev_priv(ndev);
> > > +	unsigned long rate;
> > > +	u32 reg;
> > > +
> > > +	rate = clk_get_rate(priv->ahb_clk);
> > > +	if (rate > 160000000)
> > > +		reg = 0x3 << 20; /* AHB / 128 */
> > > +	else if (rate > 80000000)
> > > +		reg = 0x2 << 20; /* AHB / 64 */
> > > +	else if (rate > 40000000)
> > > +		reg = 0x1 << 20; /* AHB / 32 */
> > > +	else
> > > +		reg = 0x0 << 20; /* AHB / 16 */
> > > +	netif_dbg(priv, link, ndev, "MDC auto : %x\n", reg);
> > > +	writel(reg, priv->base + SUN8I_EMAC_MDIO_CMD);
> > 
> > You could also expose that as a clock.
> > 
> 
> For which purpose ?
> No ethernet driver expose the MDC as clock and I dont see any interest:
> - I dont think that tuning it give any gain
> - Knowing it's value is of little interest

You don't have to implement anything, you can just register a clk_div
driver, and everything works, and you would use the proper clock APIs
(ie. clk_set_rate, and that's it).

That would be exposed just like any other clock, including in debugfs,
which would remove the need for the debug call.

But this really was just a suggestion.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160826/4b5b76a6/attachment.sig>
