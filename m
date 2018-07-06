From: kwizart@gmail.com (Nicolas Chauvet)
Date: Fri, 6 Jul 2018 17:36:58 +0200
Subject: [PATCH v4 2/2] drm/nouveau: tegra: Detach from ARM DMA/IOMMU
 mapping
In-Reply-To: <20180530140625.21247-3-thierry.reding@gmail.com>
References: <20180530140625.21247-1-thierry.reding@gmail.com>
 <20180530140625.21247-3-thierry.reding@gmail.com>
Message-ID: <CABr+WTmTFDtX=0+0uk-j1rCc1croO48MA8xHAAeYh=KBaBekvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-05-30 16:06 GMT+02:00 Thierry Reding <thierry.reding@gmail.com>:
> From: Thierry Reding <treding@nvidia.com>
>
> Depending on the kernel configuration, early ARM architecture setup code
> may have attached the GPU to a DMA/IOMMU mapping that transparently uses
> the IOMMU to back the DMA API. Tegra requires special handling for IOMMU
> backed buffers (a special bit in the GPU's MMU page tables indicates the
> memory path to take: via the SMMU or directly to the memory controller).
> Transparently backing DMA memory with an IOMMU prevents Nouveau from
> properly handling such memory accesses and causes memory access faults.
>
> As a side-note: buffers other than those allocated in instance memory
> don't need to be physically contiguous from the GPU's perspective since
> the GPU can map them into contiguous buffers using its own MMU. Mapping
> these buffers through the IOMMU is unnecessary and will even lead to
> performance degradation because of the additional translation. One
> exception to this are compressible buffers which need large pages. In
> order to enable these large pages, multiple small pages will have to be
> combined into one large (I/O virtually contiguous) mapping via the
> IOMMU. However, that is a topic outside the scope of this fix and isn't
> currently supported. An implementation will want to explicitly create
> these large pages in the Nouveau driver, so detaching from a DMA/IOMMU
> mapping would still be required.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v4:
> - use existing APIs to detach from a DMA/IOMMU mapping
>
> Changes in v3:
> - clarify the use of IOMMU mapping for compressible buffers
> - squash multiple patches into this
>
>  drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
> index 78597da6313a..0e372a190d3f 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
> @@ -23,6 +23,10 @@
>  #ifdef CONFIG_NOUVEAU_PLATFORM_DRIVER
>  #include "priv.h"
>
> +#if IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)
> +#include <asm/dma-iommu.h>
> +#endif
> +
>  static int
>  nvkm_device_tegra_power_up(struct nvkm_device_tegra *tdev)
>  {
> @@ -105,6 +109,15 @@ nvkm_device_tegra_probe_iommu(struct nvkm_device_tegra *tdev)
>         unsigned long pgsize_bitmap;
>         int ret;
>
> +#if IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)
> +       if (dev->archdata.mapping) {
> +               struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
> +
> +               arm_iommu_detach_device(dev);
> +               arm_iommu_release_mapping(mapping);
> +       }
> +#endif
> +
>         if (!tdev->func->iommu_bit)
>                 return;
>
> --
> 2.17.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

This serie (v4)
Tested-by: Nicolas Chauvet <kwizart@gmail.com>

Tested on jetson-tk1 on a Fedora 4.18-rc3 kernel.

-- 
-

Nicolas (kwizart)
