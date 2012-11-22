From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Thu, 22 Nov 2012 20:15:05 +0100
Subject: [PATCH] ARM : CLK: Fix clock multiplexers when registered before
 their parents.
Message-ID: <20121122191505.18016.25951.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a clock, C is initialised any orphan clocks listing C as
a possible parent are reparented to it regardless of the
parent requested by the orphan's get_parent() operation.

This means that multiplexers registered before their parents
are reparented to the first parent subsequently declared,
regardless of the selection made by the hardware registers.

For example:
	static const char *sel[] = { "srcA", "srcB", "dummy", "srcC" };

	child = clk_register_mux(NULL, "child",  sel, ARRAY_SIZE(sel), ...);
	clk_register_fixed(NULL, "dummy", ...);
	clk_register_fixed(NULL, "srcA", ...);
	clk_register_fixed(NULL, "srcB", ...);
	clk_register_fixed(NULL, "srcC", ...);

Causes child's parent to always be "dummy".

To fix this, when an orphanned clock has a get_parent() operation,
only reparent to the clock indicated by get_parent().

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 drivers/clk/clk.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index aae7b99..4c605ea 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1307,12 +1307,20 @@ int __clk_init(struct device *dev, struct clk *clk)
 	 * walk the list of orphan clocks and reparent any that are children of
 	 * this clock
 	 */
-	hlist_for_each_entry_safe(orphan, tmp, tmp2, &clk_orphan_list, child_node)
+	hlist_for_each_entry_safe(orphan, tmp, tmp2, &clk_orphan_list, child_node) {
+		if (orphan->ops->get_parent) {
+			i = orphan->ops->get_parent(orphan->hw);
+			if (!strcmp(clk->name, orphan->parent_names[i]))
+				__clk_reparent(orphan, clk);
+			continue;
+		}
+
 		for (i = 0; i < orphan->num_parents; i++)
 			if (!strcmp(clk->name, orphan->parent_names[i])) {
 				__clk_reparent(orphan, clk);
 				break;
 			}
+	 }
 
 	/*
 	 * optional platform-specific magic
