From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 11 Apr 2018 18:11:22 -0400
Subject: [PATCH V3] drm/amdgpu: limit DMA size to PAGE_SIZE for scatter-gather
 buffers
Message-ID: <1523484684-10426-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Code is expecing to observe the same number of buffers returned from
dma_map_sg() function compared to sg_alloc_table_from_pages(). This
doesn't hold true universally especially for systems with IOMMU.

The hardware actually needs the dma_address on a page by page basis.
Joining multiple consecutive pages into one entry is just additional
overhead which we don't need.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index af1b879..91abe1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1948,6 +1948,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	/* init the mode config */
 	drm_mode_config_init(adev->ddev);
 
+	/* limit scatter-gather buffer size to PAGE_SIZE */
+	dma_set_max_seg_size(adev->dev, PAGE_SIZE);
+
 	r = amdgpu_device_ip_init(adev);
 	if (r) {
 		/* failed in exclusive mode due to timeout */
-- 
2.7.4
