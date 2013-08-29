From: james.hogan@imgtec.com (James Hogan)
Date: Thu, 29 Aug 2013 12:10:51 +0100
Subject: [PATCH] clk: fix new_parent dereference before null check
Message-ID: <1377774651-5394-1-git-send-email-james.hogan@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 71472c0 (clk: add support for clock reparent on set_rate) added a
dereference of the new_parent pointer in clk_reparent(), but as detected
by smatch clk_reparent() later checks whether new_parent is NULL.

The dereference was in order to clear the new parent's new_child pointer
to avoid duplicate POST_RATE_CHANGE notifications, so clearly isn't
necessary if the new parent is NULL, so move it inside the "if
(new_parent)" block.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/clk/clk.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 2db08c0..02e75d4 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1108,16 +1108,17 @@ static u8 clk_fetch_parent_index(struct clk *clk, struct clk *parent)
 
 static void clk_reparent(struct clk *clk, struct clk *new_parent)
 {
-	/* avoid duplicate POST_RATE_CHANGE notifications */
-	if (new_parent->new_child == clk)
-		new_parent->new_child = NULL;
-
 	hlist_del(&clk->child_node);
 
-	if (new_parent)
+	if (new_parent) {
+		/* avoid duplicate POST_RATE_CHANGE notifications */
+		if (new_parent->new_child == clk)
+			new_parent->new_child = NULL;
+
 		hlist_add_head(&clk->child_node, &new_parent->children);
-	else
+	} else {
 		hlist_add_head(&clk->child_node, &clk_orphan_list);
+	}
 
 	clk->parent = new_parent;
 }
-- 
1.8.1.2
