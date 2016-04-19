From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 19 Apr 2016 17:01:31 +0100
Subject: [PATCH 1/2] arm64/dma-mapping: Extend DMA ops workaround to PCI
 devices
Message-ID: <d5297227e1501e722235a6cd2b22d1285d3f9135.1461080622.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCI devices now suffer the same hiccup as platform devices, in that they
get their DMA ops configured before they have been added to their bus,
and thus before we know whether they have successfully registered with
an IOMMU or not. Until the necessary driver core changes to reorder
calls during device creation have been worked out, extend our delayed
notifier trick onto the PCI bus so as to avoid broken DMA ops once
IOMMUs get plugged into the PCI code.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Resending these two separately from the generic bindings series[1]
since they only need to go in before the rest, so it wouldn't hurt to
get them into 4.7.

[1]:http://thread.gmane.org/gmane.linux.kernel.iommu/12454/

 arch/arm64/mm/dma-mapping.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index a6e757cbab77..607e70911173 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -933,6 +933,10 @@ static int __init __iommu_dma_init(void)
 		ret = register_iommu_dma_ops_notifier(&platform_bus_type);
 	if (!ret)
 		ret = register_iommu_dma_ops_notifier(&amba_bustype);
+#ifdef CONFIG_PCI
+	if (!ret)
+		ret = register_iommu_dma_ops_notifier(&pci_bus_type);
+#endif
 
 	/* handle devices queued before this arch_initcall */
 	if (!ret)
-- 
2.8.1.dirty
