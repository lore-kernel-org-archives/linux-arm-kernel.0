From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Thu, 25 Jul 2013 11:02:22 +0200
Subject: [PATCH 2/2] clocksource: dw_apb_timer_of: Fix read_sched_clock
In-Reply-To: <1374723797-22169-2-git-send-email-dinguyen@altera.com>
References: <1374723797-22169-1-git-send-email-dinguyen@altera.com>
 <1374723797-22169-2-git-send-email-dinguyen@altera.com>
Message-ID: <201307251102.23446.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 25. Juli 2013, 05:43:17 schrieb dinguyen at altera.com:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> The read_sched_clock should return the ~value because the clock is a
> countdown implementation. read_sched_clock() should be the same as
> __apbt_read_clocksource().
> 
> If a separate timer for the sched_clock exist, then read_sched_clock()
> will return an incorrect value. The (sched_io_base + 0x4) needs to be in
> the function for both cases.
> 
> Also, remove the use of "dw-apb-timer-sp" and "dw-apb-timer-osc" since
> they are the same DW clock.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Acked-by: Jamie Iles <jamie@jamieiles.com>
> CC: Rob Herring <rob.herring@calxeda.com>
> CC: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> CC: Jamie Iles <jamie@jamieiles.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Pavel Machek <pavel@denx.de>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  drivers/clocksource/dw_apb_timer_of.c |    7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clocksource/dw_apb_timer_of.c
> b/drivers/clocksource/dw_apb_timer_of.c index 4cbae4f..8e00929 100644
> --- a/drivers/clocksource/dw_apb_timer_of.c
> +++ b/drivers/clocksource/dw_apb_timer_of.c
> @@ -102,18 +102,17 @@ static void add_clocksource(struct device_node
> *source_timer) * timer is found. sched_io_base then points to the
> current_value * register of the clocksource timer.
>  	 */
> -	sched_io_base = iobase + 0x04;
> +	sched_io_base = iobase;
>  	sched_rate = rate;
>  }
> 
>  static u32 read_sched_clock(void)
>  {
> -	return __raw_readl(sched_io_base);
> +	return ~__raw_readl(sched_io_base + 0x4);
>  }
> 



>  static const struct of_device_id sptimer_ids[] __initconst = {
>  	{ .compatible = "picochip,pc3x2-rtc" },
> -	{ .compatible = "snps,dw-apb-timer-sp" },
>  	{ /* Sentinel */ },
>  };

I'm not 100% sure, but maybe the same explaination as below applies to this - 
with it better being part of the first patch.


> @@ -153,4 +152,4 @@ static void __init dw_apb_timer_init(struct device_node
> *timer) num_called++;
>  }
>  CLOCKSOURCE_OF_DECLARE(pc3x2_timer, "picochip,pc3x2-timer",
> dw_apb_timer_init); -CLOCKSOURCE_OF_DECLARE(apb_timer,
> "snps,dw-apb-timer-osc", dw_apb_timer_init);
> +CLOCKSOURCE_OF_DECLARE(apb_timer, "snps,dw-apb-timer",
> dw_apb_timer_init);

I think this hunk would better be part of the first patch, as you rename the 
devices in the dtsi files there and it has nothing to do with the sched_clock 
fix.

Changing the clocksource name here also breaks bisectability on the affected 
platforms because they wouldn't be able to add the clocksources when only the 
first patch is applied.


Heiko
