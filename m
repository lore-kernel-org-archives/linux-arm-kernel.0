From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 20 May 2014 09:51:58 +0200
Subject: [RFC PATCH 2/5] clk: Introduce 'clk_round_rate_nearest()'
In-Reply-To: <df742b46-c630-49ea-b234-4d746bb66ec1@BL2FFO11FD040.protection.gbl>
References: <1400106655-22465-1-git-send-email-soren.brinkmann@xilinx.com>
 <1400106655-22465-3-git-send-email-soren.brinkmann@xilinx.com>
 <20140515073816.GI16662@pengutronix.de>
 <91822600-39d0-4e71-b0f5-9eda35b76ec0@BN1AFFO11FD016.protection.gbl>
 <20140519161949.GG16662@pengutronix.de>
 <db8633e5-01a9-4d3a-80e8-74e23a456d52@BN1BFFO11FD051.protection.gbl>
 <df742b46-c630-49ea-b234-4d746bb66ec1@BL2FFO11FD040.protection.gbl>
Message-ID: <20140520075158.GK16662@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, May 19, 2014 at 10:29:05AM -0700, S?ren Brinkmann wrote:
> With the improvements suggested by you I have this now:
> 
> long clk_round_rate_nearest(struct clk *clk, unsigned long rate)
> {
> 	unsigned long lower, upper;
> 
> 	lower = clk_round_rate(clk, rate);
> 	if (lower >= rate)
> 		return lower;
> 
> 	upper = clk_round_rate(clk, rate + (rate - lower) - 1);
> 	if (upper == lower)
> 		return upper;
> 
> 	lower = rate + 1;
> 	while (lower < upper) {
> 		unsigned long rounded, mid;
> 
> 		mid = lower + ((upper - lower) >> 1);
> 		rounded = clk_round_rate(clk, mid);
> 		if (rounded < lower)
> 			lower = mid + 1;
> 		else
> 			upper = rounded;
> 	}
> 
> 	return upper;
> }
This is nearly my version now. I just lacks the overflow check when
calculating upper and I skipped the early return if (upper == lower).
(Instead the while condition evaluates to false on the first hit and
returns with the same result.)

Other than that I added a few comments. :-)

Something we still should resolve is the return type. It should match
clk_round_rate, but should both be signed or unsigned? 

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
