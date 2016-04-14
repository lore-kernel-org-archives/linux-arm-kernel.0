From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 14 Apr 2016 14:19:47 +0200
Subject: [PATCH v2 2/2] arm64: vhe: Verify CPU Exception Levels
In-Reply-To: <1460554893-26120-1-git-send-email-suzuki.poulose@arm.com>
References: <1460472361-28419-2-git-send-email-suzuki.poulose@arm.com>
 <1460554893-26120-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160414121947.GK30804@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2016 at 02:41:33PM +0100, Suzuki K Poulose wrote:
> With a VHE capable CPU, kernel can run at EL2 and is a decided at early
> boot. If some of the CPUs didn't start it EL2 or doesn't have VHE, we
> could have CPUs running at different exception levels, all in the same
> kernel! This patch adds an early check for the secondary CPUs to detect
> such situations.
> 
> For each non-boot CPU add a sanity check to make sure we don't have
> different run levels w.r.t the boot CPU. We save the information on
> whether the boot CPU is running in hyp mode or not and ensure the
> remaining CPUs match it.
> 
> Applies on 4.6-rc3.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> ---
> Changes since v1
>   - Move is_boot_cpu_in_hyp_mode() to smp.c
> ---
>  arch/arm64/include/asm/virt.h  |    6 ++++++
>  arch/arm64/kernel/cpufeature.c |    1 +
>  arch/arm64/kernel/smp.c        |   38 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 45 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
> index 9f22dd6..a5c2b48 100644
> --- a/arch/arm64/include/asm/virt.h
> +++ b/arch/arm64/include/asm/virt.h
> @@ -60,6 +60,12 @@ static inline bool is_kernel_in_hyp_mode(void)
>  	return el == CurrentEL_EL2;
>  }
>  
> +#ifdef CONFIG_ARM64_VHE
> +extern void verify_cpu_run_el(void);
> +#else
> +static inline void verify_cpu_run_el(void) {}
> +#endif
> +
>  /* The section containing the hypervisor text */
>  extern char __hyp_text_start[];
>  extern char __hyp_text_end[];
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 943f514..91088de 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -908,6 +908,7 @@ static u64 __raw_read_system_reg(u32 sys_id)
>   */
>  static void check_early_cpu_features(void)
>  {
> +	verify_cpu_run_el();
>  	verify_cpu_asid_bits();
>  }
>  
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index b2d5f4e..e97af155 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -75,6 +75,43 @@ enum ipi_msg_type {
>  	IPI_WAKEUP
>  };
>  
> +#ifdef CONFIG_ARM64_VHE
> +
> +/* Whether the boot CPU is running in HYP mode or not*/
> +bool boot_cpu_hyp_mode;

you can make this static now.

> +
> +static inline void save_boot_cpu_run_el(void)
> +{
> +	boot_cpu_hyp_mode = is_kernel_in_hyp_mode();
> +}
> +
> +static inline bool is_boot_cpu_in_hyp_mode(void)
> +{
> +	return boot_cpu_hyp_mode;
> +}
> +
> +/*
> + * Verify that a secondary CPU is running the kernel at the same
> + * EL as that of the boot CPU.
> + */
> +void verify_cpu_run_el(void)
> +{
> +	bool in_el2 = is_kernel_in_hyp_mode();
> +	bool boot_cpu_el2 = is_boot_cpu_in_hyp_mode();
> +
> +	if (in_el2 ^ boot_cpu_el2) {
> +		pr_crit("CPU%d: mismatched Exception Level(EL%d) with boot CPU(EL%d)\n",
> +					smp_processor_id(),
> +					in_el2 ? 2 : 1,
> +					boot_cpu_el2 ? 2 : 1);
> +		cpu_panic_kernel();
> +	}
> +}
> +
> +#else
> +static inline void save_boot_cpu_run_el(void) {}
> +#endif
> +
>  #ifdef CONFIG_HOTPLUG_CPU
>  static int op_cpu_kill(unsigned int cpu);
>  #else
> @@ -401,6 +438,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
>  void __init smp_prepare_boot_cpu(void)
>  {
>  	cpuinfo_store_boot_cpu();
> +	save_boot_cpu_run_el();
>  	set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
>  }
>  
> -- 
> 1.7.9.5
> 

Otherwise,

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
