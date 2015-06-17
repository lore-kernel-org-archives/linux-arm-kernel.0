From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 17 Jun 2015 16:08:04 +0100
Subject: [PATCH 2/2] drivers: firmware: psci: add system suspend support
In-Reply-To: <1434462640-19613-3-git-send-email-sudeep.holla@arm.com>
References: <1434462640-19613-1-git-send-email-sudeep.holla@arm.com>
 <1434462640-19613-3-git-send-email-sudeep.holla@arm.com>
Message-ID: <20150617150804.GE27017@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 16, 2015 at 02:50:40PM +0100, Sudeep Holla wrote:
> PSCI v1.0 introduces a new API called PSCI_SYSTEM_SUSPEND. This API
> provides the mechanism by which the calling OS can request entry into
> the deepest possible system sleep state.
> 
> It meets all the necessary preconditions for entrying suspend to RAM

s/entrying/entering/

> state in Linux. This patch adds support for PSCI_SYSTEM_SUSPEND in psci
> firmware and registers a psci system suspend operation to implement the
> suspend-to-RAM(s2r) in a generic way on all the platforms implementing
> PSCI.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/psci.c   | 39 +++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/psci.h |  2 ++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> index 68d0c2f6d004..4f0359516119 100644
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -20,11 +20,13 @@
>  #include <linux/printk.h>
>  #include <linux/psci.h>
>  #include <linux/reboot.h>
> +#include <linux/suspend.h>
>  
>  #include <uapi/linux/psci.h>
>  
>  #include <asm/system_misc.h>
>  #include <asm/smp_plat.h>
> +#include <asm/suspend.h>
>  
>  /*
>   * While a 64-bit OS can make calls with SMC32 calling conventions, for some
> @@ -222,6 +224,41 @@ static int __init psci_features(u32 psci_func_id)
>  			      psci_func_id, 0, 0);
>  }
>  
> +static int psci_system_suspend(unsigned long entry_point)
> +{
> +	return invoke_psci_fn(PSCI_0_2_FN_NATIVE(SYSTEM_SUSPEND),
> +			      entry_point, 0, 0);
> +}
> +
> +static int psci_system_suspend_finisher(unsigned long unused)
> +{
> +	return psci_system_suspend(virt_to_phys(cpu_resume));

Do we really need another level of indirection ? I would invoke
the PSCI function from here.

> +}
> +
> +static int psci_system_suspend_enter(suspend_state_t state)
> +{
> +	if (state != PM_SUSPEND_MEM)
> +		return 0;

suspend_valid_only_mem should check this, am I missing something ?

You should not return 0 on failure anyway.

> +
> +	return cpu_suspend(0, psci_system_suspend_finisher);
> +}
> +
> +static const struct platform_suspend_ops psci_suspend_ops = {
> +	.valid          = suspend_valid_only_mem,
> +	.enter          = psci_system_suspend_enter,
> +};
> +
> +static void __init psci_init_system_suspend(void)
> +{
> +	if (!IS_ENABLED(CONFIG_SUSPEND))
> +		return;
> +
> +	if (psci_features(PSCI_0_2_FN_NATIVE(SYSTEM_SUSPEND)))

Nit: I think we should use a 1_0 tag here for SYSTEM_SUSPEND.

> +		return;
> +
> +	suspend_set_ops(&psci_suspend_ops);
> +}
> +
>  static void __init psci_init_cpu_suspend(void)
>  {
>  	int feature = psci_features(psci_function_id[PSCI_FN_CPU_SUSPEND]);
> @@ -310,6 +347,8 @@ static int __init psci_probe(void)
>  
>  	psci_init_cpu_suspend();
>  
> +	psci_init_system_suspend();
> +
>  	return 0;
>  }
>  
> diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
> index 2598d7c9bf20..62b054524819 100644
> --- a/include/uapi/linux/psci.h
> +++ b/include/uapi/linux/psci.h
> @@ -39,12 +39,14 @@
>  #define PSCI_0_2_FN_MIGRATE_INFO_UP_CPU		PSCI_0_2_FN(7)
>  #define PSCI_0_2_FN_SYSTEM_OFF			PSCI_0_2_FN(8)
>  #define PSCI_0_2_FN_SYSTEM_RESET		PSCI_0_2_FN(9)
> +#define PSCI_0_2_FN_SYSTEM_SUSPEND		PSCI_0_2_FN(14)

I think you should keep versioning consistent, namely SYSTEM_SUSPEND
is a 1.0 only feature and the tag should reflect that.

>  #define PSCI_0_2_FN64_CPU_SUSPEND		PSCI_0_2_FN64(1)
>  #define PSCI_0_2_FN64_CPU_ON			PSCI_0_2_FN64(3)
>  #define PSCI_0_2_FN64_AFFINITY_INFO		PSCI_0_2_FN64(4)
>  #define PSCI_0_2_FN64_MIGRATE			PSCI_0_2_FN64(5)
>  #define PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU	PSCI_0_2_FN64(7)
> +#define PSCI_0_2_FN64_SYSTEM_SUSPEND		PSCI_0_2_FN64(14)

Ditto.

Thanks,
Lorenzo

>  
>  #define PSCI_1_0_FN_PSCI_FEATURES		PSCI_0_2_FN(10)
>  
> -- 
> 1.9.1
> 
