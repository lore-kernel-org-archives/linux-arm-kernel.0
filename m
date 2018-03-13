From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 13 Mar 2018 10:36:26 +0100
Subject: [PATCH 1/3] drm/meson: Fix an un-handled error path in
 'meson_drv_bind_master()'
In-Reply-To: <6cbf3d70ac3904489c7194c895225c4103aebb96.1520885192.git.christophe.jaillet@wanadoo.fr>
References: <cover.1520885192.git.christophe.jaillet@wanadoo.fr>
 <6cbf3d70ac3904489c7194c895225c4103aebb96.1520885192.git.christophe.jaillet@wanadoo.fr>
Message-ID: <48544583-2bf9-0904-b848-ec4194200af6@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2018 21:15, Christophe JAILLET wrote:
> 'drm_vblank_init()' can fail. So handle this (unlikely) error.
> 
> Fixes: bbbe775ec5b5 ("drm: Add support for Amlogic Meson Graphic Controller")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/gpu/drm/meson/meson_drv.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
> index f9ad0e960263..02b0886debc0 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -222,7 +222,10 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>  
>  	priv->vsync_irq = platform_get_irq(pdev, 0);
>  
> -	drm_vblank_init(drm, 1);
> +	ret = drm_vblank_init(drm, 1);
> +	if (ret)
> +		goto free_drm;
> +
>  	drm_mode_config_init(drm);
>  	drm->mode_config.max_width = 3840;
>  	drm->mode_config.max_height = 2160;
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks,
Neil
