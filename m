From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Feb 2016 17:22:47 +0000
Subject: [PATCH v4 20/23] arm64: perf: Count EL2 events if the kernel is
 running in HYP
In-Reply-To: <1455216004-19499-21-git-send-email-marc.zyngier@arm.com>
References: <1455216004-19499-1-git-send-email-marc.zyngier@arm.com>
 <1455216004-19499-21-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160215172247.GL6298@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 11, 2016 at 06:40:01PM +0000, Marc Zyngier wrote:
> When the kernel is running in HYP (with VHE), it is necessary to
> include EL2 events if the user requests counting kernel or
> hypervisor events.
> 
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
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

Hmm, so if userspace sets exclude_kernel but not exclude_user and
exclude_hv, what should we do? I'm slightly tempted to reject the
filter with -EINVAL...

Will
