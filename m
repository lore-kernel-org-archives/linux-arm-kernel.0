From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 27 Sep 2018 19:18:31 +0200
Subject: [PATCH 05/12] drm/sun4i: sun6i_mipi_dsi: Add DSI Generic short
 write 2 param transfer
In-Reply-To: <20180927114850.24565-6-jagan@amarulasolutions.com>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
 <20180927114850.24565-6-jagan@amarulasolutions.com>
Message-ID: <20180927171831.2nfybgn2xmc4vrgt@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2018 at 05:18:43PM +0530, Jagan Teki wrote:
> Short transfer write support for DCS and Generic transfer types
> share similar way to process command sequence in DSI block so
> add generic write 2 param transfer type macro so-that the panels
> which are requesting similar transfer type may process properly.
> 
> Also added error check for unsupporting transfer types this make
> debugging easy for new transfer types.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> index 156b371243c6..1c7e42015645 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -869,6 +869,7 @@ static ssize_t sun6i_dsi_transfer(struct mipi_dsi_host *host,
>  		     SUN6I_DSI_CMD_CTL_TX_FLAG);
>  
>  	switch (msg->type) {
> +	case MIPI_DSI_GENERIC_SHORT_WRITE_2_PARAM:
>  	case MIPI_DSI_DCS_SHORT_WRITE:
>  	case MIPI_DSI_DCS_SHORT_WRITE_PARAM:

You should order them by alphabetical order.

>  		ret = sun6i_dsi_dcs_write_short(dsi, msg);
> @@ -885,6 +886,8 @@ static ssize_t sun6i_dsi_transfer(struct mipi_dsi_host *host,
>  		}
>  
>  	default:
> +		dev_err(dsi->dev, "unsupported message type 0x%02x\n",
> +			msg->type);

And this isn't an error check.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
