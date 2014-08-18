From: carlo@caione.org (Carlo Caione)
Date: Mon, 18 Aug 2014 16:11:04 +0200
Subject: [PATCH 3/7] ARM: meson6: clocksource: add Meson6 timer support
In-Reply-To: <53F1EAAA.8020904@gmail.com>
References: <1408272594-10814-1-git-send-email-carlo@caione.org>
 <1408272594-10814-4-git-send-email-carlo@caione.org>
 <53F1EAAA.8020904@gmail.com>
Message-ID: <20140818141104.GD28819@carlo-MacBookPro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 01:59:38PM +0200, Matthias Brugger wrote:
> On 17/08/14 12:49, Carlo Caione wrote:
> >+enum {
> >+	A = 0,
> >+	B,
> >+	C,
> >+	D,
> >+};
> 
> You are just using timer A, so this enum is unnecessary. Please use
> a define instead. Also it would be better, if the define would be
> explenatory then just the letter 'A'.

In the meson6 SoCs there are 4 timers (TIMERA, TIMERB, TIMERC and
TIMERD). From the source code released by Amlogic it seems that they
have exactly the same characteristics and any of them can be used for
the clockevents. So either I fix the usage of only the TIMERA in the
driver or use the DTS to specify which one to use.

> >+
> >+#define TIMER_ISA_MUX		0
> >+#define TIMER_ISA_E_VAL		0x14
> >+#define TIMER_ISA_t_VAL(t)	((t + 1) << 2)
> >+
> >+#define TIMER_t_INPUT_BIT(t)	(2 * t)
> 
> Please put braces around 't'.

Ok

> >+#define TIMER_E_INPUT_BIT	8
> 
> From the enum above, missing timer E would be 4 so you can use the
> TIMER_t_INPUT_BIT(t) macro, right?

Right. It was to be consistent since the mask for TIMERE is different.
But I'll fix it.

> >+#define TIMER_t_INPUT_MASK(t)	(3UL << TIMER_t_INPUT_BIT(t))
> >+#define TIMER_E_INPUT_MASK	(7UL << TIMER_E_INPUT_BIT)
> >+#define TIMER_t_ENABLE_BIT(t)	(16 + t)
> >+#define TIMER_E_ENABLE_BIT	20
> >+#define TIMER_t_PERIODIC_BIT(t)	(12 + t)
> 
> Please put braces around 't'.

I'll do

> >+
> >+#define TIMER_UNIT_1us		0
> >+#define TIMER_E_UNIT_1us	1
> 
> Please don't use lower case characters in defines.

Ok

<cut>

> >+static void __init meson6_timer_init(struct device_node *node)
> >+{
> >+	u32 val;
> >+	int ret, irq;
> >+
> >+	timer_base = of_iomap(node, 0);
> 
> Please use of_io_request_and_map instead.

Agree. Fix in v2.

> >+	if (!timer_base)
> >+		panic("Can't map registers");
> >+
> >+	irq = irq_of_parse_and_map(node, 0);
> >+	if (irq <= 0)
> >+		panic("Can't parse IRQ");
> >+
> >+	/* Set 1us for timer E */
> >+	val = readl(timer_base + TIMER_ISA_MUX);
> >+	val &= ~TIMER_E_INPUT_MASK;
> >+	val |= TIMER_E_UNIT_1us << TIMER_E_INPUT_BIT;
> >+	writel(val, timer_base + TIMER_ISA_MUX);
> >+
> >+	sched_clock_register(meson6_timer_sched_read, 32, USEC_PER_SEC);
> >+	clocksource_register_khz(&clocksource_timer_e, 1000);
> 
> Why don't you use clocksource_mmio_init?

No real reason, I just missed that one.

> >+
> >+	/* Timer A base 1us */
> >+	val &= ~TIMER_t_INPUT_MASK(A);
> >+	val |= TIMER_UNIT_1us << TIMER_t_INPUT_BIT(A);
> >+	writel(val, timer_base + TIMER_ISA_MUX);
> 
> Is this dependant on any clocking of the timer?

No. At least this is what I can infer from the messy source code released by
Amlogic. I wish I had any documentation for these SoCs.

Thank you for your review,
 
-- 
Carlo Caione
