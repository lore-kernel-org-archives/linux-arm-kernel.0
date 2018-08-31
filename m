From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 31 Aug 2018 10:50:00 +0200
Subject: [PATCH v3 16/30] iio: adc: sun4i-gpadc-iio: rework: readout
 temp_data
In-Reply-To: <20180830154518.29507-17-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-17-embed3d@gmail.com>
Message-ID: <20180831085000.xsqliawn7yl7l3ax@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2018 at 05:45:04PM +0200, Philipp Rossak wrote:
> For adding newer sensor some basic rework of the code is necessary.
> 
> This commit reworks the code and uses regmap field to read out
> temp_data.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
> index d48f338af563..c278e165e161 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -63,6 +63,7 @@ struct gpadc_data {
>  	int		(*ths_suspend)(struct sun4i_gpadc_iio *info);
>  	int		(*ths_resume)(struct sun4i_gpadc_iio *info);
>  	bool		support_irq;
> +	u32		temp_data_base;
>  };
>  
>  static irqreturn_t sun4i_gpadc_data_irq_handler(int irq, void *dev_id);
> @@ -77,6 +78,7 @@ static const struct gpadc_data sun4i_gpadc_data = {
>  	.adc_channel = true,
>  	.ths_irq_thread = sun4i_gpadc_data_irq_handler,
>  	.support_irq = true,
> +	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
>  };
>  
>  static const struct gpadc_data sun5i_gpadc_data = {
> @@ -89,6 +91,7 @@ static const struct gpadc_data sun5i_gpadc_data = {
>  	.adc_channel = true,
>  	.ths_irq_thread = sun4i_gpadc_data_irq_handler,
>  	.support_irq = true,
> +	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
>  };
>  
>  static const struct gpadc_data sun6i_gpadc_data = {
> @@ -101,12 +104,14 @@ static const struct gpadc_data sun6i_gpadc_data = {
>  	.adc_channel = true,
>  	.ths_irq_thread = sun4i_gpadc_data_irq_handler,
>  	.support_irq = true,
> +	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
>  };
>  
>  static const struct gpadc_data sun8i_a33_gpadc_data = {
>  	.temp_offset = -1662,
>  	.temp_scale = 162,
>  	.tp_mode_en = SUN8I_A33_GPADC_CTRL1_CHOP_TEMP_EN,
> +	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
>  };
>  
>  struct sun4i_gpadc_iio {
> @@ -271,18 +276,18 @@ static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val)
>  {
>  	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
>  
> -	if (!info->data->support_irq) {
> -		pm_runtime_get_sync(indio_dev->dev.parent);
> +	if (info->data->adc_channel)
> +		return sun4i_gpadc_read(indio_dev, 0, val,
> +				SUN4I_GPADC_IRQ_TEMP_DATA);
>  
> -		regmap_read(info->regmap, SUN4I_GPADC_TEMP_DATA, val);
> +	pm_runtime_get_sync(indio_dev->dev.parent);
>  
> -		pm_runtime_mark_last_busy(indio_dev->dev.parent);
> -		pm_runtime_put_autosuspend(indio_dev->dev.parent);
> +	regmap_read(info->regmap, info->data->temp_data_base, val);
>  
> -		return 0;
> -	}
> +	pm_runtime_mark_last_busy(indio_dev->dev.parent);
> +	pm_runtime_put_autosuspend(indio_dev->dev.parent);
>  
> -	return sun4i_gpadc_read(indio_dev, 0, val, SUN4I_GPADC_IRQ_TEMP_DATA);
> +	return 0;

You should make this patch as small as possible. If you want to add a
variable and to invert a condition, please make two patches.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180831/49970014/attachment-0001.sig>
