From: mark.yao@rock-chips.com (Mark yao)
Date: Tue, 10 Nov 2015 14:17:43 +0800
Subject: [PATCH 1/2] drm/rockchip: create the fake mmap offset during
 gem creation
In-Reply-To: <4982827.0pnZflEOSR@phil>
References: <4982827.0pnZflEOSR@phil>
Message-ID: <56418C07.60208@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko
      I don't think this patch is needed for rockchip drm, since 
rockchip drm only use kms.
I saw the discussion about ("drm/exynos: create a fake mmap offset with 
gem creation"),
Inki said that: "This patch makes drm_gem_create_mmap_offset to be 
called even in case of
not using dumb* interfaces. I.e., exynos_drm_gem_create_ioctl -> 
exynos_drm_gem_mmap"

So I think this patch doesn't make sense for rockchip drm.


On 2015?11?10? 03:50, Heiko Stuebner wrote:
> Similarly to the equivalent exynos-fix in commit 48cf53f4343a
> ("drm/exynos: create a fake mmap offset with gem creation") the rockchip
> drm driver also calls the drm_gem_create_mmap_offset fake-offset creation
> on every invocation of rockchip_gem_dumb_map_offset.
>
> Move that to the creation of the gem to only create that offset once.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> index 4ab2f20..e50d113 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> @@ -126,8 +126,14 @@ struct rockchip_gem_object *
>   	if (ret)
>   		goto err_free_rk_obj;
>   
> +	ret = drm_gem_create_mmap_offset(obj);
> +	if (ret)
> +		goto err_free_buf;
> +
>   	return rk_obj;
>   
> +err_free_buf:
> +	rockchip_gem_free_buf(rk_obj);
>   err_free_rk_obj:
>   	kfree(rk_obj);
>   	return ERR_PTR(ret);
> @@ -196,7 +202,6 @@ int rockchip_gem_dumb_map_offset(struct drm_file *file_priv,
>   				 uint64_t *offset)
>   {
>   	struct drm_gem_object *obj;
> -	int ret;
>   
>   	obj = drm_gem_object_lookup(dev, file_priv, handle);
>   	if (!obj) {
> @@ -204,14 +209,9 @@ int rockchip_gem_dumb_map_offset(struct drm_file *file_priv,
>   		return -EINVAL;
>   	}
>   
> -	ret = drm_gem_create_mmap_offset(obj);
> -	if (ret)
> -		goto out;
> -
>   	*offset = drm_vma_node_offset_addr(&obj->vma_node);
>   	DRM_DEBUG_KMS("offset = 0x%llx\n", *offset);
>   
> -out:
>   	drm_gem_object_unreference_unlocked(obj);
>   
>   	return 0;


-- 
?ark Yao
