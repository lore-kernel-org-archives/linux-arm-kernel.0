From: seanpaul@chromium.org (Sean Paul)
Date: Tue, 2 Aug 2016 13:02:36 -0400
Subject: [PATCH 5/7] drm/mediatek: plane: Merge mtk_plane_enable into
 mtk_plane_atomic_update
In-Reply-To: <1469783054-54567-6-git-send-email-bibby.hsieh@mediatek.com>
References: <1469783054-54567-1-git-send-email-bibby.hsieh@mediatek.com>
 <1469783054-54567-6-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <CAOw6vbJjqOPL86vk5A_17ugWzgdTYH4kZmm5oOqwGtNDeSDX6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 29, 2016 at 5:04 AM, Bibby Hsieh <bibby.hsieh@mediatek.com> wrote:
> From: Daniel Kurtz <djkurtz@chromium.org>
>
> The mtk_plane_enable is just called once by mtk_plane_atomic_update.
> So, merge mtk_plane_enable into mtk_plane_atomic_update.
>
> While we are here, also clean up the function a bit by using an fb local
> variables.
>
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_plane.c |   65 +++++++++++-------------------
>  1 file changed, 23 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> index 17172ba..b3ddb20 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> @@ -30,44 +30,6 @@ static const u32 formats[] = {
>         DRM_FORMAT_RGB565,
>  };
>
> -static void mtk_plane_enable(struct drm_plane *plane,


Hi Bibby,
This doesn't merge cleanly.


It seems like upstream has:

static void mtk_plane_enable(struct mtk_drm_plane *mtk_plane,


Whereas your version of "is based on some downstream version of
"drm/mediatek: Use drm_plane_helper_check_state()" which changed this
to struct drm_plane. Can you respin the set such that the
mtk_drm_plane removal patch fixes this?

Your set should apply cleanly to
https://cgit.freedesktop.org/~seanpaul/birch/?h=for-misc

Thanks,

Sean



> -                            dma_addr_t addr)
> -{
> -       struct mtk_plane_state *state = to_mtk_plane_state(plane->state);
> -       unsigned int pitch, format;
> -       bool enable;
> -
> -       if (WARN_ON(!plane->state))
> -               return;
> -
> -       enable = state->base.visible;
> -
> -       if (WARN_ON(enable && !plane->state->fb))
> -               return;
> -
> -       if (plane->state->fb) {
> -               pitch = plane->state->fb->pitches[0];
> -               format = plane->state->fb->pixel_format;
> -       } else {
> -               pitch = 0;
> -               format = DRM_FORMAT_RGBA8888;
> -       }
> -
> -       addr += (state->base.src.x1 >> 16) * 4;
> -       addr += (state->base.src.y1 >> 16) * pitch;
> -
> -       state->pending.enable = enable;
> -       state->pending.pitch = pitch;
> -       state->pending.format = format;
> -       state->pending.addr = addr;
> -       state->pending.x = state->base.dst.x1;
> -       state->pending.y = state->base.dst.y1;
> -       state->pending.width = drm_rect_width(&state->base.dst);
> -       state->pending.height = drm_rect_height(&state->base.dst);
> -       wmb(); /* Make sure the above parameters are set before update */
> -       state->pending.dirty = true;
> -}
> -
>  static void mtk_plane_reset(struct drm_plane *plane)
>  {
>         struct mtk_plane_state *state;
> @@ -157,16 +119,35 @@ static void mtk_plane_atomic_update(struct drm_plane *plane,
>                                     struct drm_plane_state *old_state)
>  {
>         struct mtk_plane_state *state = to_mtk_plane_state(plane->state);
> -       struct drm_crtc *crtc = state->base.crtc;
> +       struct drm_crtc *crtc = plane->state->crtc;
> +       struct drm_framebuffer *fb = plane->state->fb;
>         struct drm_gem_object *gem;
>         struct mtk_drm_gem_obj *mtk_gem;
> +       unsigned int pitch, format;
> +       dma_addr_t addr;
>
> -       if (!crtc)
> +       if (!crtc || WARN_ON(!fb))
>                 return;
>
> -       gem = mtk_fb_get_gem_obj(state->base.fb);
> +       gem = mtk_fb_get_gem_obj(fb);
>         mtk_gem = to_mtk_gem_obj(gem);
> -       mtk_plane_enable(plane, mtk_gem->dma_addr);
> +       addr = mtk_gem->dma_addr;
> +       pitch = fb->pitches[0];
> +       format = fb->pixel_format;
> +
> +       addr += (plane->state->src.x1 >> 16) * 4;
> +       addr += (plane->state->src.y1 >> 16) * pitch;
> +
> +       state->pending.enable = true;
> +       state->pending.pitch = pitch;
> +       state->pending.format = format;
> +       state->pending.addr = addr;
> +       state->pending.x = plane->state->dst.x1;
> +       state->pending.y = plane->state->dst.y1;
> +       state->pending.width = drm_rect_width(&plane->state->dst);
> +       state->pending.height = drm_rect_height(&plane->state->dst);
> +       wmb(); /* Make sure the above parameters are set before update */
> +       state->pending.dirty = true;
>  }
>
>  static void mtk_plane_atomic_disable(struct drm_plane *plane,
> --
> 1.7.9.5
>
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
