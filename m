From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 27 Nov 2013 12:44:21 -0500 (EST)
Subject: [PATCH v4 4/4] ARM: EXYNOS: add Exynos Dual Cluster Support
In-Reply-To: <20131126164033.GD2355@e103592.cambridge.arm.com>
References: <1385456288-20398-1-git-send-email-v.tyrtov@samsung.com>
 <1385456288-20398-5-git-send-email-v.tyrtov@samsung.com>
 <20131126164033.GD2355@e103592.cambridge.arm.com>
Message-ID: <alpine.LFD.2.10.1311271227320.9667@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Nov 2013, Dave Martin wrote:

> [Resending to to a mail snafu on my end -- apologies for any duplicates
> of this message received]
> 
> On Tue, Nov 26, 2013 at 12:58:08PM +0400, Vyacheslav Tyrtov wrote:
> > From: Tarek Dakhran <t.dakhran@samsung.com>
> > 
> > Add EDCS(Exynos Dual Cluster Support) for Samsung Exynos5410 SoC.
> > This enables all 8 cores, 4 x A7 and 4 x A15 run at the same time.
> > 
> > Signed-off-by: Tarek Dakhran <t.dakhran@samsung.com>
> > Signed-off-by: Vyacheslav Tyrtov <v.tyrtov@samsung.com>
> > ---
> >  arch/arm/mach-exynos/Makefile |   2 +
> >  arch/arm/mach-exynos/edcs.c   | 297 ++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 299 insertions(+)
> >  create mode 100644 arch/arm/mach-exynos/edcs.c
> > 
> > diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
> > index 8930b66..bc1f7f9 100644
> > --- a/arch/arm/mach-exynos/Makefile
> > +++ b/arch/arm/mach-exynos/Makefile
> > @@ -34,3 +34,5 @@ AFLAGS_exynos-smc.o		:=-Wa,-march=armv7-a$(plus_sec)
> >  
> >  obj-$(CONFIG_ARCH_EXYNOS4)	+= mach-exynos4-dt.o
> >  obj-$(CONFIG_ARCH_EXYNOS5)	+= mach-exynos5-dt.o
> > +
> > +obj-$(CONFIG_SOC_EXYNOS5410)	+= edcs.o
> > diff --git a/arch/arm/mach-exynos/edcs.c b/arch/arm/mach-exynos/edcs.c
> > new file mode 100644
> > index 0000000..29f0bdd
> > --- /dev/null
> > +++ b/arch/arm/mach-exynos/edcs.c
> > @@ -0,0 +1,297 @@
> > +/*
> > + * arch/arm/mach-exynos/edcs.c - exynos dual cluster power management support
> > + *
> > + * Copyright (c) 2013 Samsung Electronics Co., Ltd.
> > + * Author: Tarek Dakhran <t.dakhran@samsung.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * EDCS(exynos dual cluster support) for Exynos5410 SoC.
> > + */
> > +
> > +#define pr_fmt(fmt)	"%s: " fmt, __func__
> > +
> > +#include <linux/init.h>
> > +#include <linux/io.h>
> > +#include <linux/of_address.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/errno.h>
> > +#include <linux/irqchip/arm-gic.h>
> > +#include <linux/delay.h>
> > +
> > +#include <asm/mcpm.h>
> > +#include <asm/proc-fns.h>
> > +#include <asm/cacheflush.h>
> > +#include <asm/cputype.h>
> > +#include <asm/cp15.h>
> > +
> > +#include <linux/arm-cci.h>
> > +#include <mach/regs-pmu.h>
> > +
> > +#define EDCS_CPUS_PER_CLUSTER		4
> > +#define EDCS_CLUSTERS			2
> > +
> > +/* Exynos5410 power management registers */
> > +#define EDCS_CORE_CONFIGURATION(_nr)	(S5P_ARM_CORE0_CONFIGURATION	\
> > +						+ ((_nr) * 0x80))
> > +#define EDCS_CORE_STATUS(_nr)		(EDCS_CORE_CONFIGURATION(_nr) + 0x4)
> > +#define EDCS_CORE_OPTION(_nr)		(EDCS_CORE_CONFIGURATION(_nr) + 0x8)
> > +
> > +#define REG_CPU_STATE_ADDR0		(S5P_VA_SYSRAM_NS + 0x28)
> > +#define REG_CPU_STATE_ADDR(_nr)		(REG_CPU_STATE_ADDR0 +	\
> > +						 (_nr) * EDCS_CPUS_PER_CLUSTER)
> > +
> > +#define SECONDARY_RESET			(1 << 1)
> > +#define REG_ENTRY_ADDR			(S5P_VA_SYSRAM_NS + 0x1c)
> > +
> > +#define EDCS_CORE_PWR_ON		0x3
> > +#define EDCS_CORE_PWR_OFF		0x0
> > +#define CORE_PWR_STATE_MASK		0x3
> > +
> > +static arch_spinlock_t edcs_lock = __ARCH_SPIN_LOCK_UNLOCKED;
> > +
> > +static int edcs_use_count[EDCS_CPUS_PER_CLUSTER][EDCS_CLUSTERS];
> > +static int core_count[EDCS_CLUSTERS];
> > +
> > +/*
> > + * this_core_to_pcpu reads mpidr and defines cluster and cpu.
> > + */
> > +static void this_core_to_pcpu(unsigned int *pcpu, unsigned int *pcluster)
> > +{
> > +	unsigned int mpidr;
> > +
> > +	mpidr = read_cpuid_mpidr();
> > +	*pcpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> > +	*pcluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> > +}
> > +
> > +/*
> > + * core_power_state is used to get core power state.
> > + * returns:
> > + *        0x0 - powered off;
> > + *        0x3 - powered on;
> > + *        other values - in process;
> > + */
> > +static int core_power_state(unsigned int cpu, unsigned int cluster)
> > +{
> > +	unsigned int offset = cluster * EDCS_CPUS_PER_CLUSTER + cpu;
> > +	int status = readl_relaxed(EDCS_CORE_STATUS(offset));
> > +
> > +	return status & CORE_PWR_STATE_MASK;
> > +}
> > +
> > +static void edcs_core_power_up(unsigned int cpu, unsigned int cluster)
> > +{
> > +	unsigned int offset = cluster * EDCS_CPUS_PER_CLUSTER + cpu;
> > +	if (core_power_state(cpu, cluster) == EDCS_CORE_PWR_OFF) {
> 
> This still looks racy.
> 
> edcs_core_power_up and edcs_core_power_down are both called with
> edcs_lock held, and cluster/cpu ref counting is done before we
> get here.  So we know that the power state *change* is really supposed
> to happen.
> 
> *If* my assumption is correct that there is a delay between requesting a
> new power state, and the change being reported as completed in
> EDCS_CORE_STATUS:
> 
> 
> For edcs_core_power_up(), there may be a pending power-down
> request which is not visible in the EDCS_CORE_STATUS registers yet.
> 
> I think this may mean that a power-up request will simply be missed
> if the core status does not read as EDCS_CORE_PWR_OFF yet.  If that
> can happen, then you need to wait -- calling the power_down_finish
> method may be the right thing to do.

I agree with your analysis so far.  However there is a fundamental 
question that the hardware designers need to answer:

What happens if EDCS_CORE_PWR_OFF and then EDCS_CORE_PWR_ON is written 
to the EDCS_CORE_CONFIGURATION register without waiting for the status 
to become EDCS_CORE_PWR_OFF in between the two writes?  In other words, 
will the PWR_ON be lost or will it be honored even if the PWR_OFF 
request has not yet completed?

If the PWR_ON request is always honored then there is no need for a 
status check here.  Otherwise this is a bit more complicated as 
outlined by Dave.


Nicolas
