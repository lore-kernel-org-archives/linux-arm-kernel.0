From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 11 Jun 2014 12:25:04 +0200
Subject: [PATCH v2 1/4] ASoC: atmel-ssc: distinguish whether SSC supports
 fslen ext
In-Reply-To: <1402481682-9811-2-git-send-email-voice.shen@atmel.com>
References: <1402481682-9811-1-git-send-email-voice.shen@atmel.com>
 <1402481682-9811-2-git-send-email-voice.shen@atmel.com>
Message-ID: <53982E80.5070908@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/2014 12:14, Bo Shen :
> Add compatible string to distinguish whether SSC supports
> frame sync length extension.
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>

Ok, I am fine with this one:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
> Changes in v2:
>   - Using compatible string to distinguish whether SSC supports
>     frame sync length extension to replace check IP version.
> 
>  drivers/misc/atmel-ssc.c  | 13 +++++++++++++
>  include/linux/atmel-ssc.h |  1 +
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
> index 22de137..60843a2 100644
> --- a/drivers/misc/atmel-ssc.c
> +++ b/drivers/misc/atmel-ssc.c
> @@ -83,10 +83,17 @@ EXPORT_SYMBOL(ssc_free);
>  
>  static struct atmel_ssc_platform_data at91rm9200_config = {
>  	.use_dma = 0,
> +	.has_fslen_ext = 0,
> +};
> +
> +static struct atmel_ssc_platform_data at91sam9rl_config = {
> +	.use_dma = 0,
> +	.has_fslen_ext = 1,
>  };
>  
>  static struct atmel_ssc_platform_data at91sam9g45_config = {
>  	.use_dma = 1,
> +	.has_fslen_ext = 1,
>  };
>  
>  static const struct platform_device_id atmel_ssc_devtypes[] = {
> @@ -94,6 +101,9 @@ static const struct platform_device_id atmel_ssc_devtypes[] = {
>  		.name = "at91rm9200_ssc",
>  		.driver_data = (unsigned long) &at91rm9200_config,
>  	}, {
> +		.name = "at91sam9rl_ssc",
> +		.driver_data = (unsigned long) &at91sam9rl_config,
> +	}, {
>  		.name = "at91sam9g45_ssc",
>  		.driver_data = (unsigned long) &at91sam9g45_config,
>  	}, {
> @@ -107,6 +117,9 @@ static const struct of_device_id atmel_ssc_dt_ids[] = {
>  		.compatible = "atmel,at91rm9200-ssc",
>  		.data = &at91rm9200_config,
>  	}, {
> +		.compatible = "atmel,at91sam9rl-ssc",
> +		.data = &at91sam9rl_config,
> +	}, {
>  		.compatible = "atmel,at91sam9g45-ssc",
>  		.data = &at91sam9g45_config,
>  	}, {
> diff --git a/include/linux/atmel-ssc.h b/include/linux/atmel-ssc.h
> index 571a12e..e8dd408 100644
> --- a/include/linux/atmel-ssc.h
> +++ b/include/linux/atmel-ssc.h
> @@ -7,6 +7,7 @@
>  
>  struct atmel_ssc_platform_data {
>  	int			use_dma;
> +	int			has_fslen_ext;
>  };
>  
>  struct ssc_device {
> 


-- 
Nicolas Ferre
