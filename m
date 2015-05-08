From: will.deacon@arm.com (Will Deacon)
Date: Fri, 8 May 2015 17:14:53 +0100
Subject: [PATCH 1/2] ARM: Availability of psci_smp_available depends on
 CONFIG_SMP
In-Reply-To: <20150508145620.GK2067@n2100.arm.linux.org.uk>
References: <cover.1431064527.git.jan.kiszka@siemens.com>
 <0f0a77ddee48027efa35f36d6c809d2d3ff91ce1.1431064527.git.jan.kiszka@siemens.com>
 <20150508112615.GE32221@ulmo.nvidia.com>
 <20150508145620.GK2067@n2100.arm.linux.org.uk>
Message-ID: <20150508161453.GI25587@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 03:56:20PM +0100, Russell King - ARM Linux wrote:
> On Fri, May 08, 2015 at 01:26:17PM +0200, Thierry Reding wrote:
> > On Fri, May 08, 2015 at 07:55:26AM +0200, Jan Kiszka wrote:
> > > Ensure that we can use psci_smp_available without checking for
> > > CONFIG_SMP first.
> > > 
> > > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > > ---
> > >  arch/arm/include/asm/psci.h | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm/include/asm/psci.h b/arch/arm/include/asm/psci.h
> > > index c25ef3e..eef6a0a 100644
> > > --- a/arch/arm/include/asm/psci.h
> > > +++ b/arch/arm/include/asm/psci.h
> > > @@ -39,9 +39,13 @@ extern struct smp_operations psci_smp_ops;
> > >  
> > >  #ifdef CONFIG_ARM_PSCI
> > >  int psci_init(void);
> > > -bool psci_smp_available(void);
> > >  #else
> > >  static inline int psci_init(void) { return 0; }
> > > +#endif
> > > +
> > > +#if defined(CONFIG_ARM_PSCI) && defined(CONFIG_SMP)
> > > +bool psci_smp_available(void);
> > > +#else
> > >  static inline bool psci_smp_available(void) { return false; }
> > >  #endif
> > >  
> > 
> > Looks good to me.
> > 
> > Russell, would you be willing to ack this patch so that I can take it
> > through the Tegra tree along with patch 2/2 that depends on this?
> 
> I'd prefer to see an ack from Will on this, as it's code which Will
> contributed and presumably understands better than me.

Sorry, I'm late to the thread so I'm a tad confused.

If I understand correctly, these two patches are trying to avoid using
the tegra cpuidle driver if PSCI is available instead? That raises the
question as to whether or not you're actually trying to discover whether
you're in the secure or non-secure world.

I assume PSCI only works if the kernel is running in non-secure mode,
but does the Tegra cpuidle driver only work in secure mode?

Will
