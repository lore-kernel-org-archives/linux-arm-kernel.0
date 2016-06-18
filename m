From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 18 Jun 2016 12:38:38 +0200
Subject: [PATCH V2 03/63] clocksource/drivers/rockchip_timer: Convert init
 function to return error
In-Reply-To: <1466112442-31105-4-git-send-email-daniel.lezcano@linaro.org>
References: <1466112442-31105-1-git-send-email-daniel.lezcano@linaro.org>
 <1466112442-31105-4-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <2572341.0UcvQ6PvRt@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 16. Juni 2016, 23:26:22 schrieb Daniel Lezcano:
> The init functions do not return any error. They behave as the following:
> 
>  - panic, thus leading to a kernel crash while another timer may work and
>    make the system boot up correctly
> 
>  or
> 
>  - print an error and let the caller unaware if the state of the system
> 
> Change that by converting the init functions to return an error conforming
> to the CLOCKSOURCE_OF_RET prototype.
> 
> Proper error handling (rollback, errno value) will be changed later case
> by case, thus this change just return back an error or success in the init
> function.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/clocksource/rockchip_timer.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/clocksource/rockchip_timer.c
> b/drivers/clocksource/rockchip_timer.c index a3f22b0..d10bdee 100644
> --- a/drivers/clocksource/rockchip_timer.c
> +++ b/drivers/clocksource/rockchip_timer.c
> @@ -113,17 +113,17 @@ static irqreturn_t rk_timer_interrupt(int irq, void
> *dev_id) return IRQ_HANDLED;
>  }
> 
> -static void __init rk_timer_init(struct device_node *np, u32 ctrl_reg)
> +static int __init rk_timer_init(struct device_node *np, u32 ctrl_reg)
>  {
>  	struct clock_event_device *ce = &bc_timer.ce;
>  	struct clk *timer_clk;
>  	struct clk *pclk;
> -	int ret, irq;
> +	int ret = -EINVAL, irq;
> 
>  	bc_timer.base = of_iomap(np, 0);
>  	if (!bc_timer.base) {
>  		pr_err("Failed to get base address for '%s'\n", TIMER_NAME);
> -		return;
> +		return -ENXIO;
>  	}
>  	bc_timer.ctrl = bc_timer.base + ctrl_reg;

wouldn't it be nicer to also save the error values from all the intermediate
clock calls (ret = PTR_ERR(pclk) and so on).
Right now it will be always -EINVAL for all those clk calls and also
the irq_of_parse_and_map.

Heiko
