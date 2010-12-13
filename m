From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Dec 2010 13:53:26 +0000
Subject: [PATCH v6 06/15] ARM: mxs: Add timer support
In-Reply-To: <1292244903-30392-4-git-send-email-shawn.guo@freescale.com>
References: <1292244903-30392-1-git-send-email-shawn.guo@freescale.com>
	<1292244903-30392-4-git-send-email-shawn.guo@freescale.com>
Message-ID: <20101213135326.GM8665@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 13, 2010 at 08:55:00PM +0800, Shawn Guo wrote:
> +static struct clocksource clocksource_mxs = {
> +	.name 		= "mxs_timer",
> +	.rating		= 200,
> +	.read		= timrotv2_get_cycles,
> +	.mask		= CLOCKSOURCE_MASK(32),
> +	.shift 		= 17,

Please remove the .shift initializer.

> +	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> +};
> +
> +static int __init mxs_clocksource_init(struct clk *timer_clk)
> +{
> +	unsigned int c = clk_get_rate(timer_clk);
> +
> +	if (timrot_is_v1()) {
> +		clocksource_mxs.read = timrotv1_get_cycles;
> +		clocksource_mxs.mask = CLOCKSOURCE_MASK(16);
> +	}
> +	clocksource_mxs.mult = clocksource_hz2mult(c, clocksource_mxs.shift);
> +	clocksource_register(&clocksource_mxs);

and use clocksource_register_hz(&clocksource_mxs, c); instead here -
it will calculate the shift and mult for you.
