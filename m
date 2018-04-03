From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 3 Apr 2018 11:12:18 +0200
Subject: [PATCH v5 08/13] ARM: sunxi: Add initialization of CNTVOFF
In-Reply-To: <20180403061836.3926-9-mylene.josserand@bootlin.com>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
 <20180403061836.3926-9-mylene.josserand@bootlin.com>
Message-ID: <20180403091218.t6xuq6csjp4uyy5u@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 03, 2018 at 08:18:31AM +0200, Myl?ne Josserand wrote:
> Add the initialization of CNTVOFF for sun8i-a83t.
> 
> For boot CPU, Create a new machine that handles this
> function's call in an "init_early" callback.
> For secondary CPUs, add this function into secondary_startup
> assembly entry.
> 
> Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
> ---
>  arch/arm/mach-sunxi/headsmp.S |  1 +
>  arch/arm/mach-sunxi/sunxi.c   | 18 +++++++++++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-sunxi/headsmp.S b/arch/arm/mach-sunxi/headsmp.S
> index 79890fbe5613..b586b7cf803a 100644
> --- a/arch/arm/mach-sunxi/headsmp.S
> +++ b/arch/arm/mach-sunxi/headsmp.S
> @@ -71,6 +71,7 @@ ENDPROC(sunxi_mc_smp_cluster_cache_enable)
>  
>  ENTRY(sunxi_mc_smp_secondary_startup)
>  	bl	sunxi_mc_smp_cluster_cache_enable
> +	bl	smp_init_cntvoff
>  	b	secondary_startup
>  ENDPROC(sunxi_mc_smp_secondary_startup)
>  
> diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
> index 5e9602ce1573..090784108c0a 100644
> --- a/arch/arm/mach-sunxi/sunxi.c
> +++ b/arch/arm/mach-sunxi/sunxi.c
> @@ -16,6 +16,7 @@
>  #include <linux/platform_device.h>
>  
>  #include <asm/mach/arch.h>
> +#include <asm/smp_cntvoff.h>
>  
>  static const char * const sunxi_board_dt_compat[] = {
>  	"allwinner,sun4i-a10",
> @@ -62,7 +63,6 @@ MACHINE_END
>  static const char * const sun8i_board_dt_compat[] = {
>  	"allwinner,sun8i-a23",
>  	"allwinner,sun8i-a33",
> -	"allwinner,sun8i-a83t",
>  	"allwinner,sun8i-h2-plus",
>  	"allwinner,sun8i-h3",
>  	"allwinner,sun8i-r40",
> @@ -75,6 +75,22 @@ DT_MACHINE_START(SUN8I_DT, "Allwinner sun8i Family")
>  	.dt_compat	= sun8i_board_dt_compat,
>  MACHINE_END
>  
> +void __init sun8i_cntvoff_init(void)
> +{
> +	smp_init_cntvoff();

Can't this be moved to the SMP setup code?

> +}
> +
> +static const char * const sun8i_cntvoff_board_dt_compat[] = {
> +	"allwinner,sun8i-a83t",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(SUN8I_CNTVOFF_DT, "Allwinner sun8i boards needing cntvoff")

All of the SoCs need CNTVOFF, so that doesn't really make sense. Why
not just calling it for what it is: an A83t?

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180403/d03b971d/attachment.sig>
