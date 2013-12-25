From: simon.guinot@sequanux.org (Simon Guinot)
Date: Wed, 25 Dec 2013 23:40:34 +0100
Subject: [PATCH] ata: sata_mv: setting PHY speed according to SControl
 speed
In-Reply-To: <20131224194603.GE19878@titan.lakedaemon.net>
References: <1387800455-30629-1-git-send-email-simon.guinot@sequanux.org>
 <20131224194603.GE19878@titan.lakedaemon.net>
Message-ID: <20131225224034.GB5531@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 24, 2013 at 02:46:03PM -0500, Jason Cooper wrote:
> On Mon, Dec 23, 2013 at 01:07:35PM +0100, Simon Guinot wrote:
> > From: Lior Amsalem <alior@marvell.com>
> > 
> > From: Lior Amsalem <alior@marvell.com>
> > 
> > This patch fixes a SATA hotplug issue on the Armada 370 and Armada XP
> > SoCs. Without it, if a disk is unplugged from a SATA port, then further
> > hotplug notification are now longer received on this port.
> > 
> > This should be applied to every -stable kernel supporting Armada SoCs.
> 
> Could we get a little more specific here?  Please determine which commit
> introduced the regression and note it with 'Fixes: <commitish> "oneline"'

Well, since the DT support for the sata_mv driver precedes SATA support
for Armada SoCs, I'd say that the bug has been introduced by:

a6a6de1a "arm: mvebu: SATA support: SoC-level DT data for Armada 370/XP"

Let me know if you agree with that. I will update the commit message
accorgingly.

> 
> It's really needed here since the sata_mv driver predates the Armada
> SoCs introduction.  Is it possible Kirkwood et al also experience this
> problem?

On my Orion and Kirkwood based bords, SATA disk hotplug works correctly.

Simon

> 
> thx,
> 
> Jason.
> 
> > 
> > Signed-off-by: Lior Amsalem <alior@marvell.com>
> > Signed-off-by: Nadav Haklai <nadavh@marvell.com>
> > Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> > Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > Cc: Jason Cooper <jason@lakedaemon.net>
> > Cc: Andrew Lunn <andrew@lunn.ch>
> > Cc: Gregory Clement <gregory.clement@free-electrons.com>
> > Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > Cc: stable at vger.kernel.org
> > ---
> >  drivers/ata/sata_mv.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> > index 56be318..89ca472 100644
> > --- a/drivers/ata/sata_mv.c
> > +++ b/drivers/ata/sata_mv.c
> > @@ -304,6 +304,7 @@ enum {
> >  	MV5_LTMODE		= 0x30,
> >  	MV5_PHY_CTL		= 0x0C,
> >  	SATA_IFCFG		= 0x050,
> > +	LP_PHY_CTL		= 0x058,
> >  
> >  	MV_M2_PREAMP_MASK	= 0x7e0,
> >  
> > @@ -1358,6 +1359,7 @@ static int mv_scr_write(struct ata_link *link, unsigned int sc_reg_in, u32 val)
> >  
> >  	if (ofs != 0xffffffffU) {
> >  		void __iomem *addr = mv_ap_base(link->ap) + ofs;
> > +		void __iomem *lp_phy_addr = mv_ap_base(link->ap) + LP_PHY_CTL;
> >  		if (sc_reg_in == SCR_CONTROL) {
> >  			/*
> >  			 * Workaround for 88SX60x1 FEr SATA#26:
> > @@ -1374,6 +1376,14 @@ static int mv_scr_write(struct ata_link *link, unsigned int sc_reg_in, u32 val)
> >  			 */
> >  			if ((val & 0xf) == 1 || (readl(addr) & 0xf) == 1)
> >  				val |= 0xf000;
> > +
> > +			/*
> > +			 * Setting PHY speed according to SControl speed
> > +			 */
> > +			if ((val & 0xf0) == 0x10)
> > +				writelfl(0x7, lp_phy_addr);
> > +			else
> > +				writelfl(0x227, lp_phy_addr);
> >  		}
> >  		writelfl(val, addr);
> >  		return 0;
> > -- 
> > 1.8.5.1
> > 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131225/2570a669/attachment.sig>
