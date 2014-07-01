From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  1 Jul 2014 02:55:28 -0300
Subject: [PATCH 4/5] ARM: imx: clk-gate2: Use post decrement for share_count
In-Reply-To: <1404194129-25543-1-git-send-email-festevam@gmail.com>
References: <1404194129-25543-1-git-send-email-festevam@gmail.com>
Message-ID: <1404194129-25543-4-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

SSI clocks use the share_count mechanism since SSI and SPDIF share the same
clock gate bits.

When using the share_count for the SSI clock we notice that it gets disabled
due to the usage of pre-decrement operation in the clk_gate2_disable() function.

Use the post-decrement operation so that the correct share_count is used and the
SSI clock does not get disable when an audio file needs to be played. 

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/clk-gate2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-gate2.c b/arch/arm/mach-imx/clk-gate2.c
index 4ba587d..463083c 100644
--- a/arch/arm/mach-imx/clk-gate2.c
+++ b/arch/arm/mach-imx/clk-gate2.c
@@ -67,7 +67,7 @@ static void clk_gate2_disable(struct clk_hw *hw)
 
 	spin_lock_irqsave(gate->lock, flags);
 
-	if (gate->share_count && --(*gate->share_count) > 0)
+	if (gate->share_count && (*gate->share_count)-- > 0)
 		goto out;
 
 	reg = readl(gate->reg);
-- 
1.8.3.2
