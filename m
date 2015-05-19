From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 19 May 2015 16:21:14 +0800
Subject: [PATCHv2 04/12] arm64: psci: remove unnecessary id indirection
In-Reply-To: <1431945503-6939-5-git-send-email-mark.rutland@arm.com>
References: <1431945503-6939-1-git-send-email-mark.rutland@arm.com>
 <1431945503-6939-5-git-send-email-mark.rutland@arm.com>
Message-ID: <555AF27A.1000500@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?05?18? 18:38, Mark Rutland wrote:
> PSCI 0.1 did not define canonical IDs for CPU_ON, CPU_OFF, CPU_SUSPEND,
> or MIGRATE, and so these need to be provided when using firmware
> compliant to PSCI 0.1.
>
> However, functions introduced in 0.2 or later have canonical IDs, and
> these cannot be provided via DT. There's no need to indirect the IDs via
> a table; they can be used directly at callsites (and already are for
> SYSTEM_OFF and SYSTEM_RESET).
>
> This patch removes the unnecessary function ID indirection for
> AFFINITY_INFO and MIGRATE_INFO_TYPE.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>   arch/arm64/kernel/psci.c | 20 +++-----------------
>   1 file changed, 3 insertions(+), 17 deletions(-)
>
> diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
> index 10fa25e..66b5b75 100644
> --- a/arch/arm64/kernel/psci.c
> +++ b/arch/arm64/kernel/psci.c
> @@ -67,8 +67,6 @@ enum psci_function {
>   	PSCI_FN_CPU_ON,
>   	PSCI_FN_CPU_OFF,
>   	PSCI_FN_MIGRATE,
> -	PSCI_FN_AFFINITY_INFO,
> -	PSCI_FN_MIGRATE_INFO_TYPE,
>   	PSCI_FN_MAX,
>   };
>
> @@ -168,22 +166,13 @@ static int psci_migrate(unsigned long cpuid)
>   static int psci_affinity_info(unsigned long target_affinity,
>   		unsigned long lowest_affinity_level)
>   {
> -	int err;
> -	u32 fn;
> -
> -	fn = psci_function_id[PSCI_FN_AFFINITY_INFO];
> -	err = invoke_psci_fn(fn, target_affinity, lowest_affinity_level, 0);
> -	return err;
> +	return invoke_psci_fn(PSCI_0_2_FN64_AFFINITY_INFO, target_affinity,
> +			      lowest_affinity_level, 0);
>   }
>
>   static int psci_migrate_info_type(void)
>   {
> -	int err;
> -	u32 fn;
> -
> -	fn = psci_function_id[PSCI_FN_MIGRATE_INFO_TYPE];
> -	err = invoke_psci_fn(fn, 0, 0, 0);
> -	return err;
> +	return invoke_psci_fn(PSCI_0_2_FN_MIGRATE_INFO_TYPE, 0, 0, 0);
>   }
>
>   static int __maybe_unused cpu_psci_cpu_init_idle(struct device_node *cpu_node,
> @@ -290,11 +279,8 @@ static void __init psci_0_2_set_functions(void)
>   	psci_function_id[PSCI_FN_MIGRATE] = PSCI_0_2_FN64_MIGRATE;
>   	psci_ops.migrate = psci_migrate;
>
> -	psci_function_id[PSCI_FN_AFFINITY_INFO] = PSCI_0_2_FN64_AFFINITY_INFO;
>   	psci_ops.affinity_info = psci_affinity_info;
>
> -	psci_function_id[PSCI_FN_MIGRATE_INFO_TYPE] =
> -		PSCI_0_2_FN_MIGRATE_INFO_TYPE;
>   	psci_ops.migrate_info_type = psci_migrate_info_type;
>
>   	arm_pm_restart = psci_sys_reset;

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
