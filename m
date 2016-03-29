From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 29 Mar 2016 19:13:54 +0200
Subject: [PATCH v4 1/9] clocksource: arm_arch_timer: Gather KVM specific
 information in a structure
In-Reply-To: <1458842023-31853-2-git-send-email-julien.grall@arm.com>
References: <1458842023-31853-1-git-send-email-julien.grall@arm.com>
 <1458842023-31853-2-git-send-email-julien.grall@arm.com>
Message-ID: <56FAB7D2.1000508@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/24/2016 06:53 PM, Julien Grall wrote:
> Introduce a structure which are filled up by the arch timer driver and
> used by the virtual timer in KVM.
>
> The first member of this structure will be the timecounter. More members
> will be added later.
>
> A stub for the new helper isn't introduced because KVM requires the arch
> timer for both ARM64 and ARM32.
>
> The function arch_timer_get_timecounter is kept for the time being and
> will be dropped in a subsequent patch.
>
> Signed-off-by: Julien Grall <julien.grall@arm.com>

> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
>
>      Changes in v3:
>          - Rename the patch
>          - Move the KVM changes and removal of arch_timer_get_timecounter
>          in separate patches.
> ---
>   drivers/clocksource/arm_arch_timer.c | 12 +++++++++---
>   include/clocksource/arm_arch_timer.h |  5 +++++
>   2 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 5152b38..62bdfe7 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -468,11 +468,16 @@ static struct cyclecounter cyclecounter = {
>   	.mask	= CLOCKSOURCE_MASK(56),
>   };
>
> -static struct timecounter timecounter;
> +static struct arch_timer_kvm_info arch_timer_kvm_info;

This structure is statically defined in this subsystem but not used in 
this file and a couple of a accessors is added to let another subsystem 
to access it.

That sounds there is something wrong here with the design of the current 
code, virt/phys are mixed.

It isn't possible to split the virt/phys timer code respectively in 
virt/kvm/arm/arch_timer.c and drivers/clocksource/arm_arch_timer.c ?

At least, 'struct arch_timer_kvm_info' should belong to 
virt/kvm/arm/arch_timer.c.

> +struct arch_timer_kvm_info *arch_timer_get_kvm_info(void)
> +{
> +	return &arch_timer_kvm_info;
> +}
>
>   struct timecounter *arch_timer_get_timecounter(void)
>   {
> -	return &timecounter;
> +	return &arch_timer_kvm_info.timecounter;
>   }
>
>   static void __init arch_counter_register(unsigned type)
> @@ -500,7 +505,8 @@ static void __init arch_counter_register(unsigned type)
>   	clocksource_register_hz(&clocksource_counter, arch_timer_rate);
>   	cyclecounter.mult = clocksource_counter.mult;
>   	cyclecounter.shift = clocksource_counter.shift;
> -	timecounter_init(&timecounter, &cyclecounter, start_count);
> +	timecounter_init(&arch_timer_kvm_info.timecounter,
> +			 &cyclecounter, start_count);
>
>   	/* 56 bits minimum, so we assume worst case rollover */
>   	sched_clock_register(arch_timer_read_counter, 56, arch_timer_rate);
> diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
> index 25d0914..9101ed6b 100644
> --- a/include/clocksource/arm_arch_timer.h
> +++ b/include/clocksource/arm_arch_timer.h
> @@ -49,11 +49,16 @@ enum arch_timer_reg {
>
>   #define ARCH_TIMER_EVT_STREAM_FREQ	10000	/* 100us */
>
> +struct arch_timer_kvm_info {
> +	struct timecounter timecounter;
> +};
> +
>   #ifdef CONFIG_ARM_ARCH_TIMER
>
>   extern u32 arch_timer_get_rate(void);
>   extern u64 (*arch_timer_read_counter)(void);
>   extern struct timecounter *arch_timer_get_timecounter(void);
> +extern struct arch_timer_kvm_info *arch_timer_get_kvm_info(void);
>
>   #else
>
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
