From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 24 Aug 2016 16:21:01 +0200
Subject: [v.3] clocksource:clps711x-timer:- Unmap a region obtained by
 remap.
In-Reply-To: <1472047821-5539-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1472047821-5539-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <57BDAD4D.7060602@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24/2016 04:10 PM, Arvind Yadav wrote:
> iounmap frees the mapping when timer id is not matching.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

What is the difference with the V2 ?

> ---
>  drivers/clocksource/clps711x-timer.c | 41 +++++++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/clocksource/clps711x-timer.c b/drivers/clocksource/clps711x-timer.c
> index 24db6d6..784c000 100644
> --- a/drivers/clocksource/clps711x-timer.c
> +++ b/drivers/clocksource/clps711x-timer.c
> @@ -33,14 +33,7 @@ static u64 notrace clps711x_sched_clock_read(void)
>  
>  static int __init _clps711x_clksrc_init(struct clk *clock, void __iomem *base)
>  {
> -	unsigned long rate;
> -
> -	if (!base)
> -		return -ENOMEM;
> -	if (IS_ERR(clock))
> -		return PTR_ERR(clock);
> -
> -	rate = clk_get_rate(clock);
> +	unsigned long rate = clk_get_rate(clock);
>  
>  	tcd = base;
>  
> @@ -67,13 +60,6 @@ static int __init _clps711x_clkevt_init(struct clk *clock, void __iomem *base,
>  	struct clock_event_device *clkevt;
>  	unsigned long rate;
>  
> -	if (!irq)
> -		return -EINVAL;
> -	if (!base)
> -		return -ENOMEM;
> -	if (IS_ERR(clock))
> -		return PTR_ERR(clock);
> -
>  	clkevt = kzalloc(sizeof(*clkevt), GFP_KERNEL);
>  	if (!clkevt)
>  		return -ENOMEM;
> @@ -106,16 +92,33 @@ void __init clps711x_clksrc_init(void __iomem *tc1_base, void __iomem *tc2_base,
>  #ifdef CONFIG_CLKSRC_OF
>  static int __init clps711x_timer_init(struct device_node *np)
>  {
> -	unsigned int irq = irq_of_parse_and_map(np, 0);
> -	struct clk *clock = of_clk_get(np, 0);
> -	void __iomem *base = of_iomap(np, 0);
> +	unsigned int irq;
> +	struct clk *clock;
> +	void __iomem *base;
> +	int ret;
> +
> +	clock = of_clk_get(np, 0);
> +	if (IS_ERR(clock))
> +		return PTR_ERR(clock);
> +
> +	base = of_iomap(np, 0);
> +	if (!base)
> +		return -ENOMEM;
>  
>  	switch (of_alias_get_id(np, "timer")) {
>  	case CLPS711X_CLKSRC_CLOCKSOURCE:
>  		return _clps711x_clksrc_init(clock, base);
>  	case CLPS711X_CLKSRC_CLOCKEVENT:
> -		return _clps711x_clkevt_init(clock, base, irq);
> +		irq = irq_of_parse_and_map(np, 0);
> +		if (!irq)
> +			return -EINVAL;
> +
> +		ret = _clps711x_clkevt_init(clock, base, irq);
> +		if (ret)
> +			iounmap(base);
> +		return ret;
>  	default:
> +		iounmap(base);
>  		return -EINVAL;
>  	}
>  }
> 


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
