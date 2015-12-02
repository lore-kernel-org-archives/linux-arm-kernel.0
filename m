From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 2 Dec 2015 12:01:49 +0100
Subject: [PATCH 1/4] i2c: at91: add upport for the HOLD field
In-Reply-To: <1449052747-20991-1-git-send-email-ludovic.desroches@atmel.com>
References: <1449052747-20991-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <565ECF9D.30707@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 02/12/2015 11:39, Ludovic Desroches a ?crit :
> The hold field allows to configure the data hold time which can be set
> with the help of the generic binding 'i2c-sda-hold-time-ns'. This
> feature has been introduced with SAMA5D4 SoC family.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  drivers/i2c/busses/i2c-at91.c | 54 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index 10835d1..09e1690 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -64,6 +64,7 @@
>  #define	AT91_TWI_IADR		0x000c	/* Internal Address Register */
>  
>  #define	AT91_TWI_CWGR		0x0010	/* Clock Waveform Generator Reg */
> +#define	AT91_TWI_CWGR_HOLD(x)	(((x) & 0x1f) << 24)

I would have defined MAX_HOLD here and used it in the mask above...


>  
>  #define	AT91_TWI_SR		0x0020	/* Status Register */
>  #define	AT91_TWI_TXCOMP		BIT(0)	/* Transmission Complete */
> @@ -110,6 +111,7 @@ struct at91_twi_pdata {
>  	unsigned clk_offset;
>  	bool has_unre_flag;
>  	bool has_alt_cmd;
> +	bool has_hold_field;
>  	struct at_dma_slave dma_slave;
>  };
>  
> @@ -187,10 +189,13 @@ static void at91_init_twi_bus(struct at91_twi_dev *dev)
>   */
>  static void at91_calc_twi_clock(struct at91_twi_dev *dev, int twi_clk)
>  {
> -	int ckdiv, cdiv, div;
> +	int ckdiv, cdiv, div, hold = 0;
>  	struct at91_twi_pdata *pdata = dev->pdata;
>  	int offset = pdata->clk_offset;
>  	int max_ckdiv = pdata->clk_max_div;
> +	u32 twd_hold_time_ns = 0;
> +
> +#define MAX_HOLD 31

Instead of here ^^

>  
>  	div = max(0, (int)DIV_ROUND_UP(clk_get_rate(dev->clk),
>  				       2 * twi_clk) - offset);
> @@ -204,8 +209,33 @@ static void at91_calc_twi_clock(struct at91_twi_dev *dev, int twi_clk)
>  		cdiv = 255;
>  	}
>  
> -	dev->twi_cwgr_reg = (ckdiv << 16) | (cdiv << 8) | cdiv;
> -	dev_dbg(dev->dev, "cdiv %d ckdiv %d\n", cdiv, ckdiv);
> +	if (pdata->has_hold_field) {
> +		of_property_read_u32(dev->dev->of_node, "i2c-sda-hold-time-ns",
> +				     &twd_hold_time_ns);
> +
> +		/*
> +		 * hold time = HOLD + 3 x T_peripheral_clock
> +		 * Use clk rate in kHz to prevent overflows when computing
> +		 * hold.
> +		 */
> +		hold = DIV_ROUND_UP(twd_hold_time_ns
> +				    * (clk_get_rate(dev->clk) / 1000), 1000000);
> +		hold -= 3;
> +		if (hold < 0)
> +			hold = 0;
> +		if (hold > MAX_HOLD) {
> +			dev_warn(dev->dev,
> +				 "HOLD field set to its maximum value (%d instead of %d)\n",
> +				 MAX_HOLD, hold);
> +			hold = MAX_HOLD;
> +		}
> +	}
> +
> +	dev->twi_cwgr_reg = (ckdiv << 16) | (cdiv << 8) | cdiv
> +			    | AT91_TWI_CWGR_HOLD(hold);
> +
> +	dev_dbg(dev->dev, "cdiv %d ckdiv %d hold %d (%d ns)\n",
> +		cdiv, ckdiv, hold, twd_hold_time_ns);
>  }
>  
>  static void at91_twi_dma_cleanup(struct at91_twi_dev *dev)
> @@ -797,6 +827,7 @@ static struct at91_twi_pdata at91rm9200_config = {
>  	.clk_offset = 3,
>  	.has_unre_flag = true,
>  	.has_alt_cmd = false,
> +	.has_hold_field = false,
>  };
>  
>  static struct at91_twi_pdata at91sam9261_config = {
> @@ -804,6 +835,7 @@ static struct at91_twi_pdata at91sam9261_config = {
>  	.clk_offset = 4,
>  	.has_unre_flag = false,
>  	.has_alt_cmd = false,
> +	.has_hold_field = false,
>  };
>  
>  static struct at91_twi_pdata at91sam9260_config = {
> @@ -811,6 +843,7 @@ static struct at91_twi_pdata at91sam9260_config = {
>  	.clk_offset = 4,
>  	.has_unre_flag = false,
>  	.has_alt_cmd = false,
> +	.has_hold_field = false,
>  };
>  
>  static struct at91_twi_pdata at91sam9g20_config = {
> @@ -818,6 +851,7 @@ static struct at91_twi_pdata at91sam9g20_config = {
>  	.clk_offset = 4,
>  	.has_unre_flag = false,
>  	.has_alt_cmd = false,
> +	.has_hold_field = false,
>  };
>  
>  static struct at91_twi_pdata at91sam9g10_config = {
> @@ -825,6 +859,7 @@ static struct at91_twi_pdata at91sam9g10_config = {
>  	.clk_offset = 4,
>  	.has_unre_flag = false,
>  	.has_alt_cmd = false,
> +	.has_hold_field = false,
>  };
>  
>  static const struct platform_device_id at91_twi_devtypes[] = {
> @@ -854,6 +889,15 @@ static struct at91_twi_pdata at91sam9x5_config = {
>  	.clk_offset = 4,
>  	.has_unre_flag = false,
>  	.has_alt_cmd = false,
> +	.has_hold_field = false,
> +};
> +
> +static struct at91_twi_pdata sama5d4_config = {
> +	.clk_max_div = 7,
> +	.clk_offset = 4,
> +	.has_unre_flag = false,
> +	.has_alt_cmd = false,
> +	.has_hold_field = true,
>  };
>  
>  static struct at91_twi_pdata sama5d2_config = {
> @@ -861,6 +905,7 @@ static struct at91_twi_pdata sama5d2_config = {
>  	.clk_offset = 4,
>  	.has_unre_flag = true,
>  	.has_alt_cmd = true,
> +	.has_hold_field = true,
>  };
>  
>  static const struct of_device_id atmel_twi_dt_ids[] = {
> @@ -883,6 +928,9 @@ static const struct of_device_id atmel_twi_dt_ids[] = {
>  		.compatible = "atmel,at91sam9x5-i2c",
>  		.data = &at91sam9x5_config,
>  	}, {
> +		.compatible = "atmel,sama5d4-i2c",
> +		.data = &sama5d4_config,
> +	}, {
>  		.compatible = "atmel,sama5d2-i2c",
>  		.data = &sama5d2_config,
>  	}, {

Otherwise it's okay for me.

Bye,
-- 
Nicolas Ferre
