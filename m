From: robherring2@gmail.com (Rob Herring)
Date: Wed, 17 Oct 2012 18:30:36 -0500
Subject: [PATCHv1] arm:socfpga: Enable SMP for socfpga
In-Reply-To: <20121017230216.GA25651@elf.ucw.cz>
References: <1350501498-23601-1-git-send-email-dinguyen@altera.com>
 <507F01FD.6070403@gmail.com> <20121017230216.GA25651@elf.ucw.cz>
Message-ID: <507F3F9C.7040704@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/2012 06:02 PM, Pavel Machek wrote:
> Hi!
> 
>>>  arch/arm/mach-socfpga/Kconfig             |    1 +
>>>  arch/arm/mach-socfpga/Makefile            |    3 +
>>>  arch/arm/mach-socfpga/headsmp.S           |   64 +++++++++++
>>>  arch/arm/mach-socfpga/include/mach/core.h |   33 ++++++
>>
>> Move core.h to mach-socfpga.
> 
>>> +ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
>>> +
>>
>> This can be removed if core.h is moved.
> 
> Ok, makes code nicer. Sorry for copying picoxcell too much.
> 
>>> +	__INIT
>>> +
>>> +#define CPU1_START_ADDR 	        0xffd08010
>>> +
>>> +ENTRY(secondary_trampoline)
>>
>> This appears to be your reset code at phys addr 0. How does core 0 boot
>> if you are copying this to 0?
> 
> Yes, this is reset code, goes at zero. Core 0 has already booted by
> the time we are trying to boot Core 1 (we don't support CPU hotplug,
> yet). Is that a problem?

It would be better to do both at the same time as the code is
intertwined. More below on this...

