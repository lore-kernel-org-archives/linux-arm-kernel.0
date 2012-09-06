From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 06 Sep 2012 11:34:25 +0200
Subject: [PATCH 1/2] i2c: s3c2410: add optional pin configuration using
 pinctrl interface
In-Reply-To: <1346923381-14144-2-git-send-email-thomas.abraham@linaro.org>
References: <1346923381-14144-1-git-send-email-thomas.abraham@linaro.org>
 <1346923381-14144-2-git-send-email-thomas.abraham@linaro.org>
Message-ID: <2444562.GB3nOHUb9M@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch shows the problem of the need to explicitly migrate all drivers 
to pinctrl.

Maybe we should consider extending the pinctrl subsystem to set the default 
state automatically before binding a driver to a device, at least in case 
of DT-based platforms?

This would be similar to what is done currently with samsung-gpio bindings 
- the pin is being configured by custom xlate callback based on additional 
cells in GPIO specifier, when the driver retrieves the pin using 
of_get{_named,}_gpio without the need of setting it up in the driver.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center

On Thursday 06 of September 2012 14:53:00 Thomas Abraham wrote:
> Add optional support for i2c bus pin configuration using pinctrl
> interface
> 
> Cc: Ben Dooks <ben-linux@fluff.org>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  drivers/i2c/busses/i2c-s3c2410.c |   19 ++++++++++++++++---
>  1 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-s3c2410.c
> b/drivers/i2c/busses/i2c-s3c2410.c index 5ae3b02..f4b2d6f 100644
> --- a/drivers/i2c/busses/i2c-s3c2410.c
> +++ b/drivers/i2c/busses/i2c-s3c2410.c
> @@ -38,6 +38,7 @@
>  #include <linux/io.h>
>  #include <linux/of_i2c.h>
>  #include <linux/of_gpio.h>
> +#include <linux/pinctrl/consumer.h>
> 
>  #include <asm/irq.h>
> 
> @@ -83,6 +84,8 @@ struct s3c24xx_i2c {
> 
>  	struct s3c2410_platform_i2c	*pdata;
>  	int			gpios[2];
> +	struct pinctrl		*pctrl;
> +	struct pinctrl_state	*pctrl_state;
>  #ifdef CONFIG_CPU_FREQ
>  	struct notifier_block	freq_transition;
>  #endif
> @@ -859,11 +862,17 @@ static int s3c24xx_i2c_init(struct s3c24xx_i2c
> *i2c)
> 
>  	/* inititalise the gpio */
> 
> -	if (pdata->cfg_gpio)
> +	if (pdata->cfg_gpio) {
>  		pdata->cfg_gpio(to_platform_device(i2c->dev));
> -	else
> -		if (s3c24xx_i2c_parse_dt_gpio(i2c))
> +	} else if (!IS_ERR_OR_NULL(i2c->pctrl) &&
> +			!IS_ERR_OR_NULL(i2c->pctrl_state)) {
> +		if (pinctrl_select_state(i2c->pctrl, i2c->pctrl_state)) {
> +			dev_err(i2c->dev, "failed to configure io-pins\n");
> +			return -ENXIO;
> +		}
> +	} else if (s3c24xx_i2c_parse_dt_gpio(i2c)) {
>  			return -EINVAL;
> +	}
> 
>  	/* write slave address */
> 
> @@ -1013,6 +1022,10 @@ static int s3c24xx_i2c_probe(struct
> platform_device *pdev) i2c->adap.algo_data = i2c;
>  	i2c->adap.dev.parent = &pdev->dev;
> 
> +	i2c->pctrl = devm_pinctrl_get(i2c->dev);
> +	if (!IS_ERR_OR_NULL(i2c->pctrl))
> +		i2c->pctrl_state = pinctrl_lookup_state(i2c->pctrl, "default");
> +
>  	/* initialise the i2c controller */
> 
>  	ret = s3c24xx_i2c_init(i2c);
