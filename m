From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 8 Jul 2011 10:47:09 +0100
Subject: [RFC PATCH 12/17] ARM: kernel: add SCU reset hook
In-Reply-To: <4E1667EA.5090509@ti.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-13-git-send-email-lorenzo.pieralisi@arm.com>
	<4E1667EA.5090509@ti.com>
Message-ID: <20110708094709.GA32016@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 03:14:02AM +0100, Santosh Shilimkar wrote:
> On 7/7/2011 8:50 AM, Lorenzo Pieralisi wrote:
> > When a CLUSTER is powered down the SCU must be reinitialized on
> > warm-boot.
> > This patch adds a hook to reset the SCU, which implies invalidating
> > TAG RAMs and renabling it.
> >
> > The scu virtual address is saved in a static variable when the SCU
> > is first enabled at boot; this allows common idle code to be
> > generic and avoid relying on platform code to get the address at
> > run-time.
> > On warm-boot the SCU TAG RAM is invalidated and the SCU enabled if
> > it is not already enabled.
> >
> > The reset can be skipped altogether thanks to save/restore
> > framework flags.
> >
> > Flushing D$ cache is cumbersome since the system just comes out of
> > reset, which invalidates caches in the process if needed (A9), that
> > is why the scu_enable function is not reused as it is to reset the SCU.
> >
> > If the init function is extended, there might not be a need for
> > a SCU specific hook, since the init function can be reused to
> > reinitialize the SCU at boot provided it is removed from the init
> > section and kept in memory.
> >
> > Signed-off-by: Lorenzo Pieralisi<lorenzo.pieralisi@arm.com>
> > ---
> >   arch/arm/include/asm/smp_scu.h |    3 ++-
> >   arch/arm/kernel/smp_scu.c      |   33 ++++++++++++++++++++++++++++++---
> >   2 files changed, 32 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm/include/asm/smp_scu.h b/arch/arm/include/asm/smp_scu.h
> > index 4eb6d00..cfaa68e 100644
> > --- a/arch/arm/include/asm/smp_scu.h
> > +++ b/arch/arm/include/asm/smp_scu.h
> > @@ -8,7 +8,8 @@
> >   #ifndef __ASSEMBLER__
> >   unsigned int scu_get_core_count(void __iomem *);
> >   void scu_enable(void __iomem *);
> > -int scu_power_mode(void __iomem *, unsigned int);
> > +int scu_power_mode(unsigned int);
> > +void scu_reset(void);
> >   #endif
> >
> >   #endif
> > diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
> > index a1e757c..980ced9 100644
> > --- a/arch/arm/kernel/smp_scu.c
> > +++ b/arch/arm/kernel/smp_scu.c
> > @@ -20,6 +20,7 @@
> >   #define SCU_INVALIDATE		0x0c
> >   #define SCU_FPGA_REVISION	0x10
> >
> > +static void __iomem *scu_va;
> 
> Change log and patch doesn't seems to match. I remember suggesting
> this change to Russell when "scu_power_mode()" was introduced.
> His preference was to have scu_base passed as part of the API.

Yes, but this implies that I have to call into platform code to
get the SCU virtual address. The change log seems ok to me, maybe
I have not explained properly the end goal.
I would like to reuse scu_enable when the cluster wakes up from
low-power instead of adding a reset hook, but invalidating caches
(flush_cache_all() in scu_enable) is already catered for in the reset path, 
so useless. I will work that out.
I also added an assembly function to programme the SCU power mode
(PATCH 07/17 of this series), since it has to be called from MMU off path.

Lorenzo
