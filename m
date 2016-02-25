From: rrichter@caviumnetworks.com (Robert Richter)
Date: Thu, 25 Feb 2016 12:02:43 +0100
Subject: [PATCH 1/2] mm: cma: arm64: Introduce dma_activate_contiguous() for
 early activation
In-Reply-To: <1456398164-16864-1-git-send-email-rrichter@caviumnetworks.com>
References: <1456398164-16864-1-git-send-email-rrichter@caviumnetworks.com>
Message-ID: <1456398164-16864-2-git-send-email-rrichter@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

For the arm64 gicv3 interrupt controller we need CMA to allocate large
blocks of physically contiguous memory. Usually page_alloc() is
limited by 2^(MAX_ORDER - 1), which is typically 4MB at 4k pagesize.
A current gicv3-its device table may have a size of up to 16MB.

Since the interrupt controller is initialized before other subsystems
(initcall functions), current dma activation (core_initcall) is too
late and makes it unusable for gicv3. On the other side, it is
generally possible to activate dma alloc right after the kernel's
memory initialization.

Now, this patch implements dma_activate_contiguous() to allow
architectures to enable dma alloc earlier. It also enables early dma
activation for the arm64 subsystem directly before interrupt
initialization and thus makes CMA usable for gicv3's memory
allocation.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 arch/arm64/kernel/irq.c        |  4 ++++
 drivers/base/dma-contiguous.c  | 14 ++++++++++++++
 include/linux/cma.h            |  1 +
 include/linux/dma-contiguous.h |  8 ++++++++
 mm/cma.c                       |  6 +++++-
 5 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 9f17ec071ee0..913b32021f50 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -27,6 +27,7 @@
 #include <linux/init.h>
 #include <linux/irqchip.h>
 #include <linux/seq_file.h>
+#include <linux/dma-contiguous.h>
 
 unsigned long irq_err_count;
 
@@ -49,6 +50,9 @@ void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
 
 void __init init_IRQ(void)
 {
+	/* early activate cma since some gic controllers need it */
+	dma_activate_contiguous();
+
 	irqchip_init();
 	if (!handle_arch_irq)
 		panic("No interrupt controller found.");
diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
index e167a1e1bccb..1c73d4899e8d 100644
--- a/drivers/base/dma-contiguous.c
+++ b/drivers/base/dma-contiguous.c
@@ -212,6 +212,20 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
 	return cma_release(dev_get_cma_area(dev), pages, count);
 }
 
+/**
+ * dma_activate_contiguous() - activate reserved areas for contiguous
+ *			       memory handling
+ *
+ * This function enables contiguous memory allocation. It can be used
+ * by archs for early initialization right after the kernel memory
+ * subsystem (like slab allocator) is available and if the
+ * core_initcall for it is too late.
+ */
+int __init dma_activate_contiguous(void)
+{
+	return cma_init_reserved_areas();
+}
+
 /*
  * Support for reserved memory regions defined in device tree
  */
diff --git a/include/linux/cma.h b/include/linux/cma.h
index 29f9e774ab76..c2ab619769e6 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -23,6 +23,7 @@ extern int __init cma_declare_contiguous(phys_addr_t base,
 			phys_addr_t size, phys_addr_t limit,
 			phys_addr_t alignment, unsigned int order_per_bit,
 			bool fixed, struct cma **res_cma);
+extern int __init cma_init_reserved_areas(void);
 extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 					unsigned int order_per_bit,
 					struct cma **res_cma);
diff --git a/include/linux/dma-contiguous.h b/include/linux/dma-contiguous.h
index fec734df1524..07d542b8bb4d 100644
--- a/include/linux/dma-contiguous.h
+++ b/include/linux/dma-contiguous.h
@@ -111,6 +111,8 @@ static inline int dma_declare_contiguous(struct device *dev, phys_addr_t size,
 	return ret;
 }
 
+int __init dma_activate_contiguous(void);
+
 struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
 				       unsigned int order);
 bool dma_release_from_contiguous(struct device *dev, struct page *pages,
@@ -157,6 +159,12 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
 	return false;
 }
 
+static inline
+int dma_activate_contiguous(void)
+{
+	return -ENOSYS;
+}
+
 #endif
 
 #endif
diff --git a/mm/cma.c b/mm/cma.c
index ea506eb18cd6..be1f55782c25 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -142,10 +142,14 @@ static int __init cma_activate_area(struct cma *cma)
 	return -EINVAL;
 }
 
-static int __init cma_init_reserved_areas(void)
+int __init cma_init_reserved_areas(void)
 {
 	int i;
 
+	if (cma_area_count && cma_areas[0].bitmap)
+		/* Already activated */
+		return 0;
+
 	for (i = 0; i < cma_area_count; i++) {
 		int ret = cma_activate_area(&cma_areas[i]);
 
-- 
2.7.0.rc3
