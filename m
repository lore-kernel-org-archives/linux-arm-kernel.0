From: james.morse@arm.com (James Morse)
Date: Fri,  5 Oct 2018 16:02:35 +0100
Subject: [RFC PATCH 2/2] ACPI / PPTT: cacheinfo: Label caches based on fw_token
In-Reply-To: <20181005150235.13846-1-james.morse@arm.com>
References: <20181005150235.13846-1-james.morse@arm.com>
Message-ID: <20181005150235.13846-3-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The resctrl ABI requires caches to have a unique id. This number must
be unique across all caches at this level, but doesn't need to be
contiguous. (there may be gaps, it may not start at 0).
See Documentation/x86/intel_rdt_ui.txt::Cache IDs

We want a value that is the same over reboots, and should be the same
on identical hardware, even if the PPTT is generated in a different
order. The hardware doesn't give us any indication of which caches are
shared, so this information must come from firmware tables.

Starting with a cacheinfo's fw_token, we walk the table to find all
CPUs that share this cpu_node (and thus cache), and take the lowest
physical id to use as the id for the cache. On arm64 this value
corresponds to the MPIDR.

This is only done for unified caches, as instruction/data caches would
generate the same id using this scheme.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/acpi.h |  6 +++
 drivers/acpi/pptt.c           | 81 +++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 709208dfdc8b..16b9b3d771a8 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -53,6 +53,12 @@ static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
 typedef u64 phys_cpuid_t;
 #define PHYS_CPUID_INVALID INVALID_HWID
 
+/* Shift the relevant bits out of u64 phys_cpuid_t into a u32 */
+#define ARCH_PHYSID_TO_U32(x) (u32)(MPIDR_AFFINITY_LEVEL(x, 0)		|\
+			MPIDR_AFFINITY_LEVEL(x, 1) << MPIDR_LEVEL_BITS  |\
+			MPIDR_AFFINITY_LEVEL(x, 2) << 2*MPIDR_LEVEL_BITS|\
+			MPIDR_AFFINITY_LEVEL(x, 3) << 3*MPIDR_LEVEL_BITS)
+
 #define acpi_strict 1	/* No out-of-spec workarounds on ARM64 */
 extern int acpi_disabled;
 extern int acpi_noirq;
diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index d1e26cb599bf..9478f8c28158 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -341,6 +341,84 @@ static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *ta
 /* total number of attributes checked by the properties code */
 #define PPTT_CHECKED_ATTRIBUTES 4
 
+/**
+ * acpi_pptt_min_physid_from_cpu_node() - Recursivly find @min_physid for all
+ * leaf CPUs below @cpu_node.
+ * @table_hdr:	Pointer to the head of the PPTT table
+ * @cpu_node:	The point in the toplogy to start the walk
+ * @min_physid:	The min_physid to update with leaf CPUs.
+ */
+void acpi_pptt_min_physid_from_cpu_node(struct acpi_table_header *table_hdr,
+					struct acpi_pptt_processor *cpu_node,
+					phys_cpuid_t *min_physid)
+{
+	bool leaf = true;
+	u32 acpi_processor_id;
+	phys_cpuid_t cpu_node_phys_id;
+	struct acpi_subtable_header *iter;
+	struct acpi_pptt_processor *iter_node;
+	u32 target_node = ACPI_PTR_DIFF(cpu_node, table_hdr);
+	u32 proc_sz = sizeof(struct acpi_pptt_processor *);
+	unsigned long table_end = (unsigned long)table_hdr + table_hdr->length;
+
+	/*
+	 * Walk the PPTT, looking for nodes that reference cpu_node
+	 * as parent.
+	 */
+	iter = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
+			     sizeof(struct acpi_table_pptt));
+
+	while ((unsigned long)iter + proc_sz < table_end) {
+		iter_node = (struct acpi_pptt_processor *)iter;
+
+		if (iter->type == ACPI_PPTT_TYPE_PROCESSOR &&
+		    iter_node->parent == target_node) {
+			leaf = false;
+			acpi_pptt_min_physid_from_cpu_node(table_hdr, iter_node,
+							   min_physid);
+		}
+
+		if (iter->length == 0)
+			return;
+		iter = ACPI_ADD_PTR(struct acpi_subtable_header, iter,
+				    iter->length);
+	}
+
+	if (leaf && cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID) {
+		acpi_processor_id = cpu_node->acpi_processor_id;
+		cpu_node_phys_id = acpi_id_to_phys_cpuid(acpi_processor_id);
+		*min_physid = min(*min_physid, cpu_node_phys_id);
+	}
+}
+
+static void acpi_pptt_label_cache(struct cacheinfo *this_leaf)
+{
+	acpi_status status;
+	struct acpi_table_header *table;
+	struct acpi_pptt_processor *cpu_node;
+	phys_cpuid_t min_physid = PHYS_CPUID_INVALID;
+
+	/* Affinity based IDs for non-unified caches would not be unique */
+	if (this_leaf->type != CACHE_TYPE_UNIFIED)
+		return;
+
+	if (!this_leaf->fw_token)
+		return;
+	cpu_node = this_leaf->fw_token;
+
+	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
+	if (ACPI_FAILURE(status))
+		return;
+
+	acpi_pptt_min_physid_from_cpu_node(table, cpu_node, &min_physid);
+	acpi_put_table(table);
+
+	WARN_ON_ONCE(min_physid == PHYS_CPUID_INVALID);
+
+	this_leaf->id = ARCH_PHYSID_TO_U32(min_physid);
+	this_leaf->attributes |= CACHE_ID;
+}
+
 /**
  * update_cache_properties() - Update cacheinfo for the given processor
  * @this_leaf: Kernel cache info structure being updated
@@ -408,6 +486,9 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
 	if (this_leaf->type == CACHE_TYPE_NOCACHE &&
 	    valid_flags == PPTT_CHECKED_ATTRIBUTES)
 		this_leaf->type = CACHE_TYPE_UNIFIED;
+
+	/* Now that the type is known, try and generate an id. */
+	acpi_pptt_label_cache(this_leaf);
 }
 
 static void cache_setup_acpi_cpu(struct acpi_table_header *table,
-- 
2.18.0
