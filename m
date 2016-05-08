From: niklas.soderlund+renesas@ragnatech.se (=?UTF-8?q?Niklas=20S=C3=B6derlund?=)
Date: Sun,  8 May 2016 12:59:56 +0200
Subject: [PATCH 2/2] iommu/io-pgtable-arm: use __dma_sync_single_for_device()
In-Reply-To: <1462705196-10857-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1462705196-10857-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Message-ID: <1462705196-10857-3-git-send-email-niklas.soderlund+renesas@ragnatech.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The call to dma_sync_single_for_device() can be reached from
dma_map_single(). If CONFIG_DMA_API_DEBUG is enabled this would result
in a check that the mapping being synced is valid. Since the call to
dma_map_single is not yet completed the mapping is not recorded in
dma-debug and the check fails and a warning is printed. Avoid this
warning by calling __dma_sync_single_for_device() which don't preform
this check.

Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/iommu/io-pgtable-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index f433b51..3da8102 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -255,7 +255,7 @@ static void __arm_lpae_set_pte(arm_lpae_iopte *ptep, arm_lpae_iopte pte,
 	*ptep = pte;
 
 	if (!selftest_running)
-		dma_sync_single_for_device(cfg->iommu_dev,
+		__dma_sync_single_for_device(cfg->iommu_dev,
 					   __arm_lpae_dma_addr(ptep),
 					   sizeof(pte), DMA_TO_DEVICE);
 }
-- 
2.8.2
