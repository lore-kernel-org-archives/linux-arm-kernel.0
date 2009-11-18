From: tony@atomide.com (Tony Lindgren)
Date: Wed, 18 Nov 2009 14:47:47 -0800
Subject: [PATCH 05/12] omap3evm: Add board revision function, v2
In-Reply-To: <19F8576C6E063C45BE387C64729E7394043702B5B5@dbde02.ent.ti.com>
References: <20091116232435.24892.81547.stgit@localhost>
	<20091116232734.24892.33820.stgit@localhost>
	<19F8576C6E063C45BE387C64729E7394043702B5B5@dbde02.ent.ti.com>
Message-ID: <20091118224746.GU29266@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Hiremath, Vaibhav <hvaibhav@ti.com> [091116 19:56]:
> 
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony at atomide.com]
> > Sent: Tuesday, November 17, 2009 4:58 AM
> > To: linux-arm-kernel at lists.infradead.org
> > Cc: Gupta, Ajay Kumar; linux-omap at vger.kernel.org; Hiremath,
> > Vaibhav; Premi, Sanjeev
> > Subject: [PATCH 05/12] omap3evm: Add board revision function
> > 
> > From: Ajay Kumar Gupta <ajay.gupta@ti.com>
> > 
> > Added function to differentiate between the OMAP3EVM revisions. The
> > chip-id of the ethernet PHY is being used for this purpose.
> > 
> > Rev A to D : 0x01150000
> > Rev >= E   : 0x92200000
> > 
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> > Signed-off-by: Sanjeev Premi <premi@ti.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  arch/arm/mach-omap2/board-omap3evm.c    |   33
> > +++++++++++++++++++++++++++++++
> >  arch/arm/plat-omap/include/plat/board.h |   18 +++++++++++++++++
> >  2 files changed, 51 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-
> > omap2/board-omap3evm.c
> > index 1edf06a..6bb9a37 100644
> > --- a/arch/arm/mach-omap2/board-omap3evm.c
> > +++ b/arch/arm/mach-omap2/board-omap3evm.c
> > @@ -46,9 +46,40 @@
> > 
> >  #define OMAP3EVM_ETHR_START	0x2c000000
> >  #define OMAP3EVM_ETHR_SIZE	1024
> > +#define OMAP3EVM_ETHR_ID_REV	0x50
> >  #define OMAP3EVM_ETHR_GPIO_IRQ	176
> >  #define OMAP3EVM_SMC911X_CS	5
> > 
> > +static u8 omap3_evm_version;
> > +
> > +u8 get_omap3_evm_rev(void)
> > +{
> > +	return omap3_evm_version;
> > +}
> > +EXPORT_SYMBOL(get_omap3_evm_rev);
> > +
> > +static void __init omap3_evm_get_revision(void)
> > +{
> > +	void __iomem *ioaddr;
> > +	unsigned int smsc_id;
> > +
> > +	/* Ethernet PHY ID is stored at ID_REV register */
> > +	ioaddr = ioremap_nocache(OMAP3EVM_ETHR_START, SZ_1K);
> [Hiremath, Vaibhav] I think we should check for the return value.

Good catch, updated version below.

Tony
