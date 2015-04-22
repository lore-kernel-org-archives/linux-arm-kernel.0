From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 22 Apr 2015 22:53:05 +0200
Subject: [PATCH v3 1/2] clk: track the orphan status of clocks and their
 children
In-Reply-To: <1429735986-18592-1-git-send-email-heiko@sntech.de>
References: <1429735986-18592-1-git-send-email-heiko@sntech.de>
Message-ID: <1429735986-18592-2-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While children of orphan clocks are not carried in the orphan-list itself,
they're nevertheless orphans in their own right as they also don't have an
input-rate available. To ease tracking if a clock is an orphan or has an
orphan in its parent path introduce an orphan field into struct clk and
update it and the fields in child-clocks when a clock gets added or removed
from the orphan-list.

Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Alex Elder <elder@linaro.org>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: kernel at pengutronix.de
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Chao Xie <chao.xie@marvell.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Andrew Bresticker <abrestic@chromium.org>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Georgi Djakov <georgi.djakov@linaro.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Barry Song <baohua@kernel.org>
Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: Gabriel FERNANDEZ <gabriel.fernandez@st.com>
Cc: emilio at elopez.com.ar
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Michal Simek <michal.simek@xilinx.com>
---
 drivers/clk/clk.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b2361d4..341904f 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -62,6 +62,7 @@ struct clk_core {
 	struct clk_core		*new_parent;
 	struct clk_core		*new_child;
 	unsigned long		flags;
+	bool			orphan;
 	unsigned int		enable_count;
 	unsigned int		prepare_count;
 	unsigned long		accuracy;
@@ -1401,18 +1402,40 @@ static int clk_fetch_parent_index(struct clk_core *clk,
 	return -EINVAL;
 }
 
+/*
+ * Update the orphan status of @clk and all its children.
+ */
+static void clk_core_update_orphan_status(struct clk_core *clk, bool is_orphan)
+{
+	struct clk_core *child;
+
+	clk->orphan = is_orphan;
+
+	hlist_for_each_entry(child, &clk->children, child_node)
+		clk_core_update_orphan_status(child, is_orphan);
+}
+
 static void clk_reparent(struct clk_core *clk, struct clk_core *new_parent)
 {
+	bool was_orphan = clk->orphan;
+
 	hlist_del(&clk->child_node);
 
 	if (new_parent) {
+		bool becomes_orphan = new_parent->orphan;
+
 		/* avoid duplicate POST_RATE_CHANGE notifications */
 		if (new_parent->new_child == clk)
 			new_parent->new_child = NULL;
 
 		hlist_add_head(&clk->child_node, &new_parent->children);
+
+		if (was_orphan != becomes_orphan)
+			clk_core_update_orphan_status(clk, becomes_orphan);
 	} else {
 		hlist_add_head(&clk->child_node, &clk_orphan_list);
+		if (!was_orphan)
+			clk_core_update_orphan_status(clk, true);
 	}
 
 	clk->parent = new_parent;
@@ -2302,13 +2325,17 @@ static int __clk_init(struct device *dev, struct clk *clk_user)
 	 * clocks and re-parent any that are children of the clock currently
 	 * being clk_init'd.
 	 */
-	if (clk->parent)
+	if (clk->parent) {
 		hlist_add_head(&clk->child_node,
 				&clk->parent->children);
-	else if (clk->flags & CLK_IS_ROOT)
+		clk->orphan = clk->parent->orphan;
+	} else if (clk->flags & CLK_IS_ROOT) {
 		hlist_add_head(&clk->child_node, &clk_root_list);
-	else
+		clk->orphan = false;
+	} else {
 		hlist_add_head(&clk->child_node, &clk_orphan_list);
+		clk->orphan = true;
+	}
 
 	/*
 	 * Set clk's accuracy.  The preferred method is to use
-- 
2.1.4
