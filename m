From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Mar 2018 13:05:57 +0000
Subject: [EXT] Re: [PATCH net-next 02/10] net: phy: phylink: allow 10GKR
 interface to use in-band negotiation
In-Reply-To: <2ff0a81f55a84069a4652d02a4212b70@IL-EXCH01.marvell.com>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
 <20180316103351.16616-3-antoine.tenart@bootlin.com>
 <20180316155307.GQ9418@n2100.armlinux.org.uk>
 <20180319085252.GF4519@kwain>
 <20180319111205.GB2743@n2100.armlinux.org.uk>
 <4e11135ba2644f76beb41a307c9d990a@IL-EXCH01.marvell.com>
 <2ff0a81f55a84069a4652d02a4212b70@IL-EXCH01.marvell.com>
Message-ID: <20180319130556.GC2743@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2018 at 01:01:07PM +0000, Yan Markman wrote:
> The DTS-patch for this board (in "old" format) is attached
> 
> 
> Yan Markman
> Tel. 05-44732819
> 
> 
> -----Original Message-----
> From: Stefan Chulski 
> Sent: Monday, March 19, 2018 2:58 PM
> To: Russell King - ARM Linux <linux@armlinux.org.uk>; Antoine Tenart <antoine.tenart@bootlin.com>
> Cc: davem at davemloft.net; kishon at ti.com; gregory.clement at bootlin.com; andrew at lunn.ch; jason at lakedaemon.net; sebastian.hesselbarth at gmail.com; netdev at vger.kernel.org; linux-kernel at vger.kernel.org; thomas.petazzoni at bootlin.com; maxime.chevallier at bootlin.com; miquel.raynal at bootlin.com; Nadav Haklai <nadavh@marvell.com>; Yan Markman <ymarkman@marvell.com>; mw at semihalf.com; linux-arm-kernel at lists.infradead.org
> Subject: RE: [EXT] Re: [PATCH net-next 02/10] net: phy: phylink: allow 10GKR interface to use in-band negotiation
> 
> > > > There is no inband negotiation like there is with 802.3z or SGMII, 
> > > > so this makes no sense.
> > >
> > > Oh, that's what I feared. I read some docs but probably will need 
> > > more
> > > :)
> > >
> > > Anyway, the reason to use in-band negotiation was also to avoid 
> > > using fixed-link. It would work but always report the link is up, 
> > > which for the user isn't a great experience as we have a way to detect this.
> > >
> > > What would you suggest to achieve this in a reasonable way?
> > 
> > The intention of this test in phylink_of_phy_connect() is to avoid 
> > failing when there is no requirement for a PHY to be present (such as 
> > a fixed link, or an 802.3z link.)  However, with 10G PHYs such as the 
> > 3310, we need the PHY so we can read the speed from it, and so know 
> > whether to downgrade the MAC to SGMII mode, or having downgraded the 
> > MAC, upgrade it back to 10G mode when the PHY switches to 10G.
> > 
> > I'm guessing that you're wanting this for the DB boards, but I don't see why.
> > Do they not have PHYs?
> 
> New Solid Run board MACCHIATObin Single Shot doesn't has  3310 PHY either, like DB boards.
> https://www.cnx-software.com/2017/12/20/solidrun-macchiatobin-single-shot-networking-board-launched-for-269-and-up/

Correct, but this DTS is wrong.  It connects to a SFP cage, and as SFP
cages are supported in mainline now, there's no need to mess around
with fixed links or similar.

I haven't tested phylink in that configuration yet as SolidRun haven't
sent me a SingleShot board yet - and I need any board I do get to have
the pull-up resistors on the I2C lines of the correct value, because
I'm not risking corruption of the EEPROMs in my SFP* modules.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
