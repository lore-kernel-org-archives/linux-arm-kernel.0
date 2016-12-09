From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Fri, 9 Dec 2016 12:20:35 +0200
Subject: [PATCH v6 2/5] [media] davinci: vpif_capture: remove hard-coded
 I2C adapter id
In-Reply-To: <20161207183025.20684-3-khilman@baylibre.com>
References: <20161207183025.20684-1-khilman@baylibre.com>
 <20161207183025.20684-3-khilman@baylibre.com>
Message-ID: <20161209102035.GM16630@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Wed, Dec 07, 2016 at 10:30:22AM -0800, Kevin Hilman wrote:
> Remove hard-coded I2C adapter in favor of getting the
> ID from platform_data.
> 
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
>  drivers/media/platform/davinci/vpif_capture.c | 5 ++++-
>  include/media/davinci/vpif_types.h            | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/davinci/vpif_capture.c b/drivers/media/platform/davinci/vpif_capture.c
> index 20c4344ed118..c24049acd40a 100644
> --- a/drivers/media/platform/davinci/vpif_capture.c
> +++ b/drivers/media/platform/davinci/vpif_capture.c
> @@ -1486,7 +1486,10 @@ static __init int vpif_probe(struct platform_device *pdev)
>  	}
>  
>  	if (!vpif_obj.config->asd_sizes) {
> -		i2c_adap = i2c_get_adapter(1);
> +		int i2c_id = vpif_obj.config->i2c_adapter_id;

Is there a particular reason to use a temporary variable just once? I'd use
the i2c_adapter_field directly instead. Up to you.

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

> +
> +		i2c_adap = i2c_get_adapter(i2c_id);
> +		WARN_ON(!i2c_adap);
>  		for (i = 0; i < subdev_count; i++) {
>  			subdevdata = &vpif_obj.config->subdev_info[i];
>  			vpif_obj.sd[i] =
> diff --git a/include/media/davinci/vpif_types.h b/include/media/davinci/vpif_types.h
> index 3cb1704a0650..4282a7db99d4 100644
> --- a/include/media/davinci/vpif_types.h
> +++ b/include/media/davinci/vpif_types.h
> @@ -82,6 +82,7 @@ struct vpif_capture_config {
>  	struct vpif_capture_chan_config chan_config[VPIF_CAPTURE_MAX_CHANNELS];
>  	struct vpif_subdev_info *subdev_info;
>  	int subdev_count;
> +	int i2c_adapter_id;
>  	const char *card_name;
>  	struct v4l2_async_subdev **asd;	/* Flat array, arranged in groups */
>  	int *asd_sizes;		/* 0-terminated array of asd group sizes */

-- 
Sakari Ailus
e-mail: sakari.ailus at iki.fi	XMPP: sailus at retiisi.org.uk
