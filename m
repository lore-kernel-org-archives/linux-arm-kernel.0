From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 10 Apr 2018 14:25:03 -0400
Subject: [PATCH] drm/amdgpu: limit DMA size to PAGE_SIZE for scatter-gather
 buffers
Message-ID: <1523384705-3976-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Code is expecing to observe the same number of buffers returned from
dma_map_sg() function compared to sg_alloc_table_from_pages(). This
doesn't hold true universally especially for systems with IOMMU.

IOMMU driver tries to combine buffers into a single DMA address as much
as it can. The right thing is to tell the DMA layer how much combining
IOMMU can do.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index e4bb435..02465cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -787,6 +787,8 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_tt *ttm)
 	enum dma_data_direction direction = write ?
 		DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
 
+	dma_set_max_seg_size(adev->dev, PAGE_SIZE);
+
 	r = sg_alloc_table_from_pages(ttm->sg, ttm->pages, ttm->num_pages, 0,
 				      ttm->num_pages << PAGE_SHIFT,
 				      GFP_KERNEL);
-- 
2.7.4
