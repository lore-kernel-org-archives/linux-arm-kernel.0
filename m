From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 18 May 2015 11:04:45 +0100
Subject: [PATCH 06/12] arm64: psci: account for Trusted OS instances
In-Reply-To: <20150513142255.GB11331@red-moon>
References: <1431085004-32743-1-git-send-email-mark.rutland@arm.com>
 <1431085004-32743-7-git-send-email-mark.rutland@arm.com>
 <20150513142255.GB11331@red-moon>
Message-ID: <20150518100445.GC3551@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 03:22:55PM +0100, Lorenzo Pieralisi wrote:
> On Fri, May 08, 2015 at 12:36:38PM +0100, Mark Rutland wrote:
> > Software resident in the secure world (a "Trusted OS") may cause CPU_OFF
> > calls for the CPU it is resident on to be denied. Such a denial would be
> > fatal for the kernel, and so we must detect when this can happen before
> > the point of no return.
> > 
> > This patch implements Trusted OS detection for PSCI 0.2+ systems, using
> > MIGRATE_INFO_TYPE and MIGRATE_INFO_UP_CPU. When a trusted OS is detected
> > as resident on a particular CPU, attempts to hot unplug that CPU will be
> > denied early, before they can prove fatal.
> > 
> > Trusted OS migration is not implemented by this patch. Implementation of
> > migratable UP trusted OSs seems unlikely, and the right policy for
> > migration is unclear (and will likely differ across implementations). As
> > such, it is likely that migration will require cooperation with Trusted
> > OS drivers.
> > 
> > PSCI implementations prior to 0.1 do not provide the facility to detect
> > the presence of a Trusted OS, nor the CPU any such OS is resident on, so
> > without additional information it is not possible to handle Trusted OSs
> > with PSCI 0.1.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/kernel/psci.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 61 insertions(+)
> > 
> > diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
> > index 7324db9..25e2610 100644
> > --- a/arch/arm64/kernel/psci.c
> > +++ b/arch/arm64/kernel/psci.c
> > @@ -43,6 +43,19 @@ struct psci_power_state {
> >  	u8	affinity_level;
> >  };
> >  
> > +/*
> > + * The CPU any Trusted OS is resident on. The trusted OS may reject CPU_OFF
> > + * calls to its resident CPU, so we must avoid issuing those. We never migrate
> > + * a Trusted OS even if it claims to be capable of migration -- doing so will
> > + * require cooperation with a Trusted OS driver.
> > + */
> > +static int resident_cpu = -1;
> > +
> > +static bool psci_tos_resident_on(int cpu)
> > +{
> > +	return cpu == resident_cpu;
> > +}
> > +
> >  struct psci_operations {
> >  	int (*cpu_suspend)(struct psci_power_state state,
> >  			   unsigned long entry_point);
> > @@ -52,6 +65,7 @@ struct psci_operations {
> >  	int (*affinity_info)(unsigned long target_affinity,
> >  			unsigned long lowest_affinity_level);
> >  	int (*migrate_info_type)(void);
> > +	unsigned long (*migrate_info_up_cpu)(void);
> 
> Do we really need to keep a pointer in the ops for this function ? I think
> we can just call it once for all at boot and be done with that.
> 
> Actually the same comment applies to migrate_info_type.

Sure, I can drop migrate_info_up_cpu. I'll take a look at
migrate_info_type.

> 
> >  };
> >  
> >  static struct psci_operations psci_ops;
> > @@ -172,6 +186,11 @@ static int psci_migrate_info_type(void)
> >  	return invoke_psci_fn(PSCI_0_2_FN_MIGRATE_INFO_TYPE, 0, 0, 0);
> >  }
> >  
> > +static unsigned long psci_migrate_info_up_cpu(void)
> > +{
> > +	return invoke_psci_fn(PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU, 0, 0, 0);
> > +}
> 
> See above, why can't we just invoke the function at probe time (we do
> not support migration hence I do not see why we want to keep the
> function after boot, it will never be called IIUC) ?

True, I can't see why we'd query this again.

> >  static int __maybe_unused cpu_psci_cpu_init_idle(struct device_node *cpu_node,
> >  						 unsigned int cpu)
> >  {
> > @@ -261,6 +280,40 @@ static void psci_sys_poweroff(void)
> >  	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
> >  }
> >  
> > +/*
> > + * Detect the presence of a resident Trusted OS which may cause CPU_OFF to
> > + * return DENIED (which would be fatal).
> > + */
> > +static void __init psci_init_migrate(void)
> > +{
> > +	unsigned long cpuid;
> > +	int type, cpu = -1;
> 
> Nit: cpu variable initialization is useless.
> 
> Apart from these minor comments patch is fine.

Thanks, I'll fix these up and push out a v2 shortly.

Thanks,
Mark.
