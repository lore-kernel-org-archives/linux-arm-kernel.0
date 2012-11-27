From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 27 Nov 2012 12:19:58 -0500 (EST)
Subject: [PATCH] ARM: implement optimized percpu variable access
In-Reply-To: <1352604040-10014-1-git-send-email-robherring2@gmail.com>
References: <1352604040-10014-1-git-send-email-robherring2@gmail.com>
Message-ID: <alpine.LFD.2.02.1211271157150.4576@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 10 Nov 2012, Rob Herring wrote:

> From: Rob Herring <rob.herring@calxeda.com>
> 
> Use the previously unused TPIDRPRW register to store percpu offsets.
> TPIDRPRW is only accessible in PL1, so it can only be used in the kernel.
> 
> This saves 2 loads for each percpu variable access which should yield
> improved performance, but the improvement has not been quantified.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

I've just got around to wrap my brain around this patch and the 
discussion that ensued.

Isn't your patch lacking the preserving and restoring of the TPIDRPRW in 
the suspend and resume paths.


> ---
>  arch/arm/include/asm/Kbuild   |    1 -
>  arch/arm/include/asm/percpu.h |   44 +++++++++++++++++++++++++++++++++++++++++
>  arch/arm/kernel/smp.c         |    3 +++
>  3 files changed, 47 insertions(+), 1 deletion(-)
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
> index 0000000..9eb7372
> --- /dev/null
> +++ b/arch/arm/include/asm/percpu.h
> @@ -0,0 +1,44 @@
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
> + * in the TPIDRPRW.
> + */
> +#if defined(CONFIG_SMP) && (__LINUX_ARM_ARCH__ >= 6)
> +
> +static inline void set_my_cpu_offset(unsigned long off)
> +{
> +	asm volatile("mcr p15, 0, %0, c13, c0, 4	@ set TPIDRPRW" : : "r" (off) : "cc" );
> +}
> +
> +static inline unsigned long __my_cpu_offset(void)
> +{
> +	unsigned long off;
> +	asm("mrc p15, 0, %0, c13, c0, 4	@ get TPIDRPRW" : "=r" (off) : );
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
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index fbc8b26..897ef60 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -313,6 +313,8 @@ asmlinkage void __cpuinit secondary_start_kernel(void)
>  	current->active_mm = mm;
>  	cpumask_set_cpu(cpu, mm_cpumask(mm));
>  
> +	set_my_cpu_offset(per_cpu_offset(cpu));
> +
>  	printk("CPU%u: Booted secondary processor\n", cpu);
>  
>  	cpu_init();
> @@ -371,6 +373,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
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
