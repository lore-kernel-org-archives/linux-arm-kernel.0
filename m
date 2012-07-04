From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Wed, 4 Jul 2012 18:45:37 +0530
Subject: [PATCH] clk: Fix cached parent ptrs allocation
Message-ID: <1341407737-1016-1-git-send-email-pgaikwad@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Compiler optimizes code someway that even if clk->parents
is not NULL it tries to allocate parents array. Change the
condition so that compiler does not optimize it in wrong
way.

Also, initialize i to num_parents to make sure parent
is searched using parent name if parents is NULL.

Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
---
Mike,

There could be some other way to fix problem. I have not
debugged it in detail but I think this simple change should do.

 drivers/clk/clk.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 026d901..b28f2ae 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1066,18 +1066,18 @@ static int __clk_set_parent(struct clk *clk, struct clk *parent)
 	struct clk *old_parent;
 	unsigned long flags;
 	int ret = -EINVAL;
-	u8 i;
+	u8 i = clk->num_parents;
 
 	old_parent = clk->parent;
 
 	/* find index of new parent clock using cached parent ptrs */
-	if (clk->parents)
+	if (!clk->parents)
+		clk->parents = kzalloc((sizeof(struct clk*) * clk->num_parents),
+								GFP_KERNEL);
+	else
 		for (i = 0; i < clk->num_parents; i++)
 			if (clk->parents[i] == parent)
 				break;
-	else
-		clk->parents = kzalloc((sizeof(struct clk*) * clk->num_parents),
-								GFP_KERNEL);
 
 	/*
 	 * find index of new parent clock using string name comparison
-- 
1.7.4.1
