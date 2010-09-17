From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 17 Sep 2010 11:24:33 +0200 (CEST)
Subject: [PATCH] ARM: fix a kfree address in clkdev code
Message-ID: <Pine.LNX.4.64.1009171120130.4988@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kfree() in clkdev_drop() function should actually be called with an address of
a struct clk_lookup_alloc object, and not struct clk_lookup, as presently done.
This just happens to work, because "struct clk_lookup cl" is the first
member in struct clk_lookup_alloc.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Jean-Christophe, as I said, this is a purely academic patch, I'll send a 
similar one to sh, but if your consolidation patch is accepted for 2.6.37, 
maybe you can just adjust yours to get to the desired result. If, however, 
these two patches are merged into 2.6.36, you'll need slightly larger 
adjustments to your patch, in both cases trivial though.

 arch/arm/common/clkdev.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/common/clkdev.c b/arch/arm/common/clkdev.c
index e2b2bb6..b867d47 100644
--- a/arch/arm/common/clkdev.c
+++ b/arch/arm/common/clkdev.c
@@ -171,9 +171,11 @@ EXPORT_SYMBOL(clk_add_alias);
  */
 void clkdev_drop(struct clk_lookup *cl)
 {
+	struct clk_lookup_alloc *cla = container_of(cl, struct clk_lookup_alloc, cl);
+
 	mutex_lock(&clocks_mutex);
 	list_del(&cl->node);
 	mutex_unlock(&clocks_mutex);
-	kfree(cl);
+	kfree(cla);
 }
 EXPORT_SYMBOL(clkdev_drop);
-- 
1.7.1
