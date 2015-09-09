From: holler@ahsoftware.de (Alexander Holler)
Date: Wed,  9 Sep 2015 20:35:24 +0200
Subject: [PATCH 1/2] deps: parallel initialization of (device-)drivers
In-Reply-To: <1441823725-8869-1-git-send-email-holler@ahsoftware.de>
References: <55E961DA.5040009@ahsoftware.de>
 <1441823725-8869-1-git-send-email-holler@ahsoftware.de>
Message-ID: <1441823725-8869-2-git-send-email-holler@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This initializes drivers (annotated or in the initcall level device)
in parallel.

Which drivers can be initialized in parallel is calculated by using
the dependencies. That means, currently, only annotated drivers which
are are referenced in the used DT will be in order. For all others it
is assumed that, as long as they belong to the same initcall level
(device), they can be called in any order.

Unfortunately this isn't allways true and several drivers are depending
on the link-order (based on the Makefile and the directory). This is,
imho, a bug or at least a very fragile way to do such and should be,
again imho, fixed. Otherwise problems might arise if e.g. a driver is
moved from staging to its final position (which changes its place in
the list of initcalls too).
But this isn't really the topic of this patch and I'm mentioning this
here just as a warning or as hint in case someone experiences problems
when enabling the feature this patch provides.

Signed-off-by: Alexander Holler <holler@ahsoftware.de>
---
 drivers/of/Kconfig           |  20 ++++
 drivers/of/of_dependencies.c | 245 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 261 insertions(+), 4 deletions(-)

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 26c4b1a..7e6e910 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -132,4 +132,24 @@ config OF_DEPENDENCIES_DEBUG_CALLS_OF_ANNOTATED_INITCALLS
 	help
 	  Used for debugging purposes.
 
+config OF_DEPENDENCIES_PARALLEL
+	bool "Initialize annotated initcalls in parallel"
+	depends on OF_DEPENDENCIES
+	help
+	  Calculates which (annotated) initcalls can be called in parallel
+	  and calls them using multiple threads. Be warned, this doesn't
+	  work always as it should because of missing dependencies and
+	  because it assumes that drivers belonging to the same initcall
+	  level can be called in an order different than the order they
+	  are linked.
+
+config OF_DEPENDENCIES_THREADS
+	int "Number of threads to use for parallel initialization"
+	depends on OF_DEPENDENCIES_PARALLEL
+	default 0
+	help
+	  0 means the number of threads used for parallel initialization
+	  of drivers equals the number of online CPUs.
+	  1 means the threaded initialization is disabled.
+
 endif # OF
diff --git a/drivers/of/of_dependencies.c b/drivers/of/of_dependencies.c
index 06435d5..85cef84 100644
--- a/drivers/of/of_dependencies.c
+++ b/drivers/of/of_dependencies.c
@@ -11,12 +11,16 @@
  */
 
 #include <linux/of_dependencies.h>
+#include <linux/kthread.h>
 
 #define MAX_DT_NODES 1000 /* maximum number of vertices */
 #define MAX_EDGES (MAX_DT_NODES*2) /* maximum number of edges (dependencies) */
 
 struct edgenode {
 	uint32_t y; /* phandle */
+#ifdef CONFIG_OF_DEPENDENCIES_PARALLEL
+	uint32_t x;
+#endif
 	struct edgenode *next; /* next edge in list */
 };
 
@@ -120,6 +124,9 @@ static int __init insert_edge(uint32_t x, uint32_t y)
 	graph.include_node[x] = 1;
 	graph.include_node[y] = 1;
 	p->y = y;
+#ifdef CONFIG_OF_DEPENDENCIES_PARALLEL
+	p->x = x;
+#endif
 	p->next = graph.edges[x];
 	graph.edges[x] = p; /* insert at head of list */
 
@@ -336,6 +343,90 @@ static void __init of_init_remove_duplicates(void)
 		}
 }
 
