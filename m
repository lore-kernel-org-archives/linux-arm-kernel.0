From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 31 Aug 2018 11:09:15 +0200
Subject: [PATCH v3 20/30] iio: adc: sun4i-gpadc-iio: rework: device
 specific suspend & resume
In-Reply-To: <20180830154518.29507-21-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-21-embed3d@gmail.com>
Message-ID: <20180831090915.agbldint76ngj5jf@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2018 at 05:45:08PM +0200, Philipp Rossak wrote:
> Different sensors will have different suspend and resume functions. So
> we are modularize the suspend and resume functions.
> 
> The resume function configures and initializes the thermal sensor and
> the suspend function disables the sensors.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
> index 2fd73d143815..c7b46c82e3e5 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -76,6 +76,9 @@ struct gpadc_data {
>  
>  static irqreturn_t sun4i_gpadc_data_irq_handler(int irq, void *dev_id);
>  
> +static int sun4i_ths_resume(struct sun4i_gpadc_iio *info);
> +static int sun4i_ths_suspend(struct sun4i_gpadc_iio *info);
> +
>  static const struct gpadc_data sun4i_gpadc_data = {
>  	.temp_offset = -1932,
>  	.temp_scale = 133,
> @@ -87,6 +90,8 @@ static const struct gpadc_data sun4i_gpadc_data = {
>  	.ths_irq_thread = sun4i_gpadc_data_irq_handler,
>  	.support_irq = true,
>  	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
> +	.ths_resume = sun4i_ths_resume,
> +	.ths_suspend = sun4i_ths_suspend,
>  	.sensor_count = 1,
>  };
>  
> @@ -101,6 +106,8 @@ static const struct gpadc_data sun5i_gpadc_data = {
>  	.ths_irq_thread = sun4i_gpadc_data_irq_handler,
>  	.support_irq = true,
>  	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
> +	.ths_resume = sun4i_ths_resume,
> +	.ths_suspend = sun4i_ths_suspend,
>  	.sensor_count = 1,
>  };
>  
> @@ -115,6 +122,8 @@ static const struct gpadc_data sun6i_gpadc_data = {
>  	.ths_irq_thread = sun4i_gpadc_data_irq_handler,
>  	.support_irq = true,
>  	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
> +	.ths_resume = sun4i_ths_resume,
> +	.ths_suspend = sun4i_ths_suspend,
>  	.sensor_count = 1,
>  };
>  
> @@ -123,6 +132,8 @@ static const struct gpadc_data sun8i_a33_gpadc_data = {
>  	.temp_scale = 162,
>  	.tp_mode_en = SUN8I_A33_GPADC_CTRL1_CHOP_TEMP_EN,
>  	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
> +	.ths_resume = sun4i_ths_resume,
> +	.ths_suspend = sun4i_ths_suspend,
>  	.sensor_count = 1,
>  };
>  
> @@ -401,6 +412,11 @@ static irqreturn_t sun4i_gpadc_data_irq_handler(int irq, void *dev_id)
>  static int sun4i_gpadc_runtime_suspend(struct device *dev)
>  {
>  	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
> +	return info->data->ths_suspend(info);
> +}
> +
> +static int sun4i_ths_suspend(struct sun4i_gpadc_iio *info)

suspend is already a hook in the kernel, which hasn't the same meaning
than runtime_suspend (and the same applies to resume), so we'd rather
pick a better name. And all the functions (and the driver) use gpadc,
please continue to use that prefix.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180831/99c4c49b/attachment.sig>
