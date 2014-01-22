From: joshc@codeaurora.org (Josh Cartwright)
Date: Wed, 22 Jan 2014 12:58:50 -0600
Subject: [PATCH RFC 2/4] drivers: of: implement reserved-memory handling for
 dma
In-Reply-To: <1390417133-6650-1-git-send-email-joshc@codeaurora.org>
References: <1390417133-6650-1-git-send-email-joshc@codeaurora.org>
Message-ID: <1390417133-6650-3-git-send-email-joshc@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for handling 'shared-dma-pool' reserved-memory nodes.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Laura Abbott <lauraa@codeaurora.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
---
 drivers/of/Kconfig               |   7 ++
 drivers/of/Makefile              |   1 +
 drivers/of/of_reserved_mem_dma.c | 178 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 186 insertions(+)
 create mode 100644 drivers/of/of_reserved_mem_dma.c

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index aba13df..ca58fb3e 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -81,4 +81,11 @@ config OF_RESERVED_MEM
 	help
 	  Helpers to allow for reservation of memory regions
 
+config OF_RESERVED_MEM_DMA
+	depends on OF_RESERVED_MEM
+	depends on DMA_CMA || HAVE_GENERIC_DMA_COHERENT
+	def_bool y
+	help
+	  Helpers for reserving memory regions for DMA use
+
 endmenu # OF
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index ed9660a..6142227 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_OF_PCI)	+= of_pci.o
 obj-$(CONFIG_OF_PCI_IRQ)  += of_pci_irq.o
 obj-$(CONFIG_OF_MTD)	+= of_mtd.o
 obj-$(CONFIG_OF_RESERVED_MEM) += of_reserved_mem.o
+obj-$(CONFIG_OF_RESERVED_MEM_DMA) += of_reserved_mem_dma.o
diff --git a/drivers/of/of_reserved_mem_dma.c b/drivers/of/of_reserved_mem_dma.c
new file mode 100644
index 0000000..e24f02d
--- /dev/null
+++ b/drivers/of/of_reserved_mem_dma.c
@@ -0,0 +1,178 @@
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
+#include <linux/dma-contiguous.h>
+#include <linux/dma-mapping.h>
+#include <linux/of_reserved_mem.h>
+
+static void rmem_dma_device_init(struct reserved_mem *rmem,
+				 struct platform_device *pdev,
+				 struct of_phandle_args *args)
+{
+	dma_declare_coherent_memory(&pdev->dev, rmem->base, rmem->base,
+		rmem->size, DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE);
+}
+
+static void rmem_dma_device_release(struct reserved_mem *rmem,
+				    struct platform_device *pdev)
+{
+	dma_release_declared_memory(&pdev->dev);
+}
+
+static const struct reserved_mem_ops rmem_dma_ops = {
+	.device_init	= rmem_dma_device_init,
+	.device_release	= rmem_dma_device_release,
+};
+
+static int __init rmem_dma_get_reg(unsigned long node, const char *uname,
+				   phys_addr_t *base, phys_addr_t *size)
+{
+	unsigned long len;
+	__be32 *prop;
+
+	prop = of_get_flat_dt_prop(node, "reg", &len);
+	if (!prop)
+		return -EINVAL;
+
+	if (len < (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32)) {
+		pr_err("Malformed 'shared-dma-pool' reserved-mem node '%s'.\n",
+				uname);
+		return -EINVAL;
+	}
+
+	*base = dt_mem_next_cell(dt_root_addr_cells, &prop);
+	*size = dt_mem_next_cell(dt_root_size_cells, &prop);
+	return 0;
+}
+
+static int __init rmem_dma_get_size(unsigned long node, const char *uname,
+				    phys_addr_t *size)
+{
+	unsigned long len;
+	__be32 *prop;
+
+	prop = of_get_flat_dt_prop(node, "size", &len);
+	if (!prop)
+		return -EINVAL;
+
+	if (len < dt_root_size_cells * sizeof(__be32)) {
+		pr_err("Malformed 'shared-dma-pool' reserved-mem node '%s'.\n",
+				uname);
+		return -EINVAL;
+	}
+
+	*size = dt_mem_next_cell(dt_root_size_cells, &prop);
+	return 0;
+}
+
+static void rmem_cma_device_init(struct reserved_mem *rmem,
+				 struct platform_device *pdev,
+				 struct of_phandle_args *args)
+{
+	dev_set_cma_area(&pdev->dev, rmem->cma);
+}
+
+static const struct reserved_mem_ops rmem_cma_ops = {
+	.device_init	= rmem_cma_device_init,
+};
+
+static int __init rmem_cma_reserve_area(struct reserved_mem *rmem,
+					unsigned long node, const char *uname)
+{
+	int err;
+
+	err = dma_contiguous_reserve_area(rmem->size, rmem->base, 0,
+					  &rmem->cma);
+	if (err) {
+		pr_err("Unable to setup CMA reserved-mem region for '%s'.\n",
+				uname);
+		return err;
+	}
+
+	if (of_get_flat_dt_prop(node, "linux,cma-default", NULL))
+		dma_contiguous_set_default(rmem->cma);
+
+	rmem->ops = &rmem_cma_ops;
+	return 0;
+}
+
+static int __init rmem_cma_setup(struct reserved_mem *rmem,
+				 unsigned long node,
+				 const char *uname)
+{
+	int err;
+
+	err = rmem_dma_get_reg(node, uname, &rmem->base, &rmem->size);
+	if (!err)
+		goto out_done;
+
+	rmem->base = 0;
+	err = rmem_dma_get_size(node, uname, &rmem->size);
+	if (err)
+		goto out_err;
+
+out_done:
+	return rmem_cma_reserve_area(rmem, node, uname);
+
+out_err:
+	pr_err("Malformed 'shared-dma-pool' node '%s'.\n", uname);
+	return err;
+}
+
+static int __init rmem_dma_excl_setup(struct reserved_mem *rmem,
+				      unsigned long node,
+				      const char *uname)
+{
+	int err;
+
+	err = rmem_dma_get_reg(node, uname, &rmem->base, &rmem->size);
+	if (!err)
+		goto out_done;
+
+	err = rmem_dma_get_size(node, uname, &rmem->size);
+	if (err)
+		goto out_err;
+
+	rmem->base = memblock_alloc_base(rmem->size, PAGE_SIZE,
+					 MEMBLOCK_ALLOC_ANYWHERE);
+	memblock_free(rmem->base, rmem->size);
+
+out_done:
+	rmem->ops = &rmem_dma_ops;
+	return memblock_remove(rmem->base, rmem->size);
+
+out_err:
+	pr_err("Unable to setup reserved-mem region '%s' for DMA.\n", uname);
+	return err;
+}
+
+static int __init rmem_dma_setup(struct reserved_mem *rmem,
+				 unsigned long node,
+				 const char *uname)
+{
+	if (IS_ENABLED(CONFIG_DMA_CMA) &&
+		of_get_flat_dt_prop(node, "reusable", NULL))
+		return rmem_cma_setup(rmem, node, uname);
+
+	return rmem_dma_excl_setup(rmem, node, uname);
+}
+RESERVEDMEM_OF_DECLARE(dma, "shared-dma-pool", rmem_dma_setup);
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
