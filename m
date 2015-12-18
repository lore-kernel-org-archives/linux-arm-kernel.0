From: panand@redhat.com (Pratyush Anand)
Date: Fri, 18 Dec 2015 15:45:51 +0530
Subject: [PATCH RFC] ARM64: Add cpu hotplug for device tree parking method
In-Reply-To: <20151217142018.GE13389@leverpostej>
References: <49d1ca9f7ca09707cdefbebe6f0163c376b1eaea.1450358510.git.panand@redhat.com>
 <20151217142018.GE13389@leverpostej>
Message-ID: <20151218101550.GD29413@dhcppc13.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Thanks a lot for your review.

On 17/12/2015:02:20:19 PM, Mark Rutland wrote:
> On Thu, Dec 17, 2015 at 07:09:29PM +0530, Pratyush Anand wrote:
> > This patch has been implemented for CPU hotplug support for device tree
> > spin-table based parking method.
> > 
> > While cpu is offlined, cpu_die is called and when it is brought online
> > cpu_boot is called. So, cpu_boot must wake secondary and release pen,
> > otherwise dynamic cpu offline/online will not work.
> 
> This has been discussed in the past, and using an in-kernel pen was
> NAK'd. An in-purgatory pen has an almost identical set of problems.
> 
> At minimum, to make spin-table hotplug viable we need FW support, and a
> well-defined protocol for handing CPUs back to FW.

OK.So is this being driven somewhere? Although, our interest is mainly
in ACPI based parking protocol, but sometime I do need to verify some
functionality with upstream kernel which is by default !ACPI.

> 
> Without that, NAK.
> 
> > Signed-off-by: Pratyush Anand <panand@redhat.com>
> > ---
> > Hi,
> > 
> > Actually this patch is using some infrastructure from Geoff's kexec-v12.3.
> > But I am sending this patch for your review and feedback in advance. This
> > patch is needed for kexec and cpu hotplug to work on a system with device
> > tree spin-table method.
> > 
> > Have tested this patch with kexec and also with cpu offline from sys
> > interface.
> > 
> >  # lscpu
> > Architecture:          aarch64
> > Byte Order:            Little Endian
> > CPU(s):                8
> > On-line CPU(s) list:   0-7
> > Thread(s) per core:    1
> > Core(s) per socket:    2
> > Socket(s):             4
> >  # echo 0 > /sys/bus/cpu/devices/cpu3/online
> >  # lscpu
> > Architecture:          aarch64
> > Byte Order:            Little Endian
> > CPU(s):                8
> > On-line CPU(s) list:   0-2,4-7
> > Off-line CPU(s) list:  3
> > Thread(s) per core:    1
> > Core(s) per socket:    1
> > Socket(s):             4
> >  # echo 1 > /sys/bus/cpu/devices/cpu3/online
> >  # lscpu
> > Architecture:          aarch64
> > Byte Order:            Little Endian
> > CPU(s):                8
> > On-line CPU(s) list:   0-7
> > Thread(s) per core:    1
> > Core(s) per socket:    2
> > Socket(s):             4
> > 
> > cpu-park infrastructure of this patch can further be shared by ACPI parking
> > protocol support for providing CPU hotplug support.
> 
> If the parking protocol is missing a provision to return CPUs to the FW,
> then that should be addressed in the parking protocol spec rather than
> hacking around it.

Well, IIUC then we should not need anything like cpu-park.S. When cpu is
offlined then cpu_die() should pass control to the FW. If that is correct then I
think spec [1] should be improved for it. It talks about behavior in parked
state, how to leave parked state. But it does not talk about how to enter parked
state. Also "Figure 3. Mailbox Format" has fields for "Processor ID" and "Jump
Address", the address where CPU should jump upon successful exit from parked
state. I think, it should also have a field for "Jump IN Address", where OS
should hand off the CPU upon cpu_die().

