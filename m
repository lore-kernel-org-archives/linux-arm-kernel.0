From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 Jan 2015 19:46:46 +0000
Subject: [PATCH v2 1/2] arm: perf: Prevent wraparound during overflow
In-Reply-To: <20150105193120.GA9167@sundance.lan>
References: <1416412346-8759-1-git-send-email-daniel.thompson@linaro.org>
 <1416587067-3220-1-git-send-email-daniel.thompson@linaro.org>
 <1416587067-3220-2-git-send-email-daniel.thompson@linaro.org>
 <20150105145739.GU30905@twins.programming.kicks-ass.net>
 <20150105193120.GA9167@sundance.lan>
Message-ID: <20150106194646.GG32449@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 05, 2015 at 07:31:20PM +0000, Daniel Thompson wrote:
> On Mon, Jan 05, 2015 at 03:57:39PM +0100, Peter Zijlstra wrote:
> > On Fri, Nov 21, 2014 at 04:24:26PM +0000, Daniel Thompson wrote:
> > > diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> > > index 266cba46db3e..ab68833c1e31 100644
> > > --- a/arch/arm/kernel/perf_event.c
> > > +++ b/arch/arm/kernel/perf_event.c
> > > @@ -115,8 +115,14 @@ int armpmu_event_set_period(struct perf_event *event)
> > >  		ret = 1;
> > >  	}
> > >  
> > > -	if (left > (s64)armpmu->max_period)
> > > -		left = armpmu->max_period;
> > > +	/*
> > > +	 * Limit the maximum period to prevent the counter value
> > > +	 * from overtaking the one we are about to program. In
> > > +	 * effect we are reducing max_period to account for
> > > +	 * interrupt latency (and we are being very conservative).
> > > +	 */
> > > +	if (left > (armpmu->max_period >> 1))
> > > +		left = armpmu->max_period >> 1;
> > 
> > On x86 we simply half max_period, why did you choose to do differently?
> 
> In truth because I didn't look at the x86 code... there is an existing
> halving of max_period in the arm code and that was enough to satisfy me
> that halving max_period was reasonable.
> 
> Predividing max_period looks to me like it would work for ARM too although I
> don't think we could blame hardware insanity for doing so ;-).
> 
> Will: Do you want me to update this?

Whichever you prefer. The ARM perf code used to be used by some drivers
and so we tried to keep the implementation details hidden from them, but
that didn't work out so well and it's now only used by the CPU PMUs.

Will
