From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 23 Jan 2018 14:59:34 +0000
Subject: [PATCH 02/16] arm64: Move errata work around check on boot CPU
In-Reply-To: <20180123122809.16269-3-suzuki.poulose@arm.com>
References: <20180123122809.16269-1-suzuki.poulose@arm.com>
 <20180123122809.16269-3-suzuki.poulose@arm.com>
Message-ID: <20180123145934.GS22781@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 23, 2018 at 12:27:55PM +0000, Suzuki K Poulose wrote:
> We trigger CPU errata work around check on the boot CPU from
> smp_prepare_boot_cpu() to make sure that we run the checks only
> after the CPU feature infrastructure is initialised.

On the surface of it, this sounds like a bug fix.

Should there be a Fixes tag if so?

If this reordering doesn't matter for upstream, it would be good to have
a quick explanation here as to why not.

Cheers
---Dave

> 
> We can do this from init_cpu_features() which is called only
> on the boot CPU and does the initilisation of the infrastructure.
> As we are consolidating the cpu capability handling, let us
> move this to where it should belong. No functional changes.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/kernel/cpufeature.c | 6 ++++++
>  arch/arm64/kernel/smp.c        | 6 ------
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 6a8dfdc532b1..ebb467340b9c 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -545,6 +545,12 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
>  		init_cpu_ftr_reg(SYS_ZCR_EL1, info->reg_zcr);
>  		sve_init_vq_map();
>  	}
> +
> +	/*
> +	 * Run the errata work around checks on the boot CPU, once we have
> +	 * initialised the cpu feature infrastructure.
> +	 */
> +	update_cpu_errata_workarounds();
>  }
>  
>  static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 3b8ad7be9c33..5cef11450183 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -448,12 +448,6 @@ void __init smp_prepare_boot_cpu(void)
>  	jump_label_init();
>  	cpuinfo_store_boot_cpu();
>  	save_boot_cpu_run_el();
> -	/*
> -	 * Run the errata work around checks on the boot CPU, once we have
> -	 * initialised the cpu feature infrastructure from
> -	 * cpuinfo_store_boot_cpu() above.
> -	 */
> -	update_cpu_errata_workarounds();
>  }
>  
>  static u64 __init of_get_cpu_mpidr(struct device_node *dn)
> -- 
> 2.13.6
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
