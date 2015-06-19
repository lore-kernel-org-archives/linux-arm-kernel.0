From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 19 Jun 2015 12:30:08 +0200
Subject: [PATCH 23/41] clocksource: sun4i: Migrate to new 'set-state'
 interface
In-Reply-To: <20150618122336.GB1982@linux>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
 <fe0d96a4671d94c60f7b252d1c038cd62ed71162.1434622147.git.viresh.kumar@linaro.org>
 <20150618120105.GM11732@lukather> <20150618122336.GB1982@linux>
Message-ID: <20150619103008.GB11732@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 05:53:36PM +0530, Viresh Kumar wrote:
> On 18-06-15, 14:01, Maxime Ripard wrote:
> > On Thu, Jun 18, 2015 at 04:24:37PM +0530, Viresh Kumar wrote:
> > > +static int sun4i_clkevt_shutdown(struct clock_event_device *evt)
> > >  {
> > > -	switch (mode) {
> > > -	case CLOCK_EVT_MODE_PERIODIC:
> > > -		sun4i_clkevt_time_stop(0);
> > > -		sun4i_clkevt_time_setup(0, ticks_per_jiffy);
> > > -		sun4i_clkevt_time_start(0, true);
> > > -		break;
> > > -	case CLOCK_EVT_MODE_ONESHOT:
> > > -		sun4i_clkevt_time_stop(0);
> > > -		sun4i_clkevt_time_start(0, false);
> > > -		break;
> > > -	case CLOCK_EVT_MODE_UNUSED:
> > > -	case CLOCK_EVT_MODE_SHUTDOWN:
> > > -	default:
> > > -		sun4i_clkevt_time_stop(0);
> > > -		break;
> 
> Because sun4i_clkevt_time_stop() is getting called in default case, it
> is getting called for tick-resume mode already with the old set_mode
> interface.
> 
> > > +	.tick_resume = sun4i_clkevt_shutdown,
> > 
> > I'm not exactly sure of the context here, but I wouldn't expect a
> > callback called tick_resume to stop a timer. Is this expected?
> 
> And so this patch carried the same logic here.
> 
> At suspend: clockevents core calls ->set_state_shutdown() and at
> resume it calls ->tick_resume() followed by setting to the proper
> mode, i.e. periodic or oneshot.
> 
> Many driver authors didn't knew about these details and so did
> shutdown in resume path as well.
> 
> For me, you might not even need a tick_resume() at all, as your driver
> would have already shutted down on suspend and is just required to be
> put to the right mode again.

Ok, thanks for the explanation.

It looks good for both this patch and the sun5i one. You can add my
Acked-by.

> But, I didn't wanted to change the way things behaved until now. I can
> add another patch to get things fixed separately if you want me to.

If you have some spare time, it would be great :)

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150619/06f8ce21/attachment.sig>
