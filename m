From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 30 Jun 2014 17:12:23 -0700
Subject: [PATCH 1/4] clk: Introduce 'clk_find_nearest_rate()'
In-Reply-To: <20140630212707.1eb44db6@bbrezillon>
References: <1404147396-8041-1-git-send-email-soren.brinkmann@xilinx.com>
 <1404147396-8041-2-git-send-email-soren.brinkmann@xilinx.com>
 <20140630212707.1eb44db6@bbrezillon>
Message-ID: <475a8ee0-11aa-4fad-94dc-9e5360f298d2@BL2FFO11FD028.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On Mon, 2014-06-30 at 09:27PM +0200, Boris BREZILLON wrote:
> Hello Soren,
> 
> On Mon, 30 Jun 2014 09:56:33 -0700
> Soren Brinkmann <soren.brinkmann@xilinx.com> wrote:
> 
> > Introduce a new API function to find the rate a clock can provide
> > which is closest to a given rate.
> > 
> > clk_round_rate() leaves it to the clock driver how rounding is done.
> > Commonly implementations round down due to use-cases that have a
> > certain frequency maximum that must not be exceeded.
> 
> I had the same concern (how could a driver decide whether it should
> round up, down or to the closest value), but had a slightly different
> approach in mind.
> 
> AFAIU, you're assuming the clock is always a power of two (which is
> true most of the time, but some clock implementation might differ,
> i.e. a PLL accept any kind of multiplier not necessarily a power of 2).

No, the idea is to always work. There should not be any such limitation.
Where do you see that?

> 
> How about improving the clk_ops interface instead by adding a new method
> 
> 	long (*round_rate_with_constraint)(struct clk_hw *hw,
> 					   unsigned long requested_rate,
> 					   unsigned long *parent_rate,
> 					   enum clk_round_type type);
> 
> with
> 
> enum clk_round_type {
> 	CLK_ROUND_DOWN,
> 	CLK_ROUND_UP,
> 	CLK_ROUND_CLOSEST,
> };

I thought about that, but the find_nearest() did already exist more or
less and in the end it is not much of a difference, IMHO. If it turns out that
the others are needed as well and somebody implements it, they could be
added as another convenience function like I did, and/or it could be
wrapped in the function you propose here.

> 
> or just adding these 3 methods:
> 
> 	long (*round_rate_up)(struct clk_hw *hw,
> 			      unsigned long requested_rate,
> 			      unsigned long *parent_rate);
> 
> 	long (*round_rate_down)(struct clk_hw *hw,
> 				unsigned long requested_rate,
> 				unsigned long *parent_rate);
> 
> 	long (*round_rate_closest)(struct clk_hw *hw,
> 				   unsigned long requested_rate,
> 				   unsigned long *parent_rate);

That would be quite a change for clock drivers. So far, there are not many
restrictions on round_rate. I think there has already been a discussion
in this direction that went nowhere. https://lkml.org/lkml/2010/7/14/260

> 
> and let the round_rate method implement the default behaviour.

There is no real default. Rounding is not specified for the current API.

> 
> This way you could add 3 functions to the API:
> 
> clk_round_closest (or clk_find_nearest_rate as you called it),
> clk_round_up and clk_round_down, and let the clk driver implementation
> return the appropriate rate.

I'd say the current patch set does kind of align with that, doesn't it?
We can add the find_nearest_rate() (there was a discussion on the name,
ane we decided against round_closest in favor of the current proposal)
now and the other functions could be added later if people find them to
be useful. And if they all get added we can think about consolidating
them if it made sense.

	Thanks,
	S?ren
