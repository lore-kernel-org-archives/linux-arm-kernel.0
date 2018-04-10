From: marcin@ziemianowicz.com (Marcin Ziemianowicz)
Date: Mon, 9 Apr 2018 20:16:49 -0400
Subject: [PATCH v2 2/2] clk: at91: Fix for PLL set_rate changes not being
 actually written to PLL peripheral bits
Message-ID: <20180410001649.GA62245@hak8or>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a USB device is connected to the USB host port on the SAM9N12 then
you get "-62" error which seems to indicate USB replies from the device
are timing out. Looking around, I saw the USB bus was running at half
speed. Going further, it seems that in ..._set_rate() the PLL wasn't
actually being adjusted. Writing the multiplier and divider values to
the peripheral fixes the bus running at half speed.

Signed-off-by: Marcin Ziemianowicz <marcin@ziemianowicz.com>
---
 drivers/clk/at91/clk-pll.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/at91/clk-pll.c b/drivers/clk/at91/clk-pll.c
index 534961766ae5..db7155fe9346 100644
--- a/drivers/clk/at91/clk-pll.c
+++ b/drivers/clk/at91/clk-pll.c
@@ -288,6 +288,14 @@ static int clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	pll->div = div;
 	pll->mul = mul;
 
+	// Set the PLL as per above div and mil values.
+	regmap_update_bits(pll->regmap, AT91_CKGR_PLLBR,
+		AT91_PMC_DIV | AT91_PMC_MUL,
+		(div << 0) | (mul << 16));
+
+	pr_debug("clk-pll: setting new rate, (%lu hz / %u) * %u = %lu hz\n",
+		parent_rate, div, mul, rate);
+
 	return 0;
 }
 
-- 
2.17.0
