From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue,  1 Aug 2017 21:12:56 +0800
Subject: [PATCH 05/13] clk: sunxi-ng: allow CLK_DE to set CLK_PLL_DE for H3
In-Reply-To: <20170801131304.7741-1-icenowy@aosc.io>
References: <20170801131304.7741-1-icenowy@aosc.io>
Message-ID: <20170801131304.7741-6-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner H3 features a PLL named CLK_PLL_DE, and a mod clock for the
"Display Engine 2.0" named CLK_DE. As the name indicated, the CLK_PLL_DE
is a PLL for CLK_DE.

Only CLK_DE and CLK_TVE have a parent of CLK_PLL_DE, and CLK_TVE is also
one part of the display clocks.

So allow CLK_DE to set CLK_PLL_DE (add CLK_SET_RATE_PARENT to it).

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
index d1ab0d713fa6..b1127e8629d9 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
@@ -439,7 +439,7 @@ static SUNXI_CCU_GATE(dram_ts_clk,	"dram-ts",	"dram",
 
 static const char * const de_parents[] = { "pll-periph0-2x", "pll-de" };
 static SUNXI_CCU_M_WITH_MUX_GATE(de_clk, "de", de_parents,
-				 0x104, 0, 4, 24, 3, BIT(31), 0);
+				 0x104, 0, 4, 24, 3, BIT(31), CLK_SET_RATE_PARENT);
 
 static const char * const tcon_parents[] = { "pll-video" };
 static SUNXI_CCU_M_WITH_MUX_GATE(tcon_clk, "tcon", tcon_parents,
-- 
2.13.0
