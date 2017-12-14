From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 14 Dec 2017 11:28:07 +0800
Subject: [PATCH v4 06/15] drm/sun4i: Force the mixer rate at 150MHz
In-Reply-To: <34f2c9d5c9ab48ead94253144a8e829cccfa4653.1512662253.git-series.maxime.ripard@free-electrons.com>
References: <cover.e46a07c0e181d735c807dc94fe0ce0ea013788be.1512662253.git-series.maxime.ripard@free-electrons.com>
 <34f2c9d5c9ab48ead94253144a8e829cccfa4653.1512662253.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v66TMDEJa=K+k0oMo5n64TMrpJf1Rtf0_HQMb8VpyDKZdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 7, 2017 at 11:58 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> It seems like the mixer can only run properly when clocked at 150MHz. In
> order to have something more robust than simply a fire-and-forget
> assigned-clocks-rate, let's put that in the code.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/gpu/drm/sun4i/sun8i_mixer.c |  9 +++++++++
>  drivers/gpu/drm/sun4i/sun8i_mixer.h |  3 +++
>  2 files changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> index 29ceeb016d72..ff235e3228ce 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -400,6 +400,14 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
>         }
>         clk_prepare_enable(mixer->mod_clk);
>
> +       /*
> +        * It seems that we need to enforce that rate for whatever
> +        * reason for the mixer to be functional. Make sure it's the
> +        * case.
> +        */
> +       if (mixer->cfg->mod_rate)
> +               clk_set_rate(mixer->mod_clk, mixer->cfg->mod_rate);
> +

I think it might be better to set the rate first, then enable the clock.
This is sort of implied by the user manual saying "PLLs other than CPU
do not support DVFS". And it fits better with CLK_SET_RATE_GATE semantics,
if we ever adopt it.

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

>         list_add_tail(&mixer->engine.list, &drv->engine_list);
>
>         /* Reset the registers */
> @@ -474,6 +482,7 @@ static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
>         .ui_num = 1,
>         .scaler_mask = 0x3,
>         .ccsc = 0,
> +       .mod_rate = 150000000,
>  };
>
>  static const struct of_device_id sun8i_mixer_of_table[] = {
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
> index bc58040a88f9..f34e70c42adf 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
> @@ -121,12 +121,15 @@ struct de2_fmt_info {
>   *     Set value to 0 if this is first mixer or second mixer with VEP support.
>   *     Set value to 1 if this is second mixer without VEP support. Other values
>   *     are invalid.
> + * @mod_rate: module clock rate that needs to be set in order to have
> + *     a functional block.
>   */
>  struct sun8i_mixer_cfg {
>         int             vi_num;
>         int             ui_num;
>         int             scaler_mask;
>         int             ccsc;
> +       unsigned long   mod_rate;
>  };
>
>  struct sun8i_mixer {
> --
> git-series 0.9.1
