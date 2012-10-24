From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 24 Oct 2012 16:29:28 +0100
Subject: [PATCH 10/10] ARM: imx6q: implement WAIT mode with coupled cpuidle
In-Reply-To: <20121024135725.GA2464@S2101-09.ap.freescale.net>
References: <1351005779-30347-1-git-send-email-shawn.guo@linaro.org>
 <1351005779-30347-11-git-send-email-shawn.guo@linaro.org>
 <20121023173543.GA15113@e102568-lin.cambridge.arm.com>
 <20121024135725.GA2464@S2101-09.ap.freescale.net>
Message-ID: <20121024152925.GA23483@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 02:57:31PM +0100, Shawn Guo wrote:
> On Tue, Oct 23, 2012 at 06:35:43PM +0100, Lorenzo Pieralisi wrote:
> > On Tue, Oct 23, 2012 at 04:22:59PM +0100, Shawn Guo wrote:
> > 
> > [...]
> > 
> > > +/*
> > > + * For each cpu, setup the broadcast timer because local timer
> > > + * stops for the states other than WFI.
> > > + */
> > > +static void imx6q_setup_broadcast_timer(void *arg)
> > > +{
> > > +       int cpu = smp_processor_id();
> > > +
> > > +       clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ON, &cpu);
> > > +}
> > 
> > Can anyone explain to me please why this is needed ?
> > 
> It basically does nothing if either NO_HZ or HIGH_RES_TIMERS is
> enabled, in which case tick_broadcast_setup_oneshot is already called
> on init_timers path to set up bc->event_handler.  This is the general
> case since nowadays we have both options enabled by default for most
> systems.
> 
> However if neither option is enabled, CLOCK_EVT_NOTIFY_BROADCAST_ON
> notifying will help route to call tick_broadcast_setup_oneshot to have
> bc->event_handler set up.
> 
> So in short, it's needed to have broadcast timer work as expected when
> neither NO_HZ or HIGH_RES_TIMERS is enabled.

Ok, point taken, it was just to check I was not missing anything on the
expected usage on systems where those options are enabled.

Thanks a lot,
Lorenzo
