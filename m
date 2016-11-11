From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 11 Nov 2016 18:05:57 +0800
Subject: [PATCH] clk: sunxi-ng: sun8i-a23: Set CLK_SET_RATE_PARENT for audio
 module clocks
Message-ID: <20161111100558.14629-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The audio module clocks are supposed to be set according to the sample
rate of the audio stream. The audio PLL provides the clock signal for
thees module clocks, and only it is freely tunable.

Set CLK_SET_RATE_PARENT for the audio module clocks so their users can
properly tune the clock rate.

Fixes: 5690879d93e8 ("clk: sunxi-ng: Add A23 CCU")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c b/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
index 2646d980087b..5c6d37bdf247 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
@@ -344,10 +344,10 @@ static SUNXI_CCU_MP_WITH_MUX_GATE(spi1_clk, "spi1", mod0_default_parents, 0x0a4,
 static const char * const i2s_parents[] = { "pll-audio-8x", "pll-audio-4x",
 					    "pll-audio-2x", "pll-audio" };
 static SUNXI_CCU_MUX_WITH_GATE(i2s0_clk, "i2s0", i2s_parents,
-			       0x0b0, 16, 2, BIT(31), 0);
+			       0x0b0, 16, 2, BIT(31), CLK_SET_RATE_PARENT);
 
 static SUNXI_CCU_MUX_WITH_GATE(i2s1_clk, "i2s1", i2s_parents,
-			       0x0b4, 16, 2, BIT(31), 0);
+			       0x0b4, 16, 2, BIT(31), CLK_SET_RATE_PARENT);
 
 /* TODO: the parent for most of the USB clocks is not known */
 static SUNXI_CCU_GATE(usb_phy0_clk,	"usb-phy0",	"osc24M",
@@ -415,7 +415,7 @@ static SUNXI_CCU_M_WITH_GATE(ve_clk, "ve", "pll-ve",
 			     0x13c, 16, 3, BIT(31), CLK_SET_RATE_PARENT);
 
 static SUNXI_CCU_GATE(ac_dig_clk,	"ac-dig",	"pll-audio",
-		      0x140, BIT(31), 0);
+		      0x140, BIT(31), CLK_SET_RATE_PARENT);
 static SUNXI_CCU_GATE(avs_clk,		"avs",		"osc24M",
 		      0x144, BIT(31), 0);
 
-- 
2.10.2
