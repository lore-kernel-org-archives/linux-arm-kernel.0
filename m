From: robherring2@gmail.com (Rob Herring)
Date: Tue, 13 Mar 2012 18:22:21 -0500
Subject: [PATCH 1/7] clk: fix orphan list iterator to be safe
In-Reply-To: <1331680947-29861-1-git-send-email-robherring2@gmail.com>
References: <1331680947-29861-1-git-send-email-robherring2@gmail.com>
Message-ID: <1331680947-29861-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

__clk_reparent can remove orphans, so the list iterator needs to be the
safe from removal version.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 drivers/clk/clk.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c7c3bc5..802eda4 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1172,7 +1172,7 @@ void __clk_init(struct device *dev, struct clk *clk)
 {
 	int i;
 	struct clk *orphan;
-	struct hlist_node *tmp;
+	struct hlist_node *tmp, *tmp2;
 
 	if (!clk)
 		return;
@@ -1246,7 +1246,7 @@ void __clk_init(struct device *dev, struct clk *clk)
 	 * walk the list of orphan clocks and reparent any that are children of
 	 * this clock
 	 */
-	hlist_for_each_entry(orphan, tmp, &clk_orphan_list, child_node)
+	hlist_for_each_entry_safe(orphan, tmp, tmp2, &clk_orphan_list, child_node)
 		__clk_reparent(orphan, __clk_init_parent(orphan));
 
 	/*
-- 
1.7.5.4
