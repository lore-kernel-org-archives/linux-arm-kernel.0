From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 29 Jan 2018 10:46:50 +0100
Subject: [PATCH v2 09/16] iio: adc: sun4i-gpadc-iio: add support for H3
 thermal sensor
In-Reply-To: <20180128232919.12639-10-embed3d@gmail.com>
References: <20180128232919.12639-1-embed3d@gmail.com>
 <20180128232919.12639-10-embed3d@gmail.com>
Message-ID: <20180129094650.kpbhtbcpo42huadl@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 29, 2018 at 12:29:12AM +0100, Philipp Rossak wrote:
> This patch adds support for the H3 ths sensor.
> 
> The H3 supports interrupts. The interrupt is configured to update the
> the sensor values every second. The calibration data is writen at the
> begin of the init process.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c | 86 +++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/sun4i-gpadc.h   | 22 ++++++++++
>  2 files changed, 108 insertions(+)
> 
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
> index b7b5451226b0..8196203d65fe 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -61,6 +61,9 @@ struct sun4i_gpadc_iio;
>  static int sun4i_gpadc_sample_start(struct sun4i_gpadc_iio *info);
>  static int sun4i_gpadc_sample_end(struct sun4i_gpadc_iio *info);
>  
> +static int sunxi_ths_sample_start(struct sun4i_gpadc_iio *info);
> +static int sunxi_ths_sample_end(struct sun4i_gpadc_iio *info);
> +
>  struct gpadc_data {
>  	int		temp_offset;
>  	int		temp_scale;
> @@ -71,6 +74,10 @@ struct gpadc_data {
>  	unsigned int	temp_data[MAX_SENSOR_COUNT];
>  	int		(*sample_start)(struct sun4i_gpadc_iio *info);
>  	int		(*sample_end)(struct sun4i_gpadc_iio *info);
> +	u32		ctrl0_map;
> +	u32		ctrl2_map;
> +	u32		sensor_en_map;
> +	u32		filter_map;

You can use a regmap_field for that.

>  	u32		irq_clear_map;
>  	u32		irq_control_map;
>  	bool		has_bus_clk;
> @@ -138,6 +145,31 @@ static const struct gpadc_data sun8i_a33_gpadc_data = {
>  	.support_irq = false,
>  };
>  
> +static const struct gpadc_data sun8i_h3_ths_data = {
> +	.temp_offset = -1791,
> +	.temp_scale = -121,
> +	.temp_data = {SUN8I_H3_THS_TDATA0, 0, 0, 0},
> +	.sample_start = sunxi_ths_sample_start,
> +	.sample_end = sunxi_ths_sample_end,
> +	.has_bus_clk = true,
> +	.has_bus_rst = true,
> +	.has_mod_clk = true,
> +	.sensor_count = 1,
> +	.supports_nvmem = true,
> +	.support_irq = true,
> +	.ctrl0_map = SUN4I_GPADC_CTRL0_T_ACQ(0xff),
> +	.ctrl2_map = SUN8I_H3_THS_ACQ1(0x3f),
> +	.sensor_en_map = SUN8I_H3_THS_TEMP_SENSE_EN0,
> +	.filter_map = SUN4I_GPADC_CTRL3_FILTER_EN |
> +		SUN4I_GPADC_CTRL3_FILTER_TYPE(0x2),
> +	.irq_clear_map = SUN8I_H3_THS_INTS_ALARM_INT_0 |
> +			SUN8I_H3_THS_INTS_SHUT_INT_0   |
> +			SUN8I_H3_THS_INTS_TDATA_IRQ_0  |
> +			SUN8I_H3_THS_INTS_ALARM_OFF_0,
> +	.irq_control_map = SUN8I_H3_THS_INTC_TDATA_IRQ_EN0 |
> +		SUN8I_H3_THS_TEMP_PERIOD(0x7),
> +};
> +
>  struct sun4i_gpadc_iio {
>  	struct iio_dev			*indio_dev;
>  	struct completion		completion;
> @@ -462,6 +494,16 @@ static int sun4i_gpadc_sample_end(struct sun4i_gpadc_iio *info)
>  	return 0;
>  }
>  
> +static int sunxi_ths_sample_end(struct sun4i_gpadc_iio *info)
> +{
> +	/* Disable ths interrupt */
> +	regmap_write(info->regmap, SUN8I_H3_THS_INTC, 0x0);
> +	/* Disable temperature sensor */
> +	regmap_write(info->regmap, SUN8I_H3_THS_CTRL2, 0x0);
> +
> +	return 0;
> +}
> +
>  static int sun4i_gpadc_runtime_suspend(struct device *dev)
>  {
>  	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
> @@ -473,6 +515,17 @@ static int sun4i_gpadc_runtime_suspend(struct device *dev)
>  	return info->data->sample_end(info);
>  }
>  
> +static void sunxi_calibrate(struct sun4i_gpadc_iio *info)
> +{
> +	if (info->has_calibration_data[0])
> +		regmap_write(info->regmap, SUNXI_THS_CDATA_0_1,
> +			info->calibration_data[0]);
> +
> +	if (info->has_calibration_data[1])
> +		regmap_write(info->regmap, SUNXI_THS_CDATA_2_3,
> +			info->calibration_data[1]);
> +}
> +
>  static int sun4i_gpadc_sample_start(struct sun4i_gpadc_iio *info)
>  {
>  	/* clkin = 6MHz */
> @@ -492,6 +545,35 @@ static int sun4i_gpadc_sample_start(struct sun4i_gpadc_iio *info)
>  	return 0;
>  }
>  
> +static int sunxi_ths_sample_start(struct sun4i_gpadc_iio *info)

Please remain consistent with the prefixes used in the driver

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180129/36163df3/attachment.sig>
