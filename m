From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 14 Jan 2013 11:51:11 -0500 (EST)
Subject: [PATCH 06/16] ARM: b.L: generic SMP secondary bringup and hotplug
 support
In-Reply-To: <20130114163530.GA31341@mudshark.cambridge.arm.com>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-7-git-send-email-nicolas.pitre@linaro.org>
 <20130114163530.GA31341@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.02.1301141145350.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Jan 2013, Will Deacon wrote:

> On Thu, Jan 10, 2013 at 12:20:41AM +0000, Nicolas Pitre wrote:
> > Now that the b.L power API is in place, we can use it for SMP secondary
> > bringup and CPU hotplug in a generic fashion.
> 
> [...]
> 
> > diff --git a/arch/arm/common/bL_platsmp.c b/arch/arm/common/bL_platsmp.c
> > new file mode 100644
> > index 0000000000..0acb9f4685
> > --- /dev/null
> > +++ b/arch/arm/common/bL_platsmp.c
> > @@ -0,0 +1,79 @@
> > +/*
> > + * linux/arch/arm/mach-vexpress/bL_platsmp.c
> > + *
> > + * Created by:  Nicolas Pitre, November 2012
> > + * Copyright:   (C) 2012  Linaro Limited
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * Code to handle secondary CPU bringup and hotplug for the bL power API.
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/smp.h>
> > +
> > +#include <asm/bL_entry.h>
> > +#include <asm/smp_plat.h>
> > +#include <asm/hardware/gic.h>
> > +
> > +static void __init simple_smp_init_cpus(void)
> > +{
> > +	set_smp_cross_call(gic_raise_softirq);
> > +}
> > +
> > +static int __cpuinit bL_boot_secondary(unsigned int cpu, struct task_struct *idle)
> > +{
> > +	unsigned int pcpu, pcluster, ret;
> > +	extern void secondary_startup(void);
> > +
> > +	pcpu = cpu_logical_map(cpu) & 0xff;
> > +	pcluster = (cpu_logical_map(cpu) >> 8) & 0xff;
> 
> Again, you can probably use Lorenzo's helpers here.

Yes, that goes for the whole series.

> > +	pr_debug("%s: logical CPU %d is physical CPU %d cluster %d\n",
> > +		 __func__, cpu, pcpu, pcluster);
> > +
> > +	bL_set_entry_vector(pcpu, pcluster, NULL);
> 
> Now that you don't have a barrier in this function, you need one here.

Hmmm... Why?

> > +	ret = bL_cpu_power_up(pcpu, pcluster);
> > +	if (ret)
> > +		return ret;
> 
> and here, although I confess to not understanding why you write NULL the
> first time.

If for some reasons the bL_cpu_power_up() call fails, I don't want this 
CPU to suddenly decide to enter the kernel if it wakes up at a later 
time when secondary_startup is not ready to deal with it anymore.

> > +	bL_set_entry_vector(pcpu, pcluster, secondary_startup);
> > +	gic_raise_softirq(cpumask_of(cpu), 0);
> > +	sev();
> 
> This relise on the event register being able to be set if the target is in a
> low-power (wfi) state. I'd feel safer with a dsb before the sev...

Sure.


Nicolas
