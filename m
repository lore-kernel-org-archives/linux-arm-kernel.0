From: ray.huang@amd.com (Huang Rui)
Date: Wed, 11 Apr 2018 14:26:03 +0800
Subject: [PATCH V2] drm/amdgpu: limit DMA size to PAGE_SIZE for
 scatter-gather buffers
In-Reply-To: <1523394001-4615-1-git-send-email-okaya@codeaurora.org>
References: <1523394001-4615-1-git-send-email-okaya@codeaurora.org>
Message-ID: <20180411062602.GA29109@hr-amur2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2018 at 04:59:55PM -0400, Sinan Kaya wrote:
> Code is expecing to observe the same number of buffers returned from
> dma_map_sg() function compared to sg_alloc_table_from_pages(). This
> doesn't hold true universally especially for systems with IOMMU.
> 
> IOMMU driver tries to combine buffers into a single DMA address as much
> as it can. The right thing is to tell the DMA layer how much combining
> IOMMU can do.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Sinan, I guess Christian's suggestion is to add amdgpu_device_init function
like here:

8<-------
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0e798b3..9b96771 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2339,6 +2339,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
        /* init the mode config */
        drm_mode_config_init(adev->ddev);

+       dma_set_max_seg_size(adev->dev, PAGE_SIZE);
+
        r = amdgpu_device_ip_init(adev);
        if (r) {
                /* failed in exclusive mode due to timeout */
8<-------

After that, we don't do it in each generation.

Thanks,
Ray
