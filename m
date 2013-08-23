From: baruch@tkos.co.il (Baruch Siach)
Date: Fri, 23 Aug 2013 13:38:57 +0300
Subject: [PATCH v3 2/3] clocksource: orion: Use atomic access for shared
 registers
In-Reply-To: <1377253445-2842-3-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377253445-2842-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377253445-2842-3-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130823103857.GP4600@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

On Fri, Aug 23, 2013 at 07:24:04AM -0300, Ezequiel Garcia wrote:
> Replace the driver-specific thread-safe shared register API
> by the recently introduced atomic_io_clear_set().
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

[...]

> @@ -131,7 +121,9 @@ static void __init orion_timer_init(struct device_node 
>   *np)
>  	/* setup timer0 as free-running clocksource */
>  	writel(~0, timer_base + TIMER0_VAL);
>  	writel(~0, timer_base + TIMER0_RELOAD);
> -	orion_timer_ctrl_clrset(0, TIMER0_RELOAD_EN | TIMER0_EN);
> +	oatomic_io_modify(timer_base + TIMER_CTRL,

oatomic? Are you sure this code builds?

baruch

> +		TIMER0_RELOAD_EN | TIMER0_EN,
> +		TIMER0_RELOAD_EN | TIMER0_EN);
>  	clocksource_mmio_init(timer_base + TIMER0_VAL, "orion_clocksource",
>  			      clk_get_rate(clk), 300, 32,
>  			      clocksource_mmio_readl_down);

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
