From: ta.omasab@gmail.com (Thomas Abraham)
Date: Wed, 14 May 2014 06:41:10 +0530
Subject: [PATCH v4 2/8] clk: samsung: change scope of samsung clock lock to
 global
In-Reply-To: <1400029876-5830-1-git-send-email-thomas.ab@samsung.com>
References: <1400029876-5830-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <1400029876-5830-3-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

Access to samsung clock lock is required to support newer samsung specific
clock types. So change the scope of the samsung clock lock to global. And
prefix 'samsung_clk_' to the existing name of the lock to prevent name space
pollution.

Cc: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 drivers/clk/samsung/clk.c |   13 ++++++++-----
 drivers/clk/samsung/clk.h |    2 ++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index 91bec3e..c86c28c 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -14,7 +14,7 @@
 #include <linux/syscore_ops.h>
 #include "clk.h"
 
-static DEFINE_SPINLOCK(lock);
+DEFINE_SPINLOCK(samsung_clk_lock);
 static struct clk **clk_table;
 static void __iomem *reg_base;
 #ifdef CONFIG_OF
@@ -173,7 +173,8 @@ void __init samsung_clk_register_mux(struct samsung_mux_clock *list,
 	for (idx = 0; idx < nr_clk; idx++, list++) {
 		clk = clk_register_mux(NULL, list->name, list->parent_names,
 			list->num_parents, list->flags, reg_base + list->offset,
-			list->shift, list->width, list->mux_flags, &lock);
+			list->shift, list->width, list->mux_flags,
+			&samsung_clk_lock);
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n", __func__,
 				list->name);
@@ -206,12 +207,13 @@ void __init samsung_clk_register_div(struct samsung_div_clock *list,
 					list->parent_name, list->flags,
 					reg_base + list->offset, list->shift,
 					list->width, list->div_flags,
-					list->table, &lock);
+					list->table, &samsung_clk_lock);
 		else
 			clk = clk_register_divider(NULL, list->name,
 					list->parent_name, list->flags,
 					reg_base + list->offset, list->shift,
-					list->width, list->div_flags, &lock);
+					list->width, list->div_flags,
+					&samsung_clk_lock);
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n", __func__,
 				list->name);
@@ -241,7 +243,8 @@ void __init samsung_clk_register_gate(struct samsung_gate_clock *list,
 	for (idx = 0; idx < nr_clk; idx++, list++) {
 		clk = clk_register_gate(NULL, list->name, list->parent_name,
 				list->flags, reg_base + list->offset,
-				list->bit_idx, list->gate_flags, &lock);
+				list->bit_idx, list->gate_flags,
+				&samsung_clk_lock);
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n", __func__,
 				list->name);
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index c7141ba..951bc85 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -21,6 +21,8 @@
 #include <linux/of_address.h>
 #include "clk-pll.h"
 
+extern spinlock_t samsung_clk_lock;
+
 /**
  * struct samsung_clock_alias: information about mux clock
  * @id: platform specific id of the clock.
-- 
1.7.4.4
