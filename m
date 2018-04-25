From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed, 25 Apr 2018 18:31:09 -0500
Subject: [PATCH v8 01/13] drivers: base: cacheinfo: move cache_setup_of_node()
In-Reply-To: <20180425233121.13270-1-jeremy.linton@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
Message-ID: <20180425233121.13270-2-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for the next patch, and to aid in
review of that patch, lets move cache_setup_of_node
further down in the module without any changes.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/cacheinfo.c | 80 ++++++++++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index edf726267282..09ccef7ddc99 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -32,46 +32,6 @@ struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu)
 }
 
 #ifdef CONFIG_OF
-static int cache_setup_of_node(unsigned int cpu)
-{
-	struct device_node *np;
-	struct cacheinfo *this_leaf;
-	struct device *cpu_dev = get_cpu_device(cpu);
-	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-	unsigned int index = 0;
-
-	/* skip if of_node is already populated */
-	if (this_cpu_ci->info_list->of_node)
-		return 0;
-
-	if (!cpu_dev) {
-		pr_err("No cpu device for CPU %d\n", cpu);
-		return -ENODEV;
-	}
-	np = cpu_dev->of_node;
-	if (!np) {
-		pr_err("Failed to find cpu%d device node\n", cpu);
-		return -ENOENT;
-	}
-
-	while (index < cache_leaves(cpu)) {
-		this_leaf = this_cpu_ci->info_list + index;
-		if (this_leaf->level != 1)
-			np = of_find_next_cache_node(np);
-		else
-			np = of_node_get(np);/* cpu node itself */
-		if (!np)
-			break;
-		this_leaf->of_node = np;
-		index++;
-	}
-
-	if (index != cache_leaves(cpu)) /* not all OF nodes populated */
-		return -ENOENT;
-
-	return 0;
-}
-
 static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
 					   struct cacheinfo *sib_leaf)
 {
@@ -202,6 +162,46 @@ static void cache_of_override_properties(unsigned int cpu)
 		cache_associativity(this_leaf);
 	}
 }
+
+static int cache_setup_of_node(unsigned int cpu)
+{
+	struct device_node *np;
+	struct cacheinfo *this_leaf;
+	struct device *cpu_dev = get_cpu_device(cpu);
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+	unsigned int index = 0;
+
+	/* skip if of_node is already populated */
+	if (this_cpu_ci->info_list->of_node)
+		return 0;
+
+	if (!cpu_dev) {
+		pr_err("No cpu device for CPU %d\n", cpu);
+		return -ENODEV;
+	}
+	np = cpu_dev->of_node;
+	if (!np) {
+		pr_err("Failed to find cpu%d device node\n", cpu);
+		return -ENOENT;
+	}
+
+	while (index < cache_leaves(cpu)) {
+		this_leaf = this_cpu_ci->info_list + index;
+		if (this_leaf->level != 1)
+			np = of_find_next_cache_node(np);
+		else
+			np = of_node_get(np);/* cpu node itself */
+		if (!np)
+			break;
+		this_leaf->of_node = np;
+		index++;
+	}
+
+	if (index != cache_leaves(cpu)) /* not all OF nodes populated */
+		return -ENOENT;
+
+	return 0;
+}
 #else
 static void cache_of_override_properties(unsigned int cpu) { }
 static inline int cache_setup_of_node(unsigned int cpu) { return 0; }
-- 
2.13.6
