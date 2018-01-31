From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Wed, 31 Jan 2018 20:07:18 +0100
Subject: [PATCH v2 08/16] iio: adc: sun4i-gpadc-iio: rework: add
 interrupt support
In-Reply-To: <20180128232919.12639-9-embed3d@gmail.com>
References: <20180128232919.12639-1-embed3d@gmail.com>
 <20180128232919.12639-9-embed3d@gmail.com>
Message-ID: <20180131190718.ustqzwdxzw7mqe52@qschulz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Mon, Jan 29, 2018 at 12:29:11AM +0100, Philipp Rossak wrote:
> This patch rewors the driver to support interrupts for the thermal part
> of the sensor.
> 
> This is only available for the newer sensor (currently H3 and A83T).
> The interrupt will be trigerd on data available and triggers the update
> for the thermal sensors. All newer sensors have different amount of
> sensors and different interrupts for each device the reset of the
> interrupts need to be done different
> 
> For the newer sensors is the autosuspend disabled.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> Acked-by: Jonathan  Cameron <jonathan.cameron@huawei.com>
> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c | 60 +++++++++++++++++++++++++++++++++++----
>  include/linux/mfd/sun4i-gpadc.h   |  2 ++
>  2 files changed, 56 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
> index 74eeb5cd5218..b7b5451226b0 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -71,11 +71,14 @@ struct gpadc_data {
>  	unsigned int	temp_data[MAX_SENSOR_COUNT];
>  	int		(*sample_start)(struct sun4i_gpadc_iio *info);
>  	int		(*sample_end)(struct sun4i_gpadc_iio *info);
> +	u32		irq_clear_map;
> +	u32		irq_control_map;

I would say to use a regmap_irq_chip for controlling IRQs.

>  	bool		has_bus_clk;
>  	bool		has_bus_rst;
>  	bool		has_mod_clk;
>  	int		sensor_count;
>  	bool		supports_nvmem;
> +	bool		support_irq;
>  };
>  
>  static const struct gpadc_data sun4i_gpadc_data = {
> @@ -90,6 +93,7 @@ static const struct gpadc_data sun4i_gpadc_data = {
>  	.sample_end = sun4i_gpadc_sample_end,
>  	.sensor_count = 1,
>  	.supports_nvmem = false,
> +	.support_irq = false,

False is the default, no need to set support_irq.

[...]

>  struct sun4i_gpadc_iio {
> @@ -332,6 +339,11 @@ static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val,
>  		return 0;
>  	}
>  
> +	if (info->data->support_irq) {
> +		regmap_read(info->regmap, info->data->temp_data[sensor], val);
> +		return 0;
> +	}
> +

Maybe you could define a new thermal_zone_of_device_ops for these new
thermal sensors? That way, you don't even need the boolean support_irq.

>  	return sun4i_gpadc_read(indio_dev, 0, val, info->temp_data_irq);
>  }
>  
> @@ -429,6 +441,17 @@ static irqreturn_t sun4i_gpadc_fifo_data_irq_handler(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +static irqreturn_t sunxi_irq_thread(int irq, void *data)

I think we're trying to avoid sunxi mentions but rather using the name
of the first IP (in term of product release, not support) using this
function.

> +{
> +	struct sun4i_gpadc_iio *info = data;
> +
> +	regmap_write(info->regmap, SUN8I_H3_THS_STAT, info->data->irq_clear_map);
> +

Will be handled by regmap_irq_chip.
[...]
> -	info->no_irq = true;
> +	if (info->data->support_irq) {
> +		/* only the new versions of ths support right now irqs */
> +		irq = platform_get_irq(pdev, 0);
> +		if (irq < 0) {
> +			dev_err(&pdev->dev, "failed to get IRQ: %d\n", irq);
> +			return irq;
> +		}
> +
> +		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +				sunxi_irq_thread, IRQF_ONESHOT,
> +				dev_name(&pdev->dev), info);
> +		if (ret)
> +			return ret;
> +
> +	} else
> +		info->no_irq = true;
> +

That's a bit funny to have two booleans named no_irq and support_irq :)

>  	indio_dev->num_channels = ARRAY_SIZE(sun8i_a33_gpadc_channels);
>  	indio_dev->channels = sun8i_a33_gpadc_channels;
>  
> @@ -789,11 +829,13 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	pm_runtime_set_autosuspend_delay(&pdev->dev,
> -					 SUN4I_GPADC_AUTOSUSPEND_DELAY);
> -	pm_runtime_use_autosuspend(&pdev->dev);
> -	pm_runtime_set_suspended(&pdev->dev);
> -	pm_runtime_enable(&pdev->dev);
> +	if (!info->data->support_irq) {
> +		pm_runtime_set_autosuspend_delay(&pdev->dev,
> +						 SUN4I_GPADC_AUTOSUSPEND_DELAY);
> +		pm_runtime_use_autosuspend(&pdev->dev);
> +		pm_runtime_set_suspended(&pdev->dev);
> +		pm_runtime_enable(&pdev->dev);
> +	}

Why would you not want your IP to do runtime PM?

Quentin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180131/b8de4a9e/attachment.sig>
