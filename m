From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 18 Nov 2012 22:08:20 -0500 (EST)
Subject: [PATCH v3 1/5] ARM: kernel: smp_setup_processor_id() updates
In-Reply-To: <1352983614-22924-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1352983614-22924-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1352983614-22924-2-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <alpine.LFD.2.02.1211182151400.1182@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 Nov 2012, Lorenzo Pieralisi wrote:

> This patch applies some basic changes to the smp_setup_processor_id()
> ARM implementation to make the code that builds cpu_logical_map more
> uniform across the kernel.
> 
> The function now prints the full extent of the boot CPU MPIDR[23:0] and
> initializes the cpu_logical_map for CPUs up to nr_cpu_ids.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/kernel/setup.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index da1d1aa..d0df6c8 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -426,13 +426,14 @@ int __cpu_logical_map[NR_CPUS];
>  void __init smp_setup_processor_id(void)
>  {
>  	int i;
> -	u32 cpu = is_smp() ? read_cpuid_mpidr() & 0xff : 0;
> +	u32 mpidr = is_smp() ? read_cpuid_mpidr() & 0xffffff : 0;
> +	u32 cpu = mpidr & 0xff;
>  
>  	cpu_logical_map(0) = cpu;
> -	for (i = 1; i < NR_CPUS; ++i)
> +	for (i = 1; i < nr_cpu_ids; ++i)
>  		cpu_logical_map(i) = i == cpu ? 0 : i;
>  
> -	printk(KERN_INFO "Booting Linux on physical CPU %d\n", cpu);
> +	printk(KERN_INFO "Booting Linux on physical CPU 0x%x\n", mpidr);
>  }
>  
>  static void __init setup_processor(void)
> -- 
> 1.7.12
> 
> 
