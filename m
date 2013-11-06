From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Nov 2013 11:15:34 +0000
Subject: [PATCH] clk: divider: fix rate calculation for fractional rates
In-Reply-To: <1383736008-22764-1-git-send-email-tomi.valkeinen@ti.com>
References: <1383736008-22764-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <20131106111534.GW16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 06, 2013 at 01:06:48PM +0200, Tomi Valkeinen wrote:
> This means that the following code works a bit oddly:
> 
> rate = clk_round_rate(clk, 123428572);
> clk_set_rate(clk, rate);

You're right, but the above sequence is quite a crass thing to do.  Why?

clk_round_rate() returns the clock rate that clk_set_rate() would give
you if you were to use this sequence:

	clk_rate_rate(clk, 123428572);
	rate = clk_get_rate(clk);

The difference is that it doesn't change the actual clock rate itself;
clk_round_rate() is meant to answer the question:

	"If I were to set _this_ rate, what clock rate would
	 the clock give me?"

thereby providing a method for drivers to inquire what the effect would
be when changing such a clock without actually affecting it.

So please, don't use clk_round_rate() followed by clk_set_rate().
