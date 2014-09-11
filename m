From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 11 Sep 2014 13:22:39 +0200
Subject: [PATCH v2 1/3] drivers: of: add return value to
 of_reserved_mem_device_init
In-Reply-To: <1410434561-9294-1-git-send-email-m.szyprowski@samsung.com>
References: <1410434561-9294-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1410434561-9294-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Driver calling of_reserved_mem_device_init() might be interested if the
initialization has been successful or not, so add support for returning
error code.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/of/of_reserved_mem.c    | 3 ++-
 include/linux/of_reserved_mem.h | 9 ++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 59fb12e..7e7de03 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -243,7 +243,7 @@ static inline struct reserved_mem *__find_rmem(struct device_node *node)
  * This function assign memory region pointed by "memory-region" device tree
  * property to the given device.
  */
-void of_reserved_mem_device_init(struct device *dev)
+int of_reserved_mem_device_init(struct device *dev)
 {
 	struct reserved_mem *rmem;
 	struct device_node *np;
@@ -260,6 +260,7 @@ void of_reserved_mem_device_init(struct device *dev)
 
 	rmem->ops->device_init(rmem, dev);
 	dev_info(dev, "assigned reserved memory node %s\n", rmem->name);
+	return 0;
 }
 
 /**
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index 5b5efae..ad2f670 100644
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