> 
> > 
> > ~Pratyush
> > 
> >  arch/arm64/kernel/Makefile         |  2 +-
> >  arch/arm64/kernel/cpu-park.S       | 54 ++++++++++++++++++++++++++++++++++++++
> >  arch/arm64/kernel/cpu-park.h       | 25 ++++++++++++++++++
> >  arch/arm64/kernel/smp_spin_table.c | 40 +++++++++++++++++++++++-----
> >  4 files changed, 113 insertions(+), 8 deletions(-)
> >  create mode 100644 arch/arm64/kernel/cpu-park.S
> >  create mode 100644 arch/arm64/kernel/cpu-park.h
> > 
> > diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> > index a08b0545bffa..f229f3d4b455 100644
> > --- a/arch/arm64/kernel/Makefile
> > +++ b/arch/arm64/kernel/Makefile
> > @@ -17,7 +17,7 @@ arm64-obj-y		:= debug-monitors.o entry.o irq.o fpsimd.o		\
> >  			   hyp-stub.o psci.o psci-call.o cpu_ops.o insn.o	\
> >  			   return_address.o cpuinfo.o cpu_errata.o		\
> >  			   cpufeature.o alternative.o cacheinfo.o		\
> > -			   smp.o smp_spin_table.o topology.o
> > +			   smp.o smp_spin_table.o cpu-park.o topology.o
> >  
> >  extra-$(CONFIG_EFI)			:= efi-entry.o
> >  
> > diff --git a/arch/arm64/kernel/cpu-park.S b/arch/arm64/kernel/cpu-park.S
> > new file mode 100644
> > index 000000000000..7e80ecf24f28
> > --- /dev/null
> > +++ b/arch/arm64/kernel/cpu-park.S
> > @@ -0,0 +1,54 @@
> > +/*
> > + * cpu park routines
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/linkage.h>
> > +#include <asm/assembler.h>
> > +#include <asm/sysreg.h>
> > +#include <asm/virt.h>
> > +
> > +.text
> > +.pushsection 	.idmap.text, "ax"
> > +
> > +/*
> > + * __cpu_park(el2_switch, park_address) - Helper for cpu_park
> > + *
> > + * @el2_switch: Flag to indicate a swich to EL2 is needed, passed to cpu_park.
> > + * @park_address - where cpu will keep on looking for address to jump
> > + *
> > + * Put the CPU into the wfe and check for valid none zero secondary address
> > + * at parked address when a event is received. If secondary address is
> > + * valid then jump to it.
> > + */
> > +
> > +ENTRY(__cpu_park)
> > +	/* Clear sctlr_el1 flags. */
> > +	mrs	x12, sctlr_el1
> > +	ldr	x13, =SCTLR_ELx_FLAGS
> > +	bic	x12, x12, x13
> > +	msr	sctlr_el1, x12
> > +	isb
> > +1:
> > +	wfe
> > +	ldr	x3, [x1]			// get entry address
> > +	cmp	x3, #0
> > +	b.eq	1b
> > +
> > +	mov	x2, 0
> > +	str	x2, [x1]
> > +
> > +	cbz	x0, 2f				// el2_switch?
> > +
> > +	mov	x0, x3				// entry
> > +	hvc	#HVC_CALL_FUNC			// no return
> > +
> > +2:
> > +	ret	x3
> > +
> > +ENDPROC(__cpu_park)
> 
> This relies on the old kernel text being present, but that might have
> been clobbered before the new kernel tries to boot secondary CPUs.

Yes, agreed. So, it should be handled in well defined FW.

> 
> This doesn't have the necessary endianness check/conversion (the address
> is always written little-endian, and the kernel could be big-endian).

OK.

