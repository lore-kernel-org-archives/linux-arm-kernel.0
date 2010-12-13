From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 13 Dec 2010 14:26:33 -0500 (EST)
Subject: [PATCH 22/24] ARM: orion: update clock source registration
In-Reply-To: <E1PSDyd-0008Di-EB@rmk-PC.arm.linux.org.uk>
References: <20101213191437.GN8665@n2100.arm.linux.org.uk>
	<E1PSDyd-0008Di-EB@rmk-PC.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1012131426110.10437@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 13 Dec 2010, Russell King - ARM Linux wrote:

> In d7e81c2 (clocksource: Add clocksource_register_hz/khz interface) new
> interfaces were added which simplify (and optimize) the selection of the
> divisor shift/mult constants.  Switch over to using this new interface.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Nicolas Pitre <nico@fluxnic.net>


> ---
>  arch/arm/plat-orion/time.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/plat-orion/time.c b/arch/arm/plat-orion/time.c
> index 715a301..11e2583 100644
> --- a/arch/arm/plat-orion/time.c
> +++ b/arch/arm/plat-orion/time.c
> @@ -102,7 +102,6 @@ static cycle_t orion_clksrc_read(struct clocksource *cs)
>  
>  static struct clocksource orion_clksrc = {
>  	.name		= "orion_clocksource",
> -	.shift		= 20,
>  	.rating		= 300,
>  	.read		= orion_clksrc_read,
>  	.mask		= CLOCKSOURCE_MASK(32),
> @@ -245,8 +244,7 @@ void __init orion_time_init(unsigned int irq, unsigned int tclk)
>  	writel(u & ~BRIDGE_INT_TIMER0, BRIDGE_MASK);
>  	u = readl(TIMER_CTRL);
>  	writel(u | TIMER0_EN | TIMER0_RELOAD_EN, TIMER_CTRL);
> -	orion_clksrc.mult = clocksource_hz2mult(tclk, orion_clksrc.shift);
> -	clocksource_register(&orion_clksrc);
> +	clocksource_register_hz(&orion_clksrc, tclk);
>  
>  	/*
>  	 * Setup clockevent timer (interrupt-driven.)
> -- 
> 1.6.2.5
> 
