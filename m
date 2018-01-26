From: briannorris@chromium.org (Brian Norris)
Date: Thu, 25 Jan 2018 16:46:29 -0800
Subject: [PATCH v2 2/2] drm/bridge/synopsys: dsi: Fix dsi_host_transfer()
 return value
In-Reply-To: <20180125103800.1999-3-philippe.cornu@st.com>
References: <20180125103800.1999-1-philippe.cornu@st.com>
 <20180125103800.1999-3-philippe.cornu@st.com>
Message-ID: <20180126004628.fbrady7twf7ys2qx@ban.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 25, 2018 at 11:38:00AM +0100, Philippe Cornu wrote:
> The dw_mipi_dsi_host_transfer() must return the number of
> bytes transmitted/received on success instead of 0.
> Note: As the read feature is not implemented, only the
> transmitted number of bytes is returned for the moment.
> 
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>

Assuming we're going with the current documented semantics (where we
return # of TX bytes for writes), then:

Reviewed-by: Brian Norris <briannorris@chromium.org>

I believe Archit was suggesting maybe changing that sometime, but that's
no excuse for not matching documentation now.

> ---
>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> index 72ecaeb40822..090bf62d1ea8 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> @@ -419,7 +419,16 @@ static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
>  
>  	dw_mipi_message_config(dsi, msg);
>  
> -	return dw_mipi_dsi_write(dsi, &packet);
> +	ret = dw_mipi_dsi_write(dsi, &packet);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * TODO Only transmitted size is returned as actual driver does
> +	 * not support dcs/generic reads. Please update return value when
> +	 * delivering the read feature.
> +	 */
> +	return packet.size;

You're really holding my hand here, I see :) Thanks I guess.

>  }
>  
>  static const struct mipi_dsi_host_ops dw_mipi_dsi_host_ops = {
> -- 
> 2.15.1
> 
