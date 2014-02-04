From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 04 Feb 2014 13:09:30 +0100
Subject: [PATCH v2 2/5] drivers: of: implement reserved-memory handling for dma
In-Reply-To: <1391515773-6112-1-git-send-email-m.szyprowski@samsung.com>
References: <1391515773-6112-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1391515773-6112-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Josh Cartwright <joshc@codeaurora.org>

Add support for handling 'shared-dma-pool' reserved-memory nodes using
dma exclusive driver (dma_alloc_coherent()).

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Laura Abbott <lauraa@codeaurora.org>
Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/of/Kconfig               |    7 ++++
 drivers/of/Makefile              |    1 +
 drivers/of/of_reserved_mem_dma.c |   78 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+)
 create mode 100644 drivers/of/of_reserved_mem_dma.c

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index aba13df56f3a..7ac330473ec9 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -81,4 +81,11 @@ config OF_RESERVED_MEM
 	help
 	  Helpers to allow for reservation of memory regions
 
+config OF_RESERVED_MEM_DMA
+	depends on OF_RESERVED_MEM
+	depends on HAVE_GENERIC_DMA_COHERENT
+	def_bool y
+	help
+	  Helpers for reserving memory regions for DMA use
+
 endmenu # OF
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index ed9660adad77..6142227ca854 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_OF_PCI)	+= of_pci.o
 obj-$(CONFIG_OF_PCI_IRQ)  += of_pci_irq.o
 obj-$(CONFIG_OF_MTD)	+= of_mtd.o
 obj-$(CONFIG_OF_RESERVED_MEM) += of_reserved_mem.o
+obj-$(CONFIG_OF_RESERVED_MEM_DMA) += of_reserved_mem_dma.o
diff --git a/drivers/of/of_reserved_mem_dma.c b/drivers/of/of_reserved_mem_dma.c
new file mode 100644
index 000000000000..53a4cac6084a
--- /dev/null
+++ b/drivers/of/of_reserved_mem_dma.c
@@ -0,0 +1,78 @@
+/*
+ * Device tree based initialization code for DMA reserved regions.
+ *
+ * Copyright (c) 2013, The Linux Foundation. All Rights Reserved.
+ * Copyright (c) 2013 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ * Author: Marek Szyprowski <m.szyprowski@samsung.com>
+ * Author: Josh Cartwright <joshc@codeaurora.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License or (at your optional) any later version of the license.
+ */
+#include <linux/memblock.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/of_platform.h>
+#include <linux/mm.h>
+#include <linux/sizes.h>
+#include <linux/mm_types.h>
+#include <linux/dma-mapping.h>
+#include <linux/of_reserved_mem.h>
+
+static void rmem_dma_device_init(struct reserved_mem *rmem,
+				 struct device *dev,
+				 struct of_phandle_args *args)
+{
+	dma_declare_coherent_memory(dev, rmem->base, rmem->base,
+		rmem->size, DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE);
+}
+
+static void rmem_dma_device_release(struct reserved_mem *rmem,
+				    struct device *dev)
+{
+	dma_release_declared_memory(dev);
+}
+
+static const struct reserved_mem_ops rmem_dma_ops = {
+	.device_init	= rmem_dma_device_init,
+	.device_release	= rmem_dma_device_release,
+};
+
+static int __init rmem_dma_setup(struct reserved_mem *rmem,
+				 unsigned long node,
+				 const char *uname)
+{
+	int err;
+
+	if (of_get_flat_dt_prop(node, "reusable", NULL))
+		return -EINVAL;
+
+	err = of_parse_flat_dt_reg(node, uname, &rmem->base, &rmem->size);
+	if (!err)
+		goto out_done;
+
+	err = of_parse_flat_dt_size(node, uname, &rmem->size);
+	if (err)
+		goto out_err;
+
+	rmem->base = memblock_alloc_base(rmem->size, PAGE_SIZE,
+					 MEMBLOCK_ALLOC_ANYWHERE);
+	memblock_free(rmem->base, rmem->size);
+
+out_done:
+	rmem->ops = &rmem_dma_ops;
+	pr_info("Reserved memory: created DMA memory pool at %pa, size %ld MiB\n",
+		&rmem->base, (unsigned long)rmem->size / SZ_1M);
+
+	return memblock_remove(rmem->base, rmem->size);
+
+out_err:
+	pr_err("Reserved memory: unable to setup '%s' memory region for DMA.\n",
+	       uname);
+	return err;
+}
+RESERVEDMEM_OF_DECLARE(dma, "shared-dma-pool", rmem_dma_setup);
-- 
1.7.9.5
