From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue,  2 Feb 2016 17:42:13 -0800
Subject: [PATCH] clk: Deprecate CLK_IS_ROOT
Message-ID: <1454463733-25281-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't use CLK_IS_ROOT but in a few places in the common clk
framework core. Let's replace those checks with a check for the
number of parents a clk has instead of the flag, freeing up one
flag for something else. We don't remove the flag yet so that
things keep building, but we'll remove it once all drivers have
removed their flag usage.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

A bunch of patches to remove CLK_IS_ROOT are coming...

 drivers/clk/clk.c            | 6 +++---
 include/linux/clk-provider.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index bb01ed6cc63e..cd8382c83f48 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -385,7 +385,7 @@ static unsigned long clk_core_get_rate_nolock(struct clk_core *core)
 
 	ret = core->rate;
 
-	if (core->flags & CLK_IS_ROOT)
+	if (!core->num_parents)
 		goto out;
 
 	if (!core->parent)
@@ -2351,7 +2351,7 @@ static int __clk_core_init(struct clk_core *core)
 	/*
 	 * Populate core->parent if parent has already been __clk_init'd.  If
 	 * parent has not yet been __clk_init'd then place clk in the orphan
-	 * list.  If clk has set the CLK_IS_ROOT flag then place it in the root
+	 * list.  If clk doesn't have any parents then place it in the root
 	 * clk list.
 	 *
 	 * Every time a new clk is clk_init'd then we walk the list of orphan
@@ -2362,7 +2362,7 @@ static int __clk_core_init(struct clk_core *core)
 		hlist_add_head(&core->child_node,
 				&core->parent->children);
 		core->orphan = core->parent->orphan;
-	} else if (core->flags & CLK_IS_ROOT) {
+	} else if (!core->num_parents) {
 		hlist_add_head(&core->child_node, &clk_root_list);
 		core->orphan = false;
 	} else {
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index fabe5bedbba6..9c3a18c1a984 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -25,7 +25,7 @@
 #define CLK_SET_PARENT_GATE	BIT(1) /* must be gated across re-parent */
 #define CLK_SET_RATE_PARENT	BIT(2) /* propagate rate change up one level */
 #define CLK_IGNORE_UNUSED	BIT(3) /* do not gate even if unused */
-#define CLK_IS_ROOT		BIT(4) /* root clk, has no parent */
+#define CLK_IS_ROOT		BIT(4) /* Deprecated: Don't use */
 #define CLK_IS_BASIC		BIT(5) /* Basic clk, can't do a to_clk_foo() */
 #define CLK_GET_RATE_NOCACHE	BIT(6) /* do not use the cached clk rate */
 #define CLK_SET_RATE_NO_REPARENT BIT(7) /* don't re-parent on rate change */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
