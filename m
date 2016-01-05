From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 5 Jan 2016 10:01:07 +0100
Subject: [PATCH v3 1/3] clocksource/vt8500: Increase the minimum delta
In-Reply-To: <1451654683-2401-2-git-send-email-v1ron@mail.ru>
References: <1451654683-2401-1-git-send-email-v1ron@mail.ru>
 <1451654683-2401-2-git-send-email-v1ron@mail.ru>
Message-ID: <568B8653.2010301@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/01/2016 02:24 PM, Roman Volkov wrote:
> From: Roman Volkov <rvolkov@v1ros.org>
>
> The vt8500 clocksource driver declares itself as capable to handle the
> minimum delay of 4 cycles by passing the value into
> clockevents_config_and_register(). The vt8500_timer_set_next_event()
> requires the passed cycles value to be at least 16. The impact is that
> userspace hangs in nanosleep() calls with small delay intervals.
>
> This problem is reproducible in Linux 4.2 starting from:
> c6eb3f70d448 ('hrtimer: Get rid of hrtimer softirq')
>
> Signed-off-by: Roman Volkov <rvolkov@v1ros.org>
> Acked-by: Alexey Charkov <alchark@gmail.com>

Hi Roman,

I looked at the email thread, and IIUC if set_next_event fails, the 
system freeze. Your patch fixes the issue for your driver but not the 
real issue because if set_next_event fails, at least a warning should 
appear in the log or better nanosleep should fail gracefully.

BTW why min delta is MIN_OSCR_DELTA * 2 in clockevents_config_and_register ?

> ---
>   drivers/clocksource/vt8500_timer.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clocksource/vt8500_timer.c b/drivers/clocksource/vt8500_timer.c
> index a92e94b..dfc3bb4 100644
> --- a/drivers/clocksource/vt8500_timer.c
> +++ b/drivers/clocksource/vt8500_timer.c
> @@ -50,6 +50,8 @@
>
>   #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
>
> +#define MIN_OSCR_DELTA		16
> +
>   static void __iomem *regbase;
>
>   static cycle_t vt8500_timer_read(struct clocksource *cs)
> @@ -80,7 +82,7 @@ static int vt8500_timer_set_next_event(unsigned long cycles,
>   		cpu_relax();
>   	writel((unsigned long)alarm, regbase + TIMER_MATCH_VAL);
>
> -	if ((signed)(alarm - clocksource.read(&clocksource)) <= 16)
> +	if ((signed)(alarm - clocksource.read(&clocksource)) <= MIN_OSCR_DELTA)
>   		return -ETIME;
>
>   	writel(1, regbase + TIMER_IER_VAL);
> @@ -151,7 +153,7 @@ static void __init vt8500_timer_init(struct device_node *np)
>   		pr_err("%s: setup_irq failed for %s\n", __func__,
>   							clockevent.name);
>   	clockevents_config_and_register(&clockevent, VT8500_TIMER_HZ,
> -					4, 0xf0000000);
> +					MIN_OSCR_DELTA * 2, 0xf0000000);
>   }
>
>   CLOCKSOURCE_OF_DECLARE(vt8500, "via,vt8500-timer", vt8500_timer_init);
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
