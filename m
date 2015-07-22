From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 22 Jul 2015 23:51:09 +0200
Subject: [PATCH v3 3/6] drm/rockchip: vop: Add yuv plane support
In-Reply-To: <1437466807-13689-4-git-send-email-mark.yao@rock-chips.com>
References: <1437466807-13689-1-git-send-email-mark.yao@rock-chips.com>
 <1437466807-13689-4-git-send-email-mark.yao@rock-chips.com>
Message-ID: <7451281.fUv3gEKea6@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 21. Juli 2015, 16:20:04 schrieb Mark Yao:
> vop support yuv with NV12, NV16 and NV24, only 2 plane yuv.
> 
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> ---
> Changes in v3:
> Adviced by Tomasz Figa
> - separate dest calculate to another patch
> - fix src x1,x2 when do align, and remove unnecessary src.y1 align.
> 
> Changes in v2:
> - Uv buffer not support odd offset, align it.
> - Fix error display when move yuv image.
> 
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c |   56
> ++++++++++++++++++++++++++- 1 file changed, 54 insertions(+), 2
> deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c index c7e0283..47ce943 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -373,6 +373,18 @@ static enum vop_data_format vop_convert_format(uint32_t
> format) }
>  }
> 
> +static bool is_yuv_support(uint32_t format)
> +{
> +	switch (format) {
> +	case DRM_FORMAT_NV12:
> +	case DRM_FORMAT_NV16:
> +	case DRM_FORMAT_NV24:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  static bool is_alpha_support(uint32_t format)
>  {
>  	switch (format) {
> @@ -577,16 +589,21 @@ static int vop_update_plane_event(struct drm_plane


does not apply to what's in mainline, as this patch seems to ignore
	85a359f25388 ("drm/rockchip: Add BGR formats to VOP")
from Tomasz


> *plane, struct vop *vop = to_vop(crtc);
>  	struct drm_gem_object *obj;
>  	struct rockchip_gem_object *rk_obj;
> +	struct drm_gem_object *uv_obj;
> +	struct rockchip_gem_object *rk_uv_obj;
>  	unsigned long offset;
>  	unsigned int actual_w;
>  	unsigned int actual_h;
>  	unsigned int dsp_stx;
>  	unsigned int dsp_sty;
>  	unsigned int y_vir_stride;
> +	unsigned int uv_vir_stride = 0;
>  	dma_addr_t yrgb_mst;
> +	dma_addr_t uv_mst = 0;
>  	enum vop_data_format format;
>  	uint32_t val;
>  	bool is_alpha;
> +	bool is_yuv;
>  	bool visible;
>  	int ret;
>  	struct drm_rect dest = {
> @@ -620,6 +637,8 @@ static int vop_update_plane_event(struct drm_plane
> *plane, return 0;
> 
>  	is_alpha = is_alpha_support(fb->pixel_format);
> +	is_yuv = is_yuv_support(fb->pixel_format);
> +
>  	format = vop_convert_format(fb->pixel_format);
>  	if (format < 0)
>  		return format;

same as above


Heiko