>>> +static void __cpuinit socfpga_secondary_init(unsigned int cpu)
>>> +{
>>> +	/*
>>> +	 * if any interrupts are already enabled for the primary
>>> +	 * core (e.g. timer irq), then they will not have been enabled
>>> +	 * for us: do so
>>> +	 */
>>> +	gic_secondary_init(0);
>>> +
>>> +	/*
>>> +	 * let the primary processor know we're out of the
>>> +	 * pen, then head off into the C entry point
>>> +	 */
>>> +	pen_release = -1;
>>> +	smp_wmb();
>>> +
>>> +	/*
>>> +	 * Synchronise with the boot thread.
>>> +	 */
>>> +	spin_lock(&boot_lock);
>>> +	spin_unlock(&boot_lock);
>>> +}
>>> +
>>> +static int __cpuinit socfpga_boot_secondary(unsigned int cpu, struct task_struct *idle)
>>> +{
>>> +	unsigned long timeout;
>>> +	extern char secondary_trampoline, secondary_trampoline_end;
>>> +
>>> +	int trampoline_size = &secondary_trampoline_end - &secondary_trampoline;
>>> +
>>> +	/*
>>> +	 * Set synchronisation state between this boot processor
>>> +	 * and the secondary one
>>> +	 */
>>> +	spin_lock(&boot_lock);
>>> +
>>> +	memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
>>> +
>>> +	__raw_writel(virt_to_phys(secondary_startup), (sys_manager_base_addr+0x10));
>>> +
>>> +	pen_release = 0;
>>> +	flush_cache_all();
>>> +	smp_wmb();
>>> +	outer_clean_range(0, trampoline_size);
>>> +
>>> +	/* This will release CPU #1 out of reset.*/
>>> +	__raw_writel(0, rst_manager_base_addr + 0x10);
>>> +
>>> +	timeout = jiffies + (1 * HZ);
>>> +	while (time_before(jiffies, timeout)) {
>>> +		smp_rmb();
>>> +		if (pen_release == -1)
>>> +			break;
>>> +
>>> +		udelay(10);
>>> +	}
>>> +
>>> +	/*
>>> +	 * now the secondary core is starting up let it run its
>>> +	 * calibrations, then wait for it to finish
>>> +	 */
>>> +	spin_unlock(&boot_lock);
>>> +	return pen_release != -1 ? -ENOSYS : 0;
>>
>> You don't need any of this if you can reset secondary cores on
>> hotplug.
> 
> What exactly is unneccessary? I'd like to wait for secondary to come
> up so we can raise an error if it does not...?
> 

Look at the highbank code.

If hotplug will cause a reset of the core, then none of this pen code is
needed. If hotplug just does a wfi and returns from the wfi when
onlining the core like Versatile Express, then you need this pen code.
There's been several prior discussions about this on the list.

If you will never support hotplug (and therefore suspend), then you
don't need this pen code either.

Rob

> Thanks,
> 									Pavel
> 
> PS: I have this so far...
> 
> diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
> index 659fd27..a0fc372 100644
> --- a/arch/arm/mach-socfpga/Makefile
> +++ b/arch/arm/mach-socfpga/Makefile
> @@ -2,7 +2,5 @@
>  # Makefile for the linux kernel.
>  #
>  
> -ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
> -
>  obj-y			:= socfpga.o
>  obj-$(CONFIG_SMP)	+= headsmp.o platsmp.o hotplug.o
> diff --git a/arch/arm/mach-socfpga/include/mach/core.h b/arch/arm/mach-socfpga/core.h
> similarity index 100%
> rename from arch/arm/mach-socfpga/include/mach/core.h
> rename to arch/arm/mach-socfpga/core.h
> diff --git a/arch/arm/mach-socfpga/headsmp.S b/arch/arm/mach-socfpga/headsmp.S
> index 9597ff7..081b4d1 100644
> --- a/arch/arm/mach-socfpga/headsmp.S
> +++ b/arch/arm/mach-socfpga/headsmp.S
> @@ -20,42 +20,6 @@
>  #define CONFIG_CPU1_START_ADDR 	        (CONFIG_SYSTEM_MANAGER + 0x10)
>  
>  ENTRY(secondary_trampoline)
> -	/* From u-boot: start.S */
> -	mrs     r0, cpsr
> -	bic     r0, r0, #0x1f
> -	orr     r0, r0, #0xd3
> -	msr     cpsr,r0
> -
> -/*************************************************************************
> - *
> - * cpu_init_cp15
> - *
> - * Setup CP15 registers (cache, MMU, TLBs). The I-cache is turned on unless
> - * CONFIG_SYS_ICACHE_OFF is defined.
> - *
> - *************************************************************************/
> -ENTRY(cpu_init_cp15)
> -	/*
> -	 * Invalidate L1 I/D
> -	 */
> -	mov	r0, #0			@ set up for MCR
> -	mcr	p15, 0, r0, c8, c7, 0	@ invalidate TLBs
> -	mcr	p15, 0, r0, c7, c5, 0	@ invalidate icache
> -	mcr	p15, 0, r0, c7, c5, 6	@ invalidate BP array
> -	mcr     p15, 0, r0, c7, c10, 4	@ DSB
> -	mcr     p15, 0, r0, c7, c5, 4	@ ISB
> -
> -	/*
> -	 * disable MMU stuff and caches
> -	 */
> -	mrc	p15, 0, r0, c1, c0, 0
> -	bic	r0, r0, #0x00002000	@ clear bits 13 (--V-)
> -	bic	r0, r0, #0x00000007	@ clear bits 2:0 (-CAM)
> -	orr	r0, r0, #0x00000002	@ set bit 1 (--A-) Align
> -	orr	r0, r0, #0x00000800	@ set bit 11 (Z---) BTB
> -	orr	r0, r0, #0x00001000	@ set bit 12 (I) I-cache
> -	mcr	p15, 0, r0, c1, c0, 0
> -
>  	movw	r0, #:lower16:CONFIG_CPU1_START_ADDR
>  	movt    r0, #:upper16:CONFIG_CPU1_START_ADDR
>  
> diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
> index 34440aa..60c2b4a 100644
> --- a/arch/arm/mach-socfpga/platsmp.c
> +++ b/arch/arm/mach-socfpga/platsmp.c
> @@ -26,7 +26,7 @@
>  #include <asm/smp_scu.h>
>  #include <asm/smp_plat.h>
>  
> -#include <mach/core.h>
> +#include "core.h"
>  
>  static void __iomem *sys_manager_base_addr;
>  static void __iomem *rst_manager_base_addr;
> diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
> index 68d32cd..741b9ba 100644
> --- a/arch/arm/mach-socfpga/socfpga.c
> +++ b/arch/arm/mach-socfpga/socfpga.c
> @@ -23,7 +23,7 @@
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
>  
> -#include <mach/core.h>
> +#include "core.h"
>  
>  void __iomem *socfpga_scu_base_addr = ((void __iomem *)(SOCFPGA_SCU_VIRT_BASE));
>  void __iomem *rst_manager_base_addr = ((void __iomem *)(SOCFPGA_RST_MANAGER_VIRT_BASE));
> 
