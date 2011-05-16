From: robherring2@gmail.com (Rob Herring)
Date: Mon, 16 May 2011 16:24:27 -0500
Subject: [PATCH 17/19] clockevents: ARM sp804: obtain sp804 timer rate
	via clks
In-Reply-To: <E1QM1dU-0003EL-9p@rmk-PC.arm.linux.org.uk>
References: <20110516172334.GD13659@n2100.arm.linux.org.uk>
	<E1QM1dU-0003EL-9p@rmk-PC.arm.linux.org.uk>
Message-ID: <4DD1960B.5000603@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2011 12:31 PM, Russell King - ARM Linux wrote:
> This allows platforms to specify the rate of the SP804 clockevent via
> the clk subsystem.  While ARM boards clock these at 1MHz, BCMRing also
> has SP804 timers but are clocked at different rates.
>
> Cc: Catalin Marinas<catalin.marinas@arm.com>
> Signed-off-by: Russell King<rmk+kernel@arm.linux.org.uk>
> ---
>   arch/arm/common/timer-sp.c        |   16 ++++++++--------
>   arch/arm/mach-vexpress/ct-ca9x4.c |    4 ++++
>   arch/arm/mach-vexpress/v2m.c      |    4 ++++
>   3 files changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
> index bf92afe..1707c92 100644
> --- a/arch/arm/common/timer-sp.c
> +++ b/arch/arm/common/timer-sp.c
> @@ -28,12 +28,6 @@
>
>   #include<asm/hardware/arm_timer.h>
>
> -/*
> - * These timers are currently always setup to be clocked at 1MHz.
> - */
> -#define TIMER_FREQ_KHZ	(1000)
> -#define TIMER_RELOAD	(TIMER_FREQ_KHZ * 1000 / HZ)
> -
>   static long __init sp804_get_clock_rate(const char *name)
>   {
>   	struct clk *clk;
> @@ -84,6 +78,7 @@ void __init sp804_clocksource_init(void __iomem *base, const char *name)
>
>
>   static void __iomem *clkevt_base;
> +static unsigned long clkevt_reload;
>
>   /*
>    * IRQ handler for the timer
> @@ -109,7 +104,7 @@ static void sp804_set_mode(enum clock_event_mode mode,
>
>   	switch (mode) {
>   	case CLOCK_EVT_MODE_PERIODIC:
> -		writel(TIMER_RELOAD, clkevt_base + TIMER_LOAD);
> +		writel(clkevt_reload, clkevt_base + TIMER_LOAD);
>   		ctrl |= TIMER_CTRL_PERIODIC | TIMER_CTRL_ENABLE;
>   		break;
>
> @@ -158,12 +153,17 @@ void __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
>   	const char *name)
>   {
>   	struct clock_event_device *evt =&sp804_clockevent;
> +	long rate = sp804_get_clock_rate(name);
> +
> +	if (rate<  0)
> +		return;
>
>   	clkevt_base = base;
> +	clkevt_reload = DIV_ROUND_CLOSEST(rate, HZ);
>
>   	evt->name = name;
>   	evt->irq = irq;
> -	evt->mult = div_sc(TIMER_FREQ_KHZ, NSEC_PER_MSEC, evt->shift);
> +	evt->mult = div_sc(rate, SEC_PER_MSEC, evt->shift);

This doesn't compile or make sense. Should be NSEC_PER_SEC.

Rob