+#ifdef CONFIG_OF_DEPENDENCIES_PARALLEL
+/*
+ * The algorithm I've used below to calculate the max. distance for
+ * nodes to the root node likely isn't the fasted. But based on the
+ * already done implementation of the topological sort, this is an
+ * easy way to achieve this. Instead of first doing an topological
+ * sort and then using the stuff below to calculate the distances,
+ * using an algorithm which does spit out distances directly would
+ * be likely faster.
+ * If you want to spend the time, you could have a look e.g. at the
+ * topic 'layered graph drawing'.
+ */
+/* max. distance from a node to root */
+static unsigned distance[MAX_DT_NODES+1] __initdata;
+static struct device_node *order_by_distance[MAX_DT_NODES+1] __initdata;
+
+static void __init calc_max_distance(uint32_t v)
+{
+	unsigned i;
+	unsigned max_dist = 0;
+
+	for (i = 0; i < graph.nedges; ++i)
+		if (graph.edge_slots[i].x == v)
+			max_dist = max(max_dist,
+				distance[graph.edge_slots[i].y] + 1);
+	distance[v] = max_dist;
+}
+
+static void __init calc_distances(void)
+{
+	unsigned i;
+
+	for (i = 0; i < order.count; ++i)
+		calc_max_distance(order.order[i]->phandle);
+}
+
+static void __init build_order_by_distance(void)
+{
+	unsigned i, j;
+	unsigned max_distance = 0;
+	unsigned new_order_count = 0;
+
+	calc_distances();
+	order_by_distance[new_order_count++] = order.order[0];
+	for (i = 1; i < order.count; ++i) {
+		if (distance[order.order[i]->phandle] == 1)
+			order_by_distance[new_order_count++] = order.order[i];
+		max_distance = max(max_distance,
+				   distance[order.order[i]->phandle]);
+	}
+	for (j = 2; j <= max_distance; ++j)
+		for (i = 1; i < order.count; ++i)
+			if (distance[order.order[i]->phandle] == j)
+				order_by_distance[new_order_count++] =
+							order.order[i];
+	memcpy(order.order, order_by_distance,
+		sizeof(order.order[0]) * order.count);
+}
+
+struct thread_group {
+	unsigned start;
+	unsigned length;
+};
+
+static struct thread_group tgroup[20] __initdata;
+static unsigned count_groups __initdata;
+
+static void __init build_tgroups(void)
+{
+	unsigned i;
+	unsigned dist = 0;
+
+	for (i = 0; i < order.count; ++i) {
+		if (distance[order.order[i]->phandle] != dist) {
+			dist = distance[order.order[i]->phandle];
+			count_groups++;
+			tgroup[count_groups].start = i;
+		}
+		tgroup[count_groups].length++;
+	}
+	count_groups++;
+}
+#endif /* CONFIG_OF_DEPENDENCIES_PARALLEL */
+
 #ifdef CONFIG_OF_DEPENDENCIES_PRINT_INIT_ORDER
 static void __init of_init_print_order(void)
 {
@@ -345,7 +436,13 @@ static void __init of_init_print_order(void)
 
 	pr_info("Initialization order:\n");
 	for (i = 0; i < order.count; ++i) {
+#ifdef CONFIG_OF_DEPENDENCIES_PARALLEL
+		pr_info("init %u 0x%x (group %u)", i,
+			order.order[i]->phandle,
+			distance[order.order[i]->phandle]);
+#else
 		pr_info("init %u 0x%x", i, order.order[i]->phandle);
+#endif
 		if (order.order[i]->name)
 			pr_cont(" %s", order.order[i]->name);
 		if (order.order[i]->full_name)
@@ -397,7 +494,14 @@ static int __init of_init_build_order(void)
 	if (graph.finished)
 		return -EINVAL; /* cycle found */
 
+#ifdef CONFIG_OF_DEPENDENCIES_PARALLEL
+	build_order_by_distance();
 	of_init_remove_duplicates();
+	build_tgroups();
+#else
+	of_init_remove_duplicates();
+#endif
+
 #ifdef CONFIG_OF_DEPENDENCIES_PRINT_INIT_ORDER
 	of_init_print_order();
 #endif
@@ -417,7 +521,7 @@ static void __init of_init_free_order(void)
 	/* remove_new_phandles(); */
 }
 
-static void __init init_if_matched(struct device_node *node)
+static void __init init_if_matched(struct device_node *node, unsigned thread_nr)
 {
 	struct _annotated_initcall *ac;
 
@@ -427,7 +531,8 @@ static void __init init_if_matched(struct device_node *node)
 			if (of_match_node(ac->driver->of_match_table,
 					 node)) {
 #ifdef CONFIG_OF_DEPENDENCIES_DEBUG_CALLS_OF_ANNOTATED_INITCALLS
-				pr_info("Calling (ordered) initcall for driver %s (%s)\n",
+				pr_info("Thread %u calling (ordered) initcall for driver %s (%s)\n",
+					thread_nr,
 					ac->driver->name,
 					ac->driver->of_match_table ?
 						ac->driver->of_match_table->compatible : "");
@@ -438,14 +543,93 @@ static void __init init_if_matched(struct device_node *node)
 	}
 }
 
-void __init of_init_drivers(void)
+#ifdef CONFIG_OF_DEPENDENCIES_PARALLEL
+
+static __initdata DECLARE_COMPLETION(initcall_thread_done);
+static __initdata DECLARE_WAIT_QUEUE_HEAD(group_waitqueue);
+
+static atomic_t shared_counter __initdata;
+static atomic_t count_initcall_threads __initdata;
+static atomic_t ostart __initdata;
+static atomic_t ocount __initdata;
+static unsigned num_threads __initdata;
+
+static atomic_t current_group __initdata;
+
+static int __init initcall_thread_unordered(void *thread_nr)
+{
+	struct _annotated_initcall *ac;
+	int i;
+	int count_initcalls =
+		__annotated_initcall_end - __annotated_initcall_start;
+
+	while ((i = atomic_dec_return(&shared_counter)) >= 0) {
+		ac = &__annotated_initcall_start[count_initcalls - 1 - i];
+		if (ac->initcall) {
+#ifdef CONFIG_OF_DEPENDENCIES_DEBUG_CALLS_OF_ANNOTATED_INITCALLS
+			pr_info("Thread %u calling (unordered) initcall for driver %s (%s)\n",
+				(unsigned)thread_nr, ac->driver->name,
+				ac->driver->of_match_table ?
+					ac->driver->of_match_table->compatible : "");
+#endif
+			do_one_initcall(*ac->initcall);
+		}
+	}
+	if (atomic_dec_and_test(&count_initcall_threads))
+		complete(&initcall_thread_done);
+	do_exit(0);
+	return 0;
+}
+
+static int __init initcall_thread(void *thread_nr)
+{
+	int i;
+	unsigned group;
+	int start, count;
+
+	DEFINE_WAIT(wait);
+
+	while ((group = atomic_read(&current_group)) < count_groups) {
+		start = atomic_read(&ostart);
+		count = atomic_read(&ocount);
+		while ((i = atomic_dec_return(&shared_counter)) >= 0)
+			init_if_matched(order.order[start + count - 1 - i],
+					(unsigned)thread_nr);
+		prepare_to_wait(&group_waitqueue, &wait, TASK_UNINTERRUPTIBLE);
+		if (!atomic_dec_and_test(&count_initcall_threads)) {
+			schedule();
+			finish_wait(&group_waitqueue, &wait);
+			continue;
+		}
+		atomic_inc(&current_group);
+		atomic_set(&count_initcall_threads, num_threads);
+		if (++group >= count_groups) {
+			/* all thread groups processed */
+			atomic_set(&shared_counter,
+				__annotated_initcall_end -
+					__annotated_initcall_start);
+			wake_up_all(&group_waitqueue);
+			finish_wait(&group_waitqueue, &wait);
+			break;
+		}
+		atomic_set(&ostart, tgroup[group].start);
+		atomic_set(&ocount, tgroup[group].length);
+		atomic_set(&shared_counter, tgroup[group].length);
+		wake_up_all(&group_waitqueue);
+		finish_wait(&group_waitqueue, &wait);
+	}
+	return initcall_thread_unordered(thread_nr);
+}
+#endif
+
+static void __init of_init_drivers_non_threaded(void)
 {
 	unsigned i;
 	struct _annotated_initcall *ac;
 
 	if (!of_init_build_order()) {
 		for (i = 0; i < order.count; ++i)
-			init_if_matched(order.order[i]);
+			init_if_matched(order.order[i], 0);
 		of_init_free_order();
 	}
 	ac = __annotated_initcall_start;
@@ -461,3 +645,56 @@ void __init of_init_drivers(void)
 		}
 	}
 }
