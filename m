From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 16 Nov 2012 12:19:34 -0500 (EST)
Subject: [RFC PATCH v2 1/2] ARM: kernel: add MIDR to per-CPU information
 data
In-Reply-To: <1353066105-19486-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1353066105-19486-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1353066105-19486-2-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <alpine.LFD.2.02.1211161219090.1238@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Nov 2012, Lorenzo Pieralisi wrote:

> The advent of big.LITTLE ARM platforms requires the kernel to be able
> to identify the MIDRs of all online CPUs upon request. MIDRs are stashed
> at boot time so that kernel subsystems can detect the MIDR of online CPUs
> by simply retrieving per-CPU data updated by all booted CPUs.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/include/asm/cpu.h | 1 +
>  arch/arm/kernel/smp.c      | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm/include/asm/cpu.h b/arch/arm/include/asm/cpu.h
> index d797223..2744f06 100644
> --- a/arch/arm/include/asm/cpu.h
> +++ b/arch/arm/include/asm/cpu.h
> @@ -15,6 +15,7 @@
>  
>  struct cpuinfo_arm {
>  	struct cpu	cpu;
> +	u32		cpuid;
>  #ifdef CONFIG_SMP
>  	unsigned int	loops_per_jiffy;
>  #endif
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 9da08ce..eeb75e1 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -282,6 +282,7 @@ static void __cpuinit smp_store_cpu_info(unsigned int cpuid)
>  	struct cpuinfo_arm *cpu_info = &per_cpu(cpu_data, cpuid);
>  
>  	cpu_info->loops_per_jiffy = loops_per_jiffy;
> +	cpu_info->cpuid = read_cpuid_id();
>  
>  	store_cpu_topology(cpuid);
>  }
> -- 
> 1.7.12
> 
> 
