From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 26 Mar 2015 10:43:02 +0100
Subject: [PATCH 4/7] clocksource: dw_apb_timer_of: make IO endian agnostic
In-Reply-To: <1427282610-10350-5-git-send-email-ben.dooks@codethink.co.uk>
References: <1427282610-10350-1-git-send-email-ben.dooks@codethink.co.uk>
 <1427282610-10350-5-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <5513D4A6.9070301@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2015 12:23 PM, Ben Dooks wrote:
> The dw_apb_timer_of timer is using __raw_readl to access the timer
> register, which is causing issues when the system is running in
> big endian mode. Fix this by using readl_relaxed() which should
> account for the endian settings.
>
> This fixes issues where the time jumps around in the dmesg output
> due to returnling __le32 values.
>
> For an example, these two console lines show time running backwards:
>
> [   49.882572] CPU1: failed to come online
> [   43.282457] Brought up 1 CPUs
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Hi Ben,

Through which tree this patch is supposed to go ?


> --
> CC: Daniel Lezcano <daniel.lezcano@linaro.org>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
> CC: Dinh Nguyen <dinguyen@opensource.altera.com>
> ---
>   drivers/clocksource/dw_apb_timer_of.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
> index d305fb0..a19a3f6 100644
> --- a/drivers/clocksource/dw_apb_timer_of.c
> +++ b/drivers/clocksource/dw_apb_timer_of.c
> @@ -108,7 +108,7 @@ static void __init add_clocksource(struct device_node *source_timer)
>
>   static u64 notrace read_sched_clock(void)
>   {
> -	return ~__raw_readl(sched_io_base);
> +	return ~readl_relaxed(sched_io_base);
>   }
>
>   static const struct of_device_id sptimer_ids[] __initconst = {
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
