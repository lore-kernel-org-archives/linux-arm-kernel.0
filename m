From: mark.yao@rock-chips.com (Mark yao)
Date: Tue, 10 Nov 2015 13:53:44 +0800
Subject: [PATCH 2/2] drm/rockchip: unset pgoff when mmap'ing gems
In-Reply-To: <2793929.5WVauesvFQ@phil>
References: <4982827.0pnZflEOSR@phil> <2793929.5WVauesvFQ@phil>
Message-ID: <56418668.8080306@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?11?10? 03:52, Heiko Stuebner wrote:
> Commit 371f0f085f629 ("ARM: 8426/1: dma-mapping: add missing range check
>   in dma_mmap()") introduced offset-checking for mappings, which collides
> with the fake-offset the drm sets for gems.
>
> Other drm-drivers set this offset to 0 before doing the mapping, so
> this looks like the correct way to go for rockchip as well.
>
> Fixes: 371f0f085f629 ("ARM: 8426/1: dma-mapping: add missing range check in dma_mmap()")
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> This patch is definitly necessary to keep the rockchip-drm working
> with kernel 4.4.
>
>   drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> index e50d113..e9bc188 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> @@ -68,6 +68,7 @@ static int rockchip_drm_gem_object_mmap(struct drm_gem_object *obj,
>   	 * VM_PFNMAP flag that was set by drm_gem_mmap_obj()/drm_gem_mmap().
>   	 */
>   	vma->vm_flags &= ~VM_PFNMAP;
> +	vma->vm_pgoff = 0;
>   
>   	ret = dma_mmap_attrs(drm->dev, vma, rk_obj->kvaddr, rk_obj->dma_addr,
>   			     obj->size, &rk_obj->dma_attrs);
Hi Heiko
      Sorry for miss this patch, thanks for the fix.
      Acked-by: Mark Yao <mark.yao@rock-chips.com>

-- 
?ark Yao
