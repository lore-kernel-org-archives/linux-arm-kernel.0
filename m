From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 15 Nov 2018 14:52:45 +0900
Subject: [PATCH v16 06/16] lib: fdt: add a helper function for handling memory
 range property
In-Reply-To: <20181115055254.2812-1-takahiro.akashi@linaro.org>
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
Message-ID: <20181115055254.2812-7-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added function, fdt_setprop_reg(), will be used later to handle
kexec-specific property in arm64's kexec_file implementation.
It will possibly be merged into libfdt in the future.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree at vger.kernel.org
---
 include/linux/libfdt.h | 26 ++++++++++++++++++++
 lib/Makefile           |  2 +-
 lib/fdt_addresses.c    | 56 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 lib/fdt_addresses.c

diff --git a/include/linux/libfdt.h b/include/linux/libfdt.h
index 90ed4ebfa692..47c4dc9e135c 100644
--- a/include/linux/libfdt.h
+++ b/include/linux/libfdt.h
@@ -5,4 +5,30 @@
 #include <linux/libfdt_env.h>
 #include "../../scripts/dtc/libfdt/libfdt.h"
 
+/**
+ * fdt_setprop_reg - add/set a memory region property
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node to add a property at
+ * @name: name of property
+ * @addr: physical start address
+ * @size: size of region
+ *
+ * returns:
+ *	0, on success
+ *      -FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADNCELLS, if the node has a badly formatted or invalid
+ *		#address-cells property
+ *      -FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADVALUE, addr or size doesn't fit to respective cells size
+ *      -FDT_ERR_NOSPACE, there is insufficient free space in the blob to
+ *              contain a new property
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
+int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
+					       u64 addr, u64 size);
+
 #endif /* _INCLUDE_LIBFDT_H_ */
diff --git a/lib/Makefile b/lib/Makefile
index db06d1237898..2a96cb05e15d 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -205,7 +205,7 @@ KASAN_SANITIZE_stackdepot.o := n
 KCOV_INSTRUMENT_stackdepot.o := n
 
 libfdt_files = fdt.o fdt_ro.o fdt_wip.o fdt_rw.o fdt_sw.o fdt_strerror.o \
-	       fdt_empty_tree.o
+	       fdt_empty_tree.o fdt_addresses.o
 $(foreach file, $(libfdt_files), \
 	$(eval CFLAGS_$(file) = -I$(src)/../scripts/dtc/libfdt))
 lib-$(CONFIG_LIBFDT) += $(libfdt_files)
diff --git a/lib/fdt_addresses.c b/lib/fdt_addresses.c
new file mode 100644
index 000000000000..97ddd5a5cc10
--- /dev/null
+++ b/lib/fdt_addresses.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/libfdt_env.h>
+#include <linux/types.h>
+#include "../scripts/dtc/libfdt/fdt_addresses.c"
+
+/*
+ * helper functions for arm64 kexec
+ * Those functions may be merged into libfdt in the future.
+ */
+
+/* This function assumes that cells is 1 or 2 */
+static void cpu64_to_fdt_cells(void *buf, u64 val64, int cells)
+{
+	__be32 val32;
+
+	while (cells) {
+		val32 = cpu_to_fdt32(val64 >> (32 * (--cells)));
+		memcpy(buf, &val32, sizeof(val32));
+		buf += sizeof(val32);
+	}
+}
+
+int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
+						u64 addr, u64 size)
+{
+	int addr_cells, size_cells;
+	char buf[sizeof(__be32) * 2 * 2];
+		/* assume dt_root_[addr|size]_cells <= 2 */
+	void *prop;
+	size_t buf_size;
+
+	addr_cells = fdt_address_cells(fdt, 0);
+	if (addr_cells < 0)
+		return addr_cells;
+	size_cells = fdt_size_cells(fdt, 0);
+	if (size_cells < 0)
+		return size_cells;
+
+	/* if *_cells >= 2, cells can hold 64-bit values anyway */
+	if ((addr_cells == 1) && ((addr > U32_MAX) ||
+				  ((addr + size) > U32_MAX)))
+		return -FDT_ERR_BADVALUE;
+
+	if ((size_cells == 1) && (size > U32_MAX))
+		return -FDT_ERR_BADVALUE;
+
+	buf_size = (addr_cells + size_cells) * sizeof(u32);
+	prop = buf;
+
+	cpu64_to_fdt_cells(prop, addr, addr_cells);
+	prop += addr_cells * sizeof(u32);
+
+	cpu64_to_fdt_cells(prop, size, size_cells);
+
+	return fdt_setprop(fdt, nodeoffset, name, buf, buf_size);
+}
-- 
2.19.0
