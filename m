From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 7 Nov 2013 11:46:06 -0500 (EST)
Subject: [PATCH v3 3/4] ARM: EXYNOS: add Exynos Dual Cluster Support
In-Reply-To: <20131107130141.GA3129@localhost.localdomain>
References: <1383811969-32712-1-git-send-email-v.tyrtov@samsung.com>
 <1383811969-32712-4-git-send-email-v.tyrtov@samsung.com>
 <20131107130141.GA3129@localhost.localdomain>
Message-ID: <alpine.LFD.2.03.1311071123560.18068@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Nov 2013, Dave Martin wrote:

> On Thu, Nov 07, 2013 at 08:12:48AM +0000, Vyacheslav Tyrtov wrote:
> > From: Tarek Dakhran <t.dakhran@samsung.com>
> > 
> > Add EDCS(Exynos Dual Cluster Support) for Samsung Exynos5410 SoC.
> > This enables all 8 cores, 4 x A7 and 4 x A15 run at the same time.
> > 
> > Signed-off-by: Tarek Dakhran <t.dakhran@samsung.com>
> > Signed-off-by: Vyacheslav Tyrtov <v.tyrtov@samsung.com>
> > ---
> >  arch/arm/mach-exynos/Makefile |   2 +
> >  arch/arm/mach-exynos/edcs.c   | 278 ++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 280 insertions(+)
> >  create mode 100644 arch/arm/mach-exynos/edcs.c
> > 
> > diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
> > index 5369615..ba6efdb 100644
> > --- a/arch/arm/mach-exynos/Makefile
> > +++ b/arch/arm/mach-exynos/Makefile
> > @@ -34,3 +34,5 @@ AFLAGS_exynos-smc.o		:=-Wa,-march=armv7-a$(plus_sec)
> >  
> >  obj-$(CONFIG_MACH_EXYNOS4_DT)		+= mach-exynos4-dt.o
> >  obj-$(CONFIG_MACH_EXYNOS5_DT)		+= mach-exynos5-dt.o
> > +
> > +obj-$(CONFIG_SOC_EXYNOS5410)		+= edcs.o
> > diff --git a/arch/arm/mach-exynos/edcs.c b/arch/arm/mach-exynos/edcs.c
> > new file mode 100644
> > index 0000000..980bfdd
> > --- /dev/null
> > +++ b/arch/arm/mach-exynos/edcs.c
> > @@ -0,0 +1,278 @@
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
> > +#include <linux/init.h>
> > +#include <linux/io.h>
> > +#include <linux/of_address.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/errno.h>
> > +#include <linux/irqchip/arm-gic.h>
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
> > +#define EDCS_CPUS_PER_CLUSTER	4
> > +#define EDCS_CLUSTERS		2
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
> > +#define SECONDARY_RESET		(1 << 1)
> > +#define REG_ENTRY_ADDR		(S5P_VA_SYSRAM_NS + 0x1c)
> > +
> > +static arch_spinlock_t edcs_lock = __ARCH_SPIN_LOCK_UNLOCKED;
> > +
> > +static int edcs_use_count[EDCS_CPUS_PER_CLUSTER][EDCS_CLUSTERS];
> > +static int core_count[EDCS_CLUSTERS];
> > +
> > +static void exynos_core_power_control(unsigned int cpu, unsigned int cluster,
> > +				bool enable)
> > +{
> > +	unsigned int offset = cluster * MAX_CPUS_PER_CLUSTER + cpu;

You should use EDCS_CPUS_PER_CLUSTER here, not MAX_CPUS_PER_CLUSTER.

> > +	int value = enable ? S5P_CORE_LOCAL_PWR_EN : 0;
> > +
> > +	if ((readl_relaxed(EDCS_CORE_STATUS(offset)) & 0x3) != value) {
> 
> I wonder if there is a race here.

It is racy.

> If there is a pending powerdown which has reached the __mcpm_cpu_down()
> stage, then the kernel has no way to know what is still pending.  This
> means that when calling exynos_power_up(cpu, cluster) after a successful
> call to exynos_power_down(same cpu, cluster), there is a chance that
> the CPU still gets powered down, because of the pending
> exynos_core_power_control() on the outbound side.
> 
> This isn't an issue for TC2, because TC2's power controller queues
> requests and services them in order, so a new powerup request cannot
> race with a powerdown request in that way.

The reason why this isn't an issue for TC2 is because the request to 
power down request is sent from within the spinlock protected area which 
serializes all requests.  Here exynos_core_power_down() is invoked where 
there is no such protection.

The simple fix would be to simply move this call up, assuming that the 
power is actually turned off only when the WFI signal is asserted.

> I think that for correct behaviour we would need to wait for the race to
> be resolved here, but only if a powerdown might be pending.
> 
> This implies that something like a call to the power_down_finish()
> method (which you would need to write -- see my comments below) is
> needed in exynos_core_power_up().
> 
> 
> It might make sense to have a per-cpu flag that tracks whether a
> powerdown is pending.  The flag could be set after
> __mcpm_cpu_going_down() is called, and cleared in the powered_up()
> method (which you would need to add).
> 
> 
> Maybe we should always just poll and wait, though.  exynos_power_up()
> should never be called for a CPU that the kernel thinks is already up,
> so it should either be down already (in which case we will poll the
> status once and then continue), or a power down is pending (in which
> case we must wait, but we know the wait will terminate).  This would
> be simpler than tracking a "power down pending" flag for each CPU.

That is also a good way to avoid the race.


Nicolas
