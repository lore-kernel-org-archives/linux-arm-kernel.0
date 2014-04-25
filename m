From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 25 Apr 2014 18:34:13 +0100
Subject: [PATCH 2/3] arm64: Use bus notifiers to set per-device coherent DMA
 ops
In-Reply-To: <1398447254-18527-1-git-send-email-catalin.marinas@arm.com>
References: <1398447254-18527-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1398447254-18527-3-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recently, the default DMA ops have been changed to non-coherent for
alignment with 32-bit ARM platforms (and DT files). This patch adds bus
notifiers to be able to set the coherent DMA ops (with no cache
maintenance) for devices explicitly marked as coherent via the
"dma-coherent" DT property.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/setup.c   |  2 +-
 arch/arm64/mm/dma-mapping.c | 33 ++++++++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 720853f70b6b..b89e4914b7e4 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -397,7 +397,7 @@ static int __init arm64_device_init(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 	return 0;
 }
-arch_initcall(arm64_device_init);
+arch_initcall_sync(arm64_device_init);
 
 static DEFINE_PER_CPU(struct cpu, cpu_data);
 
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 1f65963a9c04..c851eb44dc50 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -22,8 +22,11 @@
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
 #include <linux/dma-contiguous.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/vmalloc.h>
 #include <linux/swiotlb.h>
+#include <linux/amba/bus.h>
 
 #include <asm/cacheflush.h>
 
@@ -305,17 +308,45 @@ struct dma_map_ops coherent_swiotlb_dma_ops = {
 };
 EXPORT_SYMBOL(coherent_swiotlb_dma_ops);
 
+static int dma_bus_notifier(struct notifier_block *nb,
+			    unsigned long event, void *_dev)
+{
+	struct device *dev = _dev;
+
+	if (event != BUS_NOTIFY_ADD_DEVICE)
+		return NOTIFY_DONE;
+
+	if (of_property_read_bool(dev->of_node, "dma-coherent"))
+		set_dma_ops(dev, &coherent_swiotlb_dma_ops);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block platform_bus_nb = {
+	.notifier_call = dma_bus_notifier,
+};
+
+static struct notifier_block amba_bus_nb = {
+	.notifier_call = dma_bus_notifier,
+};
+
 extern int swiotlb_late_init_with_default_size(size_t default_size);
 
 static int __init swiotlb_late_init(void)
 {
 	size_t swiotlb_size = min(SZ_64M, MAX_ORDER_NR_PAGES << PAGE_SHIFT);
 
+	/*
+	 * These must be registered before of_platform_populate().
+	 */
+	bus_register_notifier(&platform_bus_type, &platform_bus_nb);
+	bus_register_notifier(&amba_bustype, &amba_bus_nb);
+
 	dma_ops = &noncoherent_swiotlb_dma_ops;
 
 	return swiotlb_late_init_with_default_size(swiotlb_size);
 }
-subsys_initcall(swiotlb_late_init);
+arch_initcall(swiotlb_late_init);
 
 #define PREALLOC_DMA_DEBUG_ENTRIES	4096
 
