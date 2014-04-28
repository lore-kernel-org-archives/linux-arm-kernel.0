From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 28 Apr 2014 12:47:26 +0100
Subject: [PATCH 2/4] mfd: twl4030-power: Add support for board specific
 configuration
In-Reply-To: <1398300030-7386-3-git-send-email-tony@atomide.com>
References: <1398300030-7386-1-git-send-email-tony@atomide.com>
 <1398300030-7386-3-git-send-email-tony@atomide.com>
Message-ID: <20140428114726.GW21279@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> With the recommended twl4030 configuration added, we can now add
> board specific changes as modifications to the recommended
> configuration.
> 
> Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/mfd/twl4030-power.c | 21 +++++++++++++++++++++
>  include/linux/i2c/twl.h     |  1 +
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
> index 89a8528..89c6b1a 100644
> --- a/drivers/mfd/twl4030-power.c
> +++ b/drivers/mfd/twl4030-power.c
> @@ -511,13 +511,34 @@ twl4030_power_configure_scripts(const struct twl4030_power_data *pdata)
>  	return 0;
>  }
>  
> +static void twl4030_patch_rconfig(struct twl4030_resconfig *common,
> +				  struct twl4030_resconfig *board)
> +{
> +	while (common->resource) {
> +		struct twl4030_resconfig *b = board;
> +
> +		while (b->resource) {
> +			if (b->resource == common->resource) {
> +				*common = *b;
> +				break;
> +			}
> +			b++;
> +		}
> +		common++;
> +	}
> +}

Forgive my ignorance, as I don't know how 'common' is setup, but we
appear to move to the next 'common' reference them immediately
dereference it without checking to see if it actually exists. Same
with 'b'. What happens if we reach the end of the array? NULL
dereference or does the final element always have a NULLed resource
attribute?

>  static int
>  twl4030_power_configure_resources(const struct twl4030_power_data *pdata)
>  {
>  	struct twl4030_resconfig *resconfig = pdata->resource_config;
> +	struct twl4030_resconfig *boardconf = pdata->board_config;
>  	int err;
>  
>  	if (resconfig) {
> +		if (boardconf)
> +			twl4030_patch_rconfig(resconfig, boardconf);
> +
>  		while (resconfig->resource) {
>  			err = twl4030_configure_resource(resconfig);
>  			if (err)
> diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
> index ade1c06..069f78f 100644
> --- a/include/linux/i2c/twl.h
> +++ b/include/linux/i2c/twl.h
> @@ -659,6 +659,7 @@ struct twl4030_power_data {
>  	struct twl4030_script **scripts;
>  	unsigned num;
>  	struct twl4030_resconfig *resource_config;
> +	struct twl4030_resconfig *board_config;
>  #define TWL4030_RESCONFIG_UNDEF	((u8)-1)
>  	bool use_poweroff;	/* Board is wired for TWL poweroff */
>  };

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
