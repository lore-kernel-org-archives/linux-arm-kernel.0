From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 3 Jul 2015 16:47:47 +0530
Subject: [PATCH 39/41] clocksource: vf_pit: Migrate to new 'set-state'
 interface
In-Reply-To: <6a6d4ec3156cb00537ed632f60430a37@agner.ch>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
 <c9f030f57a10c1be00f8732ae2190fcc55248db5.1434622147.git.viresh.kumar@linaro.org>
 <19859bd18fb69fa1f10c07de01b2259d@agner.ch>
 <20150703085749.GE23297@linux>
 <6a6d4ec3156cb00537ed632f60430a37@agner.ch>
Message-ID: <20150703111747.GG23297@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03-07-15, 13:11, Stefan Agner wrote:
> On 2015-07-03 10:57, Viresh Kumar wrote:
> > On 03-07-15, 10:10, Stefan Agner wrote:
> >> >  	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
> >> > -	.set_mode	= pit_set_mode,
> >> > +	.set_state_shutdown = pit_shutdown,
> >> > +	.set_state_periodic = pit_set_periodic,
> >>
> >> I'm not really familiar with the interface, but given that we announce
> >> the feature CLOCK_EVT_FEAT_ONESHOT shouldn't we add a set_state_oneshot
> >> callback here?
> > 
> > We weren't doing anything in pit_set_mode(ONESHOT) and so that
> > callback is not implemented. In case you need to do something in
> > set_state_oneshot(), we can add it back.
> 
> True, weren't doing anything. I wonder if that is right. Afaik, we
> should set the same timer for oneshot too, hence call
> pit_set_next_event. With your change we can just reuse the same function
> (pit_set_periodic) for set_state_oneshot.

pit_set_next_event() will be called by clockevents core directly after
tying to set the device in oneshot mode. And so no changes are
required.

> To maintain the atomicity of the changes, this would need to be fixed in
> a separate patch anyway. So this change looks good to me:
> 
> Acked-by: Stefan Agner <stefan@agner.ch>

Thanks.

> I guess "clockevents: Allow set-state callbacks to be optional" makes it
> before this patch? Otherwise we would call a null pointer...

Yeah, I have mentioned this in the cover-letter that there are
dependencies over clockevent core's next branch.

-- 
viresh
