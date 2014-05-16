From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 16 May 2014 16:07:00 +0200
Subject: [PATCH] clocksource: marco: fix the affinity set for local timer
 of CPU1
In-Reply-To: <1399445204-22159-1-git-send-email-21cnbao@gmail.com>
References: <1399445204-22159-1-git-send-email-21cnbao@gmail.com>
Message-ID: <53761B84.90109@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/2014 08:46 AM, Barry Song wrote:
> From: Zhiwu Song <Zhiwu.Song@csr.com>
>
> irqchip will reject the affinity set to CPUs which is not online
> yet. but in the CPU1 wakeup stage, OS only sets CPU1 to be online
> after local timer is set, so that causes the irq_set_affinity not
> work. this patch moves to irq_force_affinity() for the low level
> boot stage.
>
> Signed-off-by: Zhiwu Song <Zhiwu.Song@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>   drivers/clocksource/timer-marco.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/clocksource/timer-marco.c b/drivers/clocksource/timer-marco.c
> index 571d109..dbd3039 100644
> --- a/drivers/clocksource/timer-marco.c
> +++ b/drivers/clocksource/timer-marco.c
> @@ -199,7 +199,7 @@ static int sirfsoc_local_timer_setup(struct clock_event_device *ce)
>
>   	action->dev_id = ce;
>   	BUG_ON(setup_irq(ce->irq, action));
> -	irq_set_affinity(action->irq, cpumask_of(cpu));
> +	irq_force_affinity(action->irq, cpumask_of(cpu));
>
>   	clockevents_register_device(ce);
>   	return 0;

Applied to my tree as 3.15 fix.

Thanks
   -- Daniel



-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
