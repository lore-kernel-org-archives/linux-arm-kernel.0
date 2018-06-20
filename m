From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 20 Jun 2018 11:03:40 +0200 (CEST)
Subject: [PATCH v5 2/6] clocksource/drivers: Add a new driver for the
 Atmel ARM TC blocks
In-Reply-To: <20180619211929.22908-3-alexandre.belloni@bootlin.com>
References: <20180619211929.22908-1-alexandre.belloni@bootlin.com>
 <20180619211929.22908-3-alexandre.belloni@bootlin.com>
Message-ID: <alpine.DEB.2.21.1806201037240.10546@nanos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Jun 2018, Alexandre Belloni wrote:
> +
> +static struct atmel_tcb_clksrc {
> +	struct clocksource clksrc;
> +	struct clock_event_device clkevt;
> +	struct regmap *regmap;
> +	void __iomem *base;
> +	struct clk *clk[2];
> +	char name[20];
> +	int channels[2];
> +	int bits;
> +	int irq;
> +	struct {
> +		u32 cmr;
> +		u32 imr;
> +		u32 rc;
> +		bool clken;
> +	} cache[2];
> +	u32 bmr_cache;
> +	bool registered;
> +} tc = {
> +	.clksrc = {
> +		.rating		= 200,
> +		.mask		= CLOCKSOURCE_MASK(32),
> +		.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> +	},
> +	.clkevt	= {
> +		.features	= CLOCK_EVT_FEAT_ONESHOT,
> +		/* Should be lower than at91rm9200's system timer */
> +		.rating		= 125,
> +	},
> +};
> +
> +static struct tc_clkevt_device {
> +	struct clock_event_device clkevt;
> +	struct regmap *regmap;
> +	void __iomem *base;
> +	struct clk *slow_clk;
> +	struct clk *clk;
> +	char name[20];
> +	int channel;
> +	int irq;
> +	struct {
> +		u32 cmr;
> +		u32 imr;
> +		u32 rc;
> +		bool clken;
> +	} cache;
> +	bool registered;
> +	bool clk_enabled;
> +} tce = {
> +	.clkevt	= {
> +		.features		= CLOCK_EVT_FEAT_PERIODIC |
> +					  CLOCK_EVT_FEAT_ONESHOT,
> +		/*
> +		 * Should be lower than at91rm9200's system timer
> +		 * but higher than tc.clkevt.rating
> +		 */
> +		.rating			= 140,
> +	},
> +};

To be honest: This stuff is horrible to read and the two structs are almost
identical. There is really no good reason to have all this duplicated
mess. I'm pretty sure you can consolidate stuff further when using _one_.

And please define the structs separate from the define and arrange the
struct members in tabluar fashion.

> +/*
> + * Clocksource and clockevent using the same channel(s)
> + */
> +static u64 tc_get_cycles(struct clocksource *cs)
> +{
> +	u32 lower, upper;
> +
> +	do {
> +		upper = readl_relaxed(tc.base + ATMEL_TC_CV(tc.channels[1]));
> +		lower = readl_relaxed(tc.base + ATMEL_TC_CV(tc.channels[0]));
> +	} while (upper != readl_relaxed(tc.base + ATMEL_TC_CV(tc.channels[1])));
> +
> +	return (upper << 16) | lower;
> +}

For timekeeping the win of this is dubious. With a 5Mhz clock the 32bit
part wraps around in ~859 seconds, which is plenty even for NOHZ.

So I really would avoid the double read/compare/eventually repeat magic and
just use the lower 32bits for performance sake. I assume the same is true
for sched_clock(), but I might be wrong.

> +static int tcb_clkevt_next_event(unsigned long delta,
> +				 struct clock_event_device *d)
> +{
> +	u32 old, next, cur;
> +
> +	old = readl(tc.base + ATMEL_TC_CV(tc.channels[0]));
> +	next = old + delta;
> +	writel(next, tc.base + ATMEL_TC_RC(tc.channels[0]));
> +	cur = readl(tc.base + ATMEL_TC_CV(tc.channels[0]));
> +
> +	/* check whether the delta elapsed while setting the register */
> +	if ((next < old && cur < old && cur > next) ||
> +	    (next > old && (cur < old || cur > next))) {
> +		/*
> +		 * Clear the CPCS bit in the status register to avoid
> +		 * generating a spurious interrupt next time a valid
> +		 * timer event is configured.
> +		 */
> +		old = readl(tc.base + ATMEL_TC_SR(tc.channels[0]));
> +		return -ETIME;
> +	}

Aarg. Doesn;t that timer block have a simple count down and fire mode?
These compare equal timers suck.

Thanks,

	tglx
