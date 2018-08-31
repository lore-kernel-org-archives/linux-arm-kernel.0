From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 31 Aug 2018 11:07:22 +0200
Subject: [PATCH v3 19/30] iio: adc: sun4i-gpadc-iio: rework: support
 nvmem calibration data
In-Reply-To: <20180830154518.29507-20-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-20-embed3d@gmail.com>
Message-ID: <20180831090722.zf65lkozjpozngu5@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2018 at 05:45:07PM +0200, Philipp Rossak wrote:
> This patch reworks the driver to support nvmem calibration cells.
> The driver checks if the nvmem calibration is supported and reads out
> the nvmem.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
> index 18ab72e52d78..2fd73d143815 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -27,6 +27,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> @@ -70,6 +71,7 @@ struct gpadc_data {
>  	bool		has_mod_clk;
>  	u32		temp_data_base;
>  	int		sensor_count;
> +	bool		supports_nvmem;
>  };
>  
>  static irqreturn_t sun4i_gpadc_data_irq_handler(int irq, void *dev_id);
> @@ -146,6 +148,7 @@ struct sun4i_gpadc_iio {
>  	struct clk			*bus_clk;
>  	struct clk			*mod_clk;
>  	struct reset_control		*reset;
> +	u32				calibration_data[2];
>  };
>  
>  static const struct iio_chan_spec sun4i_gpadc_channels[] = {
> @@ -484,6 +487,9 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
>  	struct resource *mem;
>  	void __iomem *base;
>  	int ret;
> +	struct nvmem_cell *cell;
> +	ssize_t cell_size;
> +	u32 *cell_data;
>  
>  	info->data = of_device_get_match_data(&pdev->dev);
>  	if (!info->data)
> @@ -494,6 +500,24 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
>  
> +	if (info->data->supports_nvmem) {
> +
> +		cell = nvmem_cell_get(&pdev->dev, "calibration");
> +		if (IS_ERR(cell)) {
> +			if (PTR_ERR(cell) == -EPROBE_DEFER)
> +				return PTR_ERR(cell);

You're masking real errors here, if the issue isn't that the property
isn't found.

> +		} else {
> +			cell_data = (u32 *)nvmem_cell_read(cell, &cell_size);
> +			if (cell_size != 8)
> +				dev_err(&pdev->dev,
> +					"Calibration data has wrong size\n");
> +			else {
> +				info->calibration_data[0] = cell_data[0];
> +				info->calibration_data[1] = cell_data[1];

How are those calibration data organized when there is multiple channels?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180831/3242dca9/attachment.sig>
