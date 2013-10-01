From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 1 Oct 2013 12:01:08 +0300
Subject: [PATCH] clocksource: dw_apb_timer_of: Mark a few more functions
 as __init
In-Reply-To: <1380616692-10253-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1380616692-10253-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20131001090108.GL6918@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Tue, Oct 01, 2013 at 10:38:12AM +0200, Uwe Kleine-K?nig wrote:
> These are all only called by dw_apb_timer_init which is an __init
> function, too
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/clocksource/dw_apb_timer_of.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
> index 4cbae4f..993cdde 100644
> --- a/drivers/clocksource/dw_apb_timer_of.c
> +++ b/drivers/clocksource/dw_apb_timer_of.c
> @@ -23,7 +23,7 @@
>  #include <linux/clk.h>
>  #include <linux/sched_clock.h>
>  
> -static void timer_get_base_and_rate(struct device_node *np,
> +static void __init timer_get_base_and_rate(struct device_node *np,
>  				    void __iomem **base, u32 *rate)
>  {
>  	struct clk *timer_clk;
> @@ -55,11 +55,11 @@ static void timer_get_base_and_rate(struct device_node *np,
>  
>  try_clock_freq:
>  	if (of_property_read_u32(np, "clock-freq", rate) &&
> -		of_property_read_u32(np, "clock-frequency", rate))
> +	    of_property_read_u32(np, "clock-frequency", rate))

Unintended whitespace change?

baruch

>  		panic("No clock nor clock-frequency property for %s", np->name);
>  }
>  
> -static void add_clockevent(struct device_node *event_timer)
> +static void __init add_clockevent(struct device_node *event_timer)
>  {
>  	void __iomem *iobase;
>  	struct dw_apb_clock_event_device *ced;
> @@ -82,7 +82,7 @@ static void add_clockevent(struct device_node *event_timer)
>  static void __iomem *sched_io_base;
>  static u32 sched_rate;
>  
> -static void add_clocksource(struct device_node *source_timer)
> +static void __init add_clocksource(struct device_node *source_timer)
>  {
>  	void __iomem *iobase;
>  	struct dw_apb_clocksource *cs;
> @@ -117,7 +117,7 @@ static const struct of_device_id sptimer_ids[] __initconst = {
>  	{ /* Sentinel */ },
>  };
>  
> -static void init_sched_clock(void)
> +static void __init init_sched_clock(void)
>  {
>  	struct device_node *sched_timer;
>  
> -- 
> 1.8.4.rc3

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
