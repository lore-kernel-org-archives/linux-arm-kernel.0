From: ben@decadent.org.uk (Ben Hutchings)
Date: Mon, 10 Mar 2014 23:18:40 +0000
Subject: [PATCH] net: phy: fix uninitalized WOL parameters in
 phy_ethtool_get_wol
In-Reply-To: <20140310.162349.2007153760780671206.davem@davemloft.net>
References: <1394413270-7169-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1394419893.15968.88.camel@deadeye.wl.decadent.org.uk>
 <531D98D1.4000707@gmail.com>
 <20140310.162349.2007153760780671206.davem@davemloft.net>
Message-ID: <1394493520.23624.22.camel@deadeye.wl.decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-03-10 at 16:23 -0400, David Miller wrote:
> From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Date: Mon, 10 Mar 2014 10:49:53 +0000
> 
> > void phy_ethtool_get_wol(struct phy_device *phydev, struct
> > ethtool_wolinfo *wol)
> > {
> >       memset(wol, 0, sizeof(*wol));
> > 
> >       if (phydev && phydev->drv->get_wol)
> >               phydev->drv->get_wol(phydev, wol);
> > }
> > 
> > That would also simplify above drivers down to e.g:
> > 
> > static void cpsw_get_wol(struct net_device *ndev, struct
> > ethtool_wolinfo *wol)
> > {
> >       struct cpsw_priv *priv = netdev_priv(ndev);
> >       int slave_no = cpsw_slave_index(priv);
> >       phy_ethtool_get_wol(priv->slaves[slave_no].phy, wol);
> > }
> > 
> > instead of:
> > 
> > static void cpsw_get_wol(struct net_device *ndev, struct
> > ethtool_wolinfo *wol)
> > {
> >       struct cpsw_priv *priv = netdev_priv(ndev);
> >       int slave_no = cpsw_slave_index(priv);
> > 
> >       wol->supported = 0;
> >       wol->wolopts = 0;
> > 
> >       if (priv->slaves[slave_no].phy)
> >               phy_ethtool_get_wol(priv->slaves[slave_no].phy, wol);
> > }
> 
> Agreed, since phy_ethtool_get_wol() is the common routine used by the drivers,
> we should make it clear the structure.

No, ethtool_get_wol() is the common routine used by *all* the drivers
and it initialises the struct properly.

Ben.

-- 
Ben Hutchings
Computers are not intelligent.	They only think they are.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 811 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140310/023296ad/attachment.sig>
