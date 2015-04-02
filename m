From: heiko@sntech.de (Heiko Stuebner)
Date: Thu,  2 Apr 2015 17:34:11 +0200
Subject: [PATCH 2/4] clk: add clk_is_orphan() to check if a clocks inherits
 from an orphan clock
In-Reply-To: <1427988853-9549-1-git-send-email-heiko@sntech.de>
References: <1427988853-9549-1-git-send-email-heiko@sntech.de>
Message-ID: <1427988853-9549-3-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are cases where it is helpful to know if the full clock path can be
trusted or if there is a parent clock missing somewhere in the parent-path.

We keep it confined to the ccf area for now, if later users outside the ccf
surface it can be made more publically available.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/clk.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 512323f..476f491 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2271,6 +2271,44 @@ bool clk_is_match(const struct clk *p, const struct clk *q)
 EXPORT_SYMBOL_GPL(clk_is_match);
 
 /**
+ * __clk_is_orphan - check if a clock or its parent is an orphan
+ *
+ * Walks up the clock parents until it reaches a root-clock or
+ * a clock contained in the orphan list. Returns true if there is
+ * an orphan in the parent-path otherwise false.
+ */
+static bool __clk_is_orphan(struct clk_core *clk)
+{
+	struct clk_core *orphan;
+
+	if (clk->flags & CLK_IS_ROOT)
+		return false;
+
+	hlist_for_each_entry(orphan, &clk_orphan_list, child_node) {
+		if (clk == orphan)
+			return true;
+	}
+
+	if (clk->num_parents)
+		return __clk_is_orphan(clk->parent);
+
+	return false;
+}
+
+static bool clk_is_orphan(struct clk *clk)
+{
+	bool ret;
+
+	if (!clk)
+		return false;
+
+	clk_prepare_lock();
+	ret = __clk_is_orphan(clk->core);
+	clk_prepare_unlock();
+	return ret;
+}
+
+/**
  * __clk_init - initialize the data structures in a struct clk
  * @dev:	device initializing this clk, placeholder for now
  * @clk:	clk being initialized
-- 
2.1.4
