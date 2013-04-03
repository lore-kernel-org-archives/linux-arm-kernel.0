From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 02 Apr 2013 17:38:30 -0700
Subject: [PATCH] clk: divider: Use DIV_ROUND_CLOSEST
In-Reply-To: <4b6b9df8-e221-4e52-82d3-efdcd5de9bd1@AM1EHSMHS021.ehs.local>
References: <20130320001609.8663.21043@quantum>
 <f3ff0545-52cd-4b7b-967e-f81324ba0152@CH1EHSMHS040.ehs.local>
 <20130320185051.GA28349@pengutronix.de>
 <20130321091531.GN20530@pengutronix.de>
 <cffdea50-cadf-4662-a4fb-c61ab853fc4c@VA3EHSMHS014.ehs.local>
 <20130327013703.4014.45615@quantum>
 <4b6b9df8-e221-4e52-82d3-efdcd5de9bd1@AM1EHSMHS021.ehs.local>
Message-ID: <20130403003830.8177.40547@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting S?ren Brinkmann (2013-04-01 16:24:12)
> On Tue, Mar 26, 2013 at 06:37:03PM -0700, Mike Turquette wrote:
> > Quoting S?ren Brinkmann (2013-03-26 15:45:22)
> > > On Thu, Mar 21, 2013 at 10:15:31AM +0100, Uwe Kleine-K?nig wrote:
> > > > Hello,
> > > > 
> > > > On Wed, Mar 20, 2013 at 07:50:51PM +0100, Sascha Hauer wrote:
> > > > > On Wed, Mar 20, 2013 at 09:32:51AM -0700, S?ren Brinkmann wrote:
> > > > > > If the caller
> > > > > > doesn't like the returned frequency he can request a different one.
> > > > > > And he's eventually happy with the return value he calls
> > > > > > clk_set_rate() requesting the frequency clk_round_rate() returned.
> > > > > > Always rounding down seems a bit odd to me.
> > > > > > 
> > > > > > Another issue with the current implmentation:
> > > > > > clk_divider_round_rate() calls clk_divider_bestdiv(), which uses the ROUND_UP macro, returning a rather low frequency.
> > > > > 
> > > > > And that is correct. clk_divider_bestdiv is used to calculate the
> > > > > maximum parent frequency for which a given divider value does not
> > > > > exceed the desired rate.
> > > > The reason for that is that the (more?) usual constraint is like: This
> > > > mmc card can handle up to 100 MHz. Or this i2c device can handle up to
> > > > this and that frequency. Of course there are different constraints, e.g.
> > > > for a UART if the target baud speed is 38400 you better run at 38402
> > > > than at 19201.
> > > > 
> > > > I wonder if it depends on the clock if you want "best approximation <=
> > > > requested value" or "best approximation" or on the caller. In the former
> > > > case a flag for the clock would be the right thing (as suggested in this
> > > > thread). If however it's the caller of round_rate who knows better which
> > > > rounding is preferred than better extend the clk API.
> > > > 
> > > > Extending the API could just be a convenience function that doesn't
> > > > affect the implementations of the clk API. E.g.:
> > > > 
> > > >       long clk_round_rate_nearest(struct clk *clk, unsigned long rate)
> > > >       {
> > > >               long lower_limit = clk_round_rate(clk, rate);
> > > >               long upper_limit = clk_round_rate(clk, rate + (rate - lower_limit));
> > > > 
> > > >               if (rate - lower_limit < upper_limit - rate)
> > > >                       return lower_limit;
> > > >               else
> > > >                       return upper_limit;
> > > >       }
> > > > 
> > > I guess both approaches may work. Anybody has a preference?
> > > 
> > 
> > A dedicated function like the one Uwe defined is better than adding
> > subtlety to the existing clk_round_rate via a flag in a clock driver.
> I looked at my problem again.
> 
> A new API function is probably fine for UART, ethernet drivers and
> similar. Although, compared to a flag it would add some redundant
> rounding, since clk_set_rate() implicitly also rounds the rate.
>         clk_set_rate()
>                 clk_calc_new_rates()
>                         clk_round_rate()
> But that is true for every driver which doesn't blindly call
> clk_set_rate() and checks upfront through clk_round_rate() what
> the actual frequency would look like.
> 
> So, do we agree to add this additional clk_round_rate_nearest()
> function?

Cc'ing Russell if he has any comments on adding clk_round_rate_nearest,
since he is author of the original clk api.

Regards,
Mike

> And if, should I just make Uwe's proposal another patch, additionally to
> the other clk-divider change I'm working on?
> Or Uwe, do you prefer to submit it yourself?
> 
> 
> For my original problem, though, this is only part of a solution. It
> appeared to be a rounding issue, but the actual root cause is the loss
> of resolution when OPPs are converted to a frequency table for cpufreq.
> I'm not sure how this can be resolved, yet.
> 
> 
>         S?ren
