From: tfiga@chromium.org (Tomasz Figa)
Date: Thu, 2 Jul 2015 15:00:30 +0900
Subject: [PATCH v2 2/5] drm/rockchip: vop: fix yuv plane support
In-Reply-To: <1435313249-4549-3-git-send-email-mark.yao@rock-chips.com>
References: <1435313249-4549-1-git-send-email-mark.yao@rock-chips.com>
 <1435313249-4549-3-git-send-email-mark.yao@rock-chips.com>
Message-ID: <CAAFQd5AAYSMNRtJBVU+2LHhA=JhJQVTEGmf2+pVt5JMXbbmg-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Please see my comments inline.

On Fri, Jun 26, 2015 at 7:07 PM, Mark Yao <mark.yao@rock-chips.com> wrote:
> vop support yuv with NV12, NV16 and NV24, only 2 plane yuv.
>
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
>
> Changes in v2:
> - Uv buffer not support odd offset, align it.
> - Fix error display when move yuv image.
>
> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c |   63 ++++++++++++++++++++++++---
>  1 file changed, 57 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index 3c9f4f3..6ca08f8 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -373,6 +373,18 @@ static enum vop_data_format vop_convert_format(uint32_t format)
>         }
>  }
>
> +static bool is_yuv_support(uint32_t format)
> +{
> +       switch (format) {
> +       case DRM_FORMAT_NV12:
> +       case DRM_FORMAT_NV16:
> +       case DRM_FORMAT_NV24:
> +               return true;
> +       default:
> +               return false;
> +       }
> +}
> +
>  static bool is_alpha_support(uint32_t format)
>  {
>         switch (format) {
> @@ -577,16 +589,21 @@ static int vop_update_plane_event(struct drm_plane *plane,
>         struct vop *vop = to_vop(crtc);
>         struct drm_gem_object *obj;
>         struct rockchip_gem_object *rk_obj;
> +       struct drm_gem_object *uv_obj;
> +       struct rockchip_gem_object *rk_uv_obj;
>         unsigned long offset;
>         unsigned int actual_w;
>         unsigned int actual_h;
>         unsigned int dsp_stx;
>         unsigned int dsp_sty;
>         unsigned int y_vir_stride;
> +       unsigned int uv_vir_stride;
>         dma_addr_t yrgb_mst;
> +       dma_addr_t uv_mst;
>         enum vop_data_format format;
>         uint32_t val;
>         bool is_alpha;
> +       bool is_yuv;
>         bool visible;
>         int ret;
>         struct drm_rect dest = {
> @@ -608,6 +625,12 @@ static int vop_update_plane_event(struct drm_plane *plane,
>         };
>         bool can_position = plane->type != DRM_PLANE_TYPE_PRIMARY;
>
> +       if (drm_format_num_planes(fb->pixel_format) > 2) {
> +               DRM_ERROR("unsupport more than 2 plane format[%08x]\n",
> +                         fb->pixel_format);
> +               return -EINVAL;
> +       }

Hmm, do you need to check this? Doesn't the core guarantee that with
given pixel_format you always get the right plane count? (Possibly at
fb creation time, but I haven't checked that.)

> +
>         ret = drm_plane_helper_check_update(plane, crtc, fb,
>                                             &src, &dest, &clip,
>                                             DRM_PLANE_HELPER_NO_SCALING,
> @@ -624,28 +647,52 @@ static int vop_update_plane_event(struct drm_plane *plane,
>         if (format < 0)
>                 return format;
>
> +       is_yuv = is_yuv_support(fb->pixel_format);

nit: Could you group this together with other is_* assignments, above
the call to vop_convert_format()?

> +
>         obj = rockchip_fb_get_gem_obj(fb, 0);
>         if (!obj) {
>                 DRM_ERROR("fail to get rockchip gem object from framebuffer\n");
>                 return -EINVAL;
>         }
>
> +       if (is_yuv) {
> +               src.x1 &= (~1) << 16;
> +               src.y1 &= (~1) << 16;

Hmm, if you align x1 and y1, shouldn't you also offset x2 and y2, so
the width and height of the rectangle are preserved? Also I couldn't
find any details on this, but what are the semantics of
.update_plane(), should it really align the values or maybe just fail?

> +       }
> +
>         rk_obj = to_rockchip_obj(obj);
>
>         actual_w = (src.x2 - src.x1) >> 16;
>         actual_h = (src.y2 - src.y1) >> 16;
> -       crtc_x = max(0, crtc_x);
> -       crtc_y = max(0, crtc_y);
>
> -       dsp_stx = crtc_x + crtc->mode.htotal - crtc->mode.hsync_start;
> -       dsp_sty = crtc_y + crtc->mode.vtotal - crtc->mode.vsync_start;
> +       dsp_stx = dest.x1 + crtc->mode.htotal - crtc->mode.hsync_start;
> +       dsp_sty = dest.y1 + crtc->mode.vtotal - crtc->mode.vsync_start;

This change could be split into separate patch, which actually fixes
the coordinates used for this calculation, because that's why we do
clipping with drm_plane_helper_check_update() first to use dest not
crtc_{x,y}.

>
> -       offset = (src.x1 >> 16) * (fb->bits_per_pixel >> 3);
> +       offset = (src.x1 >> 16) * drm_format_plane_cpp(fb->pixel_format, 0);
>         offset += (src.y1 >> 16) * fb->pitches[0];
> -       yrgb_mst = rk_obj->dma_addr + offset;
>
> +       yrgb_mst = rk_obj->dma_addr + offset + fb->offsets[0];

This (missing offsets[0] addition) should also be a separate patch,
because it was obviously incorrect before this patch.

Best regards,
Tomasz
