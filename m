From: daniel@ffwll.ch (Daniel Vetter)
Date: Wed, 16 Mar 2016 16:28:25 +0100
Subject: [PATCH] drm/fb_cma_helper: Implement fb_mmap callback
In-Reply-To: <11eb10d95109abc104beb94c0409d49644ea8517.1458140105.git.robin.murphy@arm.com>
References: <11eb10d95109abc104beb94c0409d49644ea8517.1458140105.git.robin.murphy@arm.com>
Message-ID: <20160316152825.GR14170@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16, 2016 at 02:57:49PM +0000, Robin Murphy wrote:
> In the absence of an fb_mmap callback, the fbdev code falls back to a
> naive implementation which relies upon the DMA address being the same
> as the physical address, and the buffer being physically contiguous
> from there. Whilst this often holds for standard CMA allocations via
> the platform's regular DMA ops, if the allocation is provided by an
> IOMMU then such assumptions can fall apart spectacularly.
> 
> To resolve this, reroute the fb_mmap call to the appropriate DMA API
> implementation, as per the other cma_helper calls.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> Hi dri-devel,
> 
> This is an empirical fix for something I tickled via the newly-added
> ARM HDLCD driver on a Juno platform - I have no idea whatsoever about
> how "proper" it is in terms of the DRM infrastructure, so feel free to
> treat this as a bug report rather than an actual patch if appropriate ;)

I think the best case would be if we could have a generic fbdev helper
that remaps to dumb mmap support. But that's a bit tricky to pull of:
1. from fb_info we can get at the fbdev drm_framebuffer.
2. from a drm_framebuffer we can get at the underlying backing storage
object using fb->funcs->get_handle.
3. With that handle we could go into the dumb mmap support (using als the
vma) and create the mmap.

Except that ->get_handle needs a file_priv, and that just exist for the
fbdev emulation kms client. I guess we could fix that by creating a
minimal fake drm file_priv for the fbdev emulation (and treat it more like
any other kms client), but I think that's way too much work when this
simple patch here gets the job done.

Long story short, assuming this doesn't break other cma-helper using
drivers:

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> 
>  drivers/gpu/drm/drm_fb_cma_helper.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c b/drivers/gpu/drm/drm_fb_cma_helper.c
> index bb88e3d..117d7ea 100644
> --- a/drivers/gpu/drm/drm_fb_cma_helper.c
> +++ b/drivers/gpu/drm/drm_fb_cma_helper.c
> @@ -23,6 +23,7 @@
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_gem_cma_helper.h>
>  #include <drm/drm_fb_cma_helper.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/module.h>
>  
>  struct drm_fb_cma {
> @@ -221,6 +222,12 @@ int drm_fb_cma_debugfs_show(struct seq_file *m, void *arg)
>  EXPORT_SYMBOL_GPL(drm_fb_cma_debugfs_show);
>  #endif
>  
> +static int drm_fb_cma_mmap(struct fb_info *info, struct vm_area_struct *vma)
> +{
> +	return dma_mmap_writecombine(info->device, vma, info->screen_base,
> +				     info->fix.smem_start, info->fix.smem_len);
> +}
> +
>  static struct fb_ops drm_fbdev_cma_ops = {
>  	.owner		= THIS_MODULE,
>  	.fb_fillrect	= drm_fb_helper_sys_fillrect,
> @@ -231,6 +238,7 @@ static struct fb_ops drm_fbdev_cma_ops = {
>  	.fb_blank	= drm_fb_helper_blank,
>  	.fb_pan_display	= drm_fb_helper_pan_display,
>  	.fb_setcmap	= drm_fb_helper_setcmap,
> +	.fb_mmap	= drm_fb_cma_mmap,
>  };
>  
>  static int drm_fbdev_cma_create(struct drm_fb_helper *helper,
> -- 
> 2.7.3.dirty
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
