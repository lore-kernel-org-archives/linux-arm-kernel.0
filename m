From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 17 Sep 2016 15:40:14 +0200
Subject: [RFC PATCH 9/9] ethernet: sun8i-emac: add pm_runtime support
In-Reply-To: <20160914140304.GA27639@Red>
References: <1473425117-18645-1-git-send-email-clabbe.montjoie@gmail.com>
 <1473425117-18645-10-git-send-email-clabbe.montjoie@gmail.com>
 <20160912204451.GO9449@lukather> <20160914140304.GA27639@Red>
Message-ID: <20160917134014.GB17518@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2016 at 04:03:04PM +0200, LABBE Corentin wrote:
> > > +static int __maybe_unused sun8i_emac_suspend(struct platform_device *pdev, pm_message_t state)
> > > +{
> > > +	struct net_device *ndev = platform_get_drvdata(pdev);
> > > +	struct sun8i_emac_priv *priv = netdev_priv(ndev);
> > > +
> > > +	napi_disable(&priv->napi);
> > > +
> > > +	if (netif_running(ndev))
> > > +		netif_device_detach(ndev);
> > > +
> > > +	sun8i_emac_stop_tx(ndev);
> > > +	sun8i_emac_stop_rx(ndev);
> > > +
> > > +	sun8i_emac_rx_clean(ndev);
> > > +	sun8i_emac_tx_clean(ndev);
> > > +
> > > +	phy_stop(ndev->phydev);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int __maybe_unused sun8i_emac_resume(struct platform_device *pdev)
> > > +{
> > > +	struct net_device *ndev = platform_get_drvdata(pdev);
> > > +	struct sun8i_emac_priv *priv = netdev_priv(ndev);
> > > +
> > > +	phy_start(ndev->phydev);
> > > +
> > > +	sun8i_emac_start_tx(ndev);
> > > +	sun8i_emac_start_rx(ndev);
> > > +
> > > +	if (netif_running(ndev))
> > > +		netif_device_attach(ndev);
> > > +
> > > +	netif_start_queue(ndev);
> > > +
> > > +	napi_enable(&priv->napi);
> > > +
> > > +	return 0;
> > > +}
> > 
> > The main idea behind the runtime PM hooks is that they bring the
> > device to a working state and shuts it down when it's not needed
> > anymore.

Indeed.

> I expect that the first part (all pm_runtime_xxx) of the patch bring that.
> When the interface is not opened:
> cat /sys/devices/platform/soc/1c30000.ethernet/power/runtime_status 
> suspended
> 
> > However, they shouldn't be called when the device is still in used, so
> > all the mangling with NAPI, the phy and so on is irrelevant here, but
> > the clocks, resets, for example, are.
> > 
> 
> I do the same as other ethernet driver for suspend/resume.

suspend / resume are used when you put the whole system into suspend,
and bring it back.

runtime_pm is only when the device is not used anymore. It makes sense
when you suspend to do whatever you're doing here. It doesn't make any
when the system is not suspended, but the device is.

> > >  static const struct of_device_id sun8i_emac_of_match_table[] = {
> > >  	{ .compatible = "allwinner,sun8i-a83t-emac",
> > >  	  .data = &emac_variant_a83t },
> > > @@ -2246,6 +2302,8 @@ static struct platform_driver sun8i_emac_driver = {
> > >  		.name           = "sun8i-emac",
> > >  		.of_match_table	= sun8i_emac_of_match_table,
> > >  	},
> > > +	.suspend	= sun8i_emac_suspend,
> > > +	.resume		= sun8i_emac_resume,
> > 
> > These are not the runtime PM hooks. How did you test that?
> > 
> 
> Anyway I didnt test suspend/resume so I will remove it until I
> successfully found how to hibernate my board.

So you submit code you never tested? That's usually a recipe for
disaster.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160917/c2f7dacb/attachment.sig>
