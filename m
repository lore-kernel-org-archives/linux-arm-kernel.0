From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Sep 2015 17:00:58 +0100
Subject: [PATCH v2 0/9] Phy, mdiobus, and netdev struct device fixes
In-Reply-To: <20150923.162417.814596822188458346.davem@davemloft.net>
References: <20150922161710.GA21084@n2100.arm.linux.org.uk>
 <20150923.162417.814596822188458346.davem@davemloft.net>
Message-ID: <20150924160058.GA21513@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 23, 2015 at 04:24:17PM -0700, David Miller wrote:
> From: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Date: Tue, 22 Sep 2015 17:17:10 +0100
> 
> > This is the second version of the series, with the comments David had
> > on the first patch fixed up.  Original series description with updated
> > diffstat below.
> 
> This needs some build fixes:
> 
> drivers/net/ethernet/apm/xgene/xgene_enet_hw.c: In function ?xgene_enet_phy_connect?:
> drivers/net/ethernet/apm/xgene/xgene_enet_hw.c:694:20: error: too few arguments to function ?of_phy_connect?
>    pdata->phy_dev = of_phy_connect(ndev, phy_np,
>                     ^
> In file included from drivers/net/ethernet/apm/xgene/xgene_enet_main.h:31:0,
>                  from drivers/net/ethernet/apm/xgene/xgene_enet_hw.c:22:
> include/linux/of_mdio.h:18:27: note: declared here
>  extern struct phy_device *of_phy_connect(struct net_device *dev,
>                            ^

Sorry about that, I'll send a new series later this evening.

Unfortunately, that's also not the only one - Cavium Thunder BGX also
fails.  Looking again at that driver, the driver structure doesn't lend
itself well to having the refcount balancing added to it due to the
multiple different paths which it obtains a phy_device.  I think this is
best left to the maintainers of this driver to fix, so I'm intending to
drop the change to that driver.

That's not a problem: the driver is already buggy in this regard today,
and that's won't be any different as a result of omitting it.  It's just
a shame to leave one instance unfixed.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
