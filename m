From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 7 May 2013 13:15:02 +0100
Subject: [Xen-devel] [PATCH RFC v2 2/4] arm: introduce CONFIG_PARAVIRT
 and pv_time_ops
In-Reply-To: <1367918609.26321.43.camel@zakaz.uk.xensource.com>
References: <alpine.DEB.2.02.1305061532310.4756@kaball.uk.xensource.com>
 <1367851878-21629-2-git-send-email-stefano.stabellini@eu.citrix.com>
 <1367918609.26321.43.camel@zakaz.uk.xensource.com>
Message-ID: <alpine.DEB.2.02.1305071301040.4147@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 7 May 2013, Ian Campbell wrote:
> On Mon, 2013-05-06 at 15:51 +0100, Stefano Stabellini wrote:
> > Introduce CONFIG_PARAVIRT on ARM.
> 
> What about PARAVIRT_TIME_ACCOUNTING? I'm not sure what it is but it
> looks like a more lightweight version of pv stolen time?
 
PARAVIRT_TIME_ACCOUNTING selects PARAVIRT on x86 :-)


> > The only paravirt interface supported is pv_time_ops.steal_clock.
> > No runtime pvops patching yet.
> 
> Or indeed ever, I think. The use cases for patching on x86 are not
> things which carry over to ARM with virt extensions.

Agreed


> > This allows us to make us of steal_account_process_tick for stolen ticks
> > accounting.
> > 
> > 
> > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > CC: linux at arm.linux.org.uk
> > CC: will.deacon at arm.com
> > CC: nico at linaro.org
> > CC: marc.zyngier at arm.com
> > CC: cov at codeaurora.org
> > CC: arnd at arndb.de
> > CC: olof at lixom.net
> > ---
> >  arch/arm/Kconfig                |    9 +++++++++
> >  arch/arm/include/asm/paravirt.h |   19 +++++++++++++++++++
> >  arch/arm/kernel/Makefile        |    1 +
> >  arch/arm/kernel/paravirt.c      |   32 ++++++++++++++++++++++++++++++++
> >  4 files changed, 61 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/include/asm/paravirt.h
> >  create mode 100644 arch/arm/kernel/paravirt.c
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 344e299..35cb10a 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1887,12 +1887,21 @@ config XEN_DOM0
> >  	def_bool y
> >  	depends on XEN
> >  
> > +config PARAVIRT
> > +	bool "Enable paravirtualization code"
> > +	---help---
> > +	  This changes the kernel so it can modify itself when it is run
> > +	  under a hypervisor, potentially improving performance significantly
> > +	  over full virtualization.  However, when run without a hypervisor
> > +	  the kernel is theoretically slower and slightly larger.
> 
> I'm not sure this description (carried over from x86) are really true
> for ARM. e.g. the downsides there when not virtualised are in the PV MMU
> (pte operations) and interrupt masking stuff, which should never make
> its way onto ARM.

Right


> I think it would be a worthwhile change to refactor the stolen time
> handling out from under the rather wide reaching umbrella of the x86
> PARAVIRT option. (assuming PARAVIRT_TIME_ACCOUNTING isn't already that)

Actually PARAVIRT doesn't mean much in common code, the only thing it
covers is stolen time.
What I mean to say is that just because we are introducing something
called "PARAVIRT" on ARM, it doesn't mean that it has to come with all
sort of baggage.


> > +
> >  config XEN
> >  	bool "Xen guest support on ARM (EXPERIMENTAL)"
> >  	depends on ARM && AEABI && OF
> >  	depends on CPU_V7 && !CPU_V6
> >  	depends on !GENERIC_ATOMIC64
> >  	select ARM_PSCI
> > +	select PARAVIRT
> >  	help
> >  	  Say Y if you want to run Linux in a Virtual Machine on Xen on ARM.
> >  
> > diff --git a/arch/arm/include/asm/paravirt.h b/arch/arm/include/asm/paravirt.h
> > new file mode 100644
> > index 0000000..3b95bc6
> > --- /dev/null
> > +++ b/arch/arm/include/asm/paravirt.h
> > @@ -0,0 +1,19 @@
> > +#ifndef _ASM_ARM_PARAVIRT_H
> > +#define _ASM_ARM_PARAVIRT_H
> > +
> > +struct static_key;
> > +extern struct static_key paravirt_steal_enabled;
> > +extern struct static_key paravirt_steal_rq_enabled;
> > +
> > +struct pv_time_ops {
> > +	unsigned long long (*steal_clock)(int cpu);
> > +};
> > +extern struct pv_time_ops pv_time_ops;
> > +
> > +static inline u64 paravirt_steal_clock(int cpu)
> > +{
> > +	return pv_time_ops.steal_clock(cpu);
> > +}
> > +
> > +
> > +#endif
> > diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> > index dd9d90a..6764f60 100644
> > --- a/arch/arm/kernel/Makefile
> > +++ b/arch/arm/kernel/Makefile
> > @@ -86,5 +86,6 @@ ifeq ($(CONFIG_ARM_PSCI),y)
> >  obj-y				+= psci.o
> >  obj-$(CONFIG_SMP)		+= psci_smp.o
> >  endif
> > +obj-$(CONFIG_PARAVIRT)	+= paravirt.o
> >  
> >  extra-y := $(head-y) vmlinux.lds
> > diff --git a/arch/arm/kernel/paravirt.c b/arch/arm/kernel/paravirt.c
> > new file mode 100644
> > index 0000000..3e73fc8
> > --- /dev/null
> > +++ b/arch/arm/kernel/paravirt.c
> > @@ -0,0 +1,32 @@
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
> > + * Copyright (C) 2013 Citrix Systems
> > + *
> > + * Author: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > + */
> > +
> > +#include <linux/export.h>
> > +#include <linux/jump_label.h>
> > +#include <linux/types.h>
> > +#include <asm/paravirt.h>
> > +
> > +struct static_key paravirt_steal_enabled;
> > +struct static_key paravirt_steal_rq_enabled;
> > +
> > +static u64 native_steal_clock(int cpu)
> > +{
> > +	return 0;
> > +}
> > +
> > +struct pv_time_ops pv_time_ops = {
> > +	.steal_clock = native_steal_clock,
> > +};
> > +EXPORT_SYMBOL_GPL(pv_time_ops);
> 
> This foo_ops.bar and native_bar thing is a bit of a hangover from the
> paravirt patching infrastructure on x86 and it doesn't really apply
> here.
> 
> Given that the call to paravirt_steal_time call is already protected by
> this static_key stuff I think it would be safe to leave the hook as NULL
> in the case where it is unused.
 
Good point


> Given all the different clock sources on ARM is there not an existing
> ops struct where this could live?

I am not sure, but I would be happy to move it something arch-specific.
