From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Mon, 5 Nov 2012 12:53:59 +0530
Subject: [PATCH 06/15] ARM: OMAP2+: hwmod: Enable OCMCRAM registration
 in AM33XX
In-Reply-To: <1351859566-24818-7-git-send-email-vaibhav.bedia@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-7-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <5097698F.1080609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/2/2012 6:02 PM, Vaibhav Bedia wrote:
> The hwmod data for OCMCRAM in AM33XX was commented out.
> This data is needed by the power management code, hence
> uncomment the same and register the OCP interface for it.
> 
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_33xx_data.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> index 2e470ce..ec3fbb2 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> @@ -415,7 +415,6 @@ static struct omap_hwmod am33xx_adc_tsc_hwmod = {
>   *    - cEFUSE (doesn't fall under any ocp_if)
>   *    - clkdiv32k
>   *    - debugss
> - *    - ocmc ram
>   *    - ocp watch point
>   *    - aes0
>   *    - sha0
> @@ -481,6 +480,7 @@ static struct omap_hwmod am33xx_debugss_hwmod = {
>  		},
>  	},
>  };
> +#endif
>  
>  /* ocmcram */
>  static struct omap_hwmod_class am33xx_ocmcram_hwmod_class = {
> @@ -501,6 +501,7 @@ static struct omap_hwmod am33xx_ocmcram_hwmod = {
>  	},
>  };
>  
> +#if 0

Can you cut-n-paste the ocmcram hwmod entry outside of #if and resubmit
it again?

Thanks,
Vaibhav

>  /* ocpwp */
>  static struct omap_hwmod_class am33xx_ocpwp_hwmod_class = {
>  	.name		= "ocpwp",
> @@ -3331,6 +3332,13 @@ static struct omap_hwmod_ocp_if am33xx_l3_s__usbss = {
>  	.flags		= OCPIF_SWSUP_IDLE,
>  };
>  
> +/* l3 main -> ocmc */
> +static struct omap_hwmod_ocp_if am33xx_l3_main__ocmc = {
> +	.master		= &am33xx_l3_main_hwmod,
> +	.slave		= &am33xx_ocmcram_hwmod,
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
>  static struct omap_hwmod_ocp_if *am33xx_hwmod_ocp_ifs[] __initdata = {
>  	&am33xx_l4_fw__emif_fw,
>  	&am33xx_l3_main__emif,
> @@ -3401,6 +3409,7 @@ static struct omap_hwmod_ocp_if *am33xx_hwmod_ocp_ifs[] __initdata = {
>  	&am33xx_l3_main__tptc0,
>  	&am33xx_l3_main__tptc1,
>  	&am33xx_l3_main__tptc2,
> +	&am33xx_l3_main__ocmc,
>  	&am33xx_l3_s__usbss,
>  	&am33xx_l4_hs__cpgmac0,
>  	&am33xx_cpgmac0__mdio,
> 
