From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 14 Sep 2015 14:17:45 +0100
Subject: [PATCH v2 2/3] drivers: firmware: psci: define more generic
 PSCI_FN_NATIVE macro
In-Reply-To: <1434638494-514-3-git-send-email-sudeep.holla@arm.com>
References: <1434462640-19613-1-git-send-email-sudeep.holla@arm.com>
 <1434638494-514-1-git-send-email-sudeep.holla@arm.com>
 <1434638494-514-3-git-send-email-sudeep.holla@arm.com>
Message-ID: <20150914131745.GA25469@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 03:41:33PM +0100, Sudeep Holla wrote:
> This patch replaces the definition and usage of PSCI_0_2_FN_NATIVE with
> the new and more generic macro PSCI_FN_NATIVE that can be used with any
> version. This will be useful for the new features introduced in PSCIv1.0
> and for any future revisions.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/psci.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> index 68d0c2f6d004..752ca7c9eb97 100644
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -29,13 +29,13 @@
>  /*
>   * While a 64-bit OS can make calls with SMC32 calling conventions, for some
>   * calls it is necessary to use SMC64 to pass or return 64-bit values. For such
> - * calls PSCI_0_2_FN_NATIVE(x) will choose the appropriate (native-width)
> + * calls PSCI_FN_NATIVE(x) will choose the appropriate (native-width)

Nit: Comment should be PSCI_FN_NATIVE(version, name), fixed it up in my
branch.

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

>   * function ID.
>   */
>  #ifdef CONFIG_64BIT
> -#define PSCI_0_2_FN_NATIVE(name)	PSCI_0_2_FN64_##name
> +#define PSCI_FN_NATIVE(version, name)	PSCI_##version##_FN64_##name
>  #else
> -#define PSCI_0_2_FN_NATIVE(name)	PSCI_0_2_FN_##name
> +#define PSCI_FN_NATIVE(version, name)	PSCI_##version##_FN_##name
>  #endif
>  
>  /*
> @@ -169,7 +169,7 @@ static int psci_migrate(unsigned long cpuid)
>  static int psci_affinity_info(unsigned long target_affinity,
>  		unsigned long lowest_affinity_level)
>  {
> -	return invoke_psci_fn(PSCI_0_2_FN_NATIVE(AFFINITY_INFO),
> +	return invoke_psci_fn(PSCI_FN_NATIVE(0_2, AFFINITY_INFO),
>  			      target_affinity, lowest_affinity_level, 0);
>  }
>  
> @@ -180,7 +180,7 @@ static int psci_migrate_info_type(void)
>  
>  static unsigned long psci_migrate_info_up_cpu(void)
>  {
> -	return invoke_psci_fn(PSCI_0_2_FN_NATIVE(MIGRATE_INFO_UP_CPU),
> +	return invoke_psci_fn(PSCI_FN_NATIVE(0_2, MIGRATE_INFO_UP_CPU),
>  			      0, 0, 0);
>  }
>  
> @@ -267,16 +267,17 @@ static void __init psci_init_migrate(void)
>  static void __init psci_0_2_set_functions(void)
>  {
>  	pr_info("Using standard PSCI v0.2 function IDs\n");
> -	psci_function_id[PSCI_FN_CPU_SUSPEND] = PSCI_0_2_FN_NATIVE(CPU_SUSPEND);
> +	psci_function_id[PSCI_FN_CPU_SUSPEND] =
> +					PSCI_FN_NATIVE(0_2, CPU_SUSPEND);
>  	psci_ops.cpu_suspend = psci_cpu_suspend;
>  
>  	psci_function_id[PSCI_FN_CPU_OFF] = PSCI_0_2_FN_CPU_OFF;
>  	psci_ops.cpu_off = psci_cpu_off;
>  
> -	psci_function_id[PSCI_FN_CPU_ON] = PSCI_0_2_FN_NATIVE(CPU_ON);
> +	psci_function_id[PSCI_FN_CPU_ON] = PSCI_FN_NATIVE(0_2, CPU_ON);
>  	psci_ops.cpu_on = psci_cpu_on;
>  
> -	psci_function_id[PSCI_FN_MIGRATE] = PSCI_0_2_FN_NATIVE(MIGRATE);
> +	psci_function_id[PSCI_FN_MIGRATE] = PSCI_FN_NATIVE(0_2, MIGRATE);
>  	psci_ops.migrate = psci_migrate;
>  
>  	psci_ops.affinity_info = psci_affinity_info;
> -- 
> 1.9.1
> 
