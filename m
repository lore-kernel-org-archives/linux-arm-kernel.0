From: alior@marvell.com (Lior Amsalem)
Date: Wed, 8 Jan 2014 15:45:31 +0200
Subject: [PATCH] ata: sata_mv: setting PHY speed according to SControl
 speed
In-Reply-To: <20131231170515.GG32537@lunn.ch>
References: <1387800455-30629-1-git-send-email-simon.guinot@sequanux.org>
 <20131231121214.GB3985@htj.dyndns.org> <20131231170515.GG32537@lunn.ch>
Message-ID: <EE71107DF0D1F24FA2D95041E64AB9E801C034BF2AD1@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

> From: Andrew Lunn [mailto:andrew at lunn.ch]
> Sent: Tuesday, December 31, 2013 7:05 PM
> 
> On Tue, Dec 31, 2013 at 07:12:14AM -0500, Tejun Heo wrote:
> > On Mon, Dec 23, 2013 at 01:07:35PM +0100, Simon Guinot wrote:
> > > @@ -1358,6 +1359,7 @@ static int mv_scr_write(struct ata_link *link,
> > > unsigned int sc_reg_in, u32 val)
> > >
> > >  	if (ofs != 0xffffffffU) {
> > >  		void __iomem *addr = mv_ap_base(link->ap) + ofs;
> > > +		void __iomem *lp_phy_addr = mv_ap_base(link->ap) +
> LP_PHY_CTL;
> > >  		if (sc_reg_in == SCR_CONTROL) {
> > >  			/*
> > >  			 * Workaround for 88SX60x1 FEr SATA#26:
> > > @@ -1374,6 +1376,14 @@ static int mv_scr_write(struct ata_link *link,
> unsigned int sc_reg_in, u32 val)
> > >  			 */
> > >  			if ((val & 0xf) == 1 || (readl(addr) & 0xf) == 1)
> > >  				val |= 0xf000;
> > > +
> > > +			/*
> > > +			 * Setting PHY speed according to SControl speed
> > > +			 */
> > > +			if ((val & 0xf0) == 0x10)
> > > +				writelfl(0x7, lp_phy_addr);
> > > +			else
> > > +				writelfl(0x227, lp_phy_addr);
> >
> > Do we know that this is safe for all sata_mvs?  If other sata_mvs
> > haven't had the described issue, maybe this should be applied
> > selectively to the said soc?  I'd actually prefer to avoid such
> > conditionals but we need to confirm this is okay for other
> > implementations.
> 
> Hi Tejun
> 
> I've tested on Kirkwood, and not had problems. But i agree with you. We
> need somebody in Marvell to say this is safe with all sata_mv variants.
> 
> Lior, can you comment?

This register (0x58) was introduced in a370/axp (with a new SATA PHY version).
In other SoCs the register does not exist.

Writing/reading the registers on A300/A310 will not cause any harm (I haven't
tried A510).
But, I think it's better to check if we're running on A370/AXP. (maybe with a new
compatibility string in DT?)

> 
> Thanks
> 	Andrew


Regards,
Lior Amsalem
