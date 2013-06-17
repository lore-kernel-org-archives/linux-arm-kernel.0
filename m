From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Mon, 17 Jun 2013 15:03:46 -0700
Subject: [PATCH] clk/zynq/clkc: Add dedicated spinlock for the SWDT
Message-ID: <1371506626-3892-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clk_mux for the system watchdog timer reused the register lock
dedicated to the Ethernet module - for no apparent reason.
Add a lock dedicated to the SWDT's clock register to remove this
wrong dependency.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
I don't know how this slipped in...
Anyway, the fix depends on armsoc/zynq/clk.

	S?ren

 drivers/clk/zynq/clkc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
index 5c205b6..515a573 100644
--- a/drivers/clk/zynq/clkc.c
+++ b/drivers/clk/zynq/clkc.c
@@ -71,6 +71,7 @@ static DEFINE_SPINLOCK(armpll_lock);
 static DEFINE_SPINLOCK(ddrpll_lock);
 static DEFINE_SPINLOCK(iopll_lock);
 static DEFINE_SPINLOCK(armclk_lock);
+static DEFINE_SPINLOCK(swdtclk_lock);
 static DEFINE_SPINLOCK(ddrclk_lock);
 static DEFINE_SPINLOCK(dciclk_lock);
 static DEFINE_SPINLOCK(gem0clk_lock);
@@ -293,7 +294,7 @@ static void __init zynq_clk_setup(struct device_node *np)
 	}
 	clks[swdt] = clk_register_mux(NULL, clk_output_name[swdt],
 			swdt_ext_clk_mux_parents, 2, CLK_SET_RATE_PARENT,
-			SLCR_SWDT_CLK_SEL, 0, 1, 0, &gem0clk_lock);
+			SLCR_SWDT_CLK_SEL, 0, 1, 0, &swdtclk_lock);
 
 	/* DDR clocks */
 	clk = clk_register_divider(NULL, "ddr2x_div", "ddrpll", 0,
-- 
1.8.3.1
