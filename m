From: daniel@ffwll.ch (Daniel Vetter)
Date: Thu, 4 Aug 2016 10:08:54 +0200
Subject: [PATCH v1] drm/rockchip: fix fbdev crash when not use
 DRM_FBDEV_EMULATION
In-Reply-To: <1470277318-9204-1-git-send-email-mark.yao@rock-chips.com>
References: <1470212025-30336-1-git-send-email-mark.yao@rock-chips.com>
 <1470277318-9204-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <20160804080854.GQ6232@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2016 at 10:21:58AM +0800, Mark Yao wrote:
> [    1.162571] Unable to handle kernel NULL pointer dereference at virtual address 00000200
> [    1.165656] Modules linked in:
> [    1.165941] CPU: 5 PID: 143 Comm: kworker/5:2 Not tainted 4.4.15 #237
> [    1.166506] Hardware name: Rockchip RK3399 Evaluation Board v1 (Android) (DT)
> [    1.167153] Workqueue: events output_poll_execute
> [    1.168231] PC is at mutex_lock+0x14/0x44
> [    1.168586] LR is at drm_fb_helper_hotplug_event+0x28/0xcc
> [    1.172192] [<ffffff8008982110>] mutex_lock+0x14/0x44
> [    1.172196] [<ffffff80084025a4>] drm_fb_helper_hotplug_event+0x28/0xcc
> [    1.172201] [<ffffff8008427ae4>] rockchip_drm_output_poll_changed+0x14/0x1c
> [    1.172204] [<ffffff80083f7c4c>] drm_kms_helper_hotplug_event+0x28/0x34
> [    1.172207] [<ffffff80083f7ddc>] output_poll_execute+0x150/0x198
> [    1.172212] [<ffffff80080b0ea8>] process_one_work+0x218/0x3dc
> [    1.172215] [<ffffff80080b1578>] worker_thread+0x24c/0x374
> [    1.172217] [<ffffff80080b5bcc>] kthread+0xdc/0xe4
> [    1.172222] [<ffffff8008084cd0>] ret_from_fork+0x10/0x40
> 
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> ---
> Change in v1:
> Advised by Daniel Vetter
>   only do the struct->pointer conversion alone

Yeah, that looks much more in line with how the optional fbdev support is
supposed to be used.
-Daniel

> 
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c   |  6 +++---
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.h   |  2 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_fb.c    |  2 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c | 17 ++++++++++-------
>  4 files changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> index a822d49..fe22f76 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> @@ -261,7 +261,7 @@ static void rockchip_drm_lastclose(struct drm_device *dev)
>  {
>  	struct rockchip_drm_private *priv = dev->dev_private;
>  
> -	drm_fb_helper_restore_fbdev_mode_unlocked(&priv->fbdev_helper);
> +	drm_fb_helper_restore_fbdev_mode_unlocked(priv->fbdev_helper);
>  }
>  
>  static const struct file_operations rockchip_drm_driver_fops = {
> @@ -311,7 +311,7 @@ void rockchip_drm_fb_suspend(struct drm_device *drm)
>  	struct rockchip_drm_private *priv = drm->dev_private;
>  
>  	console_lock();
> -	drm_fb_helper_set_suspend(&priv->fbdev_helper, 1);
> +	drm_fb_helper_set_suspend(priv->fbdev_helper, 1);
>  	console_unlock();
>  }
>  
> @@ -320,7 +320,7 @@ void rockchip_drm_fb_resume(struct drm_device *drm)
>  	struct rockchip_drm_private *priv = drm->dev_private;
>  
>  	console_lock();
> -	drm_fb_helper_set_suspend(&priv->fbdev_helper, 0);
> +	drm_fb_helper_set_suspend(priv->fbdev_helper, 0);
>  	console_unlock();
>  }
>  
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
> index ea39329..f005f3f 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
> @@ -57,7 +57,7 @@ struct rockchip_crtc_state {
>   * @num_pipe: number of pipes for this device.
>   */
>  struct rockchip_drm_private {
> -	struct drm_fb_helper fbdev_helper;
> +	struct drm_fb_helper *fbdev_helper;
>  	struct drm_gem_object *fbdev_bo;
>  	const struct rockchip_crtc_funcs *crtc_funcs[ROCKCHIP_MAX_CRTC];
>  	struct drm_atomic_state *state;
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> index 55c5273..dc034ec 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> @@ -156,7 +156,7 @@ err_gem_object_unreference:
>  static void rockchip_drm_output_poll_changed(struct drm_device *dev)
>  {
>  	struct rockchip_drm_private *private = dev->dev_private;
> -	struct drm_fb_helper *fb_helper = &private->fbdev_helper;
> +	struct drm_fb_helper *fb_helper = private->fbdev_helper;
>  
>  	if (fb_helper)
>  		drm_fb_helper_hotplug_event(fb_helper);
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c b/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
> index 207e01d..6b50dfa 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
> @@ -22,14 +22,12 @@
>  #include "rockchip_drm_fb.h"
>  
>  #define PREFERRED_BPP		32
> -#define to_drm_private(x) \
> -		container_of(x, struct rockchip_drm_private, fbdev_helper)
>  
>  static int rockchip_fbdev_mmap(struct fb_info *info,
>  			       struct vm_area_struct *vma)
>  {
>  	struct drm_fb_helper *helper = info->par;
> -	struct rockchip_drm_private *private = to_drm_private(helper);
> +	struct rockchip_drm_private *private = helper->dev->dev_private;
>  
>  	return rockchip_gem_mmap_buf(private->fbdev_bo, vma);
>  }
> @@ -50,7 +48,7 @@ static struct fb_ops rockchip_drm_fbdev_ops = {
>  static int rockchip_drm_fbdev_create(struct drm_fb_helper *helper,
>  				     struct drm_fb_helper_surface_size *sizes)
>  {
> -	struct rockchip_drm_private *private = to_drm_private(helper);
> +	struct rockchip_drm_private *private = helper->dev->dev_private;
>  	struct drm_mode_fb_cmd2 mode_cmd = { 0 };
>  	struct drm_device *dev = helper->dev;
>  	struct rockchip_gem_object *rk_obj;
> @@ -139,7 +137,11 @@ int rockchip_drm_fbdev_init(struct drm_device *dev)
>  
>  	num_crtc = dev->mode_config.num_crtc;
>  
> -	helper = &private->fbdev_helper;
> +	helper = devm_kzalloc(dev->dev, sizeof(*helper), GFP_KERNEL);
> +	if (!helper)
> +		return -ENOMEM;
> +
> +	private->fbdev_helper = helper;
>  
>  	drm_fb_helper_prepare(dev, helper, &rockchip_drm_fb_helper_funcs);
>  
> @@ -173,9 +175,10 @@ err_drm_fb_helper_fini:
>  void rockchip_drm_fbdev_fini(struct drm_device *dev)
>  {
>  	struct rockchip_drm_private *private = dev->dev_private;
> -	struct drm_fb_helper *helper;
> +	struct drm_fb_helper *helper = private->fbdev_helper;
>  
> -	helper = &private->fbdev_helper;
> +	if (!helper)
> +		return;
>  
>  	drm_fb_helper_unregister_fbi(helper);
>  	drm_fb_helper_release_fbi(helper);
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
