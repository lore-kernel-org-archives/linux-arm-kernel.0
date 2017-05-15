From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 15 May 2017 11:11:48 +0200
Subject: [PATCH] iio: adc: sun4i-gpadc-iio: fix parent device being used
 in devm function
In-Reply-To: <20170515073902.25994-1-quentin.schulz@free-electrons.com>
References: <20170515073902.25994-1-quentin.schulz@free-electrons.com>
Message-ID: <20170515091148.gk2zvtjy5bdpbfzt@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 15, 2017 at 09:39:02AM +0200, Quentin Schulz wrote:
> For the sake of DT binding stability, this IIO driver is a child of an
> MFD driver for Allwinner A10, A13 and A31 because there already exists a
> DT binding for this IP. The MFD driver has a DT node but the IIO driver
> does not.
> 
> The IIO device registers the temperature sensor in the thermal framework
> using the DT node of the parent, the MFD device, so the thermal
> framework could match the phandle to the MFD device in the DT and the
> struct device used to register in the thermal framework.
> 
> devm_thermal_zone_of_sensor_register was previously used to register the
> thermal sensor with the parent struct device of the IIO device,
> representing the MFD device. By doing so, we registered actually the
> parent in the devm routine and not the actual IIO device.
> 
> This lead to the devm unregister function not being called when the IIO
> module driver is removed. It resulted in the thermal framework still
> polling the get_temp function of the IIO module while the device doesn't
> exist anymore, thus generated a kernel panic.
> 
> Use the non-devm function instead and do the unregister manually in the
> remove function.
> 
> Fixes: d1caa9905538 ("iio: adc: add support for Allwinner SoCs ADC")
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Reported-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c | 31 ++++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
> index b23527309088..0d3df17be405 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -105,6 +105,7 @@ struct sun4i_gpadc_iio {
>  	bool				no_irq;
>  	/* prevents concurrent reads of temperature and ADC */
>  	struct mutex			mutex;
> +	struct thermal_zone_device	*tzd;
>  };
>  
>  #define SUN4I_GPADC_ADC_CHANNEL(_channel, _name) {		\
> @@ -502,7 +503,6 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
>  {
>  	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
>  	const struct of_device_id *of_dev;
> -	struct thermal_zone_device *tzd;
>  	struct resource *mem;
>  	void __iomem *base;
>  	int ret;
> @@ -532,13 +532,13 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
>  	if (!IS_ENABLED(CONFIG_THERMAL_OF))
>  		return 0;
>  
> -	tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, info,
> -						   &sun4i_ts_tz_ops);
> -	if (IS_ERR(tzd))
> +	info->tzd = thermal_zone_of_sensor_register(&pdev->dev, 0, info,
> +						    &sun4i_ts_tz_ops);
> +	if (IS_ERR(info->tzd))
>  		dev_err(&pdev->dev, "could not register thermal sensor: %ld\n",
> -			PTR_ERR(tzd));
> +			PTR_ERR(info->tzd));
>  
> -	return PTR_ERR_OR_ZERO(tzd);
> +	return PTR_ERR_OR_ZERO(info->tzd);
>  }
>  
>  static int sun4i_gpadc_probe_mfd(struct platform_device *pdev,
> @@ -584,15 +584,14 @@ static int sun4i_gpadc_probe_mfd(struct platform_device *pdev,
>  		 * of_node, and the device from this driver as third argument to
>  		 * return the temperature.
>  		 */
> -		struct thermal_zone_device *tzd;
> -		tzd = devm_thermal_zone_of_sensor_register(pdev->dev.parent, 0,
> -							   info,
> -							   &sun4i_ts_tz_ops);
> -		if (IS_ERR(tzd)) {
> +		info->tzd = thermal_zone_of_sensor_register(pdev->dev.parent, 0,
> +							    info,
> +							    &sun4i_ts_tz_ops);
> +		if (IS_ERR(info->tzd)) {
>  			dev_err(&pdev->dev,
>  				"could not register thermal sensor: %ld\n",
> -				PTR_ERR(tzd));
> -			return PTR_ERR(tzd);
> +				PTR_ERR(info->tzd));
> +			return PTR_ERR(info->tzd);
>  		}
>  	} else {
>  		indio_dev->num_channels =
> @@ -688,6 +687,12 @@ static int sun4i_gpadc_remove(struct platform_device *pdev)
>  
>  	pm_runtime_put(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> +
> +	if (pdev->dev.of_node)
> +		thermal_zone_of_sensor_unregister(&pdev->dev, info->tzd);
> +	else
> +		thermal_zone_of_sensor_unregister(pdev->dev.parent, info->tzd);
> +

Can't we just store the device used to create the zone in the
structure as well, that would avoid that non-trivial logic.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170515/32153984/attachment.sig>
