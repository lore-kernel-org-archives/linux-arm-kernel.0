From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 22 Jun 2016 15:13:29 +0200
Subject: [PATCH 42/48] clocksource/drivers: Add a new driver for the
 Atmel ARM TC blocks
In-Reply-To: <576A8D74.5000804@linaro.org>
References: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1465596231-21766-43-git-send-email-alexandre.belloni@free-electrons.com>
 <20160611144810.4a1c61d3@bbrezillon> <576A8D74.5000804@linaro.org>
Message-ID: <20160622151329.4f0136ba@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 22 Jun 2016 15:07:00 +0200
Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> On 06/11/2016 02:48 PM, Boris Brezillon wrote:
> 
> [ ... ]
> 
> >> +static int tcb_clkevt_next_event(unsigned long delta,
> >> +				 struct clock_event_device *d)
> >> +{
> >> +	u32 val;
> >> +
> >> +	regmap_read(tc.regmap, ATMEL_TC_CV(tc.channels[0]), &val);
> >> +	regmap_write(tc.regmap, ATMEL_TC_RC(tc.channels[0]), val + delta);
> >> +	regmap_write(tc.regmap, ATMEL_TC_IER(tc.channels[0]), ATMEL_TC_CPCS);  
> >
> > Hm, not sure this is 100% sure. What happens if by the time you write
> > TC_RC, the delta value has expired? This means you'll have to wait
> > another round before the TC engine generates the "RC reached" interrupt.
> >
> > I know this is very unlikely, but should we take the risk?
> >
> > The core seems to check the ->set_next_event() return value and tries to
> > adjust ->min_delta_ns if it returns an error, so maybe it's worth
> > testing if val + delta has already occurred just before enabling the
> > TC_CPCS interrupt, and if it's the case, return an -ETIME error.
> >
> > Something like:
> >
> > 	u32 val[2], next;
> >
> > 	regmap_read(tc.regmap, ATMEL_TC_CV(tc.channels[0]), &val[0]);
> > 	next = (val[0] + delta) & GENMASK(tc.bits - 1, 0);
> > 	regmap_write(tc.regmap, ATMEL_TC_RC(tc.channels[0]), next);
> > 	regmap_read(tc.regmap, ATMEL_TC_CV(tc.channels[0]), &val[1]);
> >
> > 	if ((next < val[0] && val[1] < val[0] && val[1] >= next) ||
> > 	    (next > val[0] && (val[1] < val[0] || val[1] >= next))) {
> > 		/*
> > 		 * Clear the CPCS bit in the status register to avoid
> > 		 * generating a spurious interrupt next time a valid
> > 		 * timer event is configured.
> > 		 * FIXME: not sure it's safe, since it also clears the
> > 		 * overflow status, but it seems this flag is not used
> > 		 * by the driver anyway.
> > 		 */
> > 		regmap_read(tc.regmap, ATMEL_TC_SR, &val[0]);
> > 		return -ETIME;
> > 	}
> >
> > 	
> > 	regmap_write(tc.regmap, ATMEL_TC_IER(tc.channels[0]),
> > 		     ATMEL_TC_CPCS);
> >
> > Thomas, Daniel, what's your opinion?  
> 
> Are you describing the same as commit 
> f9eccf24615672896dc13251410c3f2f33a14f95 ?

Pretty much, yes. Note that this is purely hypothetical in the TCB
case, but I fear people might experience this problem if they're trying
to configure tiny delay values.
