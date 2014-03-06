From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 6 Mar 2014 17:19:53 +0800
Subject: [PATCH 2/7] of: introduce of_dma_get_range() helper
In-Reply-To: <1394097598-17622-1-git-send-email-santosh.shilimkar@ti.com>
References: <1394097598-17622-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1394097598-17622-3-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

The of_dma_get_range() allows to find "dma-range" property for
the specified device and parse it.
 dma-ranges format:
   DMA addr (dma_addr)          : naddr cells
   CPU addr (phys_addr_t)       : pna cells
   size                         : nsize cells

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/of/platform.c       |   85 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/of_platform.h |    8 ++++
 2 files changed, 93 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 404d1da..2265a55 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -485,4 +485,89 @@ int of_platform_populate(struct device_node *root,
 	return rc;
 }
 EXPORT_SYMBOL_GPL(of_platform_populate);
+
+/**
+ * of_dma_get_range - Get DMA range info
+ * @np:		device node to get DMA range info
+ * @dma_addr:	pointer to store initial DMA address of DMA range
+ * @paddr:	pointer to store initial CPU address of DMA range
+ * @size:	pointer to store size of DMA range
+ *
+ * Look in bottom up direction for the first "dma-range" property
+ * and parse it.
+ *  dma-ranges format:
+ *	DMA addr (dma_addr)	: naddr cells
+ *	CPU addr (phys_addr_t)	: pna cells
+ *	size			: nsize cells
+ *
+ * It returns -ENODEV if "dma-ranges" property was not found
+ * for this device in DT.
+ */
+extern int of_dma_get_range(struct device_node *np, dma_addr_t *dma_addr,
+		phys_addr_t *paddr, phys_addr_t *size)
+{
+	struct device_node *node = np;
+	const u32 *ranges = NULL;
+	int len, naddr, nsize, pna;
+	int ret = 0;
+
+	if (!node)
+		return -EINVAL;
+
+	while (1) {
+		naddr = of_n_addr_cells(node);
+		nsize = of_n_size_cells(node);
+		node = of_get_next_parent(node);
+		if (!node)
+			break;
+
+		ranges = of_get_property(node, "dma-ranges", &len);
+
+		/* Ignore empty ranges, they imply no translation required */
+		if (ranges && len > 0)
+			break;
+
+		/*
+		 * At least empty ranges has to be defined for parent node if
+		 * DMA is supported
+		 */
+		if (!ranges)
+			break;
+	}
+
+	if (!ranges) {
+		pr_debug("%s: no dma-ranges found for node(%s)\n",
+			 __func__, np->full_name);
+		ret = -ENODEV;
+		goto out;
+	}
+
+	len /= sizeof(u32);
+
+	pna = of_n_addr_cells(node);
+
+	/* dma-ranges format:
+	 * DMA addr	: naddr cells
+	 * CPU addr	: pna cells
+	 * size		: nsize cells
+	 */
+	*dma_addr = of_read_number(ranges, naddr);
+	*paddr = of_translate_dma_address(np, ranges);
+	if (*paddr == OF_BAD_ADDR) {
+		pr_err("%s: translation of DMA address(%pad) to CPU address failed node(%s)\n",
+		       __func__, dma_addr, np->full_name);
+		ret = -EINVAL;
+	}
+
+	*size = of_read_number(ranges + naddr + pna, nsize);
+
+	pr_debug("dma_addr(%pad) cpu_addr(%pa) size(%pa)\n",
+		 dma_addr, paddr, size);
+
+out:
+	of_node_put(node);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_dma_get_range);
 #endif /* CONFIG_OF_ADDRESS */
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 05cb4a9..ba7d3dc 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -72,6 +72,8 @@ extern int of_platform_populate(struct device_node *root,
 				const struct of_device_id *matches,
 				const struct of_dev_auxdata *lookup,
 				struct device *parent);
+extern int of_dma_get_range(struct device_node *np, dma_addr_t *dma_addr,
+				phys_addr_t *paddr, phys_addr_t *size);
 #else
 static inline int of_platform_populate(struct device_node *root,
 					const struct of_device_id *matches,
@@ -80,6 +82,12 @@ static inline int of_platform_populate(struct device_node *root,
 {
 	return -ENODEV;
 }
+
+static inline int of_dma_get_range(struct device_node *np, dma_addr_t *dma_addr,
+					phys_addr_t *paddr, phys_addr_t *size)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif	/* _LINUX_OF_PLATFORM_H */
-- 
1.7.9.5
