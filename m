From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 19 Oct 2013 17:41:10 +0000 (UTC)
Subject: [PATCH 07/11] ARM: OMAP3: CM/PM: add new API for checking IVA2
 idle status
In-Reply-To: <1381508141-15244-8-git-send-email-t-kristo@ti.com>
References: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
 <1381508141-15244-8-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.02.1310191741030.12900@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Oct 2013, Tero Kristo wrote:

> OMAP3 PM code needs this functionality during the IVA2 reset, but is currently
> using direct CM register accesses for this purpose. Implement a new API so
> the PM code can use this instead.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  arch/arm/mach-omap2/cm3xxx.c |    6 ++++++
>  arch/arm/mach-omap2/cm3xxx.h |    1 +
>  arch/arm/mach-omap2/pm34xx.c |    3 +--
>  3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/cm3xxx.c b/arch/arm/mach-omap2/cm3xxx.c
> index 55bf939..b0509b9 100644
> --- a/arch/arm/mach-omap2/cm3xxx.c
> +++ b/arch/arm/mach-omap2/cm3xxx.c
> @@ -696,6 +696,12 @@ void omap3_cm_force_iva_clk(bool enable)
>  	omap2_cm_write_mod_reg(val, OMAP3430_IVA2_MOD, CM_FCLKEN);
>  }
>  
> +bool omap3_cm_is_iva_active(void)
> +{
> +	return omap2_cm_read_mod_reg(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKSTST) &
> +		OMAP3430_CLKACTIVITY_IVA2_MASK;
> +}
> +

Please implement this as a generic clockdomain API that can be called for 
any clockdomain.



- Paul
