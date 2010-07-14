From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Jul 2010 21:03:24 +0100
Subject: Meaning of clk_round_rate()?
In-Reply-To: <4C3DFC7A.8020002@codeaurora.org>
References: <4C3DFC7A.8020002@codeaurora.org>
Message-ID: <20100714200324.GA18138@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 14, 2010 at 11:05:46AM -0700, Stephen Boyd wrote:
>  What is the meaning of clk_round_rate() in the clk API  
> (include/linux/clk.h)? The function documentation says "adjust a rate to  
> the exact rate a clock can provide". That seems pretty vague. I'm lead  
> to believe that it rounds the rate to the closest rate supported. Is  
> that correct? Is there some sort of error margin where beyond that it's  
> no longer possible to be rounded? 0.5%? 1%?

clk_round_rate() returns the clock rate which will be set if you ask
clk_set_rate() to set that rate.  It provides a way to query from
the implementation exactly what rate you'll get if you use clk_set_rate()
with that same argument.

So essentially, clk_set_rate() should be:

static int clk_set_rate(struct clk *clk, unsigned long rate)
{
	rate = clk_round_rate(clk, rate);
	return set_actual_rate(clk, rate);
}
