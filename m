From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 29 Jan 2018 10:31:14 +0100
Subject: [PATCH v2 05/16] iio: adc: sun4i-gpadc-iio: rework: support
 clocks and reset
In-Reply-To: <20180128232919.12639-6-embed3d@gmail.com>
References: <20180128232919.12639-1-embed3d@gmail.com>
 <20180128232919.12639-6-embed3d@gmail.com>
Message-ID: <20180129093114.nwohas57kxh347w6@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 29, 2018 at 12:29:08AM +0100, Philipp Rossak wrote:
> For adding newer sensor some basic rework of the code is necessary.
> 
> The SoCs after H3 has newer thermal sensor ADCs, which have two clock
> inputs (bus clock and sampling clock) and a reset. The registers are
> also re-arranged.
> 
> This commit reworks the code, adds the process of the clocks and
> resets.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Same remark for the SoB

> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c | 71 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
> index db57d9fffe48..51ec0104d678 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -22,6 +22,7 @@
>   * shutdown for not being used.
>   */
>  
> +#include <linux/clk.h>
>  #include <linux/completion.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> @@ -31,6 +32,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> +#include <linux/reset.h>
>  #include <linux/thermal.h>
>  #include <linux/delay.h>
>  
> @@ -68,6 +70,9 @@ struct gpadc_data {
>  	unsigned int	temp_data;
>  	int		(*sample_start)(struct sun4i_gpadc_iio *info);
>  	int		(*sample_end)(struct sun4i_gpadc_iio *info);
> +	bool		has_bus_clk;
> +	bool		has_bus_rst;
> +	bool		has_mod_clk;

Is there SoCs where this insn't all true, or all false?

>  };
>  
>  static const struct gpadc_data sun4i_gpadc_data = {
> @@ -127,6 +132,9 @@ struct sun4i_gpadc_iio {
>  	atomic_t			ignore_temp_data_irq;
>  	const struct gpadc_data		*data;
>  	bool				no_irq;
> +	struct clk			*bus_clk;
> +	struct clk			*mod_clk;
> +	struct reset_control		*reset;
>  	/* prevents concurrent reads of temperature and ADC */
>  	struct mutex			mutex;
>  	struct thermal_zone_device	*tzd;
> @@ -420,6 +428,10 @@ static int sun4i_gpadc_runtime_suspend(struct device *dev)
>  {
>  	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
>  
> +	clk_disable(info->mod_clk);
> +

Why clk_disable?

> +	clk_disable(info->bus_clk);
> +

You can tie the bus_clk to the regmap directly, instead of having to
maintain it yourself here.

And you can probably put the device in reset and out of reset here as
well.

>  	return info->data->sample_end(info);
>  }
>  
> @@ -446,6 +458,10 @@ static int sun4i_gpadc_runtime_resume(struct device *dev)
>  {
>  	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
>  
> +	clk_enable(info->mod_clk);
> +
> +	clk_enable(info->bus_clk);
> +
>  	return info->data->sample_start(info);
>  }
>  
> @@ -560,10 +576,59 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
>  		return ret;
>  	}
>  
> +	if (info->data->has_bus_rst) {
> +		info->reset = devm_reset_control_get(&pdev->dev, NULL);
> +		if (IS_ERR(info->reset)) {
> +			ret = PTR_ERR(info->reset);
> +			return ret;
> +		}
> +
> +		ret = reset_control_deassert(info->reset);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (info->data->has_bus_clk) {
> +		info->bus_clk = devm_clk_get(&pdev->dev, "bus");
> +		if (IS_ERR(info->bus_clk)) {
> +			ret = PTR_ERR(info->bus_clk);
> +			goto assert_reset;
> +		}
> +
> +		ret = clk_prepare_enable(info->bus_clk);
> +		if (ret)
> +			goto assert_reset;
> +	}
> +
> +	if (info->data->has_mod_clk) {
> +		info->mod_clk = devm_clk_get(&pdev->dev, "mod");
> +		if (IS_ERR(info->mod_clk)) {
> +			ret = PTR_ERR(info->mod_clk);
> +			goto disable_bus_clk;
> +		}
> +
> +		/* Running at 6MHz */
> +		ret = clk_set_rate(info->mod_clk, 4000000);

Your comment and the line below doesn't really make much sense :)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180129/8fb943c0/attachment.sig>
