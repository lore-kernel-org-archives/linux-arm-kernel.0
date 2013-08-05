From: horms@verge.net.au (Simon Horman)
Date: Mon, 5 Aug 2013 17:34:52 +0900
Subject: [PATCH 01/02] ARM: shmobile: Introduce per-CPU SMP boot / sleep
 code
In-Reply-To: <20130731183818.31551.51694.sendpatchset@w520>
References: <20130731183808.31551.47235.sendpatchset@w520>
 <20130731183818.31551.51694.sendpatchset@w520>
Message-ID: <20130805083451.GB13274@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 01, 2013 at 03:38:18AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add per-CPU SMP boot / sleep code that can be used by all
> SoCs included in mach-shmobile.
> 
> The boot code reads out the per-CPU MPIDR id value and
> matches it with the value stored for any CPU number, and
> if there is a match and the boot function is set as well
> then the boot function will be executed.
> 
> The sleep code simply uses WFI and then jumps back to the
> boot code to see if anyone has asked to wake up that CPU,
> if not it will sleep again.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Hi Magnus,

I have queued this up for v3.12 in the smp branch
with the following whitespace changes:

> ---
> 
>  arch/arm/mach-shmobile/headsmp.S             |   50 ++++++++++++++++++++++++++
>  arch/arm/mach-shmobile/include/mach/common.h |    4 ++
>  arch/arm/mach-shmobile/platsmp.c             |   18 +++++++++
>  3 files changed, 72 insertions(+)
> 
> --- 0001/arch/arm/mach-shmobile/headsmp.S
> +++ work/arch/arm/mach-shmobile/headsmp.S	2013-07-31 12:23:20.000000000 +0900
> @@ -40,3 +40,53 @@ shmobile_boot_fn:
>  	.globl	shmobile_boot_arg
>  shmobile_boot_arg:
>  2:	.space	4
> +
> +/*
> + * Per-CPU SMP boot function/argument selection code based on MPIDR
> + */
> +
> +ENTRY(shmobile_smp_boot)
> +						@ r0 = MPIDR_HWID_BITMASK
> +	mrc	p15, 0, r1, c0, c0, 5		@ r1 = MPIDR
> +	and	r0, r1, r0			@ r0 = cpu_logical_map() value
> +	mov	r1, #0				@ r1 = CPU index
> +	adr	r5, 1f				@ array of per-cpu mpidr values
> +	adr	r6, 2f				@ array of per-cpu functions
> +	adr	r7, 3f				@ array of per-cpu arguments
> +	

Removed trailing whitespace from line above.

> +shmobile_smp_boot_find_mpidr:
> +	ldr	r8, [r5, r1, lsl #2]
> +	cmp	r8, r0
> +	bne	shmobile_smp_boot_next
> +
> +	ldr	r9, [r6, r1, lsl #2]
> +	cmp	r9, #0
> +	bne	shmobile_smp_boot_found
> +	

Removed trailing whitespace from line above.

> +shmobile_smp_boot_next:
> +	add	r1, r1, #1
> +	cmp	r1, #CONFIG_NR_CPUS
> +	blo	shmobile_smp_boot_find_mpidr
> +
> +	b	shmobile_smp_sleep
> +	

Removed trailing whitespace from line above.

> +shmobile_smp_boot_found:
> +	ldr	r0, [r7, r1, lsl #2]
> +	mov	pc, r9
> +ENDPROC(shmobile_smp_boot)
> +
> +ENTRY(shmobile_smp_sleep)
> +	wfi
> +	b	shmobile_smp_boot
> +ENDPROC(shmobile_smp_sleep)
> +
> +	.globl	shmobile_smp_mpidr
> +shmobile_smp_mpidr:
> +1:	.space	CONFIG_NR_CPUS * 4
> +	.globl	shmobile_smp_fn
> +shmobile_smp_fn:
> +2:	.space	CONFIG_NR_CPUS * 4
> +	.globl	shmobile_smp_arg
> +shmobile_smp_arg:
> +3:	.space	CONFIG_NR_CPUS * 4
> +

Remove trailing blank line from line above.

> --- 0006/arch/arm/mach-shmobile/include/mach/common.h
> +++ work/arch/arm/mach-shmobile/include/mach/common.h	2013-07-31 12:18:01.000000000 +0900
> @@ -10,6 +10,10 @@ extern void shmobile_setup_console(void)
>  extern void shmobile_boot_vector(void);
>  extern unsigned long shmobile_boot_fn;
>  extern unsigned long shmobile_boot_arg;
> +extern void shmobile_smp_boot(void);
> +extern void shmobile_smp_sleep(void);
> +extern void shmobile_smp_hook(unsigned int cpu, unsigned long fn,
> +			      unsigned long arg);
>  extern void shmobile_boot_scu(void);
>  extern void shmobile_smp_scu_prepare_cpus(unsigned int max_cpus);
>  extern int shmobile_smp_scu_boot_secondary(unsigned int cpu,
> --- 0001/arch/arm/mach-shmobile/platsmp.c
> +++ work/arch/arm/mach-shmobile/platsmp.c	2013-07-31 12:18:01.000000000 +0900
> @@ -12,6 +12,9 @@
>   */
>  #include <linux/init.h>
>  #include <linux/smp.h>
> +#include <asm/cacheflush.h>
> +#include <asm/smp_plat.h>
> +#include <mach/common.h>
>  
>  void __init shmobile_smp_init_cpus(unsigned int ncores)
>  {
> @@ -26,3 +29,18 @@ void __init shmobile_smp_init_cpus(unsig
>  	for (i = 0; i < ncores; i++)
>  		set_cpu_possible(i, true);
>  }
> +
> +extern unsigned long shmobile_smp_fn[];
> +extern unsigned long shmobile_smp_arg[];
> +extern unsigned long shmobile_smp_mpidr[];
> +
> +void shmobile_smp_hook(unsigned int cpu, unsigned long fn, unsigned long arg)
> +{
> +	shmobile_smp_fn[cpu] = 0;
> +	flush_cache_all();
> +
> +	shmobile_smp_mpidr[cpu] = cpu_logical_map(cpu);
> +	shmobile_smp_fn[cpu] = fn;
> +	shmobile_smp_arg[cpu] = arg;
> +	flush_cache_all();
> +}
> 
