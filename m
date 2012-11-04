From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Sun, 4 Nov 2012 15:25:57 +0000
Subject: [PATCH 12/15] ARM: OMAP: timer: Add suspend-resume callbacks
 for clockevent device
In-Reply-To: <50953DA4.10008@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-13-git-send-email-vaibhav.bedia@ti.com>
 <50953DA4.10008@ti.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EBFFD03@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

On Sat, Nov 03, 2012 at 21:22:04, Shilimkar, Santosh wrote:
> On Friday 02 November 2012 06:02 PM, Vaibhav Bedia wrote:
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> >
> > The current OMAP timer code registers two timers -
> > one as clocksource and one as clockevent.
> Actually OMAP also uses only one timer. The clocksource
> is taken care by 32K syntimer till OMAP4 and by realtime
> counter on OMAP5. There is a clocksource registration of
> timer is available but that is not being used in systems.
> 

Yes, I guess the changelog should mention that AM33xx does not
have the 32k synctimer. I'll also add in the OMAP details that
you pointed out so that all the details get captured.

> > AM33XX has only one usable timer in the WKUP domain
> > so one of the timers needs suspend-resume support
> > to restore the configuration to pre-suspend state.
> >
> > commit adc78e6 (timekeeping: Add suspend and resume
> > of clock event devices) introduced .suspend and .resume
> > callbacks for clock event devices. Leverages these
> > callbacks to have AM33XX clockevent timer which is
> > in not in WKUP domain to behave properly across system
> > suspend.
> >
> So you use WKUP domain timer for clocksource and PER
> domain one for clock-event ?

Yes, that's correct.

> 
> 
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> > ---
> >   arch/arm/mach-omap2/timer.c |   31 +++++++++++++++++++++++++++++++
> >   1 files changed, 31 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> > index 6584ee0..e8781fd 100644
> > --- a/arch/arm/mach-omap2/timer.c
> > +++ b/arch/arm/mach-omap2/timer.c
> > @@ -135,6 +135,35 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
> >   	}
> >   }
> >
> > +static void omap_clkevt_suspend(struct clock_event_device *unused)
> > +{
> > +	char name[10];
> > +	struct omap_hwmod *oh;
> > +
> > +	sprintf(name, "timer%d", 2);
> > +	oh = omap_hwmod_lookup(name);
> > +	if (!oh)
> > +		return;
> 
> You can move all the look up stuff in init code and then
> suspend resume hooks will be cleaner.

Will do. Kevin also pointed this out.

> > +
> > +	omap_hwmod_idle(oh);
> > +}
> > +
> > +static void omap_clkevt_resume(struct clock_event_device *unused)
> > +{
> > +	char name[10];
> > +	struct omap_hwmod *oh;
> > +
> > +	sprintf(name, "timer%d", 2);
> > +	oh = omap_hwmod_lookup(name);
> > +	if (!oh)
> > +		return;
> > +
> > +	omap_hwmod_enable(oh);
> > +	__omap_dm_timer_load_start(&clkev,
> > +			OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0, 1);
> > +	__omap_dm_timer_int_enable(&clkev, OMAP_TIMER_INT_OVERFLOW);
> > +}
> > +
> OK. So since your clk_event stops when PER idles, how do you plan
> to support the SOC idle. For CPUIDLE path, you need your clock-event
> to wakeup the system based on next timer expiry. So you need your
> clock event to be active. Indirectly, you can't let PER idle which
> leads npo CORE idle->SOC idle.
> 
> How do you plan to address this ? Os is SOC idle is not suppose
> to be added for AMXXX ?
> 

We can't really have SOC idle on AM33xx or at least that's what I think. 
The deepest that we should be able to support is MPU off with external
memory in self-refresh mode. I mentioned the reasons for that in the
reply to Kevin [1]. If there's any another approach that we could take
that would be great to know.

Regards,
Vaibhav

[1] http://marc.info/?l=linux-arm-kernel&m=135195053104053&w=2
