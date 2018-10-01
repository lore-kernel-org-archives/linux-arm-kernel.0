From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 1 Oct 2018 11:22:09 +0200
Subject: [PATCH 3/3] clocksource/drivers/ep93xx: Create a state container
In-Reply-To: <20180930211608.5516-3-linus.walleij@linaro.org>
References: <20180930211608.5516-1-linus.walleij@linaro.org>
 <20180930211608.5516-3-linus.walleij@linaro.org>
Message-ID: <237452dc-623d-8306-1537-7b4c5e192d21@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/09/2018 23:16, Linus Walleij wrote:
> Create a struct to hold the clocksource state, augment
> everywhere to pass this around, cut a shortcut using a
> singleton for the clocksource and sched_clock callbacks
> that need to be fast.
> 
> Request the IRQ in a normal way and use offsets to
> read/write registers.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Clocksource: please ACK this if OK so I can merge this
> patch through the ARM SoC tree.
> ---
>  drivers/clocksource/timer-ep93xx.c | 121 ++++++++++++++++-------------
>  1 file changed, 69 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-ep93xx.c b/drivers/clocksource/timer-ep93xx.c
> index 3dcc58de65ef..2b68dd62c03f 100644
> --- a/drivers/clocksource/timer-ep93xx.c
> +++ b/drivers/clocksource/timer-ep93xx.c
> @@ -8,8 +8,6 @@
>  #include <linux/platform_data/timer-ep93xx.h>
>  #include <linux/slab.h>
>  
> -static void __iomem *ep93xx_base;
> -
>  /*************************************************************************
>   * Timer handling for EP93xx
>   *************************************************************************
> @@ -28,109 +26,112 @@ static void __iomem *ep93xx_base;
>   * a stable 40 bit time base.
>   *************************************************************************
>   */
> -#define EP93XX_TIMER_REG(x)		(ep93xx_base + (x))
> -#define EP93XX_TIMER1_LOAD		EP93XX_TIMER_REG(0x00)
> -#define EP93XX_TIMER1_VALUE		EP93XX_TIMER_REG(0x04)
> -#define EP93XX_TIMER1_CONTROL		EP93XX_TIMER_REG(0x08)
> +#define EP93XX_TIMER1_LOAD		0x00
> +#define EP93XX_TIMER1_VALUE		0x04
> +#define EP93XX_TIMER1_CONTROL		0x08
>  #define EP93XX_TIMER123_CONTROL_ENABLE	(1 << 7)
>  #define EP93XX_TIMER123_CONTROL_MODE	(1 << 6)
>  #define EP93XX_TIMER123_CONTROL_CLKSEL	(1 << 3)
> -#define EP93XX_TIMER1_CLEAR		EP93XX_TIMER_REG(0x0c)
> -#define EP93XX_TIMER2_LOAD		EP93XX_TIMER_REG(0x20)
> -#define EP93XX_TIMER2_VALUE		EP93XX_TIMER_REG(0x24)
> -#define EP93XX_TIMER2_CONTROL		EP93XX_TIMER_REG(0x28)
> -#define EP93XX_TIMER2_CLEAR		EP93XX_TIMER_REG(0x2c)
> -#define EP93XX_TIMER4_VALUE_LOW		EP93XX_TIMER_REG(0x60)
> -#define EP93XX_TIMER4_VALUE_HIGH	EP93XX_TIMER_REG(0x64)
> +#define EP93XX_TIMER1_CLEAR		0x0c
> +#define EP93XX_TIMER2_LOAD		0x20
> +#define EP93XX_TIMER2_VALUE		0x24
> +#define EP93XX_TIMER2_CONTROL		0x28
> +#define EP93XX_TIMER2_CLEAR		0x2c
> +#define EP93XX_TIMER4_VALUE_LOW		0x60
> +#define EP93XX_TIMER4_VALUE_HIGH	0x64
>  #define EP93XX_TIMER4_VALUE_HIGH_ENABLE	(1 << 8)
> -#define EP93XX_TIMER3_LOAD		EP93XX_TIMER_REG(0x80)
> -#define EP93XX_TIMER3_VALUE		EP93XX_TIMER_REG(0x84)
> -#define EP93XX_TIMER3_CONTROL		EP93XX_TIMER_REG(0x88)
> -#define EP93XX_TIMER3_CLEAR		EP93XX_TIMER_REG(0x8c)
> +#define EP93XX_TIMER3_LOAD		0x80
> +#define EP93XX_TIMER3_VALUE		0x84
> +#define EP93XX_TIMER3_CONTROL		0x88
> +#define EP93XX_TIMER3_CLEAR		0x8c
>  
>  #define EP93XX_TIMER123_RATE		508469
>  #define EP93XX_TIMER4_RATE		983040
>  
> -static u64 notrace ep93xx_read_sched_clock(void)
> -{
> -	u64 ret;
> +struct ep93tmr {
> +	void __iomem *base;
> +	struct clock_event_device clkevt;
> +};


Is it possible to replace by timer_of structure ?





-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
