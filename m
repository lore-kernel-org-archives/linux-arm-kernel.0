From: carlo@caione.org (Carlo Caione)
Date: Tue, 19 Aug 2014 18:01:53 +0200
Subject: [PATCH 3/7] ARM: meson6: clocksource: add Meson6 timer support
In-Reply-To: <20140818162726.GE3302@leverpostej>
References: <1408272594-10814-1-git-send-email-carlo@caione.org>
 <1408272594-10814-4-git-send-email-carlo@caione.org>
 <20140818162726.GE3302@leverpostej>
Message-ID: <20140819160153.GA869@carlo-MacBookPro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On lun, ago 18, 2014 at 05:27:26 +0100, Mark Rutland wrote:
> On Sun, Aug 17, 2014 at 11:49:50AM +0100, Carlo Caione wrote:
> > +enum {
> > +	A = 0,
> > +	B,
> > +	C,
> > +	D,
> > +};
> 
> That's a very terse set of enum names. I would recomment something a
> little longer.
> 
> Any reason for missing E?

TIMER_E is a slightly different timer so I preferred to leave it apart.

> > +#define TIMER_ISA_MUX		0
> > +#define TIMER_ISA_E_VAL		0x14
> > +#define TIMER_ISA_t_VAL(t)	((t + 1) << 2)
> > +
> > +#define TIMER_t_INPUT_BIT(t)	(2 * t)
> > +#define TIMER_E_INPUT_BIT	8
> > +#define TIMER_t_INPUT_MASK(t)	(3UL << TIMER_t_INPUT_BIT(t))
> > +#define TIMER_E_INPUT_MASK	(7UL << TIMER_E_INPUT_BIT)
> > +#define TIMER_t_ENABLE_BIT(t)	(16 + t)
> > +#define TIMER_E_ENABLE_BIT	20
> > +#define TIMER_t_PERIODIC_BIT(t)	(12 + t)
> 
> While I don't think it matters for any of these, it's usually good
> practice to add parentheses around arguments, e.g.
> 
> #define FOO(x)		((x) * 2)
> 
> So you can avoid bad expansions in cases like:
> 
> FOO(reg + 4)

Agree. I'll change it.

> > +
> > +#define TIMER_UNIT_1us		0
> > +#define TIMER_E_UNIT_1us	1
> > +
> > +static void __iomem *timer_base;
> > +
> > +static cycle_t cycle_read_timer_e(struct clocksource *cs)
> > +{
> > +	return (cycle_t)readl(timer_base + TIMER_ISA_E_VAL);
> > +}
> > +
> > +static struct clocksource clocksource_timer_e = {
> > +	.name	= "meson6_timerE",
> 
> Do we really care which specific timer we're using within the block?
> 
> Why not just "meson6_clocksource"?

Just a reminder of which timer we are using. I'll fix it.

> > +	.rating	= 300,
> > +	.read	= cycle_read_timer_e,
> > +	.mask	= CLOCKSOURCE_MASK(32),
> > +	.flags  = CLOCK_SOURCE_IS_CONTINUOUS,
> > +};
> 
> [...]
> 
> > +static irqreturn_t meson6_timer_interrupt(int irq, void *dev_id)
> > +{
> > +	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
> > +
> > +	evt->event_handler(evt);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static struct irqaction meson6_timer_irq = {
> > +	.name		= "meson6_timerA",
> 
> Similarly to the clocksource naming, this might be better as
> "meson6_timer", without the 'A'.

Yep.

Thanks for the review,

-- 
Carlo Caione
