From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 9 Mar 2015 22:58:03 +0100
Subject: [PATCH 0/3] clk: divider: three exactness fixes (and a rant)
In-Reply-To: <20150309210735.14952.91257@quantum>
References: <20150221085620.GV19388@pengutronix.de>
 <1424515225-6929-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150306185730.11109.45998@quantum>
 <20150306192813.GG10717@pengutronix.de>
 <54FA02B7.8090703@codeaurora.org>
 <1425895136.3152.22.camel@pengutronix.de>
 <54FDEEFE.1060803@codeaurora.org>
 <20150309210735.14952.91257@quantum>
Message-ID: <20150309215803.GD7525@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 09, 2015 at 02:07:35PM -0700, Mike Turquette wrote:
> Quoting Stephen Boyd (2015-03-09 12:05:34)
> > On 03/09/15 02:58, Philipp Zabel wrote:
> > > Am Freitag, den 06.03.2015, 11:40 -0800 schrieb Stephen Boyd:
> > >> On 03/06/15 11:28, Uwe Kleine-K?nig wrote:
> > >>> Hello Mike,
> > >>>
> > >>> On Fri, Mar 06, 2015 at 10:57:30AM -0800, Mike Turquette wrote:
> > >>>> Quoting Uwe Kleine-K?nig (2015-02-21 02:40:22)
> > >>>>> Hello,
> > >>>>>
> > >>>>> TLDR: only apply patch 1 and rip of CLK_DIVIDER_ROUND_CLOSEST.
> > >>>>>
> > >>>>> I stared at clk-divider.c for some time now given Sascha's failing test
> > >>>>> case. I found a fix for the failure (which happens to be what Sascha
> > >>>>> suspected).
> > >>>>>
> > >>>>> The other two patches fix problems only present when handling dividers
> > >>>>> that have CLK_DIVIDER_ROUND_CLOSEST set. Note that these are still
> > >>>>> heavily broken however. So having a 4bit-divider and a parent clk of
> > >>>>> 10000 (as in Sascha's test case) requesting
> > >>>>>
> > >>>>>         clk_set_rate(clk, 666)
> > >>>>>
> > >>>>> sets the rate to 625 (div=15) instead of 667 (div=16). The reason is the
> > >>>>> choice of parent_rate in clk_divider_bestdiv's loop is wrong for
> > >>>>> CLK_DIVIDER_ROUND_CLOSEST (with and without patch 1). A fix here is
> > >>>>> non-trivial and for sure more than one rate must be tested here. This is
> > >>>>> complicated by the fact that clk_round_rate might return a value bigger
> > >>>>> than the requested rate which convinces me (once more) that it's a bad
> > >>>>> idea to allow that. Even if this was fixed for .round_rate,
> > >>>>> clk_divider_set_rate is still broken because it also uses
> > >>>>>
> > >>>>>         div = DIV_ROUND_UP(parent_rate, rate);
> > >>>>>
> > >>>>> to calculate the (pretended) best divider to get near rate.
> > >>>>>
> > >>>>> Note this makes at least two reasons to remove support for
> > >>>>> CLK_DIVIDER_ROUND_CLOSEST!
> > >>>>>
> > >>>>> Instead I'd favour creating a function
> > >>>>>
> > >>>>>         clk_round_rate_nearest
> > >>>>>
> > >>>>> as was suggested some time ago by Soren Brinkmann and me[1] that doesn't
> > >>>> Uwe,
> > >>>>
> > >>>> Thanks for the fixes. I'm thinking of taking all three for 4.0. I also
> > >>>> agree on clk_round_rate_nearest (along with a _ceil and _floor version
> > >>>> as well). That's something we can do for 4.1 probably.
> > >>> I'd say that we make round_rate the _floor version. I guess in most
> > >>> cases that already does the right thing. Also I think 4.1 is very
> > >>> ambitious, so my suggestion for 4.1 is:
> > >>>
> > >>>  - add a WARN_ON_ONCE to clk_round_rate catching calls that return a
> > >>>    value bigger than requested.
> > >>>  - implement clk_round_rate_nearest using clk_round_rate and the
> > >>>    assumption that it returns a value that is <= the requested rate.
> > >>>    I think without that there are too many special cases to handle and
> > >>>    probably not even a reliable way to determine the nearest rate.
> > >>>  - while we're at it tightening the requirements for clk_round_rate
> > >>>    let's also specify the expected rounding. I'd vote for the
> > >>>    mathematical rounding, that is
> > >>>
> > >>>     clk_round_rate(someclk, 333)
> > >>>
> > >>>    explicitly is allowed to return a rate bigger than 333 as long as it
> > >>>    is less than 333.5.
> > >>>
> > >>> At one point while developing patch 1 I had the dividers fixed for the
> > >>> rounding issue. I think I still have that patch somewhere so can post it
> > >>> as RFC.
> > >>>
> > >> Why do we need clk_round_rate_nearest? We have rate constraints now so
> > >> drivers should be moving towards requesting a rate that's within a
> > >> tolerance they can accept if they even care to enforce anything like
> > >> that. Eventually clk_round_rate() returning a value smaller or larger
> > >> than what it's called with won't matter as long as what the
> > >> implementation does fits within the constraints that consumers specify.
> > >> It may even be possible to remove clk_round_rate() as a consumer API.
> > > If I have to provide a panel pixel clock I usually want to get a rate as
> > > close as possible to the specified typical rate, but within the
> > > specified limits.
> > >
> > > Assume a panel with 70 MHz ideal pixel clock and a valid range of 60 MHz
> > > to 80 MHz. If the clock supply supports two frequencies within that
> > > range, 60 MHz and 72 MHz, I'd prefer 72 MHz to be chosen over 60 Mhz.
> > >
> > >
> > 
> > Hm.. Maybe we should tweak the arguments to clk_set_range() to have a
> > "typical" rate? So instead of the current API:
> > 
> >   int clk_set_rate_range(struct clk *clk, unsigned long min, unsigned
> > long max)
> > 
> > we should have
> > 
> >  int clk_set_rate_range(struct clk *clk, unsigned long min, unsigned
> > long typical, unsigned long max)
> > 
> > with the semantics that we'll set the rate within the min,max
> > constraints and try to get the rate as close to the typical rate as
> > possible? That would match quite a few datasheets out there that specify
> > these triplets.
> 
> This suffers from the same problem that round_rate has today, which is
> the question of rounding policy. When you say that we want to get as
> close as possible, how do we decide between equivalent values? We need
> to make a default policy, document it and stick to it. E.g:
> 
> clk_set_rate_range(clk, 100, 110, 120);
> 
> Let's say that round_rate gives us possible values of 108 and 112, both
> of which are two Hz away from the typical value of 110Hz. One is not
> closer than the other. Which do we choose? Let's figure out a sane
> default to the question and document it very loudly in the code.
> 
> For the sake of consistency I think we should choose the slower value
> since this is what a normal clk_round_rate should do stay within spec.
> Obviously either rate (108 or 112) would be in spec, since they are
> within the min/max range. But if a normal call to clk_round_rate should
> choose a ceiling value by default (which I think it should) then
> probably the range stuff should as well, just to keep us from confusing
> ourselves.
If you see

	round_rate(110) = 108

it would be fortunate to know if you get 108 because the next available
greater rate is > 112 or because the implementation rounds down always
(which would mean that 111 is possible, too). For the "easy" consumers
this probably doesn't matter much, but if you do things that affects
a considerable part of the clock tree, you really want to know more
about the behaviour of round_rate to effectively work with its results.

So yes, please let us pick ceiling for round_rate (i.e. a fixed policy
for all clks) and then it should even be possible to make
clk_set_rate_range a generic function that doesn't need the min and max
members in the clk struct and the respective parameters to
determine_rate.

What should a clock that can only provide 100 Hz return on

	clk_round_rate(clk, 60);

? 0? -ESOMETHING (for SOMETHING = ...?)?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
