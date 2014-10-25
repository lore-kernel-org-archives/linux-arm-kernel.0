From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Sat, 25 Oct 2014 14:57:19 +0100
Subject: [PATCH v6 4/7] xen/arm: use is_dma_coherent
In-Reply-To: <alpine.DEB.2.02.1410251450180.22875@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1410251450180.22875@kaball.uk.xensource.com>
Message-ID: <1414245442-4306-4-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use is_dma_coherent to check whether we need to issue cache maintenance
operations rather than checking on the existence of a particular
dma_ops function for the device.

This is correct because coherent devices don't need cache maintenance
operations - arm_coherent_dma_ops does not set the hooks that we
were previously checking for existance.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Acked-by: Ian Campbell <ian.campbell@citrix.com>
---
 arch/arm/xen/mm32.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/xen/mm32.c b/arch/arm/xen/mm32.c
index 2b259f1..4daf931 100644
--- a/arch/arm/xen/mm32.c
+++ b/arch/arm/xen/mm32.c
@@ -82,7 +82,7 @@ void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
 		struct dma_attrs *attrs)
 
 {
-	if (!__generic_dma_ops(hwdev)->unmap_page)
+	if (is_dma_coherent(hwdev))
 		return;
 	if (dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
 		return;
@@ -93,7 +93,7 @@ void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
 void xen_dma_sync_single_for_cpu(struct device *hwdev,
 		dma_addr_t handle, size_t size, enum dma_data_direction dir)
 {
-	if (!__generic_dma_ops(hwdev)->sync_single_for_cpu)
+	if (is_dma_coherent(hwdev))
 		return;
 	__xen_dma_page_dev_to_cpu(hwdev, handle, size, dir);
 }
@@ -101,7 +101,7 @@ void xen_dma_sync_single_for_cpu(struct device *hwdev,
 void xen_dma_sync_single_for_device(struct device *hwdev,
 		dma_addr_t handle, size_t size, enum dma_data_direction dir)
 {
-	if (!__generic_dma_ops(hwdev)->sync_single_for_device)
+	if (is_dma_coherent(hwdev))
 		return;
 	__xen_dma_page_cpu_to_dev(hwdev, handle, size, dir);
 }
-- 
1.7.10.4
