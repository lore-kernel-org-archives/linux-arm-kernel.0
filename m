From: sergeimir@emcraft.com (Sergei Miroshnichenko)
Date: Fri, 16 Oct 2015 17:51:25 +0300
Subject: [PATCH] clk: vf610: don't stop enabled clocks in suspend
Message-ID: <1445007085-28250-1-git-send-email-sergeimir@emcraft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently Vybrid Clock Gating is configured to turn off all clocks in stop
mode, while kernel assumes them enabled unless explicitly disabled. This
behavior prevents waking up from wakeup sources.

Fix this by replacing Clock Gating Register bitmask 3 (Clock is on during
all modes, except stop mode) with bitmask 2 (Clock is on during all modes,
even stop mode): refer to Vybrid Reference Manual Chapter 10 "Clock
Controller Module (CCM)".

Tested on a VF610-based board.

Signed-off-by: Sergei Miroshnichenko <sergeimir@emcraft.com>
---
 drivers/clk/imx/clk-gate2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-gate2.c b/drivers/clk/imx/clk-gate2.c
index 8935bff..ac35d75 100644
--- a/drivers/clk/imx/clk-gate2.c
+++ b/drivers/clk/imx/clk-gate2.c
@@ -50,7 +50,8 @@ static int clk_gate2_enable(struct clk_hw *hw)
 		goto out;
 
 	reg = readl(gate->reg);
-	reg |= 3 << gate->bit_idx;
+	reg &= ~(3 << gate->bit_idx);
+	reg |= 2 << gate->bit_idx;
 	writel(reg, gate->reg);
 
 out:
@@ -86,7 +87,7 @@ static int clk_gate2_reg_is_enabled(void __iomem *reg, u8 bit_idx)
 {
 	u32 val = readl(reg);
 
-	if (((val >> bit_idx) & 1) == 1)
+	if (((val >> bit_idx) & 3) == 2)
 		return 1;
 
 	return 0;
-- 
1.9.3
