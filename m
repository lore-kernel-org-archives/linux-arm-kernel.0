From: holler@ahsoftware.de (Alexander Holler)
Date: Wed,  9 Sep 2015 20:35:25 +0200
Subject: [PATCH 2/2] deps: avoid multiple calls to memmove by just setting
 duplicates to 0
In-Reply-To: <1441823725-8869-1-git-send-email-holler@ahsoftware.de>
References: <55E961DA.5040009@ahsoftware.de>
 <1441823725-8869-1-git-send-email-holler@ahsoftware.de>
Message-ID: <1441823725-8869-3-git-send-email-holler@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Besides make the code (almost unmeasurable) faster, this makes the
ugly looking loop I've used to remove duplicates cleaner.
Disadvantage is that the ordered array now contains 'holes' and the
number of elements in the array doesn't really match the number
of ordered elements. But this only makes a difference for debugging.

This patch also adds an of_node_put() for duplicate dt nodes, something
I previously had forgotten.

Signed-off-by: Alexander Holler <holler@ahsoftware.de>
---
 drivers/of/of_dependencies.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/of/of_dependencies.c b/drivers/of/of_dependencies.c
index 85cef84..ac0c0f5 100644
--- a/drivers/of/of_dependencies.c
+++ b/drivers/of/of_dependencies.c
@@ -323,21 +323,20 @@ static bool __init all_compatibles_same(struct device_node *node1,
 /*
  * The order is based on devices but we are calling drivers.
  * Therefor the order contains some drivers more than once.
- * Remove the duplicates.
+ * Disable the duplicates by setting them to 0.
  */
-static void __init of_init_remove_duplicates(void)
+static void __init of_init_disable_duplicates(void)
 {
 	unsigned i, j;
 
 	for (i = 1; i < order.count; ++i)
 		for (j = 0; j < i; ++j) {
+			if (!order.order[j])
+				continue;
 			if (all_compatibles_same(order.order[j],
 							order.order[i])) {
-				--order.count;
-				memmove(&order.order[i], &order.order[i+1],
-					(order.count - i) *
-						sizeof(order.order[0]));
-				--i;
+				of_node_put(order.order[i]);
+				order.order[i] = 0;
 				break;
 			}
 		}
@@ -416,7 +415,8 @@ static void __init build_tgroups(void)
 	unsigned dist = 0;
 
 	for (i = 0; i < order.count; ++i) {
-		if (distance[order.order[i]->phandle] != dist) {
+		if (order.order[i] &&
+				distance[order.order[i]->phandle] != dist) {
 			dist = distance[order.order[i]->phandle];
 			count_groups++;
 			tgroup[count_groups].start = i;
@@ -436,6 +436,8 @@ static void __init of_init_print_order(void)
 
 	pr_info("Initialization order:\n");
 	for (i = 0; i < order.count; ++i) {
+		if (!order.order[i])
+			continue;
 #ifdef CONFIG_OF_DEPENDENCIES_PARALLEL
 		pr_info("init %u 0x%x (group %u)", i,
 			order.order[i]->phandle,
@@ -496,10 +498,10 @@ static int __init of_init_build_order(void)
 
 #ifdef CONFIG_OF_DEPENDENCIES_PARALLEL
 	build_order_by_distance();
-	of_init_remove_duplicates();
+	of_init_disable_duplicates();
 	build_tgroups();
 #else
-	of_init_remove_duplicates();
+	of_init_disable_duplicates();
 #endif
 
 #ifdef CONFIG_OF_DEPENDENCIES_PRINT_INIT_ORDER
@@ -516,7 +518,8 @@ static void __init of_init_free_order(void)
 	unsigned i;
 
 	for (i = 0; i < order.count; ++i)
-		of_node_put(order.order[i]);
+		if (order.order[i])
+			of_node_put(order.order[i]);
 	order.count = 0;
 	/* remove_new_phandles(); */
 }
@@ -593,8 +596,10 @@ static int __init initcall_thread(void *thread_nr)
 		start = atomic_read(&ostart);
 		count = atomic_read(&ocount);
 		while ((i = atomic_dec_return(&shared_counter)) >= 0)
-			init_if_matched(order.order[start + count - 1 - i],
-					(unsigned)thread_nr);
+			if (order.order[start + count - 1 - i])
+				init_if_matched(
+					order.order[start + count - 1 - i],
+					 (unsigned)thread_nr);
 		prepare_to_wait(&group_waitqueue, &wait, TASK_UNINTERRUPTIBLE);
 		if (!atomic_dec_and_test(&count_initcall_threads)) {
 			schedule();
@@ -629,7 +634,8 @@ static void __init of_init_drivers_non_threaded(void)
 
 	if (!of_init_build_order()) {
 		for (i = 0; i < order.count; ++i)
-			init_if_matched(order.order[i], 0);
+			if (order.order[i])
+				init_if_matched(order.order[i], 0);
 		of_init_free_order();
 	}
 	ac = __annotated_initcall_start;
-- 
2.1.0
