From: vdonnefort@lacie.com (Vincent Donnefort)
Date: Wed, 4 Sep 2013 17:20:19 +0200
Subject: [PATCH] net: mvneta: properly disable HW PHY polling and ensure
 adjust_link() works
In-Reply-To: <20130904145051.GO19598@titan.lakedaemon.net>
References: <1378304478-21237-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130904145051.GO19598@titan.lakedaemon.net>
Message-ID: <20130904152018.GA21032@grp-vdonnefort>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 04, 2013 at 10:50:51AM -0400, Jason Cooper wrote:
> On Wed, Sep 04, 2013 at 04:21:18PM +0200, Thomas Petazzoni wrote:
> > This commit fixes a long-standing bug that has been reported by many
> > users: on some Armada 370 platforms, only the network interface that
> > has been used in U-Boot to tftp the kernel works properly in
> > Linux. The other network interfaces can see a 'link up', but are
> > unable to transmit data. The reports were generally made on the Armada
> > 370-based Mirabox, but have also been given on the Armada 370-RD
> > board.
> > 
> > The network MAC in the Armada 370/XP (supported by the mvneta driver
> > in Linux) has a functionality that allows it to continuously poll the
> > PHY and directly update the MAC configuration accordingly (speed,
> > duplex, etc.). The very first versions of the driver submitted for
> > review were using this hardware mechanism, but due to this, the driver
> > was not integrated with the kernel phylib. Following reviews, the
> > driver was changed to use the phylib, and therefore a software based
> > polling. In software based polling, Linux regularly talks to the PHY
> > over the MDIO bus, and sees if the link status has changed. If it's
> > the case then the adjust_link() callback of the driver is called to
> > update the MAC configuration accordingly.
> > 
> > However, it turns out that the adjust_link() callback was not
> > configuring the hardware in a completely correct way: while it was
> > setting the speed and duplex bits correctly, it wasn't telling the
> > hardware to actually take into account those bits rather than what the
> > hardware-based PHY polling mechanism has concluded. So, in fact the
> > adjust_link() callback was basically a no-op.
> > 
> > However, the network happened to be working because on the network
> > interfaces used by U-Boot for tftp on Armada 370 platforms because the
> > hardware PHY polling was enabled by the bootloader, and left enabled
> > by Linux. However, the second network interface not used for tftp (or
> > both network interfaces if the kernel is loaded from USB, NAND or SD
> > card) didn't had the hardware PHY polling enabled.
> > 
> > This patch fixes this situation by:
> > 
> >  (1) Making sure that the hardware PHY polling is disabled by clearing
> >      the MVNETA_PHY_POLLING_ENABLE bit in the MVNETA_UNIT_CONTROL
> >      register in the driver ->probe() function.
> > 
> >  (2) Making sure that the duplex and speed selections made by the
> >      adjust_link() callback are taken into account by clearing the
> >      MVNETA_GMAC_AN_SPEED_EN and MVNETA_GMAC_AN_DUPLEX_EN bits in the
> >      MVNETA_GMAC_AUTONEG_CONFIG register.
> > 
> > This patch has been tested on Armada 370 Mirabox, and now both network
> > interfaces are usable after boot.
> > 
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > Cc: Willy Tarreau <w@1wt.eu>
> > Cc: Jochen De Smet <jochen.armkernel@leahnim.org>
> > Cc: Peter Sanford <psanford@nearbuy.io>
> > Cc: Ethan Tuttle <ethan@ethantuttle.com>
> > Cc: Ch?ny Yves-Gael <yves@cheny.fr>
> > Cc: Ryan Press <ryan@presslab.us>
> > Cc: Simon Guinot <simon.guinot@sequanux.org>
> > Cc: vdonnefort at lacie.com
> > Cc: stable at vger.kernel.org
> > ---
> > David, this patch is a fix for a problem that has been here since 3.8
> > (when the mvneta driver was introduced), so I've Cc'ed stable@ and if
> > possible I'd like to patch to be included for 3.12.
> 
> David,
> 
> Offending patch is:
> 
>   c5aff18 net: mvneta: driver for Marvell Armada 370/XP network unit
> 
> Applies and builds cleanly against v3.8.13, v3.9.11, v3.10.10, and v3.11
> 
> Acked-by: Jason Cooper <jason@lakedaemon.net>
> 
> thx,
> 
> Jason.

Works with the armada370-rd board.

Tested-by: Vincent Donnefort <vdonnefort@gmail.com>

Thank you!

Vincent.

> 
> > ---
> >  drivers/net/ethernet/marvell/mvneta.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> > index b017818..90ab292 100644
> > --- a/drivers/net/ethernet/marvell/mvneta.c
> > +++ b/drivers/net/ethernet/marvell/mvneta.c
> > @@ -138,7 +138,9 @@
> >  #define      MVNETA_GMAC_FORCE_LINK_PASS         BIT(1)
> >  #define      MVNETA_GMAC_CONFIG_MII_SPEED        BIT(5)
> >  #define      MVNETA_GMAC_CONFIG_GMII_SPEED       BIT(6)
> > +#define      MVNETA_GMAC_AN_SPEED_EN             BIT(7)
> >  #define      MVNETA_GMAC_CONFIG_FULL_DUPLEX      BIT(12)
> > +#define      MVNETA_GMAC_AN_DUPLEX_EN            BIT(13)
> >  #define MVNETA_MIB_COUNTERS_BASE                 0x3080
> >  #define      MVNETA_MIB_LATE_COLLISION           0x7c
> >  #define MVNETA_DA_FILT_SPEC_MCAST                0x3400
> > @@ -915,6 +917,13 @@ static void mvneta_defaults_set(struct mvneta_port *pp)
> >  	/* Assign port SDMA configuration */
> >  	mvreg_write(pp, MVNETA_SDMA_CONFIG, val);
> >  
> > +	/* Disable PHY polling in hardware, since we're using the
> > +	 * kernel phylib to do this.
> > +	 */
> > +	val = mvreg_read(pp, MVNETA_UNIT_CONTROL);
> > +	val &= ~MVNETA_PHY_POLLING_ENABLE;
> > +	mvreg_write(pp, MVNETA_UNIT_CONTROL, val);
> > +
> >  	mvneta_set_ucast_table(pp, -1);
> >  	mvneta_set_special_mcast_table(pp, -1);
> >  	mvneta_set_other_mcast_table(pp, -1);
> > @@ -2307,7 +2316,9 @@ static void mvneta_adjust_link(struct net_device *ndev)
> >  			val = mvreg_read(pp, MVNETA_GMAC_AUTONEG_CONFIG);
> >  			val &= ~(MVNETA_GMAC_CONFIG_MII_SPEED |
> >  				 MVNETA_GMAC_CONFIG_GMII_SPEED |
> > -				 MVNETA_GMAC_CONFIG_FULL_DUPLEX);
> > +				 MVNETA_GMAC_CONFIG_FULL_DUPLEX |
> > +				 MVNETA_GMAC_AN_SPEED_EN |
> > +				 MVNETA_GMAC_AN_DUPLEX_EN);
> >  
> >  			if (phydev->duplex)
> >  				val |= MVNETA_GMAC_CONFIG_FULL_DUPLEX;
> > -- 
> > 1.8.1.2
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Vincent


LaCie will welcome you at IBC Amsterdam (13-17 Sept) on booth 7.G17 (Hall7). Come and visit us.
