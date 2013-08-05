From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 5 Aug 2013 18:02:49 +0100
Subject: [PATCH 06/10] ARM: clps711x: Add CLPS711X clocksource driver
In-Reply-To: <20130804163113.07d94f707528c15b1bff13d7@mail.ru>
References: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
 <1374172501-26796-7-git-send-email-shc_work@mail.ru>
 <20130802104635.GE2884@e106331-lin.cambridge.arm.com>
 <20130804163113.07d94f707528c15b1bff13d7@mail.ru>
Message-ID: <20130805170249.GE13091@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 04, 2013 at 01:31:13PM +0100, Alexander Shiyan wrote:
> On Fri, 2 Aug 2013 11:46:35 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > On Thu, Jul 18, 2013 at 07:34:57PM +0100, Alexander Shiyan wrote:
> > > This adds the clocksource driver for Cirrus Logic CLPS711X series SoCs.
> > > Designed primarily for migration CLPS711X subarch for multiplatform & DT,
> > > for this as the "OF" and "not-OF" calls implemented.
> > > 
> > > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > > ---
> > 
> > [...]
> 
> > > +static struct clock_event_device clps711x_clockevent = {
> > > +	.name		= "clps711x-clockevent",
> > > +	.rating		= 300,
> > > +	.features	= CLOCK_EVT_FEAT_PERIODIC,
> > > +	.set_mode	= clps711x_clockevent_set_mode,
> > > +};
> > 
> > This seems to be a global clockevent, or a CPU0-only clockevent. Please
> > set the cpumask to clarify this, or core clockevent code will scream at
> > you (see clockevents_register_device).
> > 
> > I assume this doesn't stop in low power states (CLOCK_EVT_FEAT_C3STOP)?
> 
> This feature is marked as "x86(64) specific" in the header.

While the misfeature was at one point x86-specific, it's rather generic
now.

If your device doesn't stop when the CPU is put into a low power state,
then that's far better and there's nothing to worry about. I just
thought I'd check now to save any future time spent debugging odd stalls
:)

> 
> [...]
> > > +static void __init _clps711x_clksrc_init(phys_addr_t phys_base, int irq,
> > > +					 struct clk *tc1, struct clk *tc2)
> > > +{
> > > +	unsigned long tc1_rate, tc2_rate;
> > > +	void __iomem *tc2d, *syscon1;
> > > +	u32 tmp;
> > > +
> > > +	BUG_ON(IS_ERR(tc1) || IS_ERR(tc2));
> > 
> > Is this the only timer possible in the SoCs it'll be used in? You might
> > not be capable of initialising this timer, but another timer may be able
> > to keep the system running...
> 
> This CPU have two HW timers only. Both are used here.

Ok. So there clocks aren't likely to be used in futures SoCs with other
clocks?

Thanks,
Mark.
