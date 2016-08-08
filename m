From: anup.patel@broadcom.com (Anup Patel)
Date: Mon,  8 Aug 2016 11:22:37 +0530
Subject: [PATCH RESEND v2 8/8] uio: Use new memtypes in uio_dmem_genirq
In-Reply-To: <1470635557-13416-1-git-send-email-anup.patel@broadcom.com>
References: <1470635557-13416-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1470635557-13416-9-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch extends uio_dmem_genirq driver to use recently
added memtypes as follows:
1. Use UIO_MEM_DEVICE memtype for MEM resources
2. Use UIO_MEM_PHYS_CACHE memtype for dynamic regions
when UIO DT node is marked as DMA coherent.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
---
 drivers/uio/uio_dmem_genirq.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
index 1db2559..ce36afd 100644
--- a/drivers/uio/uio_dmem_genirq.c
+++ b/drivers/uio/uio_dmem_genirq.c
@@ -327,7 +327,7 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
 			break;
 		}
 
-		uiomem->memtype = UIO_MEM_PHYS;
+		uiomem->memtype = UIO_MEM_DEVICE;
 		uiomem->addr = r->start;
 		uiomem->size = resource_size(r);
 		++uiomem;
@@ -343,7 +343,12 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
 					" dynamic and fixed memory regions.\n");
 			break;
 		}
-		uiomem->memtype = UIO_MEM_PHYS;
+
+		if (pdev->dev.of_node &&
+		    of_dma_is_coherent(pdev->dev.of_node))
+			uiomem->memtype = UIO_MEM_PHYS_CACHE;
+		else
+			uiomem->memtype = UIO_MEM_PHYS;
 		uiomem->addr = DMEM_MAP_ERROR;
 		uiomem->size = pdata->dynamic_region_sizes[i];
 		++uiomem;
-- 
1.9.1
