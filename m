From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 16 Sep 2014 09:35:33 +0800
Subject: [PATCH] ARM: imx: fix .is_enabled() of shared gate clock
Message-ID: <1410831334-7859-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 63288b721a80 ("ARM: imx: fix shared gate clock") attempted to fix
an issue with particular enable/disable sequence from two shared gate
clocks.  But unfortunately, while it partially fixed the issue, it also
did something wrong in .is_enabled() function hook.  In case of shared
gate, the function shouldn't really query the hardware state via
share_count, because the function is trying to query the enabling state
of the clock in question, not the hardware state which is shared by
multiple clocks.

Fix the issue by returning the enable_count of the clock itself which is
maintained by clock core, in case it's a clock sharing hardware gate
with others.  As the result, the initialization of share_count per
hardware state is not needed now.  So remove it.

Reported-by: Fabio Estevam <fabio.estevam@freescale.com>
Fixes: 63288b721a80 ("ARM: imx: fix shared gate clock")
Cc: <stable@vger.kernel.org>
Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
Hi arm-soc folks,

Please apply it for 3.17.  Thanks.

Shawn

 arch/arm/mach-imx/clk-gate2.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/clk-gate2.c b/arch/arm/mach-imx/clk-gate2.c
index 84acdfd1d715..5a75cdc81891 100644
--- a/arch/arm/mach-imx/clk-gate2.c
+++ b/arch/arm/mach-imx/clk-gate2.c
@@ -97,7 +97,7 @@ static int clk_gate2_is_enabled(struct clk_hw *hw)
 	struct clk_gate2 *gate = to_clk_gate2(hw);
 
 	if (gate->share_count)
-		return !!(*gate->share_count);
+		return !!__clk_get_enable_count(hw->clk);
 	else
 		return clk_gate2_reg_is_enabled(gate->reg, gate->bit_idx);
 }
@@ -127,10 +127,6 @@ struct clk *clk_register_gate2(struct device *dev, const char *name,
 	gate->bit_idx = bit_idx;
 	gate->flags = clk_gate2_flags;
 	gate->lock = lock;
-
-	/* Initialize share_count per hardware state */
-	if (share_count)
-		*share_count = clk_gate2_reg_is_enabled(reg, bit_idx) ? 1 : 0;
 	gate->share_count = share_count;
 
 	init.name = name;
-- 
1.9.1
