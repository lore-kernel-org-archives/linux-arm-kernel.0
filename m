From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 14 Jul 2017 16:56:01 +0800
Subject: [PATCH 4/4] drm/sun4i: make sure we don't have a commit pending
In-Reply-To: <a6dfec7ea3598c64f6653e9b8b5febac79172341.1499956639.git-series.maxime.ripard@free-electrons.com>
References: <cover.75b0c7f741ed33015a7ad44941bed1f6152a48a9.1499956639.git-series.maxime.ripard@free-electrons.com>
 <a6dfec7ea3598c64f6653e9b8b5febac79172341.1499956639.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64KnB_zU0yk7MsGr9WRK1wpWq1xOj_cNuQ4mSQJeAGarw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 13, 2017 at 10:41 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> In the earlier display engine designs, any register access while a commit
> is pending is forbidden.
>
> One of the symptoms is that reading a register will return another, random,
> register value which can lead to register corruptions if we ever do a
> read/modify/write cycle.

Alternatively, if changes to the backend (layers) are guaranteed to happen
while the CRTC is disabled (which seems to be the case after looking at
drm_atomic_helper_commit_planes and drm_atomic_helper_commit_tail), we
could just turn on register auto-commit all the time and not deal with
this.

ChenYu

>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_backend.c | 14 ++++++++++++++
>  drivers/gpu/drm/sun4i/sun4i_crtc.c    |  1 +
>  2 files changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
> index cf480218daa5..ce1f40f7511e 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> @@ -67,6 +67,19 @@ static void sun4i_backend_commit(struct sunxi_engine *engine)
>                      SUN4I_BACKEND_REGBUFFCTL_LOADCTL);
>  }
>
> +static int sun4i_backend_commit_poll(struct sunxi_engine *engine)
> +{
> +       u32 val;
> +
> +       DRM_DEBUG_DRIVER("Polling for the commit to end\n");
> +
> +       return regmap_read_poll_timeout(engine->regs,
> +                                       SUN4I_BACKEND_REGBUFFCTL_REG,
> +                                       val,
> +                                       !(val & SUN4I_BACKEND_REGBUFFCTL_LOADCTL),
> +                                       100, 50000);
> +}
> +
>  void sun4i_backend_layer_enable(struct sun4i_backend *backend,
>                                 int layer, bool enable)
>  {
> @@ -330,6 +343,7 @@ static int sun4i_backend_of_get_id(struct device_node *node)
>
>  static const struct sunxi_engine_ops sun4i_backend_engine_ops = {
>         .commit                         = sun4i_backend_commit,
> +       .commit_poll                    = sun4i_backend_commit_poll,
>         .layers_init                    = sun4i_layers_init,
>         .apply_color_correction         = sun4i_backend_apply_color_correction,
>         .disable_color_correction       = sun4i_backend_disable_color_correction,
> diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c b/drivers/gpu/drm/sun4i/sun4i_crtc.c
> index 2eba1d8639d8..31550493fa1d 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
> @@ -34,6 +34,7 @@ static void sun4i_crtc_atomic_begin(struct drm_crtc *crtc,
>                                     struct drm_crtc_state *old_state)
>  {
>         struct sun4i_crtc *scrtc = drm_crtc_to_sun4i_crtc(crtc);
> +       struct sunxi_engine *engine = scrtc->engine;
>         struct drm_device *dev = crtc->dev;
>         unsigned long flags;
>
> --
> git-series 0.9.1
