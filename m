From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 4 Feb 2016 20:23:01 +0100
Subject: [PATCH v3 20/23] arm64: perf: Count EL2 events if the kernel is
 running in HYP
In-Reply-To: <1454522416-6874-21-git-send-email-marc.zyngier@arm.com>
References: <1454522416-6874-1-git-send-email-marc.zyngier@arm.com>
 <1454522416-6874-21-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160204192301.GG13974@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2016 at 06:00:13PM +0000, Marc Zyngier wrote:
> When the kernel is running in HYP (with VHE), it is necessary to
> include EL2 events if the user requests counting kernel or
> hypervisor events.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/kernel/perf_event.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index f7ab14c..6013a38 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -20,6 +20,7 @@
>   */
>  
>  #include <asm/irq_regs.h>
> +#include <asm/virt.h>
>  
>  #include <linux/of.h>
>  #include <linux/perf/arm_pmu.h>
> @@ -693,10 +694,15 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
>  		return -EPERM;
>  	if (attr->exclude_user)
>  		config_base |= ARMV8_EXCLUDE_EL0;
> -	if (attr->exclude_kernel)
> -		config_base |= ARMV8_EXCLUDE_EL1;
> -	if (!attr->exclude_hv)
> -		config_base |= ARMV8_INCLUDE_EL2;
> +	if (is_kernel_in_hyp_mode()) {
> +		if (!attr->exclude_kernel || !attr->exclude_hv)
> +			config_base |= ARMV8_INCLUDE_EL2;

is exclude_hv a perf generic construct?

is it really correct to count everything the host kernel does (even
unrelated to running VMs) when counting hypervisor events?

Other than my ignorance in this area, this patch looks fine to me.

Thanks,
-Christoffer

> +	} else {
> +		if (attr->exclude_kernel)
> +			config_base |= ARMV8_EXCLUDE_EL1;
> +		if (!attr->exclude_hv)
> +			config_base |= ARMV8_INCLUDE_EL2;
> +	}
>  
>  	/*
>  	 * Install the filter into config_base as this is used to
> -- 
> 2.1.4
> 
