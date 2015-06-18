From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Jun 2015 11:57:15 +0100
Subject: [PATCH 1/6] drm/rockchip: import dma_buf to gem
In-Reply-To: <1434613770-6608-2-git-send-email-mark.yao@rock-chips.com>
References: <1434613770-6608-1-git-send-email-mark.yao@rock-chips.com>
 <1434613770-6608-2-git-send-email-mark.yao@rock-chips.com>
Message-ID: <20150618105715.GJ7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 03:49:25PM +0800, Mark Yao wrote:
> We want to display a buffer allocated by other driver, need import
> the buffer to gem.
> 
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c |    1 +
>  drivers/gpu/drm/rockchip/rockchip_drm_gem.c |   45 +++++++++++++++++++++++++--
>  drivers/gpu/drm/rockchip/rockchip_drm_gem.h |    5 ++-
>  3 files changed, 47 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> index 3962176..9001a90 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> @@ -287,6 +287,7 @@ static struct drm_driver rockchip_drm_driver = {
>  	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
>  	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
>  	.gem_prime_import	= drm_gem_prime_import,
> +	.gem_prime_import_sg_table = rockchip_gem_prime_import_sg_table,
>  	.gem_prime_export	= drm_gem_prime_export,
>  	.gem_prime_get_sg_table	= rockchip_gem_prime_get_sg_table,
>  	.gem_prime_vmap		= rockchip_gem_prime_vmap,
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> index eb2282c..2e30e23 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> @@ -18,6 +18,7 @@
>  #include <drm/drm_vma_manager.h>
>  
>  #include <linux/dma-attrs.h>
> +#include <linux/dma-buf.h>
>  
>  #include "rockchip_drm_drv.h"
>  #include "rockchip_drm_gem.h"
> @@ -105,6 +106,38 @@ int rockchip_gem_mmap(struct file *filp, struct vm_area_struct *vma)
>  	return ret;
>  }
>  
> +struct drm_gem_object *
> +rockchip_gem_prime_import_sg_table(struct drm_device *drm,
> +				   struct dma_buf_attachment *attach,
> +				   struct sg_table *sgt)
> +{
> +	struct rockchip_gem_object *rk_obj;
> +	struct drm_gem_object *obj;
> +	int ret;
> +
> +	rk_obj = kzalloc(sizeof(*rk_obj), GFP_KERNEL);
> +	if (!rk_obj)
> +		return ERR_PTR(-ENOMEM);
> +
> +	obj = &rk_obj->base;
> +
> +	drm_gem_private_object_init(drm, obj, attach->dmabuf->size);
> +
> +	if (!dma_map_sg(drm->dev, sgt->sgl, sgt->nents, DMA_TO_DEVICE)) {
> +		ret = -ENOMEM;
> +		goto err_free_obj;
> +	}
> +	rk_obj->dma_addr = sg_dma_address(sgt->sgl);
> +	rk_obj->sgt = sgt;
> +	obj->size = sg_dma_len(sgt->sgl);

This is wrong.

First, if you can only cope with a single scatterlist entry, you need to
enforce that.  You can do that in your gem_prime_import_sg_table() method
by checking sgt->nents.

Secondly, you're mapping an already mapped scatterlist - scatterlists
are mapped by the exporter inside dma_buf_map_attachment() for your
device.

Thirdly, I hate drm_gem_prime_import() being used on ARM... it forces
drivers to do something very buggy: the DMA buffer is mapped for DMA
when the buffer is imported.  If the buffer is a write-combine or cached
buffer, writes to the buffer after the import will not become visible to
the display hardware until sometime later (when they're evicted from the
caches and/or pushed out of the bus structure.)  The DMA mapping should
be performed as close to the start of DMA as possible.  However, this is
a long-standing issue I have with dma_buf itself and is not something you
should be too concerned with in your patch.  Just bear it in mind if you
start to see corruption of imported buffers - the answer is not more
dma_map_sg() calls, but to get dma_buf fixed.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
