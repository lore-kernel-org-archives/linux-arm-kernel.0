From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Wed, 15 Apr 2015 22:26:36 +0800
Subject: [PATCH RFC v1 2/5] clk: add missing lock when call clk_core_enable in
 clk_set_parent
In-Reply-To: <1429107999-24413-1-git-send-email-aisheng.dong@freescale.com>
References: <1429107999-24413-1-git-send-email-aisheng.dong@freescale.com>
Message-ID: <1429107999-24413-3-git-send-email-aisheng.dong@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_core_enable is executed without &enable_clock in clk_set_parent function.
Adding it to avoid potential race condition issue.

Fixes: 035a61c314eb ("clk: Make clk API return per-user struct clk instances")
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
---
 drivers/clk/clk.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index cc56ba2..492644f 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1475,8 +1475,10 @@ static struct clk_core *__clk_set_parent_before(struct clk_core *clk,
 	 */
 	if (clk->prepare_count) {
 		clk_core_prepare(parent);
+		flags = clk_enable_lock();
 		clk_core_enable(parent);
 		clk_core_enable(clk);
+		clk_enable_unlock(flags);
 	}
 
 	/* update the clk tree topology */
@@ -1491,13 +1493,17 @@ static void __clk_set_parent_after(struct clk_core *clk,
 				   struct clk_core *parent,
 				   struct clk_core *old_parent)
 {
+	unsigned long flags;
+
 	/*
 	 * Finish the migration of prepare state and undo the changes done
 	 * for preventing a race with clk_enable().
 	 */
 	if (clk->prepare_count) {
+		flags = clk_enable_lock();
 		clk_core_disable(clk);
 		clk_core_disable(old_parent);
+		clk_enable_unlock(flags);
 		clk_core_unprepare(old_parent);
 	}
 }
@@ -1525,8 +1531,10 @@ static int __clk_set_parent(struct clk_core *clk, struct clk_core *parent,
 		clk_enable_unlock(flags);
 
 		if (clk->prepare_count) {
+			flags = clk_enable_lock();
 			clk_core_disable(clk);
 			clk_core_disable(parent);
+			clk_enable_unlock(flags);
 			clk_core_unprepare(parent);
 		}
 		return ret;
-- 
1.9.1
