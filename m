From: daniel@ffwll.ch (Daniel Vetter)
Date: Mon, 16 Nov 2015 17:21:15 +0100
Subject: [PATCH 1/2] drm/rockchip: create the fake mmap offset during gem
 creation
In-Reply-To: <56418C07.60208@rock-chips.com>
References: <4982827.0pnZflEOSR@phil>
 <56418C07.60208@rock-chips.com>
Message-ID: <20151116162115.GB16848@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 10, 2015 at 02:17:43PM +0800, Mark yao wrote:
> Hi Heiko
>      I don't think this patch is needed for rockchip drm, since rockchip drm
> only use kms.
> I saw the discussion about ("drm/exynos: create a fake mmap offset with gem
> creation"),
> Inki said that: "This patch makes drm_gem_create_mmap_offset to be called
> even in case of
> not using dumb* interfaces. I.e., exynos_drm_gem_create_ioctl ->
> exynos_drm_gem_mmap"
> 
> So I think this patch doesn't make sense for rockchip drm.
> 
> 
> On 2015?11?10? 03:50, Heiko Stuebner wrote:
> >Similarly to the equivalent exynos-fix in commit 48cf53f4343a

This exynos patch and your rockchip patch look really strange - the point
_is_ to only create fake mmap offset when someone actually tries to mmap a
bo. drm_gem_create_mmap_offset internally (and in a race-free manner)
checks whether it's been called already, so it's perfectly safe to call
mutliple times.

Imo drop this (and probably revert 48cf53f4343a as unjustified).
-Daniel

> >("drm/exynos: create a fake mmap offset with gem creation") the rockchip
> >drm driver also calls the drm_gem_create_mmap_offset fake-offset creation
> >on every invocation of rockchip_gem_dumb_map_offset.
> >
> >Move that to the creation of the gem to only create that offset once.
> >
> >Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> >---
> >  drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> >diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> >index 4ab2f20..e50d113 100644
> >--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> >+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> >@@ -126,8 +126,14 @@ struct rockchip_gem_object *
> >  	if (ret)
> >  		goto err_free_rk_obj;
> >+	ret = drm_gem_create_mmap_offset(obj);
> >+	if (ret)
> >+		goto err_free_buf;
> >+
> >  	return rk_obj;
> >+err_free_buf:
> >+	rockchip_gem_free_buf(rk_obj);
> >  err_free_rk_obj:
> >  	kfree(rk_obj);
> >  	return ERR_PTR(ret);
> >@@ -196,7 +202,6 @@ int rockchip_gem_dumb_map_offset(struct drm_file *file_priv,
> >  				 uint64_t *offset)
> >  {
> >  	struct drm_gem_object *obj;
> >-	int ret;
> >  	obj = drm_gem_object_lookup(dev, file_priv, handle);
> >  	if (!obj) {
> >@@ -204,14 +209,9 @@ int rockchip_gem_dumb_map_offset(struct drm_file *file_priv,
> >  		return -EINVAL;
> >  	}
> >-	ret = drm_gem_create_mmap_offset(obj);
> >-	if (ret)
> >-		goto out;
> >-
> >  	*offset = drm_vma_node_offset_addr(&obj->vma_node);
> >  	DRM_DEBUG_KMS("offset = 0x%llx\n", *offset);
> >-out:
> >  	drm_gem_object_unreference_unlocked(obj);
> >  	return 0;
> 
> 
> -- 
> ?ark Yao
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
