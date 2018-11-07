From: elder@linaro.org (Alex Elder)
Date: Tue,  6 Nov 2018 18:32:40 -0600
Subject: [RFC PATCH 02/12] soc: qcom: ipa: DMA helpers
In-Reply-To: <20181107003250.5832-1-elder@linaro.org>
References: <20181107003250.5832-1-elder@linaro.org>
Message-ID: <20181107003250.5832-3-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch includes code implementing the IPA DMA module, which
defines a structure to represent a DMA allocation for the IPA device.
It's used throughout the IPA code.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_dma.c | 61 +++++++++++++++++++++++++++++++++++++++
 drivers/net/ipa/ipa_dma.h | 61 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100644 drivers/net/ipa/ipa_dma.c
 create mode 100644 drivers/net/ipa/ipa_dma.h

diff --git a/drivers/net/ipa/ipa_dma.c b/drivers/net/ipa/ipa_dma.c
new file mode 100644
index 000000000000..dfde59e5072a
--- /dev/null
+++ b/drivers/net/ipa/ipa_dma.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2018 Linaro Ltd.
+ */
+
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/string.h>
+
+#include "ipa_dma.h"
+
+static struct device *ipa_dma_dev;
+
+int ipa_dma_init(struct device *dev, u32 align)
+{
+	int ret;
+
+	/* Ensure DMA addresses will have the alignment we require */
+	if (dma_get_cache_alignment() % align)
+		return -ENOTSUPP;
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	if (!ret)
+		ipa_dma_dev = dev;
+
+	return ret;
+}
+
+void ipa_dma_exit(void)
+{
+	ipa_dma_dev = NULL;
+}
+
+int ipa_dma_alloc(struct ipa_dma_mem *mem, size_t size, gfp_t gfp)
+{
+	dma_addr_t phys;
+	void *virt;
+
+	virt = dma_zalloc_coherent(ipa_dma_dev, size, &phys, gfp);
+	if (!virt)
+		return -ENOMEM;
+
+	mem->virt = virt;
+	mem->phys = phys;
+	mem->size = size;
+
+	return 0;
+}
+
+void ipa_dma_free(struct ipa_dma_mem *mem)
+{
+	dma_free_coherent(ipa_dma_dev, mem->size, mem->virt, mem->phys);
+	memset(mem, 0, sizeof(*mem));
+}
+
+void *ipa_dma_phys_to_virt(struct ipa_dma_mem *mem, dma_addr_t phys)
+{
+	return mem->virt + (phys - mem->phys);
+}
diff --git a/drivers/net/ipa/ipa_dma.h b/drivers/net/ipa/ipa_dma.h
new file mode 100644
index 000000000000..e211dbd9d4ec
--- /dev/null
+++ b/drivers/net/ipa/ipa_dma.h
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2018 Linaro Ltd.
+ */
+#ifndef _IPA_DMA_H_
+#define _IPA_DMA_H_
+
+#include <linux/types.h>
+#include <linux/device.h>
+
+/**
+ * struct ipa_dma_mem - IPA allocated DMA memory descriptor
+ * @virt: host virtual base address of allocated DMA memory
+ * @phys: bus physical base address of DMA memory
+ * @size: size (bytes) of DMA memory
+ */
+struct ipa_dma_mem {
+	void *virt;
+	dma_addr_t phys;
+	size_t size;
+};
+
+/**
+ * ipa_dma_init() - Initialize IPA DMA system.
+ * @dev:	IPA device structure
+ * @align:	Hardware required alignment for DMA memory
+ *
+ * Returns:	 0 if successful, or a negative error code.
+ */
+int ipa_dma_init(struct device *dev, u32 align);
+
+/**
+ * ipa_dma_exit() - shut down/clean up IPA DMA system
+ */
+void ipa_dma_exit(void);
+
+/**
+ * ipa_dma_alloc() - allocate a DMA buffer, describe it in mem struct
+ * @mem:	Memory structure to fill with allocation information.
+ * @size:	Size of DMA buffer to allocate.
+ * @gfp:	Allocation mode.
+ */
+int ipa_dma_alloc(struct ipa_dma_mem *mem, size_t size, gfp_t gfp);
+
+/**
+ * ipa_dma_free() - free a previously-allocated DMA buffer
+ * @mem:	Information about DMA allocation to free
+ */
+void ipa_dma_free(struct ipa_dma_mem *mem);
+
+/**
+ * ipa_dma_phys_to_virt() - return the virtual equivalent of a DMA address
+ * @phys:	DMA allocation information
+ * @phys:	Physical address to convert
+ *
+ * Return:	Virtual address corresponding to the given physical address
+ */
+void *ipa_dma_phys_to_virt(struct ipa_dma_mem *mem, dma_addr_t phys);
+
+#endif /* !_IPA_DMA_H_ */
-- 
2.17.1
