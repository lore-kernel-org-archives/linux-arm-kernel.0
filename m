From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 18 Nov 2016 15:15:57 +0800
Subject: [PATCH] clk: sunxi-ng: sun6i-a31: Enable PLL-MIPI LDOs when ungating
 it
Message-ID: <20161118071557.30195-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PLL-MIPI clock is somewhat special as it has its own LDOs which
need to be turned on for this PLL to actually work and output a clock
signal.

Add the 2 LDO enable bits to the gate bits. This fixes issues with
the TCON not sending vblank interrupts when the tcon and dot clock are
indirectly clocked from the PLL-MIPI clock.

Fixes: c6e6c96d8fa6 ("clk: sunxi-ng: Add A31/A31s clocks")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

This can be queued for either 4.9 or 4.10.

The clock driver was introduced in 4.9,
but the users won't appear until 4.10.

---
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
index 4a82a49cff5e..fc75a335a7ce 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
@@ -143,7 +143,7 @@ static SUNXI_CCU_NKM_WITH_MUX_GATE_LOCK(pll_mipi_clk, "pll-mipi",
 					4, 2,	/* K */
 					0, 4,	/* M */
 					21, 0,	/* mux */
-					BIT(31),	/* gate */
+					BIT(31) | BIT(23) | BIT(22), /* gate */
 					BIT(28),	/* lock */
 					CLK_SET_RATE_UNGATE);
 
-- 
2.10.2
