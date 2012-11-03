From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Sat, 3 Nov 2012 13:17:46 +0000
Subject: [PATCH 12/15] ARM: OMAP: timer: Add suspend-resume callbacks
 for clockevent device
In-Reply-To: <50950AC7.1030707@deeprootsystems.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-13-git-send-email-vaibhav.bedia@ti.com>
 <50950AC7.1030707@deeprootsystems.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EBFEA88@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 03, 2012 at 17:45:03, Kevin Hilman wrote:
> On 11/02/2012 01:32 PM, Vaibhav Bedia wrote:
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> >
> > The current OMAP timer code registers two timers -
> > one as clocksource and one as clockevent.
> > AM33XX has only one usable timer in the WKUP domain
> > so one of the timers needs suspend-resume support
> > to restore the configuration to pre-suspend state.
> 
> The changelog describes "what", but doesn't answer "why?"
> 

Sorry I'll try to take of this in the future.

> > commit adc78e6 (timekeeping: Add suspend and resume
> > of clock event devices) introduced .suspend and .resume
> > callbacks for clock event devices. Leverages these
> > callbacks to have AM33XX clockevent timer which is
> > in not in WKUP domain to behave properly across system
> > suspend.
> 
> You say it behaves properly without describing what improper
> behavior is happening.
> 

There are two issues. One is that the clockevent timer doesn't
get idled which blocks PER domain transition. The next one is that
the clockevent doesn't generate any further interrupts once the
system resumes. We need to restore the pre-suspend configuration.
I haven't tried but I guess we could have used the save and restore
of timer registers here.

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
> 
> hard-coded timer ID?  the rest of the code is using timer_id

Will fix.

> 
> > +	oh = omap_hwmod_lookup(name);
> > +	if (!oh)
> > +		return;
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
> 
> I don't like the sprintf/hwmod_lookup for every suspend/resume.  Just add a
> new file-global static 'struct omap_hwmod clockevt_oh' along side 
> clockevent_gpt,
> and assign it at init time in dmtimer_init_one.  Then you don't have to 
> do this
> sprintf/lookup on every suspend/resume.
> 

Ok. Will make the changes accordingly.

Regards,
Vaibhav 
