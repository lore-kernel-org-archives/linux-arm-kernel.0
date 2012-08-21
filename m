From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 21 Aug 2012 18:04:22 +0200
Subject: [PATCH 1/5] i2c: at91: add new fixes for some TWI ip versions
In-Reply-To: <1345559345-13988-2-git-send-email-ludovic.desroches@atmel.com>
References: <1345559345-13988-1-git-send-email-ludovic.desroches@atmel.com>
 <1345559345-13988-2-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <5033B186.5010601@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/21/2012 04:29 PM, ludovic.desroches at atmel.com :
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> The at91sam9261 TWI ip version requires also some fixes. The id_entry
> field from the platform device structure has been replaced by the use
> of cpu_is_xxx function to determine when to use these fixes.

No, for this one. The current tendency is to remove the use of
cpu_is_xxx() functions.

So yes, you will have to keep the use of struct platform_device_id in
this driver and extend it with the device tree information.

> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  arch/arm/mach-at91/at91rm9200_devices.c |  9 -------
>  drivers/i2c/busses/i2c-at91.c           | 42 +++++++++++++++++++--------------
>  2 files changed, 24 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
> index 2b9b493..e6b7d05 100644
> --- a/arch/arm/mach-at91/at91rm9200_devices.c
> +++ b/arch/arm/mach-at91/at91rm9200_devices.c
> @@ -494,18 +494,9 @@ static struct resource twi_resources[] = {
>  	},
>  };
>  
> -static const struct platform_device_id twi_id = {
> -	/*
> -	 * driver_data is "1" for hardware with ckdiv upper limit == 5
> -	 * (AT91RM9200 erratum 22), "0" for twi modules without this bug
> -	 */
> -	.driver_data	= 1,
> -};
> -
>  static struct platform_device at91rm9200_twi_device = {
>  	.name		= "at91_i2c",
>  	.id		= -1,
> -	.id_entry	= &twi_id,
>  	.resource	= twi_resources,
>  	.num_resources	= ARRAY_SIZE(twi_resources),
>  };
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index b1cb780..4599522 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -27,6 +27,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
> +#include <mach/cpu.h>
> +
>  #define TWI_CLK_HZ		100000			/* max 400 Kbits/s */
>  #define AT91_I2C_TIMEOUT	msecs_to_jiffies(100)	/* transfer timeout */
>  
> @@ -72,7 +74,6 @@ struct at91_twi_dev {
>  	int			irq;
>  	unsigned		transfer_status;
>  	struct i2c_adapter	adapter;
> -	bool			is_rm9200;
>  	unsigned		twi_cwgr_reg;
>  };
>  
> @@ -111,20 +112,28 @@ static void at91_init_twi_bus(struct at91_twi_dev *dev)
>   */
>  static void __devinit at91_calc_twi_clock(struct at91_twi_dev *dev, int twi_clk)
>  {
> -	const int offset = dev->is_rm9200 ? 3 : 4;
> -	const int div = max(0, (int)DIV_ROUND_UP(clk_get_rate(dev->clk),
> -						 2 * twi_clk) - offset);
> -	int ckdiv = fls(div >> 8);
> -	int cdiv = div >> ckdiv;
> -
> -	if (dev->is_rm9200 && (ckdiv > 5)) {
> -		dev_warn(dev->dev, "AT91RM9200 erratum 22: using ckdiv = 5.\n");
> -		ckdiv = 5;
> -		cdiv = 255;
> -	} else if (ckdiv > 7) {
> -		dev_warn(dev->dev, "%d exceeds 3 bits for ckdiv, limiting.\n",
> -			 ckdiv);
> -		ckdiv = 7;
> +	int offset, div, max_ckdiv, ckdiv, cdiv;
> +
> +	if (cpu_is_at91rm9200()) {
> +		offset = 3;
> +		max_ckdiv = 5;
> +	} else if (cpu_is_at91sam9261()) {
> +		offset = 4;
> +		max_ckdiv = 5;
> +	} else {
> +		offset = 4;
> +		max_ckdiv = 7;
> +	}
> +
> +	div = max(0, (int)DIV_ROUND_UP(clk_get_rate(dev->clk),
> +				       2 * twi_clk) - offset);
> +	ckdiv = fls(div >> 8);
> +	cdiv = div >> ckdiv;
> +
> +	if (ckdiv > max_ckdiv) {
> +		dev_warn(dev->dev, "%d exceeds ckdiv max value which is %d.\n",
> +			 ckdiv, max_ckdiv);
> +		ckdiv = max_ckdiv;
>  		cdiv = 255;
>  	}
>  
> @@ -331,9 +340,6 @@ static int __devinit at91_twi_probe(struct platform_device *pdev)
>  		goto err_release_region;
>  	}
>  
> -	if (pdev->id_entry && pdev->id_entry->driver_data == 1)
> -		dev->is_rm9200 = 1;
> -
>  	init_completion(&dev->cmd_complete);
>  
>  	dev->dev = &pdev->dev;
> 


-- 
Nicolas Ferre
