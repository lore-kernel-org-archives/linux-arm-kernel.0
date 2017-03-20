From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 20 Mar 2017 10:38:21 +0100
Subject: [PATCH 2/8] soc: imx: gpc: fix the wrong using of regmap cache
In-Reply-To: <1489990547-1510-3-git-send-email-aisheng.dong@nxp.com>
References: <1489990547-1510-1-git-send-email-aisheng.dong@nxp.com>
 <1489990547-1510-3-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1490002701.2895.13.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 20.03.2017, 14:15 +0800 schrieb Dong Aisheng:
> Without providing the proper reg_defaults, the regmap registers first
> read out may be always 0 if enabling cache, which results in the
> following issue we met.
> e.g. During driver probe in imx6_pm_domain_power_on():
> regmap_read(pd->regmap, pd->reg_offs + GPC_PGC_PUPSCR_OFFS, &val);
> The PGC_PUPSCR register val is always 0 but it's actually 0xf01 in HW.
> 
> Since GPC registers are tightly related to CPU bring up and may be
> changed in bootloader, we don't want to provide defaults.
> And the cache really does not save too much for GPC module.
> 
> Therefore, simply disable cache to fix the issue and make life easy.

While I agree that not using the cache may be the right thing to do
here, bypassing the cache by not providing the volatile function is only
half the fix.

Please also set the cache type to REGCACHE_NONE, to make it clear that
the cache isn't used.

Regards,
Lucas

> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/soc/imx/gpc.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
> index c9bfdfd..7e6a672 100644
> --- a/drivers/soc/imx/gpc.c
> +++ b/drivers/soc/imx/gpc.c
> @@ -289,22 +289,12 @@ static bool imx_gpc_readable_reg(struct device *dev, unsigned int reg)
>  	return (reg % 4 == 0) && (reg <= 0x2ac);
>  }
>  
> -static bool imx_gpc_volatile_reg(struct device *dev, unsigned int reg)
> -{
> -	if (reg == GPC_CNTR)
> -		return true;
> -
> -	return false;
> -}
> -
>  static const struct regmap_config imx_gpc_regmap_config = {
> -	.cache_type = REGCACHE_FLAT,
>  	.reg_bits = 32,
>  	.val_bits = 32,
>  	.reg_stride = 4,
>  
>  	.readable_reg = imx_gpc_readable_reg,
> -	.volatile_reg = imx_gpc_volatile_reg,
>  
>  	.max_register = 0x2ac,
>  };