> 
> > +
> > +.popsection
> > diff --git a/arch/arm64/kernel/cpu-park.h b/arch/arm64/kernel/cpu-park.h
> > new file mode 100644
> > index 000000000000..356438d21360
> > --- /dev/null
> > +++ b/arch/arm64/kernel/cpu-park.h
> > @@ -0,0 +1,25 @@
> > +/*
> > + * cpu park routines
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#ifndef _ARM64_CPU_PARK_H
> > +#define _ARM64_CPU_PARK_H
> > +
> > +#include <asm/virt.h>
> > +
> > +void __cpu_park(unsigned long el2_switch, unsigned long park_address);
> > +
> > +static inline void __noreturn cpu_park(unsigned long el2_switch,
> > +					unsigned long park_address)
> > +{
> > +	typeof(__cpu_park) *park_fn;
> > +	park_fn = (void *)virt_to_phys(__cpu_park);
> > +	park_fn(el2_switch, park_address);
> > +	unreachable();
> > +}
> > +
> > +#endif
> > diff --git a/arch/arm64/kernel/smp_spin_table.c b/arch/arm64/kernel/smp_spin_table.c
> > index aef3605a8c47..9411b9f59f9e 100644
> > --- a/arch/arm64/kernel/smp_spin_table.c
> > +++ b/arch/arm64/kernel/smp_spin_table.c
> > @@ -26,8 +26,11 @@
> >  #include <asm/cpu_ops.h>
> >  #include <asm/cputype.h>
> >  #include <asm/io.h>
> > +#include <asm/kexec.h>
> 
> This code shouldn't have to know anything about kexec.
> 
> >  #include <asm/smp_plat.h>
> >  
> > +#include "cpu-park.h"
> > +
> >  extern void secondary_holding_pen(void);
> >  volatile unsigned long secondary_holding_pen_release = INVALID_HWID;
> >  
> > @@ -73,11 +76,16 @@ static int smp_spin_table_cpu_init(unsigned int cpu)
> >  
> >  static int smp_spin_table_cpu_prepare(unsigned int cpu)
> >  {
> > -	__le64 __iomem *release_addr;
> > -
> >  	if (!cpu_release_addr[cpu])
> >  		return -ENODEV;
> >  
> > +	return 0;
> > +}
> > +
> > +static int smp_spin_table_cpu_boot(unsigned int cpu)
> > +{
> > +	__le64 __iomem *release_addr;
> > +
> >  	/*
> >  	 * The cpu-release-addr may or may not be inside the linear mapping.
> >  	 * As ioremap_cache will either give us a new mapping or reuse the
> > @@ -107,11 +115,6 @@ static int smp_spin_table_cpu_prepare(unsigned int cpu)
> >  
> >  	iounmap(release_addr);
> >  
> > -	return 0;
> > -}
> > -
> > -static int smp_spin_table_cpu_boot(unsigned int cpu)
> > -{
> >  	/*
> >  	 * Update the pen release flag.
> >  	 */
> > @@ -125,9 +128,32 @@ static int smp_spin_table_cpu_boot(unsigned int cpu)
> >  	return 0;
> >  }
> 
> Why have you changed the code for the boot path? No changes should be
> necessary there.

This is the only point which I am still not able to understand. Current code
structure of smp_spin_table_cpu_prepare() and smp_spin_table_cpu_boot() is fine
when secondaries boot up during kernel initialization. But, will it work in case
of a particular cpu is shutdown dynamically and brought up again?

Lets say we get a defined parking protocol for DT and we execute `echo 0
> /sys/bus/cpu/devices/cpu3/online`. smp_spin_table_cpu_die() will be called
which will hand over control to FW to some DT defined cpu-park-addr location.

Once control goes back to FW, it will keep on waiting for some non zero address
at DT defined cpu-release-addr.

Now when we execute `echo 1 > /sys/bus/cpu/devices/cpu3/online`, only cpu_boot()
is called and no cpu_prepare() is called. Currently it is the cpu_prepare()
which writes secondary_holding_pen to to DT defined cpu-release-addr

 99         writeq_relaxed(__pa(secondary_holding_pen), release_addr);   

So, until we write a valid address to cpu-release-addr, how can offlined CPU be
brought back?

> 
> >  
> > +#ifdef CONFIG_HOTPLUG_CPU
> > +static int smp_spin_table_cpu_disable(unsigned int cpu)
> > +{
> > +	if (!cpu_release_addr[cpu])
> > +		return -EOPNOTSUPP;
> > +
> > +	return 0;
> > +}
> > +
> > +static void smp_spin_table_cpu_die(unsigned int cpu)
> > +{
> > +	setup_mm_for_reboot();
> > +	cpu_park(in_crash_kexec ? 0 : is_hyp_mode_available(),
> > +			cpu_release_addr[cpu]);
> > +
> 
> For a crash it's _vastly_ simpler to put the secondary CPUs in a WFI
> loop inside the crashed kernel and leave them there. You don't need them
> to be able to dump the state of the system.
> 
> For a non-crash kernel you have no guarantee that the new kernel won't
> clobber the old text. This won't work there.

Yes, agreed. I think we need to define something like cpu-park-addr in DT, where
OS will handover control to FW and FW should have code something like following
at that location:
1: 
        wfe
        check for valid address at cpu-release-addr
        if valid switch to EL2 (if needed) and jump to that address
        else goto 1:
> 
> I'm also not clear on the rationale for circumventing hyp. If you can't
> rely on your HVC working, you can't rely on it not trapping at any
> arbitrary point in time (e.g. because its page tables were corrupt).

Now with the new understanding, yes.. no need to do anything with hyp. FW
already know that in which mode it has to switch before entering kernel. So, it
will switch over to that mode before jumping to cpu-release-addr.

Again, thanks for your time.

~Pratyush

[1] https://acpica.org/sites/acpica/files/MP%20Startup%20for%20ARM%20platforms.docx
