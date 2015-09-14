From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Sep 2015 12:42:09 +0100
Subject: mvneta: SGMII fixed-link not so fixed
In-Reply-To: <55F6AA25.2070603@list.ru>
References: <20150914103207.GH21084@n2100.arm.linux.org.uk>
 <55F6AA25.2070603@list.ru>
Message-ID: <20150914114209.GL21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 14, 2015 at 02:06:13PM +0300, Stas Sergeev wrote:
> 14.09.2015 13:32, Russell King - ARM Linux ?????:
> >I've been bringing up the mainline kernel on a new board, which has
> >an Marvell SoC with a mvneta interface connected to a Marvell DSA
> >switch.  The DSA switch is a 88E6176.
> >
> >In the DT block for the interface, I specify:
> >
> >	ethernet at ... {
> >	        phy-mode = "sgmii";
> >		status = "okay";
> >
> >		fixed-link {
> >			speed = <1000>;
> >			full-duplex;
> >		};
> >	};
> >
> >However, this doesn't work without patching mvneta to disable the
> >autonegotiation and forcing the link up:
> >
> >diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> >index 62e48bc0cb23..e1698731e429 100644
> >--- a/drivers/net/ethernet/marvell/mvneta.c
> >+++ b/drivers/net/ethernet/marvell/mvneta.c
> >@@ -1010,6 +1010,10 @@ static void mvneta_defaults_set(struct mvneta_port *pp)
> >  		val |= MVNETA_GMAC_INBAND_AN_ENABLE |
> >  		       MVNETA_GMAC_AN_SPEED_EN |
> >  		       MVNETA_GMAC_AN_DUPLEX_EN;
> >+		/* We appear to need the interface forced for DSA switches */
> >+		val &= ~(MVNETA_GMAC_AN_DUPLEX_EN |
> >+			 MVNETA_GMAC_AN_SPEED_EN);
> >+		val |= MVNETA_GMAC_FORCE_LINK_PASS;
> >  		mvreg_write(pp, MVNETA_GMAC_AUTONEG_CONFIG, val);
> >  		val = mvreg_read(pp, MVNETA_GMAC_CLOCK_DIVIDER);
> >  		val |= MVNETA_GMAC_1MS_CLOCK_ENABLE;
> Hello Russell, just to make sure, aren't you missing this by any chance:
> https://lkml.org/lkml/2015/7/20/710

Thanks, I think that will solve it.  I have to wonder why that patch
(f8af8e6eb9509 in mainline) didn't made it into v4.2 though, as it's
billed as a regression that occurred in the previous merge window, and
given that it was sent in July, and we're now in September.  As it
wasn't in v4.2, it looks like it should be a stable candidate.

David, any objections to having the stable guys pick this regression
fix up, if not already done so?

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
