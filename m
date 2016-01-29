From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 29 Jan 2016 11:54:55 -0800
Subject: [PATCH 2/2] clk: defer clk_gets on orphan clocks
In-Reply-To: <7262598.5pX8AAxUPK@diego>
References: <1453385439-10154-1-git-send-email-emilio.lopez@collabora.co.uk>
 <1453385958-11366-1-git-send-email-emilio.lopez@collabora.co.uk>
 <20160128082324.GG12841@codeaurora.org> <7262598.5pX8AAxUPK@diego>
Message-ID: <20160129195455.GQ12841@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28, Heiko St?bner wrote:
> Am Donnerstag, 28. Januar 2016, 00:23:24 schrieb Stephen Boyd:
> > On 01/21, Emilio L?pez wrote:
> > > @@ -3059,7 +3069,25 @@ struct clk *__of_clk_get_from_provider(struct
> > > of_phandle_args *clkspec,> 
> > >   */
> > >  
> > >  struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec)
> > >  {
> > > 
> > > -	return __of_clk_get_from_provider(clkspec, NULL, __func__);
> > > +	return __of_clk_get_from_provider(clkspec, NULL, __func__, false);
> > > +}
> > > +
> > > +/**
> > > + * of_clk_get_from_provider_with_orphans() - Lookup clock from a clock
> > > provider + * @clkspec: pointer to a clock specifier data structure
> > > + *
> > > + * This function looks up a struct clk from the registered list of clock
> > > + * providers, an input is a clock specifier data structure as returned
> > > + * from the of_parse_phandle_with_args() function call.
> > > + *
> > > + * The difference to of_clk_get_from_provider() is that this function
> > > will
> > > + * also successfully lookup orphan-clocks, as it in some cases may be
> > > + * necessary to access such orphan-clocks as well.
> > > + */
> > > +struct clk *
> > > +of_clk_get_from_provider_with_orphans(struct of_phandle_args *clkspec)
> > 
> > Dislike. In fact, the whole clk conf approach is odd here. When
> > we're doing of_clk_init() we do a best effort loop around
> > parent_ready(), waiting for clk providers to register as long as
> > we have a clocks property in our provider node. We should do
> > something similar in the non of_clk_init() case too, because
> > of_clk_init() isn't special.
> 
> At least to me being able to reparent orphan clocks when knowing that they 
> won't ever get supplied is special.
> 
> The Rockchip clock controller has quite a number of clocks that can either be 
> supplied by some external source. xin32k supplied by some i2c chip being the 
> most prominent. But while this one will get supplied eventually, there are 
> others who will never get a supply and stay orphans forever.
> 
> Example:
> rk3288 sclk_edp_24m can get supplied by either the general 24MHz oscillator or 
> some separate clock input connected some chip pin. Reset-default seems to be 
> the external supply, but on all boards I've seen so far doesn't get connected.
> 
> So we know on a per-board level if this is connected and want to move away 
> from the non-existent source. Which is why the limit of this new function is 
> limited to be ccf internal and the assigned-clock-parents path.

Right, this problem isn't limited to clk-conf though. If some
clock is orphaned by its reset default, then consumers that want
to reparent them to something else will never be able to get the
clocks without some sort of clk_get_ignore_orphan() API. We can't
rely on DTS files telling us to do the reparent. This is a whole
other problem to be dealt with before we can defer clk_get()
orphans.

In this case, I wonder why we haven't specified some sort of
"ground" clock that has a rate of 0? In the example above, I
would imagine that we have our dts file specify a fixed rate
clock with frequency of 0 that's named whatever the external
supply clock is named when that pin isn't connected.

> 
> 
> I guess if you really dislike that approach the other option would be 
> reparenting all the time in the clock-controller driver and then let the 
> board-dts reparent back if needed. Which would also work for that clock, but 
> may cause other glitches down the road when it affects some pre-setup things.
> 
> 

For all we know that could cause some audio pop on a speaker 
something. Let's avoid this if we can.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