+
+void __init of_init_drivers(void)
+{
+	unsigned count_annotated;
+
+	count_annotated = __annotated_initcall_end - __annotated_initcall_start;
+	if (!count_annotated)
+		return;
+
+#ifndef CONFIG_OF_DEPENDENCIES_PARALLEL
+	of_init_drivers_non_threaded();
+#else
+	if (CONFIG_OF_DEPENDENCIES_THREADS == 0)
+		num_threads = num_online_cpus();
+	else
+		num_threads = CONFIG_OF_DEPENDENCIES_THREADS;
+	if (num_threads < 2) {
+		of_init_drivers_non_threaded();
+		return;
+	}
+	if (!of_init_build_order()) {
+		if (count_groups > 1) {
+			unsigned i;
+
+			atomic_set(&count_initcall_threads, num_threads);
+			atomic_set(&ostart, tgroup[1].start);
+			atomic_set(&ocount, tgroup[1].length);
+			atomic_set(&shared_counter, tgroup[1].length);
+			atomic_set(&current_group, 1);
+			for (i = 0; i < num_threads; ++i)
+				kthread_run(initcall_thread, (void *)i,
+							"initcalls");
+			wait_for_completion(&initcall_thread_done);
+			reinit_completion(&initcall_thread_done);
+		}
+		of_init_free_order();
+	} else {
+		/*
+		 * Building order failed (dependency circle).
+		 * Try to boot anyway by calling all initcalls unordered.
+		 */
+		unsigned i;
+
+		atomic_set(&shared_counter, count_annotated);
+		num_threads = min(count_annotated, num_threads);
+		atomic_set(&count_initcall_threads, num_threads);
+		for (i = 0; i < num_threads; ++i)
+			kthread_run(initcall_thread_unordered, (void *)i,
+							"initcalls");
+		wait_for_completion(&initcall_thread_done);
+	}
+#endif
+}
-- 
2.1.0
