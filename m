From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 20 Jun 2014 14:28:48 +0200
Subject: [PATCH v9.1] of: Provide function to request and map memory
In-Reply-To: <1403264929-21325-2-git-send-email-matthias.bgg@gmail.com>
References: <1403264929-21325-2-git-send-email-matthias.bgg@gmail.com>
Message-ID: <1403267328-23085-1-git-send-email-matthias.bgg@gmail.com>
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
Changes for v9.1:
- fixed the Author email address

 drivers/of/address.c       |   29 +++++++++++++++++++++++++++++
 include/linux/of_address.h |    8 ++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index cb4242a..09074ba 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -721,3 +721,32 @@ void __iomem *of_iomap(struct device_node *np, int index)
 	return ioremap(res.start, resource_size(&res));
 }
 EXPORT_SYMBOL(of_iomap);
+
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
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 5f6ed6b..725b875 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -96,6 +96,8 @@ static inline struct of_pci_range *of_pci_range_parser_one(
 extern int of_address_to_resource(struct device_node *dev, int index,
 				  struct resource *r);
 void __iomem *of_iomap(struct device_node *node, int index);
+void __iomem *of_io_request_and_map(struct device_node *device,
+					int index, char *name);
 #else
 static inline int of_address_to_resource(struct device_node *dev, int index,
 					 struct resource *r)
@@ -107,6 +109,12 @@ static inline void __iomem *of_iomap(struct device_node *device, int index)
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
