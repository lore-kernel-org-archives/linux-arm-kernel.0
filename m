From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 23 Feb 2015 08:23:04 +0100
Subject: [PATCH 0/3] clk: divider: three exactness fixes (and a rant)
In-Reply-To: <1424515225-6929-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20150221085620.GV19388@pengutronix.de>
 <1424515225-6929-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20150223072304.GI12209@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 21, 2015 at 11:40:22AM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> TLDR: only apply patch 1 and rip of CLK_DIVIDER_ROUND_CLOSEST.
> 
> I stared at clk-divider.c for some time now given Sascha's failing test
> case. I found a fix for the failure (which happens to be what Sascha
> suspected).
> 
> The other two patches fix problems only present when handling dividers
> that have CLK_DIVIDER_ROUND_CLOSEST set. Note that these are still
> heavily broken however. So having a 4bit-divider and a parent clk of
> 10000 (as in Sascha's test case) requesting
> 
> 	clk_set_rate(clk, 666)
> 
> sets the rate to 625 (div=15) instead of 667 (div=16). The reason is the
> choice of parent_rate in clk_divider_bestdiv's loop is wrong for
> CLK_DIVIDER_ROUND_CLOSEST (with and without patch 1). A fix here is
> non-trivial and for sure more than one rate must be tested here. This is
> complicated by the fact that clk_round_rate might return a value bigger
> than the requested rate which convinces me (once more) that it's a bad
> idea to allow that. Even if this was fixed for .round_rate,
> clk_divider_set_rate is still broken because it also uses
> 
> 	div = DIV_ROUND_UP(parent_rate, rate);
> 
> to calculate the (pretended) best divider to get near rate.
> 
> Note this makes at least two reasons to remove support for
> CLK_DIVIDER_ROUND_CLOSEST!
> 
> Instead I'd favour creating a function
> 
> 	clk_round_rate_nearest

Full ack. It's a clock consumer who wants to decide the rounding
strategy, not the clock itself and for sure not a specific entity of the
clock tree. CLK_DIVIDER_ROUND_CLOSEST should be dropped.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
