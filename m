From: nm@ti.com (Nishanth Menon)
Date: Wed, 5 Feb 2014 03:04:08 -0600
Subject: [PATCH] ARM: OMAP3+: DPLL: stop reparenting to same parent if already
 done
Message-ID: <1391591048-19433-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

omap3_noncore_dpll_set_rate forces a reparent to the same clk_ref
for every call that takes place. This is an can be done only if a change
is detected.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/dpll3xxx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index 3185ced..d9bcbf7 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -525,7 +525,7 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
 	* stuff is inherited for free
 	*/
 
-	if (!ret)
+	if (!ret && clk_get_parent(hw->clk) != new_parent)
 		__clk_reparent(hw->clk, new_parent);
 
 	return 0;
-- 
1.7.9.5
