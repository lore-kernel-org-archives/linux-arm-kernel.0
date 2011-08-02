From: LW@KARO-electronics.de (=?utf-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue,  2 Aug 2011 09:07:15 +0200
Subject: [PATCH] disable the correct parent clock in clk_gate_disable()
Message-ID: <1312268835-32291-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Calling clk_parent_disable() on the parent clock goes one step too far
up the clock hierarchy.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 drivers/clk/clk-gate.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index a10d8e3..712960a 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -90,9 +90,7 @@ static void clk_gate_disable(struct clk *clk)
 	struct clk_gate *gate = to_clk_gate(clk);
 
 	gate->disable(gate);
-
-	if (gate->parent)
-		clk_parent_disable(gate->parent);
+	clk_parent_disable(clk);
 }
 
 static struct clk *clk_gate_get_parent(struct clk *clk)
-- 
1.5.6.5
