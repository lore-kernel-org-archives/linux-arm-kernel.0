From: emil.l.velikov@gmail.com (Emil Velikov)
Date: Tue, 30 Aug 2016 16:21:47 +0100
Subject: [PATCH] drm/sun4i: rgb: add missing calls to drm_panel_{prepare,
 unprepare}
In-Reply-To: <20160830065500.31847-1-net147@gmail.com>
References: <20160830065500.31847-1-net147@gmail.com>
Message-ID: <CACvgo53=_PQCEONbBpgRgHtLZGSiihGEYJFCPLYF1-ocLrfyMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 August 2016 at 07:55, Jonathan Liu <net147@gmail.com> wrote:
> If the enable-gpios property of a simple panel in device tree is set,
> the GPIO is not toggled on/off because of missing calls to
> drm_panel_prepare and drm_panel_unprepare.
>
> Signed-off-by: Jonathan Liu <net147@gmail.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_rgb.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
> index f5bbac6..d6943e9 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
> @@ -151,6 +151,7 @@ static void sun4i_rgb_encoder_enable(struct drm_encoder *encoder)
>
>         DRM_DEBUG_DRIVER("Enabling RGB output\n");
>
> +       drm_panel_prepare(tcon->panel);
>         drm_panel_enable(tcon->panel);
IMHO it's worth having a _prepare_enable, and alike on the dtor side,
similar to clk. The clk helper attributes when .enable() fails, which
is a good idea. Looking on the drm side - all the users of such
helper(s) don't bother checking neither .prepare or .enable. So
updating that alongside the introduction would be a great move ;-)

Just an idea about another small task.
Emil

P.S. Skimming through v4.7 mediatek (mtk) driver looks a bit
assymetrical wrt using the drm_panel API. Worth checking if things
have improved with later versions ?
