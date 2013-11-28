From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 28 Nov 2013 12:55:38 +0100
Subject: [PATCH v2 4/9] clocksource/cadence_ttc: Use enable/disable_irq
In-Reply-To: <1385514296-26702-5-git-send-email-soren.brinkmann@xilinx.com>
References: <1385514296-26702-1-git-send-email-soren.brinkmann@xilinx.com>
 <1385514296-26702-5-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <52972F3A.9090103@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27/2013 02:04 AM, Soren Brinkmann wrote:
> To ensure that the timer interrupt is properly enabled/disabled across
> the whole CPU cluster use enable/disable_irq() instead of
> local_irq_disable().
>
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>   drivers/clocksource/cadence_ttc_timer.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clocksource/cadence_ttc_timer.c b/drivers/clocksource/cadence_ttc_timer.c
> index a92350b55d32..246d018d1e63 100644
> --- a/drivers/clocksource/cadence_ttc_timer.c
> +++ b/drivers/clocksource/cadence_ttc_timer.c
> @@ -322,18 +322,16 @@ static int ttc_rate_change_clockevent_cb(struct notifier_block *nb,
>   	switch (event) {
>   	case POST_RATE_CHANGE:
>   	{
> -		unsigned long flags;
> -
>   		/*
>   		 * clockevents_update_freq should be called with IRQ disabled on
>   		 * the CPU the timer provides events for. The timer we use is
>   		 * common to both CPUs, not sure if we need to run on both
>   		 * cores.
>   		 */
> -		local_irq_save(flags);
> +		disable_irq(ttcce->ce.irq);
>   		clockevents_update_freq(&ttcce->ce,
>   				ndata->new_rate / PRESCALE);
> -		local_irq_restore(flags);
> +		enable_irq(ttcce->ce.irq);
>
>   		/* update cached frequency */
>   		ttc->freq = ndata->new_rate;
>

I am worried about the 'disable_irq' function calling 'synchronize_irq'. 
Isn't possible to deadlock with the ondemand cpufreq governor ? I added 
Viresh in Cc, he knows better than me the code path.

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
