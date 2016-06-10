From: tfiga@chromium.org (Tomasz Figa)
Date: Fri, 10 Jun 2016 17:03:22 +0900
Subject: [PATCH v2 5/7] drm: rockchip: use common iommu api to attach iommu
In-Reply-To: <1465392392-2003-6-git-send-email-zhengsq@rock-chips.com>
References: <1465392392-2003-1-git-send-email-zhengsq@rock-chips.com>
 <1465392392-2003-6-git-send-email-zhengsq@rock-chips.com>
Message-ID: <CAAFQd5AEsMhQiNkjBr-Af6rBg9x6Z9bCOu7GuYXt2h=wao7Cow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 8, 2016 at 10:26 PM, Shunqian Zheng <zhengsq@rock-chips.com> wrote:
> Rockchip DRM used the arm special API, arm_iommu_*(), to attach
> iommu for ARM32 SoCs. This patch convert to common iommu API
> so it would support ARM64 like RK3399.
>
> The general idea is domain_alloc(), attach_device() and
> arch_setup_dma_ops() to set dma_ops manually for DRM at the last.
>
> Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>
> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 130 +++++++++++++++++++---------
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.h |   1 +
>  2 files changed, 89 insertions(+), 42 deletions(-)
>

Please see my comments inline.

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> index f5a68fc..7965a66 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> @@ -14,8 +14,6 @@
>   * GNU General Public License for more details.
>   */
>
> -#include <asm/dma-iommu.h>
> -
>  #include <drm/drmP.h>
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_fb_helper.h>
> @@ -24,6 +22,8 @@
>  #include <linux/module.h>
>  #include <linux/of_graph.h>
>  #include <linux/component.h>
> +#include <linux/dma-iommu.h>
> +#include <linux/iommu.h>
>
>  #include "rockchip_drm_drv.h"
>  #include "rockchip_drm_fb.h"
> @@ -46,7 +46,8 @@ static bool is_support_iommu = true;
>  int rockchip_drm_dma_attach_device(struct drm_device *drm_dev,
>                                    struct device *dev)
>  {
> -       struct dma_iommu_mapping *mapping = drm_dev->dev->archdata.mapping;
> +       struct rockchip_drm_private *private = drm_dev->dev_private;
> +       struct iommu_domain *domain = private->domain;
>         int ret;
>
>         if (!is_support_iommu)
> @@ -58,16 +59,25 @@ int rockchip_drm_dma_attach_device(struct drm_device *drm_dev,
>
>         dma_set_max_seg_size(dev, DMA_BIT_MASK(32));
>
> -       return arm_iommu_attach_device(dev, mapping);
> +       ret = iommu_attach_device(domain, dev);
> +

nit: Unnecessary blank line.

> +       if (ret) {
> +               dev_err(dev, "Failed to attach iommu device\n");
> +               return ret;
> +       }

nit: On the other hand, a blank line here would improve readability.

> +       arch_setup_dma_ops(dev, 0x00000000, SZ_2G,
> +                          (struct iommu_ops *)dev->bus->iommu_ops, false);

This is casting a const pointer to a non-const pointer. which isn't
really a good idea. I can see that arch_setup_dma_ops() requires a
writable pointer, though. Looking at the implementations of
arch_setup_dma_ops() around the platforms (namely arm and arm64...),
it makes me wonder if the prototype shouldn't be changed to const
instead.

> +       return 0;
>  }
>
>  void rockchip_drm_dma_detach_device(struct drm_device *drm_dev,
>                                     struct device *dev)
>  {
> -       if (!is_support_iommu)
> -               return;
> +       struct rockchip_drm_private *private = drm_dev->dev_private;
> +       struct iommu_domain *domain = private->domain;
>
> -       arm_iommu_detach_device(dev);
> +       if (is_support_iommu)
> +               iommu_detach_device(domain, dev);
>  }
>
>  int rockchip_register_crtc_funcs(struct drm_crtc *crtc,
> @@ -132,10 +142,70 @@ static void rockchip_drm_crtc_disable_vblank(struct drm_device *dev,
>                 priv->crtc_funcs[pipe]->disable_vblank(crtc);
>  }
>
> +static int rockchip_drm_init_iommu(struct drm_device *drm_dev)
> +{
> +       struct rockchip_drm_private *private = drm_dev->dev_private;
> +       struct device *dev = drm_dev->dev;
> +       int ret;
> +
> +       dev->dma_parms = devm_kzalloc(dev, sizeof(*dev->dma_parms),
> +                                     GFP_KERNEL);
> +       if (!dev->dma_parms) {
> +               ret = -ENOMEM;
> +               return ret;

nit: return -ENOMEM;

> +       }
> +
> +       ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> +       if (ret) {
> +               dev_err(dev, "Failed to set coherent mask\n");
> +               return ret;
> +       }
> +
> +       dma_set_max_seg_size(dev, DMA_BIT_MASK(32));
> +
> +       private->domain = iommu_domain_alloc(&platform_bus_type);
> +       if (!private->domain)
> +               return -ENOMEM;
> +
> +       ret = iommu_get_dma_cookie(private->domain);
> +       if (ret) {
> +               dev_err(dev, "Failed to get dma cookie\n");
> +               goto err_free_domain;
> +       }
> +
> +       ret = iommu_dma_init_domain(private->domain, 0x00000000, SZ_2G);

I guess djkurtz's TODO comment could be preserved here.

Best regards,
Tomasz
