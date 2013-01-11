From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 11 Jan 2013 18:53:33 +0530
Subject: [PATCHv2 04/11] arm: arch_timer: standardise counter reading
In-Reply-To: <1357747640-18594-5-git-send-email-mark.rutland@arm.com>
References: <1357747640-18594-1-git-send-email-mark.rutland@arm.com>
 <1357747640-18594-5-git-send-email-mark.rutland@arm.com>
Message-ID: <50F01255.4060805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 January 2013 09:37 PM, Mark Rutland wrote:
> We're currently inconsistent with respect to our accesses to the
> physical and virtual counters, mixing and matching the two.
>
> This patch introduces and uses a function for accessing the correct
> counter based on whether we're using physical or virtual interrupts.
> All current accesses to the counter accessors are redirected through
> it.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   arch/arm/kernel/arch_timer.c |   48 ++++++++++-------------------------------
>   1 files changed, 12 insertions(+), 36 deletions(-)
>
> diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
> index 498c29f..0d2681c 100644
> --- a/arch/arm/kernel/arch_timer.c
> +++ b/arch/arm/kernel/arch_timer.c
> @@ -272,51 +272,32 @@ static int arch_timer_available(void)
>   	return 0;
>   }
>
> -static u32 notrace arch_counter_get_cntpct32(void)
> +u64 arch_timer_read_counter(void)
>   {
> -	cycle_t cnt = arch_counter_get_cntpct();
> -
> -	/*
> -	 * The sched_clock infrastructure only knows about counters
> -	 * with at most 32bits. Forget about the upper 24 bits for the
> -	 * time being...
> -	 */
> -	return (u32)cnt;
> +	if (arch_timer_use_virtual)
> +		return arch_counter_get_cntvct();
> +	else
> +		return arch_counter_get_cntpct();
>   }
>

[...]

> @@ -489,18 +470,13 @@ int __init arch_timer_of_register(void)
>
>   int __init arch_timer_sched_clock_init(void)
>   {
> -	u32 (*cnt32)(void);
>   	int err;
>
>   	err = arch_timer_available();
>   	if (err)
>   		return err;
>
> -	if (arch_timer_use_virtual)
> -		cnt32 = arch_counter_get_cntvct32;
> -	else
> -		cnt32 = arch_counter_get_cntpct32;
> -
> -	setup_sched_clock(cnt32, 32, arch_timer_rate);
> +	setup_sched_clock(arch_timer_read_counter32,
> +			  32, arch_timer_rate);
>   	return 0;
>   }
>
I think the original idea had merit since the check was needed
in init code instead of proposed one which has if check for
every counter read function. No ?
