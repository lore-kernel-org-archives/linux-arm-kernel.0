From: javi.merino@arm.com (Javi Merino)
Date: Wed, 29 May 2013 15:25:42 +0100
Subject: [PATCH 7/8] ARM: vexpress/dcscb: handle platform coherency
 exit/setup and CCI
In-Reply-To: <1369830581.3715.50.camel@linaro1.home>
References: <1369374311-21260-1-git-send-email-nicolas.pitre@linaro.org>
 <1369374311-21260-8-git-send-email-nicolas.pitre@linaro.org>
 <1369830581.3715.50.camel@linaro1.home>
Message-ID: <20130529142541.GB2919@e102654-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 29, 2013 at 01:29:41PM +0100, Jon Medhurst (Tixy) wrote:
> On Fri, 2013-05-24 at 01:45 -0400, Nicolas Pitre wrote:
> > From: Dave Martin <dave.martin@linaro.org>
> > 
> > Add the required code to properly handle race free platform coherency exit
> > to the DCSCB power down method.
> > 
> > The power_up_setup callback is used to enable the CCI interface for
> > the cluster being brought up.  This must be done in assembly before
> > the kernel environment is entered.
> > 
> > Thanks to Achin Gupta and Nicolas Pitre for their help and
> > contributions.
> > 
> > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> > Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Acked-by: Pawel Moll <pawel.moll@arm.com>
> > ---
> >  arch/arm/mach-vexpress/Kconfig       |  1 +
> >  arch/arm/mach-vexpress/Makefile      |  2 +-
> >  arch/arm/mach-vexpress/dcscb.c       | 79 +++++++++++++++++++++++++++---------
> >  arch/arm/mach-vexpress/dcscb_setup.S | 38 +++++++++++++++++
> >  4 files changed, 100 insertions(+), 20 deletions(-)
> >  create mode 100644 arch/arm/mach-vexpress/dcscb_setup.S
> > 
> > diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
> > index 2f46385c28..b8bbabec63 100644
> > --- a/arch/arm/mach-vexpress/Kconfig
> > +++ b/arch/arm/mach-vexpress/Kconfig
> > @@ -60,6 +60,7 @@ config ARCH_VEXPRESS_CA9X4
> >  config ARCH_VEXPRESS_DCSCB
> >  	bool "Dual Cluster System Control Block (DCSCB) support"
> >  	depends on MCPM
> > +	select ARM_CCI
> >  	help
> >  	  Support for the Dual Cluster System Configuration Block (DCSCB).
> >  	  This is needed to provide CPU and cluster power management
> > diff --git a/arch/arm/mach-vexpress/Makefile b/arch/arm/mach-vexpress/Makefile
> > index 518519f57a..48ba89a814 100644
> > --- a/arch/arm/mach-vexpress/Makefile
> > +++ b/arch/arm/mach-vexpress/Makefile
> > @@ -6,6 +6,6 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
> >  
> >  obj-y					:= v2m.o
> >  obj-$(CONFIG_ARCH_VEXPRESS_CA9X4)	+= ct-ca9x4.o
> > -obj-$(CONFIG_ARCH_VEXPRESS_DCSCB)	+= dcscb.o
> > +obj-$(CONFIG_ARCH_VEXPRESS_DCSCB)	+= dcscb.o	dcscb_setup.o
> >  obj-$(CONFIG_SMP)			+= platsmp.o
> >  obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
> > diff --git a/arch/arm/mach-vexpress/dcscb.c b/arch/arm/mach-vexpress/dcscb.c
> > index b928b1f5eb..1acc975360 100644
> > --- a/arch/arm/mach-vexpress/dcscb.c
> > +++ b/arch/arm/mach-vexpress/dcscb.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/errno.h>
> >  #include <linux/of_address.h>
> >  #include <linux/vexpress.h>
> > +#include <linux/arm-cci.h>
> >  
> >  #include <asm/mcpm.h>
> >  #include <asm/proc-fns.h>
> > @@ -105,7 +106,10 @@ static void dcscb_power_down(void)
> >  	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
> >  	BUG_ON(cpu >= 4 || cluster >= 2);
> >  
> > +	__mcpm_cpu_going_down(cpu, cluster);
> > +
> >  	arch_spin_lock(&dcscb_lock);
> > +	BUG_ON(__mcpm_cluster_state(cluster) != CLUSTER_UP);
> >  	dcscb_use_count[cpu][cluster]--;
> >  	if (dcscb_use_count[cpu][cluster] == 0) {
> >  		rst_hold = readl_relaxed(dcscb_base + RST_HOLD0 + cluster * 4);
> > @@ -125,31 +129,59 @@ static void dcscb_power_down(void)
> >  		skip_wfi = true;
> >  	} else
> >  		BUG();
> > -	arch_spin_unlock(&dcscb_lock);
> > -
> > -	/*
> > -	 * Now let's clean our L1 cache and shut ourself down.
> > -	 * If we're the last CPU in this cluster then clean L2 too.
> > -	 */
> >  
> > -	/*
> > -	 * A15/A7 can hit in the cache with SCTLR.C=0, so we don't need
> > -	 * a preliminary flush here for those CPUs.  At least, that's
> > -	 * the theory -- without the extra flush, Linux explodes on
> > -	 * RTSM (to be investigated)..
> > -	 */
> > -	flush_cache_louis();
> > -	set_cr(get_cr() & ~CR_C);
> > +	if (last_man && __mcpm_outbound_enter_critical(cpu, cluster)) {
> > +		arch_spin_unlock(&dcscb_lock);
> >  
> > -	if (!last_man) {
> > -		flush_cache_louis();
> > -	} else {
> > +		/*
> > +		 * Flush all cache levels for this cluster.
> > +		 *
> > +		 * A15/A7 can hit in the cache with SCTLR.C=0, so we don't need
> > +		 * a preliminary flush here for those CPUs.  At least, that's
> > +		 * the theory -- without the extra flush, Linux explodes on
> > +		 * RTSM (to be investigated).
> > +		 */
> > +		flush_cache_all();
> > +		set_cr(get_cr() & ~CR_C);
> >  		flush_cache_all();
> > +
> > +		/*
> > +		 * This is a harmless no-op.  On platforms with a real
> > +		 * outer cache this might either be needed or not,
> > +		 * depending on where the outer cache sits.
> > +		 */
> >  		outer_flush_all();
> > +
> > +		/* Disable local coherency by clearing the ACTLR "SMP" bit: */
> > +		set_auxcr(get_auxcr() & ~(1 << 6));
> > +
> > +		/*
> > +		 * Disable cluster-level coherency by masking
> > +		 * incoming snoops and DVM messages:
> > +		 */
> > +		cci_disable_port_by_cpu(mpidr);
> > +
> > +		__mcpm_outbound_leave_critical(cluster, CLUSTER_DOWN);
> > +	} else {
> > +		arch_spin_unlock(&dcscb_lock);
> > +
> > +		/*
> > +		 * Flush the local CPU cache.
> > +		 *
> > +		 * A15/A7 can hit in the cache with SCTLR.C=0, so we don't need
> > +		 * a preliminary flush here for those CPUs.  At least, that's
> > +		 * the theory -- without the extra flush, Linux explodes on
> > +		 * RTSM (to be investigated).
> > +		 */
> > +		flush_cache_louis();
> > +		set_cr(get_cr() & ~CR_C);
> > +		flush_cache_louis();
> > +
> > +		/* Disable local coherency by clearing the ACTLR "SMP" bit: */
> > +		set_auxcr(get_auxcr() & ~(1 << 6));
> >  	}
> >  
> > -	/* Disable local coherency by clearing the ACTLR "SMP" bit: */
> > -	set_auxcr(get_auxcr() & ~(1 << 6));
> > +	__mcpm_cpu_down(cpu, cluster);
> >  
> >  	/* Now we are prepared for power-down, do it: */
> >  	dsb();
> > @@ -177,12 +209,17 @@ static void __init dcscb_usage_count_init(void)
> >  	dcscb_use_count[cpu][cluster] = 1;
> >  }
> >  
> > +extern void dcscb_power_up_setup(unsigned int affinity_level);
> > +
> >  static int __init dcscb_init(void)
> >  {
> >  	struct device_node *node;
> >  	unsigned int cfg;
> >  	int ret;
> >  
> > +	if (!cci_probed())
> > +		return -ENODEV;
> > +
> 
> I can't see where cci_probed() is defined, this seems to be the only
> occurrence in this patch set.

cci_probed() is defined in patch 1 of these series, in
include/linux/arm-cci.h and drivers/bus/arm-cci.c

Cheers,
Javi
