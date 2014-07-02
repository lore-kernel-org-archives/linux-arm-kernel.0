From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue,  1 Jul 2014 19:03:27 -0700
Subject: [PATCHv2 2/3] of: Add memory limiting function for flattened
 devicetrees
In-Reply-To: <1404266608-3274-1-git-send-email-lauraa@codeaurora.org>
References: <1404266608-3274-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1404266608-3274-2-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Buggy bootloaders may pass bogus memory entries in the devicetree.
Add of_fdt_limit_memory to add an upper bound on the number of
entries that can be present in the devicetree.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 drivers/of/fdt.c       | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of_fdt.h |  1 +
 2 files changed, 49 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 55bfca9..fd5db5a 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -26,6 +26,54 @@
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 #include <asm/page.h>
 
+/*
+ * of_fdt_limit_memory - limit the number of regions in the /memory node
+ * @limit: maximum entries
+ *
+ * Adjust the flattened device tree to have at most 'limit' number of
+ * memory entries in the /memory node. This function may be called
+ * any time after initial_boot_param is set.
+ */
+void of_fdt_limit_memory(int limit)
+{
+	int memory;
+	int len;
+	const void *val;
+	int nr_address_cells = OF_ROOT_NODE_ADDR_CELLS_DEFAULT;
+	int nr_size_cells = OF_ROOT_NODE_SIZE_CELLS_DEFAULT;
+	const uint32_t *addr_prop;
+	const uint32_t *size_prop;
+	int root_offset;
+	int cell_size;
+
+	root_offset = fdt_path_offset(initial_boot_params, "/");
+	if (root_offset < 0)
+		return;
+
+	addr_prop = fdt_getprop(initial_boot_params, root_offset,
+				"#address-cells", NULL);
+	if (addr_prop)
+		nr_address_cells = fdt32_to_cpu(*addr_prop);
+
+	size_prop = fdt_getprop(initial_boot_params, root_offset,
+				"#size-cells", NULL);
+	if (size_prop)
+		nr_size_cells = fdt32_to_cpu(*size_prop);
+
+	cell_size = sizeof(uint32_t)*(nr_address_cells + nr_size_cells);
+
+	memory = fdt_path_offset(initial_boot_params, "/memory");
+	if (memory > 0) {
+		val = fdt_getprop(initial_boot_params, memory, "reg", &len);
+		if (len > limit*cell_size) {
+			len = limit*cell_size;
+			pr_debug("Limiting number of entries to %d\n", limit);
+			fdt_setprop(initial_boot_params, memory, "reg", val,
+					len);
+		}
+	}
+}
+
 /**
  * of_fdt_is_compatible - Return true if given node from the given blob has
  * compat in its compatible list
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index d600993..1aea25c 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -86,6 +86,7 @@ extern void unflatten_and_copy_device_tree(void);
 extern void early_init_devtree(void *);
 extern void early_get_first_memblock_info(void *, phys_addr_t *);
 extern u64 fdt_translate_address(const void *blob, int node_offset);
+extern void of_fdt_limit_memory(int limit);
 #else /* CONFIG_OF_FLATTREE */
 static inline void early_init_fdt_scan_reserved_mem(void) {}
 static inline const char *of_flat_dt_get_machine_name(void) { return NULL; }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
