From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 21 May 2014 10:18:57 +0100
Subject: [PATCH 5/7] mfd: twl4030-power: Add support for board specific
 configuration
In-Reply-To: <20140521024552.GD17417@atomide.com>
References: <1400031250-29542-1-git-send-email-tony@atomide.com>
 <1400031250-29542-6-git-send-email-tony@atomide.com>
 <20140520151722.GA24991@lee--X1>
 <20140521024552.GD17417@atomide.com>
Message-ID: <20140521091857.GD6679@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 May 2014, Tony Lindgren wrote:

> * Lee Jones <lee.jones@linaro.org> [140520 08:18]:
> > 
> > Ah, I forgot to Ack this last time, didn't I?
> > 
> >   Acked-by: Lee Jones <lee.jones@linaro.org>
> 
> Yeah, here's this one updated with your ack.

Has the code changed at all, or are you just reposting with my Ack
applied?

> 8< ---------------------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Tue, 20 May 2014 11:17:54 -0700
> Subject: [PATCH] mfd: twl4030-power: Add support for board specific configuration
> 
> With the recommended twl4030 configuration added, we can now add
> board specific changes as modifications to the recommended
> configuration.
> 
> Note that the data is private to this driver, and the data must
> always have a NULL resource in the sentinel.
> 
> Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> --- a/drivers/mfd/twl4030-power.c
> +++ b/drivers/mfd/twl4030-power.c
> @@ -567,13 +567,34 @@ twl4030_power_configure_scripts(const struct twl4030_power_data *pdata)
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
> +
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
> --- a/include/linux/i2c/twl.h
> +++ b/include/linux/i2c/twl.h
> @@ -674,6 +674,7 @@ struct twl4030_power_data {
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
