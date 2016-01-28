From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 27 Jan 2016 23:56:21 -0800
Subject: [PATCH v2 03/26] clk: Add regmap support
In-Reply-To: <1452785109-6172-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1452785109-6172-1-git-send-email-maxime.ripard@free-electrons.com>
 <1452785109-6172-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160128075621.GF12841@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/14, Maxime Ripard wrote:
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> Some devices like SoCs from Mediatek need to use the clock
> through a regmap interface.
> This patch adds regmap support for the simple multiplexer clock,
> the divider clock and the clock gate code.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Nak.

The whole anonymous union thing and clk-io.c file is not
appealing at all. I'd prefer we remove clk_readl/writel, not add
to it. Plus we're bloating the basic clock types and adding a
bunch of parallel registration APIs to assign a regmap pointer.
Really, let's stop adding stuff to the basic clock types, it's
getting out of hand.

To move forward on making regmap clks generic for everyone, let's
make sure that regmap clk code is a library that any driver can
use. No OF_CLK_DECLARE should exist because it doesn't make any
sense. No clk_register_regmap_{div,mux,gate}() functions, just a
clk_register_regmap() function to assign the regmap pointer from
the device. Drivers that want to use the code should need to
select a Kconfig symbol, so that we don't compile in support for
regmap clocks unless we really need them.

If we had a clk_regmap structure with a regmap pointer and a
clk_hw inside it I think that's all we would need. Once we had
that, we could let driver writers wrap that in their own
structures for dividers, muxes, gates, etc. and then have them
call library functions from their clk_ops that takes a regmap (or
clk_regmap struct), and offset to do the get_div/set_div,
get_parent/set_parent, enable/disable stuff.

The policy part can be shared with the basic clock types, because
we've already started libifying them. For example, we can ask the
divider code what the hardware value should be for a particular
divider type and it will tell us without writing any registers.
I had a patch for libifying muxes, not sure where it went. The
point being to leave the I/O part to the regmap code without
putting it behind another layer of indirection buried inside the
basic types. Make things flat and easy to follow.

I haven't thought through making new structs to hold the data for
offsets, masks, etc. but I guess we would want those so that we
could assign functions directly to clk_ops and not require any
boiler plate clk_ops implementations in drivers. There are a few
approaches here: different regmap structs for different basic
types, one mega struct that combines all the needs of the basic
types, or some private void pointer inside struct clk_regmap that
points to different basic type structs. Let's see how that goes.

Maybe we can lift drivers/clk/qcom/clk-regmap.c up into the
drivers/clk/ directory too. In the qcom design I put the
enable/disable bits (gate functionality) directly into the
clk_regmap structure. That may need some more thought if it was
the right idea to force enable/disable on every regmap clock
though. If we remove that and introduce a clk_regmap_gate things
should turn out alright.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
