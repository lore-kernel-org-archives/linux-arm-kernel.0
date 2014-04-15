From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 15 Apr 2014 18:51:37 +0200
Subject: [PATCH v2 1/4] clocksource: arm_global_timer: Only check for
 unusable timer on A9
In-Reply-To: <1394792302-24451-2-git-send-email-matthew.leach@arm.com>
References: <1394792302-24451-1-git-send-email-matthew.leach@arm.com>
 <1394792302-24451-2-git-send-email-matthew.leach@arm.com>
Message-ID: <534D6399.2000504@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14/2014 11:18 AM, Matthew Leach wrote:
> The check for a usable global timer in the probe code does not enquire
> which CPU we are currently running on. This can cause the driver to
> incorrectly assume we have an unusable global timer if we are running
> on a CPU other than A9.
>
> Before checking the CPU revision, ensure we are running on an A9 CPU.
>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Matthew Leach <matthew.leach@arm.com>
> ---
>   drivers/clocksource/arm_global_timer.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
> index 0fc31d0..60e5a170 100644
> --- a/drivers/clocksource/arm_global_timer.c
> +++ b/drivers/clocksource/arm_global_timer.c
> @@ -246,11 +246,12 @@ static void __init global_timer_of_register(struct device_node *np)
>   	int err = 0;
>
>   	/*
> -	 * In r2p0 the comparators for each processor with the global timer
> +	 * In A9 r2p0 the comparators for each processor with the global timer
>   	 * fire when the timer value is greater than or equal to. In previous
>   	 * revisions the comparators fired when the timer value was equal to.
>   	 */
> -	if ((read_cpuid_id() & 0xf0000f) < 0x200000) {
> +	if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9
> +	    && (read_cpuid_id() & 0xf0000f) < 0x200000) {
>   		pr_warn("global-timer: non support for this cpu version.\n");
>   		return;
>   	}

Applied on my tree for 3.16


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
