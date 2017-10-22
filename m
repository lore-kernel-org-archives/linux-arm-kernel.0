From: plaes@plaes.org (Priit Laes)
Date: Sun, 22 Oct 2017 18:52:42 +0000
Subject: [PATCH 15/23] drm/sun4i: Add LVDS support
In-Reply-To: <6e313d0b31dca3f47583668eb755d934a1ab515e.1508231063.git-series.maxime.ripard@free-electrons.com>
References: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
 <6e313d0b31dca3f47583668eb755d934a1ab515e.1508231063.git-series.maxime.ripard@free-electrons.com>
Message-ID: <20171022185241.GA11292@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 11:06:22AM +0200, Maxime Ripard wrote:
> The TCON supports the LVDS interface to output to a panel or a bridge.
> Let's add support for it.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/gpu/drm/sun4i/Makefile     |   1 +-
>  drivers/gpu/drm/sun4i/sun4i_lvds.c | 183 ++++++++++++++++++++++++++++-
>  drivers/gpu/drm/sun4i/sun4i_lvds.h |  18 +++-
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 193 +++++++++++++++++++++++++++++-
>  drivers/gpu/drm/sun4i/sun4i_tcon.h |  25 ++++-
>  5 files changed, 419 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/sun4i/sun4i_lvds.c
>  create mode 100644 drivers/gpu/drm/sun4i/sun4i_lvds.h
> 

[...]

> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index 3efa1ab045cd..6a20a467ee6d 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c

[...]
> @@ -698,6 +858,26 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
>  		return ret;
>  	}
>  
> +	/*
> +	 * This can only be made optional since we've had DT nodes
> +	 * without the LVDS reset properties.
> +	 *
> +	 * If the property is missing, just disable LVDS, and print a
> +	 * warning.
> +	 */
> +	tcon->lvds_rst = devm_reset_control_get_optional(dev, "lvds");
> +	if (IS_ERR(tcon->lvds_rst)) {
> +		dev_err(dev, "Couldn't get our reset line\n");
> +		return PTR_ERR(tcon->lvds_rst);
> +	} else if (tcon->lvds_rst) {
> +		has_lvds = true;
> +		reset_control_reset(tcon->lvds_rst);
> +	} else {
> +		has_lvds = false;
> +		dev_warn(dev,
> +			 "Missing LVDS reset property, you should consider upgrading your DT\n");

This will generate annoying warning for tcon1 on A10/A20.

> +	}
> +
>  	ret = sun4i_tcon_init_clocks(dev, tcon);
>  	if (ret) {
>  		dev_err(dev, "Couldn't init our TCON clocks\n");
> @@ -729,7 +909,18 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
>  		goto err_free_clocks;
>  	}
>  
> -	ret = sun4i_rgb_init(drm, tcon);
> +	/*
> +	 * If we have an LVDS panel connected to the TCON, we should
> +	 * just probe the LVDS connector. Otherwise, just probe RGB as
> +	 * we used to.
> +	 */
