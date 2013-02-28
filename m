From: avinashphilip@ti.com (Philip, Avinash)
Date: Thu, 28 Feb 2013 10:38:56 +0000
Subject: [PATCH 06/14] ARM: OMAP2+: Convert NAND to use
 gpmc_cs_program_settings()
In-Reply-To: <1361899842-30303-7-git-send-email-jon-hunter@ti.com>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com>
 <1361899842-30303-7-git-send-email-jon-hunter@ti.com>
Message-ID: <518397C60809E147AF5323E0420B992E3EA8F235@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 26, 2013 at 23:00:33, Hunter, Jon wrote:
> Convert the OMAP2+ NAND code to use the gpmc_cs_program_settings()
> function for configuring the various GPMC options instead of directly
> programming the CONFIG1 register.
> 
> This moves the configuration of some GPMC options outside the
> nand_gpmc_retime() because these options should only need to be set once
> regardless of whether the gpmc timing is changing dynamically at runtime.
> The programming of where the wait-pin is also moved slightly, but this
> will not have any impact to existing devices as no boards are currently
> setting the dev_ready variable.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  arch/arm/mach-omap2/gpmc-nand.c |   35 +++++++++++++++++++++++------------
>  1 file changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
> index afc1e8c..4bdfea2 100644
> --- a/arch/arm/mach-omap2/gpmc-nand.c
> +++ b/arch/arm/mach-omap2/gpmc-nand.c
> @@ -43,6 +43,10 @@ static struct platform_device gpmc_nand_device = {
>  	.resource	= gpmc_nand_resource,
>  };
>  
> +static struct gpmc_settings nand_settings = {
> +	.device_nand = true,
> +};
> +

Is it possible to make it local variable?
It would help GPMC to support NAND device on multiple chip select.

Thanks
Avinash

...
> @@ -140,11 +136,26 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
>  			dev_err(dev, "Unable to set gpmc timings: %d\n", err);
>  			return err;
>  		}
> -	}
>  
> -	/* Enable RD PIN Monitoring Reg */
> -	if (gpmc_nand_data->dev_ready) {
> -		gpmc_cs_configure(gpmc_nand_data->cs, GPMC_CONFIG_RDY_BSY, 1);
> +		/* Enable RD PIN Monitoring Reg */
> +		if (gpmc_nand_data->dev_ready) {
> +			nand_settings.wait_on_read = true;
> +			nand_settings.wait_on_write = true;
> +		}
> +
> +		if (gpmc_nand_data->devsize == NAND_BUSWIDTH_16)
> +			nand_settings.device_width = GPMC_DEVWIDTH_16BIT;
> +		else
> +			nand_settings.device_width = GPMC_DEVWIDTH_8BIT;
> +
> +		err = gpmc_cs_program_settings(gpmc_nand_data->cs,
> +					       &nand_settings);
> +		if (IS_ERR_VALUE(err))
> +			goto out_free_cs;
> +
> +		err = gpmc_cs_configure(gpmc_nand_data->cs, GPMC_CONFIG_WP, 0);
> +		if (IS_ERR_VALUE(err))
> +			goto out_free_cs;
>  	}
>  
>  	gpmc_update_nand_reg(&gpmc_nand_data->reg, gpmc_nand_data->cs);
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
