From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Sat, 21 Feb 2015 11:40:22 +0100
Subject: [PATCH 0/3] clk: divider: three exactness fixes (and a rant)
In-Reply-To: <20150221085620.GV19388@pengutronix.de>
References: <20150221085620.GV19388@pengutronix.de>
Message-ID: <1424515225-6929-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

TLDR: only apply patch 1 and rip of CLK_DIVIDER_ROUND_CLOSEST.

I stared at clk-divider.c for some time now given Sascha's failing test
case. I found a fix for the failure (which happens to be what Sascha
suspected).

The other two patches fix problems only present when handling dividers
that have CLK_DIVIDER_ROUND_CLOSEST set. Note that these are still
heavily broken however. So having a 4bit-divider and a parent clk of
10000 (as in Sascha's test case) requesting

	clk_set_rate(clk, 666)

sets the rate to 625 (div=15) instead of 667 (div=16). The reason is the
choice of parent_rate in clk_divider_bestdiv's loop is wrong for
CLK_DIVIDER_ROUND_CLOSEST (with and without patch 1). A fix here is
non-trivial and for sure more than one rate must be tested here. This is
complicated by the fact that clk_round_rate might return a value bigger
than the requested rate which convinces me (once more) that it's a bad
idea to allow that. Even if this was fixed for .round_rate,
clk_divider_set_rate is still broken because it also uses

	div = DIV_ROUND_UP(parent_rate, rate);

to calculate the (pretended) best divider to get near rate.

Note this makes at least two reasons to remove support for
CLK_DIVIDER_ROUND_CLOSEST!

Instead I'd favour creating a function

	clk_round_rate_nearest

as was suggested some time ago by Soren Brinkmann and me[1] that doesn't
need any clk type specific knowledge. This would mean that not the
divider (or clk in general) would have to know that returning a slightly
bigger rate than requested is OK but the caller which is fine (and even
better) in my eyes. This would simplify clk-divider.c (and probably
others) and give support for "nearest match" for all clock types without
type specific implementation. (Note that it might even make sense to use
a different metric for "nearest", instead of minimizing

	abs(target - rate)

you might want to minimize

	abs(target / rate - 1)

instead.

Converting the clk framework to 64 bit rates was discussed earlier
already, too, and I wonder if we should fix rounding issues (a bit) in
the same transition such that 

	clk_set_rate(clk, 333)

allows the clk to be set to 333.3333333333 Hz and let clk_get_rate
return 333 in this case.

Also I'd vote to return 0 or -ESOMETHING if a requested rate is too low
to be set. This would simplify some special casing I think and makes the
request

	clk_round_rate(clk, x) <= x

consistent.

Best regards
Uwe

[1] https://lkml.org/lkml/2014/5/14/698

Uwe Kleine-K?nig (3):
  clk: divider: fix calculation of maximal parent rate for a given
    divider
  clk: divider: fix selection of divider when rounding to closest
  clk: divider: fix calculation of initial best divider when rounding to
    closest

 drivers/clk/clk-divider.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

-- 
2.1.4
