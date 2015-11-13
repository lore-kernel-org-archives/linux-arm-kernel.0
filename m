From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 13 Nov 2015 16:37:13 +0800
Subject: [PATCH] clocksource/drivers/arm_global_timer: Always use use
 {readl|writel}_relaxed
In-Reply-To: <1447403558-7139-1-git-send-email-jszhang@marvell.com>
References: <1447403558-7139-1-git-send-email-jszhang@marvell.com>
Message-ID: <20151113163713.39b0b7e2@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear all,

On Fri, 13 Nov 2015 16:32:38 +0800
Jisheng Zhang <jszhang@marvell.com> wrote:

> This driver use both readl/writel and their relaxed version, this patch
> tries to unify the io accesses.


I'm very sorry. Hit the "Enter" key too quickly. Please kindly ignore this one

Thanks,
Jisheng

> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  drivers/clocksource/arm_global_timer.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
> index a2cb6fa..84a5a5d 100644
> --- a/drivers/clocksource/arm_global_timer.c
> +++ b/drivers/clocksource/arm_global_timer.c
> @@ -99,27 +99,27 @@ static void gt_compare_set(unsigned long delta, int periodic)
>  
>  	counter += delta;
>  	ctrl = GT_CONTROL_TIMER_ENABLE;
> -	writel(ctrl, gt_base + GT_CONTROL);
> -	writel(lower_32_bits(counter), gt_base + GT_COMP0);
> -	writel(upper_32_bits(counter), gt_base + GT_COMP1);
> +	writel_relaxed(ctrl, gt_base + GT_CONTROL);
> +	writel_relaxed(lower_32_bits(counter), gt_base + GT_COMP0);
> +	writel_relaxed(upper_32_bits(counter), gt_base + GT_COMP1);
>  
>  	if (periodic) {
> -		writel(delta, gt_base + GT_AUTO_INC);
> +		writel_relaxed(delta, gt_base + GT_AUTO_INC);
>  		ctrl |= GT_CONTROL_AUTO_INC;
>  	}
>  
>  	ctrl |= GT_CONTROL_COMP_ENABLE | GT_CONTROL_IRQ_ENABLE;
> -	writel(ctrl, gt_base + GT_CONTROL);
> +	writel_relaxed(ctrl, gt_base + GT_CONTROL);
>  }
>  
>  static int gt_clockevent_shutdown(struct clock_event_device *evt)
>  {
>  	unsigned long ctrl;
>  
> -	ctrl = readl(gt_base + GT_CONTROL);
> +	ctrl = readl_relaxed(gt_base + GT_CONTROL);
>  	ctrl &= ~(GT_CONTROL_COMP_ENABLE | GT_CONTROL_IRQ_ENABLE |
>  		  GT_CONTROL_AUTO_INC);
> -	writel(ctrl, gt_base + GT_CONTROL);
> +	writel_relaxed(ctrl, gt_base + GT_CONTROL);
>  	return 0;
>  }
>  
> @@ -212,11 +212,11 @@ static u64 notrace gt_sched_clock_read(void)
>  
>  static void __init gt_clocksource_init(void)
>  {
> -	writel(0, gt_base + GT_CONTROL);
> -	writel(0, gt_base + GT_COUNTER0);
> -	writel(0, gt_base + GT_COUNTER1);
> +	writel_relaxed(0, gt_base + GT_CONTROL);
> +	writel_relaxed(0, gt_base + GT_COUNTER0);
> +	writel_relaxed(0, gt_base + GT_COUNTER1);
>  	/* enables timer on all the cores */
> -	writel(GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
> +	writel_relaxed(GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
>  
>  #ifdef CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
>  	sched_clock_register(gt_sched_clock_read, 64, gt_clk_rate);
