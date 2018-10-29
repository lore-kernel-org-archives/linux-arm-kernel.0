From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 29 Oct 2018 10:31:42 +0100
Subject: [PATCH v3 16/25] drm/sun4i: sun6i_mipi_dsi: Add support for
 VCC-DSI voltage regulator
In-Reply-To: <20181026144344.27778-17-jagan@amarulasolutions.com>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
 <20181026144344.27778-17-jagan@amarulasolutions.com>
Message-ID: <20181029093142.hgn4q6o7q32voutf@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2018 at 08:13:35PM +0530, Jagan Teki wrote:
> Some boards have VCC-DSI pin connected to voltage regulator which may
> not be turned on by default.
> 
> Add support for such boards by adding voltage regulator handling code to
> MIPI DSI driver.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Tested-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - new patch
> Changes for v2:
> - none
> 
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 14 ++++++++++++++
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |  3 +++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> index 42bd7506abaf..bc57343592e0 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -949,6 +949,12 @@ static int sun6i_dsi_bind(struct device *dev, struct device *master,
>  
>  	dsi->drv = drv;
>  
> +	ret = regulator_enable(dsi->regulator);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable regulator\n");
> +		return ret;
> +	}
> +

The regulator should be enabled only when the device is in use.

>  	drm_encoder_helper_add(&dsi->encoder,
>  			       &sun6i_dsi_enc_helper_funcs);
>  	ret = drm_encoder_init(drm,
> @@ -980,6 +986,7 @@ static int sun6i_dsi_bind(struct device *dev, struct device *master,
>  
>  err_cleanup_connector:
>  	drm_encoder_cleanup(&dsi->encoder);
> +	regulator_disable(dsi->regulator);
>  	return ret;
>  }
>  
> @@ -989,6 +996,7 @@ static void sun6i_dsi_unbind(struct device *dev, struct device *master,
>  	struct sun6i_dsi *dsi = dev_get_drvdata(dev);
>  
>  	drm_panel_detach(dsi->panel);
> +	regulator_disable(dsi->regulator);
>  }
>  
>  static const struct component_ops sun6i_dsi_ops = {
> @@ -1022,6 +1030,12 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
>  		return PTR_ERR(base);
>  	}
>  
> +	dsi->regulator = devm_regulator_get(dev, "vcc-dsi");
> +	if (IS_ERR(dsi->regulator)) {
> +		dev_err(dev, "Couldn't get regulator\n");
> +		return PTR_ERR(dsi->regulator);
> +	}
> +

You haven't updated the DT bindings accordingly.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181029/ba137116/attachment-0001.sig>
