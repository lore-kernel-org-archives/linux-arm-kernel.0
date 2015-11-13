From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Nov 2015 13:42:09 +0100
Subject: [PATCH v2] clocksource/drivers/dw_apb_timer: Use
 {readl|writel}_relaxed
In-Reply-To: <1447417883-7881-1-git-send-email-jszhang@marvell.com>
References: <1447417883-7881-1-git-send-email-jszhang@marvell.com>
Message-ID: <3713227.4t0cg6qNF9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 November 2015 20:31:23 Jisheng Zhang wrote:
> diff --git a/drivers/clocksource/dw_apb_timer.c b/drivers/clocksource/dw_apb_timer.c
> index c76c750..04282ee 100644
> --- a/drivers/clocksource/dw_apb_timer.c
> +++ b/drivers/clocksource/dw_apb_timer.c
> @@ -51,13 +51,13 @@ clocksource_to_dw_apb_clocksource(struct clocksource *cs)
>  
>  static unsigned long apbt_readl(struct dw_apb_timer *timer, unsigned long offs)
>  {
> -       return readl(timer->base + offs);
> +       return readl_relaxed(timer->base + offs);
>  }
>  
>  static void apbt_writel(struct dw_apb_timer *timer, unsigned long val,
>                  unsigned long offs)
>  {
> -       writel(val, timer->base + offs);
> +       writel_relaxed(val, timer->base + offs);
>  }
>  
> 

As with the other patch, I think it would be nicer to only change the
functions that benefit from the change, to make it easier to prove
that the conversion is correct. You could introduce apbt_readl_releaxed()
etc functions and call them from __apbt_read_clocksource()
and apbt_next_event().

	Arnd
