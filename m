From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 May 2016 11:51:36 +0800
Subject: [PATCH 08/20] drm/sun4i: rgb: panel is an error pointer
In-Reply-To: <1463402840-17062-9-git-send-email-maxime.ripard@free-electrons.com>
References: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
 <1463402840-17062-9-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v6485nF_e9GeANLsy2Rq1XOn4nV5wD_eWskTmL2ME316+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 16, 2016 at 8:47 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> In case of an error, our pointer to the drm_panel structure attached to our
> encoder will hold an error pointer, not a NULL pointer.
>
> Make sure we check the right thing.
>
> Fixes: 29e57fab97fc ("drm: sun4i: Add RGB output")
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_rgb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
> index 923f55039cb1..b46d2c15dc95 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
> @@ -217,7 +217,7 @@ int sun4i_rgb_init(struct drm_device *drm)
>         int ret;
>
>         /* If we don't have a panel, there's no point in going on */
> -       if (!tcon->panel)
> +       if (IS_ERR(tcon->panel))

Without the next patch, tcon->panel could be the result of of_drm_find_panel(),
which could be NULL.

Use IS_ERR_OR_NULL here, or reorder/squash the patches.

Regards
ChenYu

>                 return -ENODEV;
>
>         rgb = devm_kzalloc(drm->dev, sizeof(*rgb), GFP_KERNEL);
> --
> 2.8.2
>
