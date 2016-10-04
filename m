From: sricharan@codeaurora.org (Sricharan R)
Date: Tue,  4 Oct 2016 22:33:51 +0530
Subject: [PATCH V3 7/8] arm/arm64: dma-mapping: Call iommu's remove_device
 callback during device detach
In-Reply-To: <1475600632-21289-1-git-send-email-sricharan@codeaurora.org>
References: <1475600632-21289-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1475600632-21289-8-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dma_deconfigure calls arch_teardown_dma_ops in the device_detach path,
which is called when the device gets detached from the driver.
When the device was added, iommu's add_device callback was used to
add the device in to its iommu_group and setup the device to be ready
to use its iommu. Similarly, call remove_device callback to remove the
device from the group and reset any other device's iommu configurations.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm/mm/dma-mapping.c   | 8 ++++++++
 arch/arm64/mm/dma-mapping.c | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index b9191f0..cbe22de 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2289,11 +2289,19 @@ static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
 static void arm_teardown_iommu_dma_ops(struct device *dev)
 {
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
+	const struct iommu_ops *ops;
 
 	if (!mapping)
 		return;
 
 	__arm_iommu_detach_device(dev);
+
+	if (dev->iommu_fwspec) {
+		ops = dev->iommu_fwspec->ops;
+		if (ops->remove_device)
+			ops->remove_device(dev);
+	}
+
 	arm_iommu_release_mapping(mapping);
 	set_dma_ops(dev, NULL);
 }
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 610d8e5..faf4b92 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -938,6 +938,13 @@ static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 void arch_teardown_dma_ops(struct device *dev)
 {
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	const struct iommu_ops *ops;
+
+	if (dev->iommu_fwspec) {
+		ops = dev->iommu_fwspec->ops;
+		if (ops->remove_device)
+			ops->remove_device(dev);
+	}
 
 	if (WARN_ON(domain))
 		iommu_detach_device(domain, dev);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
