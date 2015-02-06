From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu,  5 Feb 2015 16:32:00 -0800
Subject: [PATCH/RFC 2/4] of: Return error codes from of_dma_configure
In-Reply-To: <1423182722-16646-1-git-send-email-lauraa@codeaurora.org>
References: <1423182722-16646-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1423182722-16646-3-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_dma_configure is currently a void function. IOMMU configuration may
need to defer probing so return appropriate values.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 drivers/iommu/of_iommu.c  | 14 +++++++++++---
 drivers/of/device.c       |  9 +++++++--
 include/linux/of_device.h |  4 ++--
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 396bc77..01cd540 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -138,7 +138,7 @@ struct iommu_ops *of_iommu_configure(struct device *dev,
 {
 	struct of_phandle_args iommu_spec;
 	struct device_node *np;
-	struct iommu_ops *ops = NULL;
+	struct iommu_ops *ops = ERR_PTR(-ENODEV);
 	int idx = 0;
 
 	if (dev_is_pci(dev)) {
@@ -154,11 +154,19 @@ struct iommu_ops *of_iommu_configure(struct device *dev,
 	while (!of_parse_phandle_with_args(node, "iommus",
 					   "#iommu-cells", idx,
 					   &iommu_spec)) {
+		int ret;
+
 		np = iommu_spec.np;
 		ops = of_iommu_get_ops(np);
 
-		if (!ops || !ops->of_xlate || ops->of_xlate(dev, &iommu_spec))
+		if (!ops || !ops->of_xlate)
+			goto err_put_node;
+
+		ret = ops->of_xlate(dev, &iommu_spec);
+		if (ret) {
+			ops = ERR_PTR(ret);
 			goto err_put_node;
+		}
 
 		of_node_put(np);
 		idx++;
@@ -168,7 +176,7 @@ struct iommu_ops *of_iommu_configure(struct device *dev,
 
 err_put_node:
 	of_node_put(np);
-	return NULL;
+	return ops;
 }
 
 void __init of_iommu_init(void)
diff --git a/drivers/of/device.c b/drivers/of/device.c
index ccbc958..1ff7a7a 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -81,7 +81,7 @@ int of_device_add(struct platform_device *ofdev)
  * can use Platform bus notifier and handle BUS_NOTIFY_ADD_DEVICE event
  * to fix up DMA configuration.
  */
-void of_dma_configure(struct device *dev, struct device_node *np)
+int of_dma_configure(struct device *dev, struct device_node *np)
 {
 	u64 dma_addr, paddr, size;
 	int ret;
@@ -117,10 +117,15 @@ void of_dma_configure(struct device *dev, struct device_node *np)
 		coherent ? " " : " not ");
 
 	iommu = of_iommu_configure(dev, np);
+	if (PTR_ERR(iommu) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+	else if (IS_ERR(iommu))
+		iommu = NULL;
+
 	dev_dbg(dev, "device is%sbehind an iommu\n",
 		iommu ? " " : " not ");
 
-	arch_setup_dma_ops(dev, dma_addr, size, iommu, coherent);
+	return arch_setup_dma_ops(dev, dma_addr, size, iommu, coherent);
 }
 EXPORT_SYMBOL_GPL(of_dma_configure);
 
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index c661496..c0821c0 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -53,7 +53,7 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
 	return of_node_get(cpu_dev->of_node);
 }
 
-void of_dma_configure(struct device *dev, struct device_node *np);
+int of_dma_configure(struct device *dev, struct device_node *np);
 #else /* CONFIG_OF */
 
 static inline int of_driver_match_device(struct device *dev,
@@ -91,7 +91,7 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
 {
 	return NULL;
 }
-void of_dma_configure(struct device *dev, struct device_node *np) { }
+int of_dma_configure(struct device *dev, struct device_node *np) { return -ENXIO; }
 #endif /* CONFIG_OF */
 
 #endif /* _LINUX_OF_DEVICE_H */
-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
