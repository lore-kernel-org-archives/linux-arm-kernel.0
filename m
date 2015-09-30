From: caesar.upstream@gmail.com (Caesar Wang)
Date: Wed, 30 Sep 2015 18:17:33 +0800
Subject: [PATCH 1/2] clocksource/drivers/rockchip: Fix bad NO_IRQ usage
In-Reply-To: <1443607710-10415-1-git-send-email-daniel.lezcano@linaro.org>
References: <560BB452.1020000@linaro.org>
 <1443607710-10415-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <560BB6BD.4080509@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2015?09?30? 18:08, Daniel Lezcano ??:
> The current code assumes the 'irq_of_parse_and_map' will return NO_IRQ in case
> of failure. Unfortunately, the NO_IRQ is not consistent across the different
> architectures and we must not rely on it.
>
> NO_IRQ is equal to '-1' on ARM and 'irq_of_parse_and_map' returns '0' in case
> of an error. Hence, the latter won't be detected and will lead to a crash.
>
> Fix this by just checking 'irq' is different from zero.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

As Per- discuss,  you can free add my test tag.

  Tested-by: Caesar Wang <wxt@rock-chips.com>

> ---
>   drivers/clocksource/rockchip_timer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clocksource/rockchip_timer.c b/drivers/clocksource/rockchip_timer.c
> index bb2c2b0..d3c1742 100644
> --- a/drivers/clocksource/rockchip_timer.c
> +++ b/drivers/clocksource/rockchip_timer.c
> @@ -148,7 +148,7 @@ static void __init rk_timer_init(struct device_node *np)
>   	bc_timer.freq = clk_get_rate(timer_clk);
>   
>   	irq = irq_of_parse_and_map(np, 0);
> -	if (irq == NO_IRQ) {
> +	if (!irq) {
>   		pr_err("Failed to map interrupts for '%s'\n", TIMER_NAME);
>   		return;
>   	}


-- 
Thanks,
Caesar
