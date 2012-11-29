From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 29 Nov 2012 10:45:50 -0500 (EST)
Subject: [PATCH v2] ARM: implement optimized percpu variable access
In-Reply-To: <1354200764-23751-1-git-send-email-robherring2@gmail.com>
References: <1354200764-23751-1-git-send-email-robherring2@gmail.com>
Message-ID: <alpine.LFD.2.02.1211291039060.4576@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 29 Nov 2012, Rob Herring wrote:

> From: Rob Herring <rob.herring@calxeda.com>
> 
> Use the previously unused TPIDRPRW register to store percpu offsets.
> TPIDRPRW is only accessible in PL1, so it can only be used in the kernel.
> 
> This replaces 2 loads with a mrc instruction for each percpu variable
> access. With hackbench, the performance improvement is 1.4% on Cortex-A9
> (highbank). Taking an average of 30 runs of "hackbench -l 1000" yields:
> 
> Before: 6.2191
> After: 6.1348
> 
> Will Deacon reported similar delta on v6 with 11MPCore.
> 
> The asm "memory" constraints are needed here to ensure the percpu offset
> gets reloaded. Testing by Will found that this would not happen in
> __schedule() which is a bit of a special case as preemption is disabled
> but the execution can move cores.

Strictly speaking, you should say "memory clobber" and not "memory 
constraint" in this case.

> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Acked-by: Will Deacon <will.deacon@arm.com>

With the above, and moving the call to cpu_init() after the call to 
cpu_switch_mm(mm->pgd, mm) to fix Will's concerns (personally I'd put it 
right after local_flush_tlb_all())... 

Acked-by: Nicolas Pitre <nico@linaro.org>


> ---
> Changes in v2:
> - Add asm "memory" constraint
> - Only enable on v6K and v7 and avoid enabling for v6 SMP_ON_UP
> - Fix missing initialization of TPIDRPRW for resume path
> - Move cpu_init to beginning of secondary_start_kernel to ensure percpu
>   variables can be accessed as early as possible.
> 
>  arch/arm/include/asm/Kbuild   |    1 -
>  arch/arm/include/asm/percpu.h |   45 +++++++++++++++++++++++++++++++++++++++++
>  arch/arm/kernel/setup.c       |    6 ++++++
>  arch/arm/kernel/smp.c         |    4 +++-
>  4 files changed, 54 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/include/asm/percpu.h
> 
> diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
> index f70ae17..2ffdaac 100644
> --- a/arch/arm/include/asm/Kbuild
> +++ b/arch/arm/include/asm/Kbuild
> @@ -16,7 +16,6 @@ generic-y += local64.h
>  generic-y += msgbuf.h
>  generic-y += param.h
>  generic-y += parport.h
> -generic-y += percpu.h
>  generic-y += poll.h
>  generic-y += resource.h
>  generic-y += sections.h
> diff --git a/arch/arm/include/asm/percpu.h b/arch/arm/include/asm/percpu.h
> new file mode 100644
> index 0000000..968c0a1
> --- /dev/null
> +++ b/arch/arm/include/asm/percpu.h
> @@ -0,0 +1,45 @@
> +/*
> + * Copyright 2012 Calxeda, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +#ifndef _ASM_ARM_PERCPU_H_
> +#define _ASM_ARM_PERCPU_H_
> +
> +/*
> + * Same as asm-generic/percpu.h, except that we store the per cpu offset
> + * in the TPIDRPRW. TPIDRPRW only exists on V6K and V7
> + */
> +#if defined(CONFIG_SMP) && !defined(CONFIG_CPU_V6)
> +static inline void set_my_cpu_offset(unsigned long off)
> +{
> +	/* Set TPIDRPRW */
> +	asm volatile("mcr p15, 0, %0, c13, c0, 4" : : "r" (off) : "memory");
> +}
> +
> +static inline unsigned long __my_cpu_offset(void)
> +{
> +	unsigned long off;
> +	/* Read TPIDRPRW */
> +	asm("mrc p15, 0, %0, c13, c0, 4" : "=r" (off) : : "memory");
> +	return off;
> +}
> +#define __my_cpu_offset __my_cpu_offset()
> +#else
> +#define set_my_cpu_offset(x)	do {} while(0)
> +
> +#endif /* CONFIG_SMP */
> +
> +#include <asm-generic/percpu.h>
> +
> +#endif /* _ASM_ARM_PERCPU_H_ */
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index da1d1aa..b2909ce 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -383,6 +383,12 @@ void cpu_init(void)
>  		BUG();
>  	}
>  
> +	/*
> +	 * This only works on resume and secondary cores. For booting on the
> +	 * boot cpu, smp_prepare_boot_cpu is called after percpu area setup.
> +	 */
> +	set_my_cpu_offset(per_cpu_offset(cpu));
> +
>  	cpu_proc_init();
>  
>  	/*
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index fbc8b26..aadcca7 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -296,6 +296,8 @@ asmlinkage void __cpuinit secondary_start_kernel(void)
>  	struct mm_struct *mm = &init_mm;
>  	unsigned int cpu;
>  
> +	cpu_init();
> +
>  	/*
>  	 * The identity mapping is uncached (strongly ordered), so
>  	 * switch away from it before attempting any exclusive accesses.
> @@ -315,7 +317,6 @@ asmlinkage void __cpuinit secondary_start_kernel(void)
>  
>  	printk("CPU%u: Booted secondary processor\n", cpu);
>  
> -	cpu_init();
>  	preempt_disable();
>  	trace_hardirqs_off();
>  
> @@ -371,6 +372,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
>  
>  void __init smp_prepare_boot_cpu(void)
>  {
> +	set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
>  }
>  
>  void __init smp_prepare_cpus(unsigned int max_cpus)
> -- 
> 1.7.10.4
> 
