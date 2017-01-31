From: seanpaul@chromium.org (Sean Paul)
Date: Tue, 31 Jan 2017 14:21:17 -0500
Subject: [PATCH v3 21/24] drm/rockchip: dw-mipi-dsi: defer probe if panel
 is not loaded
In-Reply-To: <20170129132444.25251-22-john@metanate.com>
References: <20170129132444.25251-1-john@metanate.com>
 <20170129132444.25251-22-john@metanate.com>
Message-ID: <20170131192117.GE20076@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 29, 2017 at 01:24:41PM +0000, John Keeping wrote:
> This ensures that the output resolution is known before fbcon loads.
> 
> Signed-off-by: John Keeping <john@metanate.com>
> ---
> Unchanged in v3
> Unchanged in v2
> 
>  drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> index f5b15377ef85..5bad92e2370e 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> @@ -1176,10 +1176,17 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
>  
>  	dsi->dsi_host.ops = &dw_mipi_dsi_host_ops;
>  	dsi->dsi_host.dev = dev;
> -	return mipi_dsi_host_register(&dsi->dsi_host);
> +	ret = mipi_dsi_host_register(&dsi->dsi_host);
> +	if (!ret && !dsi->panel) {
> +		mipi_dsi_host_unregister(&dsi->dsi_host);
> +		drm_encoder_cleanup(&dsi->encoder);
> +		drm_connector_cleanup(&dsi->connector);

Move the host registration up before dw_mipi_dsi_register() to avoid
having to clean up the encoder and connector?

> +		ret = -EPROBE_DEFER;
> +	}
>  
>  err_pllref:
> -	clk_disable_unprepare(dsi->pllref_clk);
> +	if (ret)

I personally think it's cleaner to explicitly goto in the error conditional (or
in this case, the defer conditional) and have a return 0; right before the err_*
labels. Then you don't need to worry about a) checking ret in all of your
cleanups and b) someone adding code above the labels that you don't intend to
run.

Sean

> +		clk_disable_unprepare(dsi->pllref_clk);
>  	return ret;
>  }
>  
> -- 
> 2.11.0.197.gb556de5.dirty
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Sean Paul, Software Engineer, Google / Chromium OS
