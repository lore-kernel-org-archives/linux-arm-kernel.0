From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 26 Feb 2015 17:08:11 +0200
Subject: [PATCH v2] ASoC: omap: fix up SND_OMAP_SOC_OMAP_ABE_TWL6040
 dependency
In-Reply-To: <2707228.SKhEXovzW4@wuerfel>
References: <22890811.0MuvZ4MxOU@wuerfel> <54EDEAE3.6080605@ti.com>
 <2707228.SKhEXovzW4@wuerfel>
Message-ID: <54EF36DB.5040206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/25/2015 05:42 PM, Arnd Bergmann wrote:
> The change to enable OMAP5 support on this platform was a little too
> eager in adding a 'select' for a particular clock driver that might
> not be enabled in all configurations, which in turn leads to a build
> error:
> 
> warning: (SND_OMAP_SOC_OMAP_ABE_TWL6040) selects COMMON_CLK_PALMAS which has unmet direct dependencies (COMMON_CLK && MFD_PALMAS)
> drivers/built-in.o: In function `palmas_clks_probe':
> drivers/clk/clk-palmas.c:228: undefined reference to `palmas_ext_control_req_config'
> 
> I do not see a strong dependency here, so it's probably better to
> drop this select and to avoid adding more complexity here.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 5163c1eede8e9 ("ASoC: omap: Kconfig: Support for omap5-uevm analog audio")

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
> v2: change the dependency as suggested by Peter
> 
> diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
> index e7c78b0406b5..6768e4f7d7d0 100644
> --- a/sound/soc/omap/Kconfig
> +++ b/sound/soc/omap/Kconfig
> @@ -105,7 +105,7 @@ config SND_OMAP_SOC_OMAP_ABE_TWL6040
>  	select SND_OMAP_SOC_MCPDM
>  	select SND_SOC_TWL6040
>  	select SND_SOC_DMIC
> -	select COMMON_CLK_PALMAS if SOC_OMAP5
> +	select COMMON_CLK_PALMAS if MFD_PALMAS
>  	help
>  	  Say Y if you want to add support for SoC audio on OMAP boards using
>  	  ABE and twl6040 codec. This driver currently supports:
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
P?ter
