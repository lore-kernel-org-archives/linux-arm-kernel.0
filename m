From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 10 Apr 2018 16:59:55 -0400
Subject: [PATCH V2] drm/amdgpu: limit DMA size to PAGE_SIZE for scatter-gather
 buffers
Message-ID: <1523394001-4615-1-git-send-email-okaya@codeaurora.org>
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
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 8e28270..1b031eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -851,7 +851,7 @@ static int gmc_v6_0_sw_init(void *handle)
 		pci_set_consistent_dma_mask(adev->pdev, DMA_BIT_MASK(32));
 		dev_warn(adev->dev, "amdgpu: No coherent DMA available.\n");
 	}
-
+	dma_set_max_seg_size(adev->dev, PAGE_SIZE);
 	r = gmc_v6_0_init_microcode(adev);
 	if (r) {
 		dev_err(adev->dev, "Failed to load mc firmware!\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 86e9d682..0a4b2cc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -999,6 +999,7 @@ static int gmc_v7_0_sw_init(void *handle)
 		pci_set_consistent_dma_mask(adev->pdev, DMA_BIT_MASK(32));
 		pr_warn("amdgpu: No coherent DMA available\n");
 	}
+	dma_set_max_seg_size(adev->dev, PAGE_SIZE);
 
 	r = gmc_v7_0_init_microcode(adev);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 9a813d8..b171529 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1096,6 +1096,7 @@ static int gmc_v8_0_sw_init(void *handle)
 		pci_set_consistent_dma_mask(adev->pdev, DMA_BIT_MASK(32));
 		pr_warn("amdgpu: No coherent DMA available\n");
 	}
+	dma_set_max_seg_size(adev->dev, PAGE_SIZE);
 
 	r = gmc_v8_0_init_microcode(adev);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3b7e7af..36e658ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -855,6 +855,7 @@ static int gmc_v9_0_sw_init(void *handle)
 		pci_set_consistent_dma_mask(adev->pdev, DMA_BIT_MASK(32));
 		printk(KERN_WARNING "amdgpu: No coherent DMA available.\n");
 	}
+	dma_set_max_seg_size(adev->dev, PAGE_SIZE);
 
 	r = gmc_v9_0_mc_init(adev);
 	if (r)
-- 
2.7.4
