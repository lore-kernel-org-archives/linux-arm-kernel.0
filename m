From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Jul 2014 11:26:38 +0100
Subject: [PATCH 2/3] ARM: smp_scu: enable SCU standby support
In-Reply-To: <20140721092703.GL8537@dragon>
References: <1405928755-19413-1-git-send-email-shawn.guo@freescale.com>
 <1405928755-19413-3-git-send-email-shawn.guo@freescale.com>
 <20140721085150.GB15666@arm.com> <20140721092703.GL8537@dragon>
Message-ID: <20140721102638.GE32578@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 05:27:04PM +0800, Shawn Guo wrote:
> On Mon, Jul 21, 2014 at 09:51:50AM +0100, Will Deacon wrote:
> > On Mon, Jul 21, 2014 at 08:45:54AM +0100, Shawn Guo wrote:
> > > With SCU standby enabled, SCU CLK will be turned off when all processors
> > > are in WFI mode.  And the clock will be turned on when any processor
> > > leaves WFI mode.
> > > 
> > > This behavior should be preferable in terms of power efficiency of
> > > system idle.  So let's set the SCU standby bit to enable the support in
> > > function scu_enable().
> > > 
> > > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > > ---
> > >  arch/arm/kernel/smp_scu.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
> > > index c947508f84e6..9f29d167d02c 100644
> > > --- a/arch/arm/kernel/smp_scu.c
> > > +++ b/arch/arm/kernel/smp_scu.c
> > > @@ -18,6 +18,7 @@
> > >  
> > >  #define SCU_CTRL		0x00
> > >  #define SCU_ENABLE		(1 << 0)
> > > +#define SCU_STANDBY_ENABLE	(1 << 5)
> > >  #define SCU_CONFIG		0x04
> > >  #define SCU_CPU_STATUS		0x08
> > >  #define SCU_INVALIDATE		0x0c
> > > @@ -54,7 +55,7 @@ void scu_enable(void __iomem *scu_base)
> > >  	if (scu_ctrl & SCU_ENABLE)
> > >  		return;
> > >  
> > > -	scu_ctrl |= SCU_ENABLE;
> > > +	scu_ctrl |= SCU_ENABLE | SCU_STANDBY_ENABLE;
> > 
> > I don't think this bit exists on all revisions of the A9.
> 
> Thanks for the info, Will.  Is there any side-effect to write the
> standby bit on those revisions which do not define the bit?

The usual question - could the firmware enable this bit before Linux
starts? We already do a read/modify/write sequence here and are only
supposed to write the enable bit as the rest are implementation defined.

-- 
Catalin
