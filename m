From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 24 Oct 2012 21:57:31 +0800
Subject: [PATCH 10/10] ARM: imx6q: implement WAIT mode with coupled cpuidle
In-Reply-To: <20121023173543.GA15113@e102568-lin.cambridge.arm.com>
References: <1351005779-30347-1-git-send-email-shawn.guo@linaro.org>
 <1351005779-30347-11-git-send-email-shawn.guo@linaro.org>
 <20121023173543.GA15113@e102568-lin.cambridge.arm.com>
Message-ID: <20121024135725.GA2464@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 06:35:43PM +0100, Lorenzo Pieralisi wrote:
> On Tue, Oct 23, 2012 at 04:22:59PM +0100, Shawn Guo wrote:
> 
> [...]
> 
> > +/*
> > + * For each cpu, setup the broadcast timer because local timer
> > + * stops for the states other than WFI.
> > + */
> > +static void imx6q_setup_broadcast_timer(void *arg)
> > +{
> > +       int cpu = smp_processor_id();
> > +
> > +       clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ON, &cpu);
> > +}
> 
> Can anyone explain to me please why this is needed ?
> 
It basically does nothing if either NO_HZ or HIGH_RES_TIMERS is
enabled, in which case tick_broadcast_setup_oneshot is already called
on init_timers path to set up bc->event_handler.  This is the general
case since nowadays we have both options enabled by default for most
systems.

However if neither option is enabled, CLOCK_EVT_NOTIFY_BROADCAST_ON
notifying will help route to call tick_broadcast_setup_oneshot to have
bc->event_handler set up.

So in short, it's needed to have broadcast timer work as expected when
neither NO_HZ or HIGH_RES_TIMERS is enabled.

Shawn
