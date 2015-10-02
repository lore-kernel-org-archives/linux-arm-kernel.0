From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 02 Oct 2015 16:33:56 +0200
Subject: [PATCH v2] drm/rockchip: import dma_buf to gem
In-Reply-To: <1435282038-23778-1-git-send-email-mark.yao@rock-chips.com>
References: <1435282038-23778-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <10058594.7xF1CeL72y@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Am Freitag, 26. Juni 2015, 09:27:18 schrieb Mark Yao:
> We want to display a buffer allocated by other driver, need import
> the buffer to gem.
> 
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>

This looks interesting ... do you want to follow up on it?


Heiko

> ---
> Changes in v2:
> Adviced by Russell King
> - check sgt-nents == 1 when get iova from scatterlist
> - remove unused dma_map_sg/dma_unmap_sg, dma_buf_map_attachment->map_dma_buf
> should do the dma_map
> 
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c |    1 +
>  drivers/gpu/drm/rockchip/rockchip_drm_gem.c |   40
> +++++++++++++++++++++++++-- drivers/gpu/drm/rockchip/rockchip_drm_gem.h |  
>  5 +++-
>  3 files changed, 42 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c index 3962176..9001a90 100644
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
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c index eb2282c..e8c4d4e 100644
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
> @@ -105,6 +106,36 @@ int rockchip_gem_mmap(struct file *filp, struct
> vm_area_struct *vma) return ret;
>  }
> 
> +struct drm_gem_object *
> +rockchip_gem_prime_import_sg_table(struct drm_device *drm,
> +				   struct dma_buf_attachment *attach,
> +				   struct sg_table *sgt)
> +{
> +	struct rockchip_gem_object *rk_obj;
> +	struct drm_gem_object *obj;
> +
> +	/*
> +	 * Todo: only support continuous buffer now, plan to found a method
> +	 * to import non continuous with iommu.
> +	 */
> +	if (sgt->nents != 1)
> +		return ERR_PTR(-EINVAL);
> +
> +	rk_obj = kzalloc(sizeof(*rk_obj), GFP_KERNEL);
> +	if (!rk_obj)
> +		return ERR_PTR(-ENOMEM);
> +
> +	obj = &rk_obj->base;
> +
> +	drm_gem_private_object_init(drm, obj, attach->dmabuf->size);
> +
> +	rk_obj->dma_addr = sg_dma_address(sgt->sgl);
> +	rk_obj->sgt = sgt;
> +	obj->size = sg_dma_len(sgt->sgl);
> +
> +	return obj;
> +}
> +
>  struct rockchip_gem_object *
>  	rockchip_gem_create_object(struct drm_device *drm, unsigned int size,
>  				   bool alloc_kmap)
> @@ -142,11 +173,14 @@ void rockchip_gem_free_object(struct drm_gem_object
> *obj) {
>  	struct rockchip_gem_object *rk_obj;
> 
> -	drm_gem_free_mmap_offset(obj);
> -
>  	rk_obj = to_rockchip_obj(obj);
> 
> -	rockchip_gem_free_buf(rk_obj);
> +	if (obj->import_attach) {
> +		drm_prime_gem_destroy(obj, rk_obj->sgt);
> +	} else {
> +		drm_gem_free_mmap_offset(obj);
> +		rockchip_gem_free_buf(rk_obj);
> +	}
> 
>  	kfree(rk_obj);
>  }
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.h
> b/drivers/gpu/drm/rockchip/rockchip_drm_gem.h index ad22618..9fd58e3 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.h
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.h
> @@ -21,6 +21,7 @@ struct rockchip_gem_object {
>  	struct drm_gem_object base;
>  	unsigned int flags;
> 
> +	struct sg_table *sgt;
>  	void *kvaddr;
>  	dma_addr_t dma_addr;
>  	struct dma_attrs dma_attrs;
> @@ -28,8 +29,10 @@ struct rockchip_gem_object {
> 
>  struct sg_table *rockchip_gem_prime_get_sg_table(struct drm_gem_object
> *obj); struct drm_gem_object *
> -rockchip_gem_prime_import_sg_table(struct drm_device *dev, size_t size,
> +rockchip_gem_prime_import_sg_table(struct drm_device *drm,
> +				   struct dma_buf_attachment *attach,
>  				   struct sg_table *sgt);
> +
>  void *rockchip_gem_prime_vmap(struct drm_gem_object *obj);
>  void rockchip_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr);
