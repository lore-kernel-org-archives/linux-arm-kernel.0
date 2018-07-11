From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 11 Jul 2018 16:41:53 +0900
Subject: [PATCH v11 05/15] of/fdt: add helper functions for handling properties
In-Reply-To: <20180711074203.3019-1-takahiro.akashi@linaro.org>
References: <20180711074203.3019-1-takahiro.akashi@linaro.org>
Message-ID: <20180711074203.3019-6-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These functions will be used later to handle kexec-specific properties
in arm64's kexec_file implementation.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
---
 drivers/of/fdt.c       | 62 ++++++++++++++++++++++++++++++++++++++++--
 include/linux/of_fdt.h | 10 +++++--
 2 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 6da20b9688f7..f7c9d69ce86c 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -25,6 +25,7 @@
 #include <linux/debugfs.h>
 #include <linux/serial_core.h>
 #include <linux/sysfs.h>
+#include <linux/types.h>
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 #include <asm/page.h>
@@ -537,8 +538,8 @@ void *of_fdt_unflatten_tree(const unsigned long *blob,
 EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
 
 /* Everything below here references initial_boot_params directly. */
-int __initdata dt_root_addr_cells;
-int __initdata dt_root_size_cells;
+int dt_root_addr_cells;
+int dt_root_size_cells;
 
 void *initial_boot_params;
 
@@ -1330,3 +1331,60 @@ late_initcall(of_fdt_raw_init);
 #endif
 
 #endif /* CONFIG_OF_EARLY_FLATTREE */
+
+bool of_fdt_cells_size_fitted(u64 base, u64 size)
+{
+	/* if *_cells >= 2, cells can hold 64-bit values anyway */
+	if ((dt_root_addr_cells == 1) && (base > U32_MAX))
+		return false;
+
+	if ((dt_root_size_cells == 1) && (size > U32_MAX))
+		return false;
+
+	return true;
+}
+
+size_t of_fdt_reg_cells_size(void)
+{
+	return (dt_root_addr_cells + dt_root_size_cells) * sizeof(u32);
+}
+
+#define FDT_ALIGN(x, a)	(((x) + (a) - 1) & ~((a) - 1))
+#define FDT_TAGALIGN(x)	(FDT_ALIGN((x), FDT_TAGSIZE))
+
+int fdt_prop_len(const char *prop_name, int len)
+{
+	return (strlen(prop_name) + 1) +
+		sizeof(struct fdt_property) +
+		FDT_TAGALIGN(len);
+}
+
+static void fill_property(void *buf, u64 val64, int cells)
+{
+	__be32 val32;
+
+	while (cells) {
+		val32 = cpu_to_fdt32((val64 >> (32 * (--cells))) & U32_MAX);
+		memcpy(buf, &val32, sizeof(val32));
+		buf += sizeof(val32);
+	}
+}
+
+int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
+						u64 addr, u64 size)
+{
+	char buf[sizeof(__be32) * 2 * 2];
+		/* assume dt_root_[addr|size]_cells <= 2 */
+	void *prop;
+	size_t buf_size;
+
+	buf_size = of_fdt_reg_cells_size();
+	prop = buf;
+
+	fill_property(prop, addr, dt_root_addr_cells);
+	prop += dt_root_addr_cells * sizeof(u32);
+
+	fill_property(prop, size, dt_root_size_cells);
+
+	return fdt_setprop(fdt, nodeoffset, name, buf, buf_size);
+}
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index b9cd9ebdf9b9..9615d6142578 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -37,8 +37,8 @@ extern void *of_fdt_unflatten_tree(const unsigned long *blob,
 				   struct device_node **mynodes);
 
 /* TBD: Temporary export of fdt globals - remove when code fully merged */
-extern int __initdata dt_root_addr_cells;
-extern int __initdata dt_root_size_cells;
+extern int dt_root_addr_cells;
+extern int dt_root_size_cells;
 extern void *initial_boot_params;
 
 extern char __dtb_start[];
@@ -108,5 +108,11 @@ static inline void unflatten_device_tree(void) {}
 static inline void unflatten_and_copy_device_tree(void) {}
 #endif /* CONFIG_OF_EARLY_FLATTREE */
 
+bool of_fdt_cells_size_fitted(u64 base, u64 size);
+size_t of_fdt_reg_cells_size(void);
+int fdt_prop_len(const char *prop_name, int len);
+int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
+						u64 addr, u64 size);
+
 #endif /* __ASSEMBLY__ */
 #endif /* _LINUX_OF_FDT_H */
-- 
2.17.0
