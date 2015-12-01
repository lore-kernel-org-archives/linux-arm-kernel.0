From: daniel@fooishbar.org (Daniel Stone)
Date: Tue, 1 Dec 2015 08:18:04 +0000
Subject: [RFC PATCH 3/9] drm/rockchip: Convert to support atomic API
In-Reply-To: <1448940391-23333-4-git-send-email-mark.yao@rock-chips.com>
References: <1448940391-23333-1-git-send-email-mark.yao@rock-chips.com>
 <1448940391-23333-4-git-send-email-mark.yao@rock-chips.com>
Message-ID: <CAPj87rPtWgH2WE7_EEC-Q41c7Ew2z8CwPMMQD+cC08G7qNZTeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 1 December 2015 at 03:26, Mark Yao <mark.yao@rock-chips.com> wrote:
> +static void rockchip_atomic_wait_for_complete(struct drm_atomic_state *state)
> +{
> +       struct drm_crtc_state *crtc_state;
> +       struct drm_crtc *crtc;
> +       int i;
> +
> +       for_each_crtc_in_state(state, crtc, crtc_state, i) {
> +               if (!crtc->state->active)
> +                       continue;
> +
> +               WARN_ON(drm_crtc_vblank_get(crtc));
> +       }
> +
> +       for_each_crtc_in_state(state, crtc, crtc_state, i) {
> +               if (!crtc->state->active)
> +                       continue;
> +
> +               rockchip_crtc_wait_for_update(crtc);
> +       }

I'd be much more comfortable if this passed in an explicit pointer to
state, or an address to wait for, rather than have wait_for_complete
dig out state with no locking. The latter is potentially racy for
async operations.

> +struct vop_plane_state {
> +       struct drm_plane_state base;
> +       dma_addr_t dma_addr[ROCKCHIP_MAX_FB_BUFFER];

Can you get rid of this by just using the pointer to a
rockchip_gem_object already provided?

> -static int vop_update_plane_event(struct drm_plane *plane,
> -                                 struct drm_crtc *crtc,
> -                                 struct drm_framebuffer *fb, int crtc_x,
> -                                 int crtc_y, unsigned int crtc_w,
> -                                 unsigned int crtc_h, uint32_t src_x,
> -                                 uint32_t src_y, uint32_t src_w,
> -                                 uint32_t src_h,
> -                                 struct drm_pending_vblank_event *event)
> +static int vop_plane_atomic_check(struct drm_plane *plane,
> +                          struct drm_plane_state *state)
>  {
> +       struct drm_crtc *crtc = state->crtc;
> +       struct drm_framebuffer *fb = state->fb;
>         struct vop_win *vop_win = to_vop_win(plane);
> +       struct vop_plane_state *vop_plane_state = to_vop_plane_state(state);
>         const struct vop_win_data *win = vop_win->data;
> -       struct vop *vop = to_vop(crtc);
>         struct drm_gem_object *obj;
>         struct rockchip_gem_object *rk_obj;
> -       struct drm_gem_object *uv_obj;
> -       struct rockchip_gem_object *rk_uv_obj;
>         unsigned long offset;
> -       unsigned int actual_w;
> -       unsigned int actual_h;
> -       unsigned int dsp_stx;
> -       unsigned int dsp_sty;
> -       unsigned int y_vir_stride;
> -       unsigned int uv_vir_stride = 0;
> -       dma_addr_t yrgb_mst;
> -       dma_addr_t uv_mst = 0;
> -       enum vop_data_format format;
> -       uint32_t val;
> -       bool is_alpha;
> -       bool rb_swap;
>         bool is_yuv;
>         bool visible;
>         int ret;
> -       struct drm_rect dest = {
> -               .x1 = crtc_x,
> -               .y1 = crtc_y,
> -               .x2 = crtc_x + crtc_w,
> -               .y2 = crtc_y + crtc_h,
> -       };
> -       struct drm_rect src = {
> -               /* 16.16 fixed point */
> -               .x1 = src_x,
> -               .y1 = src_y,
> -               .x2 = src_x + src_w,
> -               .y2 = src_y + src_h,
> -       };
> -       const struct drm_rect clip = {
> -               .x2 = crtc->mode.hdisplay,
> -               .y2 = crtc->mode.vdisplay,
> -       };
> -       bool can_position = plane->type != DRM_PLANE_TYPE_PRIMARY;
> +       struct drm_rect *dest = &vop_plane_state->dest;
> +       struct drm_rect *src = &vop_plane_state->src;
> +       struct drm_rect clip;
>         int min_scale = win->phy->scl ? FRAC_16_16(1, 8) :
>                                         DRM_PLANE_HELPER_NO_SCALING;
>         int max_scale = win->phy->scl ? FRAC_16_16(8, 1) :
>                                         DRM_PLANE_HELPER_NO_SCALING;
>
> -       ret = drm_plane_helper_check_update(plane, crtc, fb,
> -                                           &src, &dest, &clip,
> +       crtc = crtc ? crtc : plane->state->crtc;
> +       /*
> +        * Both crtc or plane->state->crtc can be null.
> +        */
> +       if (!crtc || !fb)
> +               goto out_disable;
> +       src->x1 = state->src_x;
> +       src->y1 = state->src_y;
> +       src->x2 = state->src_x + state->src_w;
> +       src->y2 = state->src_y + state->src_h;
> +       dest->x1 = state->crtc_x;
> +       dest->y1 = state->crtc_y;
> +       dest->x2 = state->crtc_x + state->crtc_w;
> +       dest->y2 = state->crtc_y + state->crtc_h;
> +
> +       clip.x1 = 0;
> +       clip.y1 = 0;
> +       clip.x2 = crtc->mode.hdisplay;
> +       clip.y2 = crtc->mode.vdisplay;
> +
> +       ret = drm_plane_helper_check_update(plane, crtc, state->fb,
> +                                           src, dest, &clip,
>                                             min_scale,
>                                             max_scale,
> -                                           can_position, false, &visible);
> +                                           true, true, &visible);
>         if (ret)
>                 return ret;
>
>         if (!visible)
> -               return 0;
> -
> -       is_alpha = is_alpha_support(fb->pixel_format);
> -       rb_swap = has_rb_swapped(fb->pixel_format);
> -       is_yuv = is_yuv_support(fb->pixel_format);
> +               goto out_disable;
>
> -       format = vop_convert_format(fb->pixel_format);
> -       if (format < 0)
> -               return format;
> +       vop_plane_state->format = vop_convert_format(fb->pixel_format);
> +       if (vop_plane_state->format < 0)
> +               return vop_plane_state->format;
>
> -       obj = rockchip_fb_get_gem_obj(fb, 0);
> -       if (!obj) {
> -               DRM_ERROR("fail to get rockchip gem object from framebuffer\n");
> -               return -EINVAL;
> -       }
> -
> -       rk_obj = to_rockchip_obj(obj);
> +       is_yuv = is_yuv_support(fb->pixel_format);
>
>         if (is_yuv) {
>                 /*
>                  * Src.x1 can be odd when do clip, but yuv plane start point
>                  * need align with 2 pixel.
>                  */
> -               val = (src.x1 >> 16) % 2;
> -               src.x1 += val << 16;
> -               src.x2 += val << 16;
> +               uint32_t temp = (src->x1 >> 16) % 2;
> +
> +               src->x1 += temp << 16;
> +               src->x2 += temp << 16;
>         }

I know this isn't new, but moving the plane around is bad. If the user
gives you a pixel boundary that you can't actually use, please reject
the configuration rather than silently trying to fix it up.

> -static void vop_plane_destroy(struct drm_plane *plane)
> +static void vop_atomic_plane_destroy_state(struct drm_plane *plane,
> +                                          struct drm_plane_state *state)
>  {
> -       vop_disable_plane(plane);
> -       drm_plane_cleanup(plane);
> +       struct vop_plane_state *vop_state = to_vop_plane_state(state);
> +
> +       if (state->fb)
> +               drm_framebuffer_unreference(state->fb);
> +
> +       kfree(vop_state);
>  }

You can replace this hook with drm_atomic_helper_plane_destroy_state.

> -static void vop_win_state_complete(struct vop_win *vop_win,
> -                                  struct vop_win_state *state)
> -{
> -       struct vop *vop = vop_win->vop;
> -       struct drm_crtc *crtc = &vop->crtc;
> -       struct drm_device *drm = crtc->dev;
> -       unsigned long flags;
> -
> -       if (state->event) {
> -               spin_lock_irqsave(&drm->event_lock, flags);
> -               drm_crtc_send_vblank_event(crtc, state->event);
> -               spin_unlock_irqrestore(&drm->event_lock, flags);
> -       }

Ah, I see this is based on top of the patches I sent to fix pageflips?
If they have been merged, I would like to send you some others to
merge as well, which fix an OOPS when you close Weston. I didn't send
them yet as I didn't get a response to the previous patchset, so did
not know you had merged it. There are a lot of other correctness fixes
I had in there (e.g. using the CRTC vblank functions, some locking
fixes), but if this code is going to be thrown away then I will just
discard most of them as well.

Still, I would like to prepare another series for you to merge through
drm-fixes, to be able to run Weston (the same-fb-flip patch I sent
along with the drm_crtc_send_vblank_event conversion, also adding a
preclose hook to discard events when clients exit).

Cheers,
Daniel
