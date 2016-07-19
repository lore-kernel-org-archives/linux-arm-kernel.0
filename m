From: mark.yao@rock-chips.com (Mark yao)
Date: Tue, 19 Jul 2016 09:59:29 +0800
Subject: [PATCH] drm/rockchip: Delete an unnecessary check before
 drm_gem_object_unreference_unlocked()
In-Reply-To: <b66399ed-278b-b85d-4a21-b34164936ef6@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <b66399ed-278b-b85d-4a21-b34164936ef6@users.sourceforge.net>
Message-ID: <578D8981.2070102@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?07?15? 21:35, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 15 Jul 2016 15:23:22 +0200
>
> The drm_gem_object_unreference_unlocked() function tests whether
> its argument is NULL and then returns immediately.
> Thus the test around the call is not needed.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   drivers/gpu/drm/rockchip/rockchip_drm_fb.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> index 20f12bc..6f64e79 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> @@ -43,14 +43,10 @@ struct drm_gem_object *rockchip_fb_get_gem_obj(struct drm_framebuffer *fb,
>   static void rockchip_drm_fb_destroy(struct drm_framebuffer *fb)
>   {
>   	struct rockchip_drm_fb *rockchip_fb = to_rockchip_fb(fb);
> -	struct drm_gem_object *obj;
>   	int i;
>   
> -	for (i = 0; i < ROCKCHIP_MAX_FB_BUFFER; i++) {
> -		obj = rockchip_fb->obj[i];
> -		if (obj)
> -			drm_gem_object_unreference_unlocked(obj);
> -	}
> +	for (i = 0; i < ROCKCHIP_MAX_FB_BUFFER; i++)
> +		drm_gem_object_unreference_unlocked(rockchip_fb->obj[i]);
>   
Good, Thanks for the fixes, Applied to my drm-fixes.

>   	drm_framebuffer_cleanup(fb);
>   	kfree(rockchip_fb);


-- 
?ark Yao
