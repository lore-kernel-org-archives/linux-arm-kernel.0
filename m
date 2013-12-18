From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 18 Dec 2013 12:10:35 -0800
Subject: [PATCHv6 2/5] clk: socfpga: Add a clock type for the SD/MMC driver
In-Reply-To: <2899559.jbTzDM2qtE@dizzy-6.site>
References: <1386880245-10192-1-git-send-email-dinguyen@altera.com>
 <20131215045116.23538.4@quantum> <52AF68DB.7090105@elopez.com.ar>
 <2899559.jbTzDM2qtE@dizzy-6.site>
Message-ID: <20131218201035.23538.60602@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting David Lanzend?rfer (2013-12-16 13:54:21)
> Hi
> > that takes the MMC clock (and only the MMC clock) and does the setup
> > (it's basically configuring two values, "sample" and "output", into the
> > clock register). I really don't know what does this do/why is it
> > required/when is it used; I'm cc'ing Hans and David who can hopefully
> > explain that part.
> Since the read/write operations have to happen asynchronously and in a manner
> so that the data provided by the SD-Card can be fetched on time, a specific
> clock phase shift is required as you can see in the linked picture[1].
> That's what the function is doing: It accesses the special registers of the
> MMC clock device and configures this phase offset.

Yeah, clock phase is a fairly common thing to tune but there are two
things to consider when crafting a new api like clk_set_phase(...):

1) are we adjusting the phase of the clock signal or the phase of
something else related to the clock rate? This is just something to
think about. Sometimes it would be better to have
video_signal_set_phase() instead of clk_set_phase().

2) what is the input parameter to clk_set_phase? I guess the two best
options are degrees (zero to 359), or a fraction of the clock period
(1/4, 1/2, etc).

Any thoughts?

Regards,
Mike

> 
> > I also saw a similar requirement from the gmac people (on cc too), who
> > needed to set the phy type (or something like that) on one of the clock
> > registers; so I'm thinking maybe a generic "tune something" approach
> > that lets users configure some clock-dependent, arbitrary aspect of the
> > clock is the way forward. Otherwise, we're going to end up bloating the
> > clock framework with a lot of callback pointers that are going to be
> > used in one or two clocks out of potentially hundreds on the whole system.
> It totally makes sense, since GMAC will be doing asynchrous
> operations as well.
> 
> -David
> 
> [1] http://www.chipestimate.com/techtalk/images/11022010_fig2_3.JPG
