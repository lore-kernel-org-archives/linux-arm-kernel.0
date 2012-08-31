From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 31 Aug 2012 13:22:58 +0200
Subject: [PATCH 3/3] i2c: nomadik: Add Device Tree support to the
 Nomadik I2C driver
In-Reply-To: <1345734087-21803-3-git-send-email-lee.jones@linaro.org>
References: <1345734087-21803-1-git-send-email-lee.jones@linaro.org>
 <1345734087-21803-3-git-send-email-lee.jones@linaro.org>
Message-ID: <20120831112258.GA2624@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2012 at 04:01:27PM +0100, Lee Jones wrote:
> Here we apply the bindings required for successful Device Tree
> probing of the i2c-nomadik driver.
> 
> Cc: linux-i2c at vger.kernel.org
> Acked-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>

Two acks? I'd think this cannot work for multiple reasons.

BTW, patch 2 and 3 should be merged. It is a lot easier to review the
code with the binding description together.

Is there some dependency other than updating the dts files? If not, I'd
like to pick up the patch via I2C.

> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/i2c/busses/i2c-nomadik.c |   28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
> index 61b00ed..8168389 100644
> --- a/drivers/i2c/busses/i2c-nomadik.c
> +++ b/drivers/i2c/busses/i2c-nomadik.c
> @@ -25,6 +25,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/platform_data/i2c-nomadik.h>
> +#include <linux/of.h>
>  
>  #define DRIVER_NAME "nmk-i2c"
>  
> @@ -920,15 +921,42 @@ static struct nmk_i2c_controller u8500_i2c = {
>  	.sm             = I2C_FREQ_MODE_FAST,
>  };
>  
> +static void nmk_i2c_of_probe(struct device_node *np,
> +			struct nmk_i2c_controller *pdata)
> +{
> +	/* Provide the default configuration as a base. */
> +	pdata = &u8500_i2c;

?????? I wonder how that could work... have you tested the patch?

> +
> +	of_property_read_u32(np, "clock-frequency", (u32*)&pdata->clk_freq);

Might be worth changing clk_freq to u32?

> +
> +	/* This driver only supports 'standard' and 'fast' modes of operation. */
> +	if (pdata->clk_freq <= 100000)
> +		pdata->sm = I2C_FREQ_MODE_STANDARD;

Is standard == 100000 Hz?


> +	else
> +		pdata->sm = I2C_FREQ_MODE_FAST;

If those two are fixed frequencies, you should omit a warning if the
devicetree has a different frequency set and report which one is going
to be used actually.


> +}
> +
>  static atomic_t adapter_id = ATOMIC_INIT(0);
>  
>  static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
>  {
>  	int ret = 0;
>  	struct nmk_i2c_controller *pdata = adev->dev.platform_data;
> +	struct device_node *np = adev->dev.of_node;
>  	struct nmk_i2c_dev	*dev;
>  	struct i2c_adapter *adap;
>  
> +	if (np) {
> +		if (!pdata) {
> +			pdata = devm_kzalloc(&adev->dev, sizeof(*pdata), GFP_KERNEL);
> +			if (!pdata) {
> +				ret = -ENOMEM;
> +				goto err_no_mem;
> +			}
> +		}
> +		nmk_i2c_of_probe(np, pdata);
> +	}
> +
>  	if (!pdata)
>  		/* No i2c configuration found, using the default. */
>  		pdata = &u8500_i2c;
> -- 
> 1.7.9.5
> 

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120831/8d00663e/attachment.sig>
