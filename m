From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 3 Jan 2017 15:46:56 +0000
Subject: [PATCH 5/5] mfd: twl: use mfd_add_devices for TWL6032 regulator
In-Reply-To: <20161126181326.14951-6-Nicolae_Rosia@mentor.com>
References: <20161126181326.14951-1-Nicolae_Rosia@mentor.com>
 <20161126181326.14951-6-Nicolae_Rosia@mentor.com>
Message-ID: <20170103154656.GK2977@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 26 Nov 2016, Nicolae Rosia wrote:

> TWL6032 regulator driver uses the drvdata twl_priv pointer.
> In order to avoid accessing an invalid drvdata
> when the driver gets unbinded, make sure we remove the
> child devices before deleting the drvdata.

This doesn't really describe the change.

Surely we're really just registering the regulator driver?

The fact that we then remove the device during .remove() is
incidental. 

> Signed-off-by: Nicolae Rosia <Nicolae_Rosia@mentor.com>
> ---
>  drivers/mfd/twl-core.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index 409b836..1e94364 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -43,6 +43,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/irq.h>
>  #include <linux/irqdomain.h>
> +#include <linux/mfd/core.h>
>  
>  #include <linux/regulator/machine.h>
>  
> @@ -155,8 +156,16 @@ int twl4030_init_irq(struct device *dev, int irq_num);
>  int twl4030_exit_irq(void);
>  int twl4030_init_chip_irq(const char *chip);
>  
> +

?

>  static struct twlcore *twl_priv;
>  
> +static struct mfd_cell twl6032_devs[] = {
> +	{
> +		.name = "twl6032-regulator",
> +		.of_compatible = "ti,twl6032-regulator",
> +	},
> +};
> +
>  static struct twl_mapping twl4030_map[] = {
>  	/*
>  	 * NOTE:  don't change this table without updating the
> @@ -665,6 +674,8 @@ static int twl_remove(struct i2c_client *client)
>  	unsigned i, num_slaves;
>  	int status;
>  
> +	mfd_remove_devices(&client->dev);
> +
>  	if (twl_class_is_4030())
>  		status = twl4030_exit_irq();
>  	else
> @@ -834,6 +845,17 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  				 TWL4030_DCDC_GLOBAL_CFG);
>  	}
>  
> +	if (id->driver_data & TWL6032_SUBCLASS) {
> +		status = mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
> +					 twl6032_devs, ARRAY_SIZE(twl6032_devs),
> +					 NULL, 0, NULL);
> +		if (status != 0) {
> +			dev_err(&client->dev, "failed to add mfd devices: %d\n",
> +				status);
> +			goto fail;
> +		}
> +	}
> +
>  fail:
>  	if (status < 0)
>  		twl_remove(client);

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
