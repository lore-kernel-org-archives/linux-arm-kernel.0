From: seanpaul@google.com (Sean Paul)
Date: Tue, 27 Sep 2016 12:05:36 -0400
Subject: [PATCH][v2] drm/sun4i: rgb: Enable panel after controller
In-Reply-To: <20160926102146.19129-1-net147@gmail.com>
References: <20160926102146.19129-1-net147@gmail.com>
Message-ID: <CAOw6vbLzbx6D1C1bOZnMN-XgW=zAhCcV7OVK0VHhr8E6cagQ2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 26, 2016 at 6:21 AM, Jonathan Liu <net147@gmail.com> wrote:
> The panel should be enabled after the controller so that we do not have
> visual glitches on the panel while the controller is setup. Similarly,
> the panel should be disabled before the controller.
>
> Signed-off-by: Jonathan Liu <net147@gmail.com>

Cool, this makes much more sense.

Reviewed-by: Sean Paul <seanpaul@chromium.org>


I still think there's a problem with the bridge ops, though.


Sean


> ---
> Changes in v2:
>  - Changed the commit message to be clearer
>
>  drivers/gpu/drm/sun4i/sun4i_rgb.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
> index c3ff10f..4e4bea6 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
> @@ -152,15 +152,16 @@ static void sun4i_rgb_encoder_enable(struct drm_encoder *encoder)
>
>         DRM_DEBUG_DRIVER("Enabling RGB output\n");
>
> -       if (!IS_ERR(tcon->panel)) {
> +       if (!IS_ERR(tcon->panel))
>                 drm_panel_prepare(tcon->panel);
> -               drm_panel_enable(tcon->panel);
> -       }
>
>         /* encoder->bridge can be NULL; drm_bridge_enable checks for it */
>         drm_bridge_enable(encoder->bridge);
>
>         sun4i_tcon_channel_enable(tcon, 0);
> +
> +       if (!IS_ERR(tcon->panel))
> +               drm_panel_enable(tcon->panel);
>  }
>
>  static void sun4i_rgb_encoder_disable(struct drm_encoder *encoder)
> @@ -171,15 +172,16 @@ static void sun4i_rgb_encoder_disable(struct drm_encoder *encoder)
>
>         DRM_DEBUG_DRIVER("Disabling RGB output\n");
>
> +       if (!IS_ERR(tcon->panel))
> +               drm_panel_disable(tcon->panel);
> +
>         sun4i_tcon_channel_disable(tcon, 0);
>
>         /* encoder->bridge can be NULL; drm_bridge_disable checks for it */
>         drm_bridge_disable(encoder->bridge);
>
> -       if (!IS_ERR(tcon->panel)) {
> -               drm_panel_disable(tcon->panel);
> +       if (!IS_ERR(tcon->panel))
>                 drm_panel_unprepare(tcon->panel);
> -       }
>  }
>
>  static void sun4i_rgb_encoder_mode_set(struct drm_encoder *encoder,
> --
> 2.10.0
>
