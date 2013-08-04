From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 4 Aug 2013 16:31:13 +0400
Subject: [PATCH 06/10] ARM: clps711x: Add CLPS711X clocksource driver
In-Reply-To: <20130802104635.GE2884@e106331-lin.cambridge.arm.com>
References: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
 <1374172501-26796-7-git-send-email-shc_work@mail.ru>
 <20130802104635.GE2884@e106331-lin.cambridge.arm.com>
Message-ID: <20130804163113.07d94f707528c15b1bff13d7@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2 Aug 2013 11:46:35 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> On Thu, Jul 18, 2013 at 07:34:57PM +0100, Alexander Shiyan wrote:
> > This adds the clocksource driver for Cirrus Logic CLPS711X series SoCs.
> > Designed primarily for migration CLPS711X subarch for multiplatform & DT,
> > for this as the "OF" and "not-OF" calls implemented.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
> 
> [...]

> > +static struct clock_event_device clps711x_clockevent = {
> > +	.name		= "clps711x-clockevent",
> > +	.rating		= 300,
> > +	.features	= CLOCK_EVT_FEAT_PERIODIC,
> > +	.set_mode	= clps711x_clockevent_set_mode,
> > +};
> 
> This seems to be a global clockevent, or a CPU0-only clockevent. Please
> set the cpumask to clarify this, or core clockevent code will scream at
> you (see clockevents_register_device).
> 
> I assume this doesn't stop in low power states (CLOCK_EVT_FEAT_C3STOP)?

This feature is marked as "x86(64) specific" in the header.

[...]
> > +static void __init _clps711x_clksrc_init(phys_addr_t phys_base, int irq,
> > +					 struct clk *tc1, struct clk *tc2)
> > +{
> > +	unsigned long tc1_rate, tc2_rate;
> > +	void __iomem *tc2d, *syscon1;
> > +	u32 tmp;
> > +
> > +	BUG_ON(IS_ERR(tc1) || IS_ERR(tc2));
> 
> Is this the only timer possible in the SoCs it'll be used in? You might
> not be capable of initialising this timer, but another timer may be able
> to keep the system running...

This CPU have two HW timers only. Both are used here.

-- 
Alexander Shiyan <shc_work@mail.ru>
