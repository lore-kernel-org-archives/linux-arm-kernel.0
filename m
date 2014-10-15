From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 15 Oct 2014 13:01:42 +0200
Subject: [PATCH v4] drivers: of: add return value to
 of_reserved_mem_device_init
In-Reply-To: <13963062.ORRNOhrvYD@wuerfel>
References: <13963062.ORRNOhrvYD@wuerfel>
Message-ID: <1413370902-28187-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Driver calling of_reserved_mem_device_init() might be interested if the
initialization has been successful or not, so add support for returning
error code.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
This patch fixes build warining caused by commit
7bfa5ab6fa1b18f53fb94f922e107e6fbdc5e485 ("drivers: dma-coherent: add
initialization from device tree"), which has been merged without this
change and without fixing function return value.
---
 drivers/base/dma-contiguous.c   |  3 ++-
 drivers/of/of_reserved_mem.c    | 14 +++++++++-----
 include/linux/of_reserved_mem.h |  9 ++++++---
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
index 473ff4892401..950fff9ce453 100644
--- a/drivers/base/dma-contiguous.c
+++ b/drivers/base/dma-contiguous.c
@@ -223,9 +223,10 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
 #undef pr_fmt
 #define pr_fmt(fmt) fmt
 
-static void rmem_cma_device_init(struct reserved_mem *rmem, struct device *dev)
+static int rmem_cma_device_init(struct reserved_mem *rmem, struct device *dev)
 {
 	dev_set_cma_area(dev, rmem->priv);
+	return 0;
 }
 
 static void rmem_cma_device_release(struct reserved_mem *rmem,
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 59fb12e84e6b..dc566b38645f 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -243,23 +243,27 @@ static inline struct reserved_mem *__find_rmem(struct device_node *node)
  * This function assign memory region pointed by "memory-region" device tree
  * property to the given device.
  */
-void of_reserved_mem_device_init(struct device *dev)
+int of_reserved_mem_device_init(struct device *dev)
 {
 	struct reserved_mem *rmem;
 	struct device_node *np;
+	int ret;
 
 	np = of_parse_phandle(dev->of_node, "memory-region", 0);
 	if (!np)
-		return;
+		return -ENODEV;
 
 	rmem = __find_rmem(np);
 	of_node_put(np);
 
 	if (!rmem || !rmem->ops || !rmem->ops->device_init)
-		return;
+		return -EINVAL;
+
+	ret = rmem->ops->device_init(rmem, dev);
+	if (ret == 0)
+		dev_info(dev, "assigned reserved memory node %s\n", rmem->name);
 
-	rmem->ops->device_init(rmem, dev);
-	dev_info(dev, "assigned reserved memory node %s\n", rmem->name);
+	return ret;
 }
 
 /**
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index 5b5efae09135..ad2f67054372 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -16,7 +16,7 @@ struct reserved_mem {
 };
 
 struct reserved_mem_ops {
-	void	(*device_init)(struct reserved_mem *rmem,
+	int	(*device_init)(struct reserved_mem *rmem,
 			       struct device *dev);
 	void	(*device_release)(struct reserved_mem *rmem,
 				  struct device *dev);
@@ -28,14 +28,17 @@ typedef int (*reservedmem_of_init_fn)(struct reserved_mem *rmem);
 	_OF_DECLARE(reservedmem, name, compat, init, reservedmem_of_init_fn)
 
 #ifdef CONFIG_OF_RESERVED_MEM
-void of_reserved_mem_device_init(struct device *dev);
+int of_reserved_mem_device_init(struct device *dev);
 void of_reserved_mem_device_release(struct device *dev);
 
 void fdt_init_reserved_mem(void);
 void fdt_reserved_mem_save_node(unsigned long node, const char *uname,
 			       phys_addr_t base, phys_addr_t size);
 #else
-static inline void of_reserved_mem_device_init(struct device *dev) { }
+static inline int of_reserved_mem_device_init(struct device *dev)
+{
+	return -ENOSYS;
+}
 static inline void of_reserved_mem_device_release(struct device *pdev) { }
 
 static inline void fdt_init_reserved_mem(void) { }
-- 
1.9.2
