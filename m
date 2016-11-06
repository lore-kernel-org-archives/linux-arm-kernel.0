From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Mon,  7 Nov 2016 01:29:31 +0800
Subject: [PATCH 1/2] clk: sunxi-ng: Fix CPUX clock for the A23/A33
Message-ID: <20161106172932.39478-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CPUX clock of A23/33 CCU driver forgot to add CLK_SET_RATE_PARENT
flag, which makes its frequency fail to change (as part of cpu thermal
throttle).

Fix it by add this flag.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
Patch 4.9-rc too.
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c | 2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c b/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
index 2646d98..44c4775 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
@@ -163,7 +163,7 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_de_clk, "pll-de",
 static const char * const cpux_parents[] = { "osc32k", "osc24M",
 					     "pll-cpux" , "pll-cpux" };
 static SUNXI_CCU_MUX(cpux_clk, "cpux", cpux_parents,
-		     0x050, 16, 2, CLK_IS_CRITICAL);
+		     0x050, 16, 2, CLK_IS_CRITICAL | CLK_SET_RATE_PARENT);
 
 static SUNXI_CCU_M(axi_clk, "axi", "cpux", 0x050, 0, 2, 0);
 
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
index 96b40ca..59cfdc8 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
@@ -170,7 +170,7 @@ static SUNXI_CCU_N_WITH_GATE_LOCK(pll_ddr1_clk, "pll-ddr1",
 static const char * const cpux_parents[] = { "osc32k", "osc24M",
 					     "pll-cpux" , "pll-cpux" };
 static SUNXI_CCU_MUX(cpux_clk, "cpux", cpux_parents,
-		     0x050, 16, 2, CLK_IS_CRITICAL);
+		     0x050, 16, 2, CLK_IS_CRITICAL | CLK_SET_RATE_PARENT);
 
 static SUNXI_CCU_M(axi_clk, "axi", "cpux", 0x050, 0, 2, 0);
 
-- 
2.10.1
