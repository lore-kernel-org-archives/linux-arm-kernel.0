From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed, 28 Feb 2018 16:06:13 -0600
Subject: [PATCH v7 07/13] drivers: base cacheinfo: Add support for ACPI based
 firmware tables
In-Reply-To: <20180228220619.6992-1-jeremy.linton@arm.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
Message-ID: <20180228220619.6992-8-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Call ACPI cache parsing routines from base cacheinfo code if ACPI
is enable. Also stub out cache_setup_acpi() so that individual
architectures can enable ACPI topology parsing.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/acpi/pptt.c       |  1 +
 drivers/base/cacheinfo.c  | 14 ++++++++++----
 include/linux/cacheinfo.h |  9 +++++++++
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index 883e4318c6cd..c98f94ebd272 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -343,6 +343,7 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
 {
 	int valid_flags = 0;
 
+	this_leaf->fw_token = cpu_node;
 	if (found_cache->flags & ACPI_PPTT_SIZE_PROPERTY_VALID) {
 		this_leaf->size = found_cache->size;
 		valid_flags++;
diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 597aacb233fc..2880e2ab01f5 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -206,7 +206,7 @@ static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
 					   struct cacheinfo *sib_leaf)
 {
 	/*
-	 * For non-DT systems, assume unique level 1 cache, system-wide
+	 * For non-DT/ACPI systems, assume unique level 1 caches, system-wide
 	 * shared caches for all other levels. This will be used only if
 	 * arch specific code has not populated shared_cpu_map
 	 */
@@ -214,6 +214,11 @@ static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
 }
 #endif
 
+int __weak cache_setup_acpi(unsigned int cpu)
+{
+	return -ENOTSUPP;
+}
+
 static int cache_shared_cpu_map_setup(unsigned int cpu)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
@@ -227,8 +232,8 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
 	if (of_have_populated_dt())
 		ret = cache_setup_of_node(cpu);
 	else if (!acpi_disabled)
-		/* No cache property/hierarchy support yet in ACPI */
-		ret = -ENOTSUPP;
+		ret = cache_setup_acpi(cpu);
+
 	if (ret)
 		return ret;
 
@@ -279,7 +284,8 @@ static void cache_shared_cpu_map_remove(unsigned int cpu)
 			cpumask_clear_cpu(cpu, &sib_leaf->shared_cpu_map);
 			cpumask_clear_cpu(sibling, &this_leaf->shared_cpu_map);
 		}
-		of_node_put(this_leaf->fw_token);
+		if (of_have_populated_dt())
+			of_node_put(this_leaf->fw_token);
 	}
 }
 
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 0c6f658054d2..1446d3f053a2 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -97,6 +97,15 @@ int func(unsigned int cpu)					\
 struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu);
 int init_cache_level(unsigned int cpu);
 int populate_cache_leaves(unsigned int cpu);
+int cache_setup_acpi(unsigned int cpu);
+int acpi_find_last_cache_level(unsigned int cpu);
+#ifndef CONFIG_ACPI
+int acpi_find_last_cache_level(unsigned int cpu)
+{
+	/* ACPI kernels should be built with PPTT support */
+	return 0;
+}
+#endif
 
 const struct attribute_group *cache_get_priv_group(struct cacheinfo *this_leaf);
 
-- 
2.13.6
