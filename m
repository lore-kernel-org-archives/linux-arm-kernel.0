From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Jan 2013 09:31:24 +0000
Subject: One of these things (CONFIG_HZ) is not like the others..
In-Reply-To: <50FE307F.9000701@ti.com>
References: <CAKGA1bkiowcO7OPSfPmaB6eRj_3FNr+4ONnaQHEZkpxB2XfduQ@mail.gmail.com>
 <20130121232322.GK15361@atomide.com> <50FE307F.9000701@ti.com>
Message-ID: <201301220931.24570.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 January 2013, Santosh Shilimkar wrote:
> On Tuesday 22 January 2013 04:53 AM, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [130121 13:07]:
> >>
> >> As for Samsung and the rest I can't comment.  The original reason OMAP
> >> used this though was because the 32768Hz counter can't produce 100Hz
> >> without a .1% error - too much error under pre-clocksource
> >> implementations for timekeeping.  Whether that's changed with the
> >> clocksource/clockevent support needs to be checked.
> >
> > Yes that's why HZ was originally set to 128. That value (or some multiple)
> > still makes sense when the 32 KiHZ clock source is being used. Of course
> > we should rely on the local timer when running for the SoCs that have
> > them.
> >
> This is right. It was only because of the drift associated when clocked
> with 32KHz. Even on SOCs where local timers are available for power
> management reasons we need to switch to 32KHz clocked device in
> low power states. Hence the HZ value should be multiple of 32 on
> OMAP.

I need some help understanding what the two of you are saying, because
it sounds to me that you imply we cannot have a multiplatform kernel
that includes OMAP and another platform that needs (or wants) a different
HZ value.

However, I also thought that when using a proper clocksource driver,
the HZ setting has absolutely no impact on the drift of the wall clock,
because those two are decoupled.

Even when using the HZ based clocksource (for whatever reason you
would want to do that), I thought there should be no drift as long
as the CLOCK_TICK_RATE (in older kernels) or the register_refined_jiffies()
(in older kernels) setting matches the hardware timer frequency.

What am I missing?

	Arnd
