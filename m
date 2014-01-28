From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Jan 2014 10:32:53 +0000
Subject: [PATCH] clk: divider: fix rate calculation for fractional rates
In-Reply-To: <52E76E3A.8030807@ti.com>
References: <1383736008-22764-1-git-send-email-tomi.valkeinen@ti.com>
 <20131106111534.GW16735@n2100.arm.linux.org.uk> <527A2C9C.4080409@ti.com>
 <20131106161911.GA16735@n2100.arm.linux.org.uk> <52E76E3A.8030807@ti.com>
Message-ID: <20140128103253.GD15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 28, 2014 at 10:45:46AM +0200, Tomi Valkeinen wrote:
> Russell, I'd like to understand why you think the original example is bad:
> 
> 	rate = clk_round_rate(clk, rate);
> 	clk_set_rate(clk, rate);

It's needlessly wasteful.  All the processing for setting the rate is
repeated.

> If the definition of clk_round_rate is basically "clk_set_rate without
> actually setting the rate", I agree that the above code is not good as
> it might not work correctly.
> 
> However, if  the following code you gave should work:
> 
> 	rate = clk_get_rate(clk);
> 	clk_set_rate(clk, rate);
> 	assert(clk_get_rate(clk) == rate);
> 
> then the original example should also always work, as it's almost the
> same as:
> 
> 	/* this is the "round" part */
> 	clk_set_rate(clk, rate);
> 	rate = clk_get_rate(clk);
> 
> 	clk_set_rate(clk, rate);
> 	assert(clk_get_rate(clk) == rate);

Okay, now ask yourself this - would you code the above into your driver
with no processing between the two?  It seems that some people would!

> Why I'm asking this is that for me (and probably for others also if
> you've seen it used in the kernel code) it feels natural to have code like:
> 
> 	rate = clk_round_rate(clk, rate);
> 	
> 	/* Verify the rounded rate here to see it's ok for the IP etc */
> 
> 	/* The rate is ok, so set it */
> 	clk_set_rate(clk, rate);

If you want to do something with the rounded rate, then that's fine,
you have a reason to do it this way.  However, what I was referring to
are drivers which literally do this:

	clk_set_rate(clk, clk_round_rate(clk, rate));

In other words, they think that they must always round the rate before
passing it into clk_set_rate() even though they make no other use of
the rounded rate.  That is completely wasteful and unnecessary.  It
might as well have clk_round_rate() replaced by a udelay() to waste
some CPU cycles just for the hell of it.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
