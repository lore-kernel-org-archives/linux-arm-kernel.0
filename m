From: pavel@denx.de (Pavel Machek)
Date: Mon, 29 Jul 2013 20:30:06 +0200
Subject: [PATCH 2/2] clocksource: dw_apb_timer_of: Fix read_sched_clock
In-Reply-To: <1374723797-22169-2-git-send-email-dinguyen@altera.com>
References: <1374723797-22169-1-git-send-email-dinguyen@altera.com>
 <1374723797-22169-2-git-send-email-dinguyen@altera.com>
Message-ID: <20130729183006.GB10346@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> The read_sched_clock should return the ~value because the clock is a
> countdown implementation. read_sched_clock() should be the same as
> __apbt_read_clocksource().

...for altera boards. But AFAICT:

> diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
> index 4cbae4f..8e00929 100644
> --- a/drivers/clocksource/dw_apb_timer_of.c
> +++ b/drivers/clocksource/dw_apb_timer_of.c
> @@ -102,18 +102,17 @@ static void add_clocksource(struct device_node *source_timer)
>  	 * timer is found. sched_io_base then points to the current_value
>  	 * register of the clocksource timer.
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
>

picochip,pc3x2-rtc is _not_ compatible with snps,dw-apb-timer, and
does count up. You correctly remove snps,dw-apb-timer-sp
compatibility, but AFAICT the ~value change will do something
interesting on picochip boards.

Or maybe I'm just confused about all the timers? Jamie acked this so
it should be fine...?

Thanks,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
