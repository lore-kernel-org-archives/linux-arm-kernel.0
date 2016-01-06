From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Wed, 6 Jan 2016 19:36:24 +0200
Subject: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
In-Reply-To: <20160105224929.GF12777@atomide.com>
References: <1432156863-19695-1-git-send-email-tony@atomide.com>
 <568662FC.9050206@gmail.com> <20160104170206.GC12777@atomide.com>
 <201601041834.56056@pali> <20160104174001.GD12777@atomide.com>
 <568AC0F9.2010304@gmail.com> <20160105041356.GE12777@atomide.com>
 <20160105084947.GG22661@pali> <20160105224929.GF12777@atomide.com>
Message-ID: <20160106173624.GG1587@darkstar.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 05, 2016 at 02:49:29PM -0800, Tony Lindgren wrote:
> From: Tony Lindgren <tony@atomide.com>
> Date: Tue, 5 Jan 2016 12:04:20 -0800
> Subject: [PATCH] ARM: OMAP2+: Fix onenand rate detection to avoid filesystem
>  corruption
> 
> Commit 63aa945b1013 ("memory: omap-gpmc: Add Kconfig option for debug")
> unified the GPMC debug for the SoCs with GPMC. The commit also left
> out the option for HWMOD_INIT_NO_RESET as we now require proper timings
> for GPMC to be able to remap GPMC devices out of address 0.
> 
> Unfortunately on 900, onenand now only partially works with the device
> tree provided timings. It works enough to get detected but the clock
> rate supported by the onenand chip gets misdetected. This in turn causes
> the GPMC timings to be miscalculated and this leads into file system
> corruption on n900.
> 
> Looks like onenand needs CS_CONFIG1 bit 27 WRITETYPE set for for sync
> write. This is needed also for async timings when we write to onenand
> with omap2_onenand_set_async_mode(). Without sync write bit set, the
> async read for the onenand ONENAND_REG_VERSION_ID will return 0xfff.
> 
> Let's exit with an error if onenand rate is not detected. And let's
> remove the extra call to omap2_onenand_set_async_mode() as we only
> need to do this once at the end of omap2_onenand_setup_async().
> 
> Reported-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

This fixes also the detection issue on N950. Also tested the patch
with N810.

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.

> --- a/arch/arm/mach-omap2/gpmc-onenand.c
> +++ b/arch/arm/mach-omap2/gpmc-onenand.c
> @@ -149,8 +149,8 @@ static int omap2_onenand_get_freq(struct omap_onenand_platform_data *cfg,
>  		freq = 104;
>  		break;
>  	default:
> -		freq = 54;
> -		break;
> +		pr_err("onenand rate not detected, bad GPMC async timings?\n");
> +		freq = 0;
>  	}
>  
>  	return freq;
> @@ -271,6 +271,11 @@ static int omap2_onenand_setup_async(void __iomem *onenand_base)
>  	struct gpmc_timings t;
>  	int ret;
>  
> +	/*
> +	 * Note that we need to keep sync_write set for the call to
> +	 * omap2_onenand_set_async_mode() to work to detect the onenand
> +	 * supported clock rate for the sync timings.
> +	 */
>  	if (gpmc_onenand_data->of_node) {
>  		gpmc_read_settings_dt(gpmc_onenand_data->of_node,
>  				      &onenand_async);
> @@ -281,12 +286,9 @@ static int omap2_onenand_setup_async(void __iomem *onenand_base)
>  			else
>  				gpmc_onenand_data->flags |= ONENAND_SYNC_READ;
>  			onenand_async.sync_read = false;
> -			onenand_async.sync_write = false;
>  		}
>  	}
>  
> -	omap2_onenand_set_async_mode(onenand_base);
> -
>  	omap2_onenand_calc_async_timings(&t);
>  
>  	ret = gpmc_cs_program_settings(gpmc_onenand_data->cs, &onenand_async);
> @@ -310,6 +312,8 @@ static int omap2_onenand_setup_sync(void __iomem *onenand_base, int *freq_ptr)
>  	if (!freq) {
>  		/* Very first call freq is not known */
>  		freq = omap2_onenand_get_freq(gpmc_onenand_data, onenand_base);
> +		if (!freq)
> +			return -ENODEV;
>  		set_onenand_cfg(onenand_base);
>  	}
>  
