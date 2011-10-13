From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Oct 2011 15:22:41 +0100
Subject: [PATCH 2/5] ARM: s3c64xx: Add generic high resolution time
	support using PWM timers.
In-Reply-To: <3260808.zUY9bHslbC@flatron>
References: <1731819.jJi37IsjvJ@flatron> <3260808.zUY9bHslbC@flatron>
Message-ID: <20111013142241.GY21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2011 at 02:34:52PM +0200, Tomasz Figa wrote:
> +/*
> + * Clock source
> + */
> +
> +static struct clk *source_in;
> +static struct clk *source_div;
> +
> +static cycle_t s3c64xx_clocksource_read(struct clocksource *cs)
> +{
> +	return (cycle_t) ~__raw_readl(S3C2410_TCNTO(PWM_SOURCE));
> +}

This looks like a very simple MMIO clocksource...  This looks the
same as clocksource_mmio_readl_down().

> +
> +static void s3c64xx_clocksource_resume(struct clocksource *cs)
> +{
> +	unsigned long pclk;
> +	struct clk *tscaler;
> +
> +	pclk = clk_get_rate(timerclk);
> +	tscaler = clk_get_parent(source_div);
> +	clk_set_rate(tscaler, pclk / 3);
> +
> +	clk_set_rate(source_div, pclk / 6);
> +	clk_set_parent(source_in, source_div);
> +
> +	s3c64xx_pwm_init(PWM_SOURCE, TCNT_MAX);
> +	s3c64xx_pwm_start(PWM_SOURCE, PERIODIC);
> +}
> +
> +static struct clocksource pwm_clocksource = {
> +	.name		= "s3c64xx_clksrc",
> +	.rating		= 250,
> +	.read		= s3c64xx_clocksource_read,
> +	.mask		= CLOCKSOURCE_MASK(32),
> +	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> +	.resume		= s3c64xx_clocksource_resume,
> +};
> +
> +static void __init s3c64xx_clocksource_init(void)
> +{
> +	unsigned long clock_rate;
> +
> +	clock_rate = clk_get_rate(source_in);
> +
> +	s3c64xx_pwm_init(PWM_SOURCE, TCNT_MAX);
> +	s3c64xx_pwm_start(PWM_SOURCE, PERIODIC);
> +
> +	if (clocksource_register_hz(&pwm_clocksource, clock_rate))
> +		panic("%s: can't register clocksource\n", pwm_clocksource.name);

Apart from the resume entry, this looks like it could use
drivers/clocksource/mmio.c - and so avoid yet another clocksource
creation.

Maybe adding some kind of resume support to mmio.c would be a good
idea?
