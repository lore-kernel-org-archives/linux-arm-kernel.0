From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 11 Jun 2014 14:34:09 +0200
Subject: [PATCH v8 1/7] of: Provide function to request and map memory
In-Reply-To: <1402490055-15197-1-git-send-email-matthias.bgg@gmail.com>
References: <1402490055-15197-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <1402490055-15197-2-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A call to of_iomap does not request the memory region.
This patch adds the function of_io_request_and_map which requests
the memory region before mapping it.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Rob Herring <robh@kernel.org>
Acked-by: Grant Likely <grant.likely@linaro.org>
---
 drivers/of/address.c       |   29 +++++++++++++++++++++++++++++
 include/linux/of_address.h |    8 ++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 5edfcb0..d6b2900 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -702,6 +702,35 @@ void __iomem *of_iomap(struct device_node *np, int index)
 }
 EXPORT_SYMBOL(of_iomap);
 
+/*
+ * of_io_request_and_map - Requests a resource and maps the memory mapped IO
+ *			   for a given device_node
+ * @device:	the device whose io range will be mapped
+ * @index:	index of the io range
+ * @name:	name of the resource
+ *
+ * Returns a pointer to the requested and mapped memory
+ */
+void __iomem *of_io_request_and_map(struct device_node *np, int index,
+					char *name)
+{
+	struct resource res;
+	void __iomem *mem;
+
+	if (of_address_to_resource(np, index, &res))
+		return NULL;
+
+	if (!request_mem_region(res.start, resource_size(&res), name))
+		return NULL;
+
+	mem = ioremap(res.start, resource_size(&res));
+	if (!mem)
+		release_mem_region(res.start, resource_size(&res));
+
+	return mem;
+}
+EXPORT_SYMBOL(of_io_request_and_map);
+
 /**
  * of_dma_get_range - Get DMA range info
  * @np:		device node to get DMA range info
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index c13b878..0a13482 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -109,6 +109,8 @@ static inline bool of_dma_is_coherent(struct device_node *np)
 extern int of_address_to_resource(struct device_node *dev, int index,
 				  struct resource *r);
 void __iomem *of_iomap(struct device_node *node, int index);
+void __iomem *of_io_request_and_map(struct device_node *device,
+					int index, char *name);
 #else
 static inline int of_address_to_resource(struct device_node *dev, int index,
 					 struct resource *r)
@@ -120,6 +122,12 @@ static inline void __iomem *of_iomap(struct device_node *device, int index)
 {
 	return NULL;
 }
+
+static inline void __iomem *of_io_request_and_map(struct device_node *device,
+					int index, char *name)
+{
+	return NULL;
+}
 #endif
 
 #if defined(CONFIG_OF_ADDRESS) && defined(CONFIG_PCI)
-- 
1.7.9.5
