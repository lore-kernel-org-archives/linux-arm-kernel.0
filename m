From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 06 Mar 2015 11:40:39 -0800
Subject: [PATCH 0/3] clk: divider: three exactness fixes (and a rant)
In-Reply-To: <20150306192813.GG10717@pengutronix.de>
References: <20150221085620.GV19388@pengutronix.de>
 <1424515225-6929-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150306185730.11109.45998@quantum> <20150306192813.GG10717@pengutronix.de>
Message-ID: <54FA02B7.8090703@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/15 11:28, Uwe Kleine-K?nig wrote:
> Hello Mike,
>
> On Fri, Mar 06, 2015 at 10:57:30AM -0800, Mike Turquette wrote:
>> Quoting Uwe Kleine-K?nig (2015-02-21 02:40:22)
>>> Hello,
>>>
>>> TLDR: only apply patch 1 and rip of CLK_DIVIDER_ROUND_CLOSEST.
>>>
>>> I stared at clk-divider.c for some time now given Sascha's failing test
>>> case. I found a fix for the failure (which happens to be what Sascha
>>> suspected).
>>>
>>> The other two patches fix problems only present when handling dividers
>>> that have CLK_DIVIDER_ROUND_CLOSEST set. Note that these are still
>>> heavily broken however. So having a 4bit-divider and a parent clk of
>>> 10000 (as in Sascha's test case) requesting
>>>
>>>         clk_set_rate(clk, 666)
>>>
>>> sets the rate to 625 (div=15) instead of 667 (div=16). The reason is the
>>> choice of parent_rate in clk_divider_bestdiv's loop is wrong for
>>> CLK_DIVIDER_ROUND_CLOSEST (with and without patch 1). A fix here is
>>> non-trivial and for sure more than one rate must be tested here. This is
>>> complicated by the fact that clk_round_rate might return a value bigger
>>> than the requested rate which convinces me (once more) that it's a bad
>>> idea to allow that. Even if this was fixed for .round_rate,
>>> clk_divider_set_rate is still broken because it also uses
>>>
>>>         div = DIV_ROUND_UP(parent_rate, rate);
>>>
>>> to calculate the (pretended) best divider to get near rate.
>>>
>>> Note this makes at least two reasons to remove support for
>>> CLK_DIVIDER_ROUND_CLOSEST!
>>>
>>> Instead I'd favour creating a function
>>>
>>>         clk_round_rate_nearest
>>>
>>> as was suggested some time ago by Soren Brinkmann and me[1] that doesn't
>> Uwe,
>>
>> Thanks for the fixes. I'm thinking of taking all three for 4.0. I also
>> agree on clk_round_rate_nearest (along with a _ceil and _floor version
>> as well). That's something we can do for 4.1 probably.
> I'd say that we make round_rate the _floor version. I guess in most
> cases that already does the right thing. Also I think 4.1 is very
> ambitious, so my suggestion for 4.1 is:
>
>  - add a WARN_ON_ONCE to clk_round_rate catching calls that return a
>    value bigger than requested.
>  - implement clk_round_rate_nearest using clk_round_rate and the
>    assumption that it returns a value that is <= the requested rate.
>    I think without that there are too many special cases to handle and
>    probably not even a reliable way to determine the nearest rate.
>  - while we're at it tightening the requirements for clk_round_rate
>    let's also specify the expected rounding. I'd vote for the
>    mathematical rounding, that is
>
>    	clk_round_rate(someclk, 333)
>
>    explicitly is allowed to return a rate bigger than 333 as long as it
>    is less than 333.5.
>
> At one point while developing patch 1 I had the dividers fixed for the
> rounding issue. I think I still have that patch somewhere so can post it
> as RFC.
>

Why do we need clk_round_rate_nearest? We have rate constraints now so
drivers should be moving towards requesting a rate that's within a
tolerance they can accept if they even care to enforce anything like
that. Eventually clk_round_rate() returning a value smaller or larger
than what it's called with won't matter as long as what the
implementation does fits within the constraints that consumers specify.
It may even be possible to remove clk_round_rate() as a consumer API.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
