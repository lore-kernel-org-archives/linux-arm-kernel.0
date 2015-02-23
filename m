From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 23 Feb 2015 08:32:58 +0100
Subject: [PATCH 1/3] clk: divider: fix calculation of maximal parent rate
 for a given divider
In-Reply-To: <1424515225-6929-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20150221085620.GV19388@pengutronix.de>
 <1424515225-6929-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1424515225-6929-2-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20150223073258.GJ12209@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 21, 2015 at 11:40:23AM +0100, Uwe Kleine-K?nig wrote:
> The rate provided at the output of a clk-divider is calculated as:
> 
> 	DIV_ROUND_UP(parent_rate, div)
> 
> since commit b11d282dbea2 (clk: divider: fix rate calculation for
> fractional rates). So to yield a rate not bigger than r parent_rate
> must be <= r * div.
> 
> The effect of choosing a parent rate that is too big as was done before
> this patch results in wrongly ruling out good dividers.
> 
> Note that this is not a complete fix as __clk_round_rate might return a
> value >= its 2nd parameter. Also for dividers with
> CLK_DIVIDER_ROUND_CLOSEST set the calculation is not accurate. But this
> fixes the test case by Sascha Hauer that uses a chain of three dividers
> under a fixed clock.
> 
> Fixes: b11d282dbea2 (clk: divider: fix rate calculation for fractional rates)
> Suggested-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

This gives clk_round_rate/clk_set_rate on dividers a consistent
behaviour. Also the testcases I posted seem to work fine.

The only thing that might not be nice is that when a divider can only
output fractional rates then the next higher integer value has to be used
for clk_round_rate/clk_set_rate. A consumer should probably make no
assumptions whether 333.333Hz is rounded up or down and use 334Hz to be
sure anyway.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
