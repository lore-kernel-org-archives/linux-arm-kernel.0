From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sat, 18 Mar 2017 04:19:43 +0800
Subject: [PATCH] clk: sunxi-ng: fix recalc_rate formula of NKMP clocks
Message-ID: <20170317201943.45190-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit e66f81bbd746 ("clk: sunxi-ng: Implement factors offsets"), the
final formula of NKMP clocks' recalc_rate is refactored; however, the
refactored formula broke the calculation due to some C language operand
priority problem -- the priority of operand >> is lower than * and /,
makes the formula being parsed as "(parent_rate * n * k) >> (p / m)", but
it should be "(parent_rate * n * k >> p) / m".

Add the pair of parentheses to fix up this issue. This pair of
parentheses used to exist in the old formula.

Fixes: commit e66f81bbd746 ("clk: sunxi-ng: Implement factors offsets")
Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
Please patch the latest git tree master too, as this buggy commit is
introduced in 4.11-rc (for sun5i ccu support).

 drivers/clk/sunxi-ng/ccu_nkmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.c b/drivers/clk/sunxi-ng/ccu_nkmp.c
index a2b40a000157..488055ed944f 100644
--- a/drivers/clk/sunxi-ng/ccu_nkmp.c
+++ b/drivers/clk/sunxi-ng/ccu_nkmp.c
@@ -107,7 +107,7 @@ static unsigned long ccu_nkmp_recalc_rate(struct clk_hw *hw,
 	p = reg >> nkmp->p.shift;
 	p &= (1 << nkmp->p.width) - 1;
 
-	return parent_rate * n * k >> p / m;
+	return (parent_rate * n * k >> p) / m;
 }
 
 static long ccu_nkmp_round_rate(struct clk_hw *hw, unsigned long rate,
-- 
2.12.0
