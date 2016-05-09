From: d-gerlach@ti.com (Dave Gerlach)
Date: Mon, 9 May 2016 16:41:50 -0500
Subject: [RFC PATCH 2/3] lib: devres: Add exec and exec_nocache versions of
 devm_ioremap
In-Reply-To: <1462830111-28172-1-git-send-email-d-gerlach@ti.com>
References: <1462830111-28172-1-git-send-email-d-gerlach@ti.com>
Message-ID: <1462830111-28172-3-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russ Dill <russ.dill@ti.com>

Now that there are _exec and _exec_nocache versions of ioremap, add devm
support for them.

Signed-off-by: Russ Dill <Russ.Dill@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 include/linux/io.h |  5 +++++
 lib/devres.c       | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/include/linux/io.h b/include/linux/io.h
index e2c8419278c1..1c0442e5d72c 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -79,6 +79,11 @@ void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t offset,
 				   resource_size_t size);
 void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
 				   resource_size_t size);
+void __iomem *devm_ioremap_exec(struct device *dev, resource_size_t offset,
+				unsigned long size);
+void __iomem *devm_ioremap_exec_nocache(struct device *dev,
+					resource_size_t offset,
+					unsigned long size);
 void devm_iounmap(struct device *dev, void __iomem *addr);
 int check_signature(const volatile void __iomem *io_addr,
 			const unsigned char *signature, int length);
diff --git a/lib/devres.c b/lib/devres.c
index cb1464c411a2..1181a739fd49 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -100,6 +100,64 @@ void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
 EXPORT_SYMBOL(devm_ioremap_wc);
 
 /**
+ * devm_ioremap_exec - Managed ioremap_exec()
+ * @dev: Generic device to remap IO address for
+ * @offset: BUS offset to map
+ * @size: Size of map
+ *
+ * Managed ioremap_exec().  Map is automatically unmapped on driver detach.
+ */
+void __iomem *devm_ioremap_exec(struct device *dev, resource_size_t offset,
+				unsigned long size)
+{
+	void __iomem **ptr, *addr;
+
+	ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	addr = ioremap_exec(offset, size);
+	if (addr) {
+		*ptr = addr;
+		devres_add(dev, ptr);
+	} else
+		devres_free(ptr);
+
+	return addr;
+}
+EXPORT_SYMBOL(devm_ioremap_exec);
+
+/**
+ * devm_ioremap_exec_nocache - Managed ioremap_exec_nocache()
+ * @dev: Generic device to remap IO address for
+ * @offset: BUS offset to map
+ * @size: Size of map
+ *
+ * Managed ioremap_exec_nocache().  Map is automatically unmapped on driver
+ * detach.
+ */
+void __iomem *devm_ioremap_exec_nocache(struct device *dev,
+					resource_size_t offset,
+					unsigned long size)
+{
+	void __iomem **ptr, *addr;
+
+	ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	addr = ioremap_exec_nocache(offset, size);
+	if (addr) {
+		*ptr = addr;
+		devres_add(dev, ptr);
+	} else
+		devres_free(ptr);
+
+	return addr;
+}
+EXPORT_SYMBOL(devm_ioremap_exec_nocache);
+
+/**
  * devm_iounmap - Managed iounmap()
  * @dev: Generic device to unmap for
  * @addr: Address to unmap
-- 
2.7.3
