From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Mar 2018 18:06:12 +0000
Subject: [RFC 2/3] arm: make cpu a percpu variable
In-Reply-To: <20180315170859.93893-3-zsm@chromium.org>
References: <20180315170859.93893-1-zsm@chromium.org>
 <20180315170859.93893-3-zsm@chromium.org>
Message-ID: <20180315180612.vpae3c5k4msc2tz3@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2018 at 05:08:58PM +0000, Zubin Mithra wrote:
> Without CONFIG_THREAD_INFO_IN_TASK, core code maintains thread_info::cpu
> and arch specific code can use this to build raw_smp_processor_id().
> With CONFIG_THREAD_INFO_IN_TASK, core code maintains task_struct::cpu,
> and arch specific code cannot access this due to header file circular
> dependency.
> 
> Instead, we can maintain a percpu variable containing the cpu number.
> 
> This also means that cpu numbers obtained using smp_processor_id cannot
> be used to set_my_cpu_offset. Use task_cpu(current) instead to get the
> cpu in those cases.
> 
> Earlier raw_smp_processor_id() was current_thread_info()->cpu :-
> 	mov	r3, sp
> 	bic     r3, r3, #8128
> 	bic     r3, r3, #63
> 	ldr     r0, [r3, #16]
> 
> Now it is *raw_cpu_ptr(&cpu_number) :-
> 	movw	r3, #57344
> 	movt	r3, #32917
> 	mrc	15, 0, r0, cr13, cr0, {4}
> 	ldr	r0, [r3, r0]

It's probably worth noting that with the thread_info moved off of the
stack, were we to use that to get at the cpu number, this would require
a similar sequence to the raw_cpu_ptr() code here.

This might make more sense after a patch using a register for the
thread_info (which would also allow for having separate IRQ stacks).

> 
> Signed-off-by: Zubin Mithra <zsm@chromium.org>
> ---
>  arch/arm/include/asm/cputype.h | 3 +++
>  arch/arm/include/asm/smp.h     | 3 ++-
>  arch/arm/kernel/setup.c        | 2 +-
>  arch/arm/kernel/smp.c          | 5 +++--
>  arch/arm/kernel/topology.c     | 5 +++++
>  5 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
> index cb546425da8a..10148c7af12f 100644
> --- a/arch/arm/include/asm/cputype.h
> +++ b/arch/arm/include/asm/cputype.h
> @@ -2,6 +2,9 @@
>  #ifndef __ASM_ARM_CPUTYPE_H
>  #define __ASM_ARM_CPUTYPE_H
>  
> +#include <asm/percpu.h>
> +DECLARE_PER_CPU(int, cpu_number);
> +

Why isn't this defined in <asm/smp.h>, as we do on arm64?

> --- a/arch/arm/include/asm/smp.h
> +++ b/arch/arm/include/asm/smp.h
> @@ -18,7 +18,8 @@
>  # error "<asm/smp.h> included in non-SMP build"
>  #endif
>  
> -#define raw_smp_processor_id() (current_thread_info()->cpu)
> +#include <asm/cputype.h>
> +#define raw_smp_processor_id() (*raw_cpu_ptr(&cpu_number))

It might be worth dragging the comment along from arm64, explaining why
we must use *raw_cpu_ptr(), and not this_cpu_read(), etc.

> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -30,6 +30,9 @@
>  #include <asm/cputype.h>
>  #include <asm/topology.h>
>  
> +DEFINE_PER_CPU_READ_MOSTLY(int, cpu_number);
> +EXPORT_PER_CPU_SYMBOL(cpu_number);

Why not in smp.c, as with arm64?

> +
>  /*
>   * cpu capacity scale management
>   */
> @@ -310,6 +313,8 @@ void __init init_cpu_topology(void)
>  	for_each_possible_cpu(cpu) {
>  		struct cputopo_arm *cpu_topo = &(cpu_topology[cpu]);
>  
> +		per_cpu(cpu_number, cpu) = cpu;

Likewise, why isn't this in smp_prepare_cpus() in smp.c?

This isn't toplogy related, so it would be better placed there.

Thanks,
Mark.
