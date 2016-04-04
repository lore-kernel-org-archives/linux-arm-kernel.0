From: daniel@fooishbar.org (Daniel Stone)
Date: Mon, 4 Apr 2016 16:44:17 +0100
Subject: [PATCH] drm/rockchip: Return -EBUSY if there's already a pending
 flip event v3
In-Reply-To: <1459778134-30693-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1459778134-30693-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <CAPj87rPtP1ph-1FMxSKUANjeKwwjwgfMzbUGHvqudEx7nYCESQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomeu,

On 4 April 2016 at 14:55, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> index 3b8f652698f8..8305bbd2a4d7 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> @@ -280,7 +280,18 @@ int rockchip_drm_atomic_commit(struct drm_device *dev,
>  {
>         struct rockchip_drm_private *private = dev->dev_private;
>         struct rockchip_atomic_commit *commit = &private->commit;
> -       int ret;
> +       struct drm_crtc_state *crtc_state;
> +       struct drm_crtc *crtc;
> +       int i, ret;
> +
> +       if (async) {
> +               for_each_crtc_in_state(state, crtc, crtc_state, i) {
> +                       if (crtc->state->event ||
> +                           rockchip_drm_crtc_has_pending_event(crtc)) {
> +                               return -EBUSY;
> +                       }
> +               }
> +       }

Hmmm ...

Doesn't this trigger before the VOP atomic_begin() helper, meaning
that anything with an event set will trigger the check? Seems like it
should be && rather than ||.

Also, I know rockchip_drm_vop.c isn't holding dev->event_lock when it
checks vop->event, but it really should be ... and so should this
check. Otherwise you can race with the IRQ handler, which isn't
required to hold the CRTC lock.

Cheers,
Daniel
