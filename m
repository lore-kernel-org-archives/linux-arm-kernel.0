From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 26 Mar 2013 18:37:03 -0700
Subject: [PATCH] clk: divider: Use DIV_ROUND_CLOSEST
In-Reply-To: <cffdea50-cadf-4662-a4fb-c61ab853fc4c@VA3EHSMHS014.ehs.local>
References: <20130320001609.8663.21043@quantum>
 <f3ff0545-52cd-4b7b-967e-f81324ba0152@CH1EHSMHS040.ehs.local>
 <20130320185051.GA28349@pengutronix.de>
 <20130321091531.GN20530@pengutronix.de>
 <cffdea50-cadf-4662-a4fb-c61ab853fc4c@VA3EHSMHS014.ehs.local>
Message-ID: <20130327013703.4014.45615@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting S?ren Brinkmann (2013-03-26 15:45:22)
> On Thu, Mar 21, 2013 at 10:15:31AM +0100, Uwe Kleine-K?nig wrote:
> > Hello,
> > 
> > On Wed, Mar 20, 2013 at 07:50:51PM +0100, Sascha Hauer wrote:
> > > On Wed, Mar 20, 2013 at 09:32:51AM -0700, S?ren Brinkmann wrote:
> > > > If the caller
> > > > doesn't like the returned frequency he can request a different one.
> > > > And he's eventually happy with the return value he calls
> > > > clk_set_rate() requesting the frequency clk_round_rate() returned.
> > > > Always rounding down seems a bit odd to me.
> > > > 
> > > > Another issue with the current implmentation:
> > > > clk_divider_round_rate() calls clk_divider_bestdiv(), which uses the ROUND_UP macro, returning a rather low frequency.
> > > 
> > > And that is correct. clk_divider_bestdiv is used to calculate the
> > > maximum parent frequency for which a given divider value does not
> > > exceed the desired rate.
> > The reason for that is that the (more?) usual constraint is like: This
> > mmc card can handle up to 100 MHz. Or this i2c device can handle up to
> > this and that frequency. Of course there are different constraints, e.g.
> > for a UART if the target baud speed is 38400 you better run at 38402
> > than at 19201.
> > 
> > I wonder if it depends on the clock if you want "best approximation <=
> > requested value" or "best approximation" or on the caller. In the former
> > case a flag for the clock would be the right thing (as suggested in this
> > thread). If however it's the caller of round_rate who knows better which
> > rounding is preferred than better extend the clk API.
> > 
> > Extending the API could just be a convenience function that doesn't
> > affect the implementations of the clk API. E.g.:
> > 
> >       long clk_round_rate_nearest(struct clk *clk, unsigned long rate)
> >       {
> >               long lower_limit = clk_round_rate(clk, rate);
> >               long upper_limit = clk_round_rate(clk, rate + (rate - lower_limit));
> > 
> >               if (rate - lower_limit < upper_limit - rate)
> >                       return lower_limit;
> >               else
> >                       return upper_limit;
> >       }
> > 
> I guess both approaches may work. Anybody has a preference?
> 

A dedicated function like the one Uwe defined is better than adding
subtlety to the existing clk_round_rate via a flag in a clock driver.

Regards,
Mike

>         S?ren
