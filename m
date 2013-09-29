From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 29 Sep 2013 02:37:16 +0200
Subject: [PATCH 3/3] clk: Correct lookup logic in clk_fetch_parent_index()
In-Reply-To: <1380415036-15997-1-git-send-email-tomasz.figa@gmail.com>
References: <1380415036-15997-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1380415036-15997-3-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function is supposed to iterate over all parents of given child
clock to find the index of given parent clock in its parent list,
using parent cache if possible and falling back to string compare
otherwise. However currently the logic falls back to string compare in
every iteration in which clock cache entry does not match given parent,
due to wrong check conditions.

This patch corrects the logic to continue the loop if parent cache entry
is present and does not match requested parent clock. In addition,
redundant checks for parent cache array presence are removed, because it
is always allocated in the beginning of the function.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/clk/clk.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 63f9ac1..32e2fed 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1097,11 +1097,14 @@ static int clk_fetch_parent_index(struct clk *clk, struct clk *parent)
 	 * them now to avoid future calls to __clk_lookup.
 	 */
 	for (i = 0; i < clk->num_parents; i++) {
-		if (clk->parents && clk->parents[i] == parent)
+		if (clk->parents[i] == parent)
 			return i;
-		else if (!strcmp(clk->parent_names[i], parent->name)) {
-			if (clk->parents)
-				clk->parents[i] = __clk_lookup(parent->name);
+
+		if (clk->parents[i])
+			continue;
+
+		if (!strcmp(clk->parent_names[i], parent->name)) {
+			clk->parents[i] = __clk_lookup(parent->name);
 			return i;
 		}
 	}
-- 
1.8.3.2
