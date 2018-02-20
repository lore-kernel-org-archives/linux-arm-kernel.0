From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 20 Feb 2018 18:31:35 +0000
Subject: [PATCH 08/11] firmware: arm_sdei: Add ACPI GHES registration
 helper
References: <20180215185606.26736-1-james.morse@arm.com>
 <20180215185606.26736-9-james.morse@arm.com>
Message-ID: <87eflfzf5k.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

One typo below.

James Morse <james.morse@arm.com> writes:

> APEI's Generic Hardware Error Source structures do not describe
> whether the SDEI event is shared or private, as this information is
> discoverable via the API.
>
> GHES needs to know whether an event is normal or critical to avoid
> sharing locks or fixmap entries.
>
> Add a helper to ask firmware for this information so it can initialise
> the struct ghes and register then enable the event.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/arm64/include/asm/fixmap.h |  4 +++
>  drivers/firmware/arm_sdei.c     | 75 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/arm_sdei.h        |  5 +++
>  3 files changed, 84 insertions(+)
>
> diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
> index c3974517c2cb..e2b423a5feaf 100644
> --- a/arch/arm64/include/asm/fixmap.h
> +++ b/arch/arm64/include/asm/fixmap.h
> @@ -58,6 +58,10 @@ enum fixed_addresses {
>  #ifdef CONFIG_ACPI_APEI_SEA
>  	FIX_APEI_GHES_SEA,
>  #endif
> +#ifdef CONFIG_ARM_SDE_INTERFACE
> +	FIX_APEI_GHES_SDEI_NORMAL,
> +	FIX_APEI_GHES_SDEI_CRITICAL,
> +#endif
>  #endif /* CONFIG_ACPI_APEI_GHES */
>  
>  #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
> diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
> index 1ea71640fdc2..9b6e140cf6cb 100644
> --- a/drivers/firmware/arm_sdei.c
> +++ b/drivers/firmware/arm_sdei.c
> @@ -2,6 +2,7 @@
>  // Copyright (C) 2017 Arm Ltd.
>  #define pr_fmt(fmt) "sdei: " fmt
>  
> +#include <acpi/ghes.h>
>  #include <linux/acpi.h>
>  #include <linux/arm_sdei.h>
>  #include <linux/arm-smccc.h>
> @@ -887,6 +888,80 @@ static void sdei_smccc_hvc(unsigned long function_id,
>  	arm_smccc_hvc(function_id, arg0, arg1, arg2, arg3, arg4, 0, 0, res);
>  }
>  
> +#ifdef CONFIG_ACPI
> +/* These stop private notifications using the fixmap entries simultaneously */
> +static DEFINE_RAW_SPINLOCK(sdei_ghes_fixmap_lock_normal);
> +static DEFINE_RAW_SPINLOCK(sdei_ghes_fixmap_lock_critical);
> +
> +int sdei_register_ghes(struct ghes *ghes, sdei_event_callback *cb)
> +{
> +	int err;
> +	u32 event_num;
> +	u64 result;
> +
> +	if (acpi_disabled)
> +		return -EOPNOTSUPP;
> +
> +	event_num = ghes->generic->notify.vector;
> +	if (event_num == 0) {
> +		/*
> +		 * Event 0 is the reserved by the specification for
                              ^
Typo.

Thanks,
Punit

> +		 * SDEI_EVENT_SIGNAL.
> +		 */
> +		return -EINVAL;
> +	}
> +
> +	err = sdei_api_event_get_info(event_num, SDEI_EVENT_INFO_EV_PRIORITY,
> +				      &result);
> +	if (err)
> +		return err;
> +
> +	if (result == SDEI_EVENT_PRIORITY_CRITICAL) {
> +		ghes->nmi_fixmap_lock = &sdei_ghes_fixmap_lock_critical;
> +		ghes->fixmap_idx = FIX_APEI_GHES_SDEI_CRITICAL;
> +	} else {
> +		ghes->nmi_fixmap_lock = &sdei_ghes_fixmap_lock_normal;
> +		ghes->fixmap_idx = FIX_APEI_GHES_SDEI_NORMAL;
> +	}
> +
> +	err = sdei_event_register(event_num, cb, ghes);
> +	if (!err)
> +		err = sdei_event_enable(event_num);
> +
> +	return err;
> +}
> +

[...]
