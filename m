From: vikas.cha.sajjan@hpe.com (Sajjan, Vikas C)
Date: Fri, 24 Jun 2016 03:57:53 +0000
Subject: [PATCH] drivers: firmware: psci: Add support for cpu suspend mode
 as per psci v1.0 spec
In-Reply-To: <20160623125008.GE8836@leverpostej>
References: <1466684053-26966-1-git-send-email-vikas.cha.sajjan@hpe.com>
 <20160623125008.GE8836@leverpostej>
Message-ID: <DF4PR84MB0041ED3B18FB74C886B3F31BD92E0@DF4PR84MB0041.NAMPRD84.PROD.OUTLOOK.COM>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



-----Original Message-----
From: Mark Rutland [mailto:mark.rutland at arm.com] 
Sent: Thursday, June 23, 2016 6:20 PM
To: Sajjan, Vikas C <vikas.cha.sajjan@hpe.com>
Cc: lorenzo.pieralisi at arm.com; rafael.j.wysocki at intel.com; linux-acpi at vger.kernel.org; sudeep.holla at arm.com; linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCH] drivers: firmware: psci: Add support for cpu suspend mode as per psci v1.0 spec

On Thu, Jun 23, 2016 at 05:44:13PM +0530, Vikas C Sajjan wrote:
> According to section 5.1.16 of PSCI spec, an optional feature called 
> PSCI_SET_SUSPEND_MODE was added in v1.0.
> This patch adds the support for the same.

This alone is not sufficient to use OS Initiated mode.

Lina Iyer has been looking into more comprehensive support. Please see [1,2]

Sure Mark, will see lina's patchset. I somehow missed this series, thank you.


[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-June/438625.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-June/438642.html

Thanks,
Mark.

Thanks and Regards
Vikas Sajjan

> 
> Signed-off-by: Vikas C Sajjan <vikas.cha.sajjan@hpe.com>
> ---
>  drivers/firmware/psci.c   | 20 +++++++++++++++++++-
>  include/linux/psci.h      |  1 +
>  include/uapi/linux/psci.h |  6 +++++-
>  3 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c index 
> 03e0458..c318972 100644
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -91,6 +91,12 @@ static inline bool psci_has_ext_power_state(void)
>  				PSCI_1_0_FEATURES_CPU_SUSPEND_PF_MASK;
>  }
>  
> +static inline bool psci_has_OS_initiated_mode_support(void)
> +{
> +	return psci_cpu_suspend_feature &
> +			PSCI_1_0_FEATURES_CPU_SUSPEND_OS_INITIATED_MODE_MASK;
> +}
> +
>  static inline bool psci_power_state_loses_context(u32 state)  {
>  	const u32 mask = psci_has_ext_power_state() ?
> @@ -145,6 +151,14 @@ static int psci_to_linux_errno(int errno)
>  
>  	return -EINVAL;
>  }
> +static int psci_set_cpu_suspend_mode(bool suspend_mode) {
> +	int err;
> +
> +	err = invoke_psci_fn(PSCI_FN_NATIVE(1_0, SUSPEND_MODE),
> +						suspend_mode, 0, 0);
> +	return psci_to_linux_errno(err);
> +}
>  
>  static u32 psci_get_version(void)
>  {
> @@ -397,8 +411,12 @@ static void __init psci_init_cpu_suspend(void)  {
>  	int feature = psci_features(psci_function_id[PSCI_FN_CPU_SUSPEND]);
>  
> -	if (feature != PSCI_RET_NOT_SUPPORTED)
> +	if (feature != PSCI_RET_NOT_SUPPORTED) {
>  		psci_cpu_suspend_feature = feature;
> +		if (psci_has_OS_initiated_mode_support())
> +			psci_ops.set_cpu_suspend_mode =
> +						psci_set_cpu_suspend_mode;
> +	}
>  }
>  
>  /*
> diff --git a/include/linux/psci.h b/include/linux/psci.h index 
> bdea1cb..c040502 100644
> --- a/include/linux/psci.h
> +++ b/include/linux/psci.h
> @@ -33,6 +33,7 @@ struct psci_operations {
>  	int (*affinity_info)(unsigned long target_affinity,
>  			unsigned long lowest_affinity_level);
>  	int (*migrate_info_type)(void);
> +	int (*set_cpu_suspend_mode)(bool);
>  };
>  
>  extern struct psci_operations psci_ops; diff --git 
> a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h index 
> 3d7a0fc..097c95e 100644
> --- a/include/uapi/linux/psci.h
> +++ b/include/uapi/linux/psci.h
> @@ -50,6 +50,8 @@
>  #define PSCI_1_0_FN_SYSTEM_SUSPEND		PSCI_0_2_FN(14)
>  
>  #define PSCI_1_0_FN64_SYSTEM_SUSPEND		PSCI_0_2_FN64(14)
> +#define PSCI_1_0_FN_SUSPEND_MODE		PSCI_0_2_FN(0xF)
> +#define PSCI_1_0_FN64_SUSPEND_MODE		PSCI_0_2_FN64(0xF)
>  
>  /* PSCI v0.2 power state encoding for CPU_SUSPEND function */
>  #define PSCI_0_2_POWER_STATE_ID_MASK		0xffff
> @@ -90,8 +92,10 @@
>  
>  /* PSCI features decoding (>=1.0) */
>  #define PSCI_1_0_FEATURES_CPU_SUSPEND_PF_SHIFT	1
> +#define PSCI_1_0_FEATURES_CPU_SUSPEND_OS_INITIATED_MODE_MASK 1
>  #define PSCI_1_0_FEATURES_CPU_SUSPEND_PF_MASK	\
> -			(0x1 << PSCI_1_0_FEATURES_CPU_SUSPEND_PF_SHIFT)
> +			((0x1 << PSCI_1_0_FEATURES_CPU_SUSPEND_PF_SHIFT)| \
> +			PSCI_1_0_FEATURES_CPU_SUSPEND_OS_INITIATED_MODE_MASK)
>  
>  /* PSCI return values (inclusive of all PSCI versions) */
>  #define PSCI_RET_SUCCESS			0
> --
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
