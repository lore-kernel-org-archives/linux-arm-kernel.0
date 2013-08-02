From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Fri,  2 Aug 2013 15:52:35 +0100
Subject: [PATCH] clk: prevent out of bounds access of clock parent arrays
Message-ID: <1375455155-10610-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Gallimore <stephen.gallimore@st.com>

Clocks implementing the get_parent() op may return an invalid parent
index if the hardware is in an undefined state when the clock is
created. However the calls of get_parent() in clk.c do not check
that the returned index is in range before using it to dereference
the clock's parents[] and parent_names[] arrays.

This patch adds checks against the number of clock parents to
prevent an incorrect access to the clock state. This does not
otherwise change the use of get_parent() and will leave a
clock, with an undefined parent, orphaned until a valid parent
is set through the clock API.

Signed-off-by: Stephen Gallimore <stephen.gallimore@st.com>
---
Notes:

There are two clocks, clk-mux and the OMAP2 dpll, that currently
return -EINVAL, which as the return type of get_parent() is a u8
will result in an index value of 234. Mike is aware of this and
was already thinking about changing the get_parent() prototype
and usage. That should not remove the need for the tests added
by this patch, but may require them to be modified later depending
on exactly what Mike decides to do.

 drivers/clk/clk.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 54a191c..b5032d0 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1309,6 +1309,8 @@ static struct clk *__clk_init_parent(struct clk *clk)
 	 */
 
 	index = clk->ops->get_parent(clk->hw);
+	if (index >= clk->num_parents)
+		goto out;
 
 	if (!clk->parents)
 		clk->parents =
@@ -1630,8 +1632,9 @@ int __clk_init(struct device *dev, struct clk *clk)
 	hlist_for_each_entry_safe(orphan, tmp2, &clk_orphan_list, child_node) {
 		if (orphan->ops->get_parent) {
 			i = orphan->ops->get_parent(orphan->hw);
-			if (!strcmp(clk->name, orphan->parent_names[i]))
-				__clk_reparent(orphan, clk);
+			if (i < orphan->num_parents)
+				if (!strcmp(clk->name, orphan->parent_names[i]))
+					__clk_reparent(orphan, clk);
 			continue;
 		}
 
-- 
1.7.6.5
