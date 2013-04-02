From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 2 Apr 2013 16:09:38 +0100
Subject: [PATCH v4 1/2] arm: introduce psci_smp_ops
In-Reply-To: <20130402110255.GA26949@mudshark.cambridge.arm.com>
References: <1364575371-8926-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130402110255.GA26949@mudshark.cambridge.arm.com>
Message-ID: <alpine.DEB.2.02.1304021535420.5078@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2 Apr 2013, Will Deacon wrote:
> > diff --git a/arch/arm/include/asm/psci.h b/arch/arm/include/asm/psci.h
> > index ce0dbe7..4134dda 100644
> > --- a/arch/arm/include/asm/psci.h
> > +++ b/arch/arm/include/asm/psci.h
> > @@ -32,5 +32,14 @@ struct psci_operations {
> >  };
> >  
> >  extern struct psci_operations psci_ops;
> > +extern struct smp_operations psci_smp_ops;
> >  
> > +#ifdef CONFIG_ARM_PSCI
> > +int psci_init(void);
> > +bool psci_smp_available(void);
> > +#else
> > +static inline int psci_init(void) { return -ENODEV; }
> > +static inline bool psci_smp_available(void) { return false; }
> 
> You can probably make psci_init return void now that it's no longer an
> initcall (you're not checking it's return value anyway).

Sure.


> > diff --git a/arch/arm/kernel/psci_smp.c b/arch/arm/kernel/psci_smp.c
> > new file mode 100644
> > index 0000000..66b0f77
> > --- /dev/null
> > +++ b/arch/arm/kernel/psci_smp.c
> > @@ -0,0 +1,67 @@
> > +/*
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * Copyright (C) 2012 ARM Limited
> > + *
> > + * Author: Will Deacon <will.deacon@arm.com>
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/irqchip/arm-gic.h>
> > +#include <linux/smp.h>
> > +#include <linux/of.h>
> > +
> > +#include <asm/psci.h>
> > +#include <asm/smp_plat.h>
> > +
> > +extern void secondary_startup(void);
> > +
> > +static int __cpuinit psci_boot_secondary(unsigned int cpu,
> > +					 struct task_struct *idle)
> > +{
> > +	if (psci_ops.cpu_on)
> > +		return psci_ops.cpu_on(cpu_logical_map(cpu),
> > +				       __pa(secondary_startup));
> > +	return -ENODEV;
> > +}
> 
> Since this code is now likely to be shared, it could be worth a comment
> before each function to describe the expected semantics (e.g. mpidr is used
> as the CPUID, additional power state information is zero).

OK. I'll document psci_operations in psci.h.
