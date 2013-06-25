From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 25 Jun 2013 15:13:32 +0100
Subject: [PATCH] ARM: keystone: remove hand-coded smc instruction
In-Reply-To: <51C4D9B7.5010109@ti.com>
References: <201306212228.29717.arnd@arndb.de>
 <201306212313.16771.arnd@arndb.de> <51C4C3B4.2050508@ti.com>
 <201306212341.08579.arnd@arndb.de> <51C4D9B7.5010109@ti.com>
Message-ID: <20130625141332.GC2327@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 06:54:47PM -0400, Santosh Shilimkar wrote:
> On Friday 21 June 2013 05:41 PM, Arnd Bergmann wrote:
> > On Friday 21 June 2013, Santosh Shilimkar wrote:
> >>>
> >> I was curious how you will fix that for a c file.
> >> Just to be clear, I was planning to do that in 3.11-rcx/3.12
> >> time. Let me know if it needs to be done earlier than that.
> > 
> > It breaks randconfig builds on arm-soc at the moment, so I'd
> > like the fix as early as possible for 3.11.
> > 
> Ok, fix is at end of the email. Let me know if it makes
> to pass both the builds now. I have build and boot tested
> both ARM and THUMB2 builds on Keystone board.
> 
> Regards,
> Santosh
> 
> From 05d6a5b6cad624fb3791e8c1f8eb7c774f0790d9 Mon Sep 17 00:00:00 2001
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Date: Fri, 21 Jun 2013 18:35:32 -0400
> Subject: [PATCH] ARM: keystone: Move CPU bringup code to dedicated asm file
> 
> Because of inline asm usage in platsmp.c, smc instruction
> creates build failure for ARM V6+V7 build where as using instruction
> encoding for smc breaks the thumb2 build.
> 
> So move the code snippet to separate asm file and mark
> it with 'armv7-a$(plus_sec)' to avoid any build issues.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-keystone/Makefile   |    6 +++++-
>  arch/arm/mach-keystone/keystone.h |    6 ++++++
>  arch/arm/mach-keystone/platsmp.c  |   15 +++------------
>  arch/arm/mach-keystone/smc.S      |   29 +++++++++++++++++++++++++++++
>  4 files changed, 43 insertions(+), 13 deletions(-)
>  create mode 100644 arch/arm/mach-keystone/smc.S
> 
> diff --git a/arch/arm/mach-keystone/Makefile b/arch/arm/mach-keystone/Makefile
> index 3f6b8ab..ddc52b0 100644
> --- a/arch/arm/mach-keystone/Makefile
> +++ b/arch/arm/mach-keystone/Makefile
> @@ -1,2 +1,6 @@
> -obj-y					:= keystone.o
> +obj-y					:= keystone.o smc.o
> +
> +plus_sec := $(call as-instr,.arch_extension sec,+sec)
> +AFLAGS_smc.o				:=-Wa,-march=armv7-a$(plus_sec)
> +
>  obj-$(CONFIG_SMP)			+= platsmp.o
> diff --git a/arch/arm/mach-keystone/keystone.h b/arch/arm/mach-keystone/keystone.h
> index 43a1b47..60bef9d 100644
> --- a/arch/arm/mach-keystone/keystone.h
> +++ b/arch/arm/mach-keystone/keystone.h
> @@ -11,7 +11,13 @@
>  #ifndef __KEYSTONE_H__
>  #define __KEYSTONE_H__
>  
> +#define KEYSTONE_MON_CPU_UP_IDX		0x00
> +
> +#ifndef __ASSEMBLER__
> +
>  extern struct smp_operations keystone_smp_ops;
>  extern void secondary_startup(void);
> +extern u32 keystone_cpu_smc(u32 command, u32 cpu, u32 addr);
>  
> +#endif /* __ASSEMBLER__ */
>  #endif /* __KEYSTONE_H__ */
> diff --git a/arch/arm/mach-keystone/platsmp.c b/arch/arm/mach-keystone/platsmp.c
> index 630ab3b..1d4181e 100644
> --- a/arch/arm/mach-keystone/platsmp.c
> +++ b/arch/arm/mach-keystone/platsmp.c
> @@ -30,18 +30,9 @@ static int __cpuinit keystone_smp_boot_secondary(unsigned int cpu,
>  	pr_debug("keystone-smp: booting cpu %d, vector %08lx\n",
>  		 cpu, start);
>  
> -	asm volatile (
> -		"mov    r0, #0\n"	/* power on cmd	*/
> -		"mov    r1, %1\n"	/* cpu		*/
> -		"mov    r2, %2\n"	/* start	*/
> -		".inst  0xe1600070\n"	/* smc #0	*/
> -		"mov    %0, r0\n"
> -		: "=r" (error)
> -		: "r"(cpu), "r"(start)
> -		: "cc", "r0", "r1", "r2", "memory"
> -	);
> -
> -	pr_debug("keystone-smp: monitor returned %d\n", error);
> +	error = keystone_cpu_smc(KEYSTONE_MON_CPU_UP_IDX, cpu, start);
> +	if (error)
> +		pr_err("CPU %d bringup failed with %d\n", cpu, error);
>  
>  	return error;
>  }
> diff --git a/arch/arm/mach-keystone/smc.S b/arch/arm/mach-keystone/smc.S
> new file mode 100644
> index 0000000..9b9e4f7
> --- /dev/null
> +++ b/arch/arm/mach-keystone/smc.S
> @@ -0,0 +1,29 @@
> +/*
> + * Keystone Secure APIs
> + *
> + * Copyright (C) 2013 Texas Instruments, Inc.
> + * 	Santosh Shilimkar <santosh.shilimkar@ti.com>
> + *
> + * This program is free software,you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/linkage.h>
> +
> +/**
> + * u32 keystone_cpu_smc(u32 command, u32 cpu, u32 addr)
> + *
> + * Low level CPU monitor API
> + * @command:	Monitor command.
> + * @cpu:	CPU Number
> + * @addr:	Kernel jump address for boot CPU
> + *
> + * Return: Non zero value on failure
> + */

Oops, looks like I missed the final mail on this thread.  Ignore my
previous mail.

I still think it would be a good idea to try to consolidate all these
trivial SMC wrappers, but this remains debatable.



Anyway, this looks like it should work, except:

> +ENTRY(keystone_cpu_smc)
> +	stmfd   sp!, {r4-r12, lr}
> +	smc	#0
> +	dsb

What's this DSB for?  (You didn't have it in the inline asm version)

> +	ldmfd   sp!, {r4-r12, pc}
> +ENDPROC(keystone_cpu_smc)

r12 is caller-save btw; you don't need to preserve it.

Cheers
---Dave
