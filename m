From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 19 Apr 2014 13:01:31 +0800
Subject: [PATCH 2/4] ARM: imx: lock is always valid for clk_gate2
In-Reply-To: <1397883693-26101-1-git-send-email-shawn.guo@freescale.com>
References: <1397883693-26101-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1397883693-26101-3-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The imx specific clk_gate2 always has a valid lock with the clock.  So
the validation on gate->lock is not really needed.  Remove it.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-imx/clk-gate2.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-imx/clk-gate2.c b/arch/arm/mach-imx/clk-gate2.c
index 7e98ccb..0803df9 100644
--- a/arch/arm/mach-imx/clk-gate2.c
+++ b/arch/arm/mach-imx/clk-gate2.c
@@ -43,15 +43,13 @@ static int clk_gate2_enable(struct clk_hw *hw)
 	u32 reg;
 	unsigned long flags = 0;
 
-	if (gate->lock)
-		spin_lock_irqsave(gate->lock, flags);
+	spin_lock_irqsave(gate->lock, flags);
 
 	reg = readl(gate->reg);
 	reg |= 3 << gate->bit_idx;
 	writel(reg, gate->reg);
 
-	if (gate->lock)
-		spin_unlock_irqrestore(gate->lock, flags);
+	spin_unlock_irqrestore(gate->lock, flags);
 
 	return 0;
 }
@@ -62,15 +60,13 @@ static void clk_gate2_disable(struct clk_hw *hw)
 	u32 reg;
 	unsigned long flags = 0;
 
-	if (gate->lock)
-		spin_lock_irqsave(gate->lock, flags);
+	spin_lock_irqsave(gate->lock, flags);
 
 	reg = readl(gate->reg);
 	reg &= ~(3 << gate->bit_idx);
 	writel(reg, gate->reg);
 
-	if (gate->lock)
-		spin_unlock_irqrestore(gate->lock, flags);
+	spin_unlock_irqrestore(gate->lock, flags);
 }
 
 static int clk_gate2_is_enabled(struct clk_hw *hw)
-- 
1.8.3.2
