From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 31 May 2016 11:44:29 +0200
Subject: [PATCH 4/4] clocksource: sp804: support 64bit mode for hisilicon
 timer64
In-Reply-To: <1464428033-52106-5-git-send-email-wangkefeng.wang@huawei.com>
References: <1464428033-52106-1-git-send-email-wangkefeng.wang@huawei.com>
 <1464428033-52106-5-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <574D5CFD.1010305@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2016 11:33 AM, Kefeng Wang wrote:
> There is a kind of 64bit mode timer in hisilicon soc(like Hip05, Hip06 and
> some arm32 soc), it is very similar with ARM sp804 Dual Timers, but TimerX
> LOAD/Value/BGLoad are 64bit(two 32bit regs), and reg offset is different.

"A kind of 64bit mode timer" is very vague. Please describe more the 
timer you want to support in this driver and split dt-bindings, so Rob 
can ack it independently.

Especially, explain why 64bits is needed here, when the clocksource 
wraps up, etc ...

> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   .../devicetree/bindings/timer/arm,sp804.txt        |  1 +
>   drivers/clocksource/timer-sp.h                     |  1 +
>   drivers/clocksource/timer-sp804.c                  | 76 ++++++++++++++++++----
>   3 files changed, 66 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/timer/arm,sp804.txt b/Documentation/devicetree/bindings/timer/arm,sp804.txt
> index 5cd8eee7..d8e8f8f 100644
> --- a/Documentation/devicetree/bindings/timer/arm,sp804.txt
> +++ b/Documentation/devicetree/bindings/timer/arm,sp804.txt
> @@ -17,6 +17,7 @@ Optional properties:
>   - arm,sp804-has-irq = <#>: In the case of only 1 timer irq line connected, this
>   	specifies if the irq connection is for timer 1 or timer 2. A value of 1
>   	or 2 should be used.
> +- hisilicon,timer64: Support hisilicon 64bit mode timer.
>
>   Example:
>
> diff --git a/drivers/clocksource/timer-sp.h b/drivers/clocksource/timer-sp.h
> index 050d885..adf82f4 100644
> --- a/drivers/clocksource/timer-sp.h
> +++ b/drivers/clocksource/timer-sp.h
> @@ -16,6 +16,7 @@
>   #define TIMER_VALUE	0x04			/* ACVR ro */
>   #define TIMER_CTRL	0x08			/* ACVR rw */
>   #define TIMER_CTRL_ONESHOT	(1 << 0)	/*  CVR */
> +/* Used in hisilicon timer64, it means enabling 64bit mode */
>   #define TIMER_CTRL_32BIT	(1 << 1)	/*  CVR */
>   #define TIMER_CTRL_DIV1		(0 << 2)	/* ACVR */
>   #define TIMER_CTRL_DIV16	(1 << 2)	/* ACVR */
> diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
> index 2ff8777..7f1d947 100644
> --- a/drivers/clocksource/timer-sp804.c
> +++ b/drivers/clocksource/timer-sp804.c
> @@ -34,6 +34,16 @@
>
>   #include "timer-sp.h"
>
> +#define TIMER64_2_BASE	0x40
> +#define TIMER64_LOAD_L	0x00
> +#define TIMER64_LOAD_H	0x04
> +#define TIMER64_VALUE_L	0x08
> +#define TIMER64_VALUE_H	0x0C
> +
> +#define HISI_OFFSET	0x8
> +
> +static int timer64_offset;
> +
>   static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
>   {
>   	long rate;
> @@ -78,8 +88,8 @@ static inline void sp804_load_mode_set(void __iomem *base, unsigned long load, i
>   	unsigned long ctrl = TIMER_CTRL_32BIT | TIMER_CTRL_IE |
>   			     mode | TIMER_CTRL_ENABLE;
>
> -	writel(load, base + TIMER_LOAD);
> -	writel(ctrl, base + TIMER_CTRL);
> +	writel(load, base + TIMER_LOAD); /* equal TIMER64_LOAD_L when timer64*/
> +	writel(ctrl, base + TIMER_CTRL + timer64_offset);
>   }
>
>   static void __iomem *sched_clock_base;
> @@ -89,11 +99,37 @@ static u64 notrace sp804_read(void)
>   	return ~readl_relaxed(sched_clock_base + TIMER_VALUE);
>   }
>
> +static u64 notrace hisi_timer64_read(void)
> +{
> +	u32 val_lo, val_hi, tmp_hi;
> +
> +	do {
> +		val_hi = readl_relaxed(sched_clock_base + TIMER64_VALUE_H);
> +		val_lo = readl_relaxed(sched_clock_base + TIMER64_VALUE_L);
> +		tmp_hi = readl_relaxed(sched_clock_base + TIMER64_VALUE_H);
> +	} while (val_hi != tmp_hi);
> +
> +	return ((u64) val_hi << 32) | val_lo;
> +}

64bits is not free. Is it really needed ? How long before it wraps up in 
32bits ?

> +
>   void __init sp804_timer_disable(void __iomem *base)
>   {
> -	writel(0, base + TIMER_CTRL);
> +	writel(0, base + TIMER_CTRL + timer64_offset);
>   }

Nope, sp804_timer_disable() should be called with the right parameter.

Ok, so before going further, do the following:

1. Create a structure:

struct sp804_clockevent {
	struct clockevent clkevt;
	void __iomem *base;
	void __iomem *ctrl;
	int width;
};

2. Add a function to return the sp804_clockevent from a clkevt

struct sp804_clockevent sp804_timer(struct clockevent *clkevt)
{
	return container_of(clkevt, struct sp804_clockevent, clkevt);
}

3. Change the different function to use:
	struct sp804_clockevent -> base | ctrl
	
4. And then at init time, fill the structure with the right info.

5. Make sure, 64bits clocksource is really needed and if it is possible 
to share a common timer_read()

Thanks !
   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
