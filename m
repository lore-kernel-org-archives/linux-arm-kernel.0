From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Feb 2016 18:27:51 +0000
Subject: [PATCH v4 20/23] arm64: perf: Count EL2 events if the kernel is
 running in HYP
In-Reply-To: <56C217A7.5020105@arm.com>
References: <1455216004-19499-1-git-send-email-marc.zyngier@arm.com>
 <1455216004-19499-21-git-send-email-marc.zyngier@arm.com>
 <20160215172247.GL6298@arm.com> <56C217A7.5020105@arm.com>
Message-ID: <20160215182751.GP6298@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 06:23:35PM +0000, Marc Zyngier wrote:
> On 15/02/16 17:22, Will Deacon wrote:
> > On Thu, Feb 11, 2016 at 06:40:01PM +0000, Marc Zyngier wrote:
> >> When the kernel is running in HYP (with VHE), it is necessary to
> >> include EL2 events if the user requests counting kernel or
> >> hypervisor events.
> >>
> >> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
> >> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> >> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> >> ---
> >>  arch/arm64/kernel/perf_event.c | 14 ++++++++++----
> >>  1 file changed, 10 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> >> index f7ab14c..6013a38 100644
> >> --- a/arch/arm64/kernel/perf_event.c
> >> +++ b/arch/arm64/kernel/perf_event.c
> >> @@ -20,6 +20,7 @@
> >>   */
> >>  
> >>  #include <asm/irq_regs.h>
> >> +#include <asm/virt.h>
> >>  
> >>  #include <linux/of.h>
> >>  #include <linux/perf/arm_pmu.h>
> >> @@ -693,10 +694,15 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
> >>  		return -EPERM;
> >>  	if (attr->exclude_user)
> >>  		config_base |= ARMV8_EXCLUDE_EL0;
> >> -	if (attr->exclude_kernel)
> >> -		config_base |= ARMV8_EXCLUDE_EL1;
> >> -	if (!attr->exclude_hv)
> >> -		config_base |= ARMV8_INCLUDE_EL2;
> >> +	if (is_kernel_in_hyp_mode()) {
> >> +		if (!attr->exclude_kernel || !attr->exclude_hv)
> >> +			config_base |= ARMV8_INCLUDE_EL2;
> > 
> > Hmm, so if userspace sets exclude_kernel but not exclude_user and
> > exclude_hv, what should we do? I'm slightly tempted to reject the
> > filter with -EINVAL...
> 
> I was angling for the minimum level of surprise for the user, but
> I guess that the results are going to be troubling anyway.
> 
> How about something like this on top:
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 6013a38..8c00ed4 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -695,7 +695,10 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
>  	if (attr->exclude_user)
>  		config_base |= ARMV8_EXCLUDE_EL0;
>  	if (is_kernel_in_hyp_mode()) {
> -		if (!attr->exclude_kernel || !attr->exclude_hv)
> +		/* Demand that kernel and hv are consistent */
> +		if (attr->exclude_kernel != attr->exclude_hv)
> +			return -EINVAL;
> +		if (!attr->exclude_hv)
>  			config_base |= ARMV8_INCLUDE_EL2;
>  	} else {
>  		if (attr->exclude_kernel)

Looks like the right idea, and you can probably refactor things slightly
to avoid having two codepaths dealing with ARMV8_INCLUDE_EL2.

Note that I've got a couple of outstanding questions with the architects
that I should have answers to later in the week.

Will
