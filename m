From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 9 Jul 2013 09:30:29 +0100
Subject: [PATCH] ARM: Kconfig: Let ARM_ERRATA_364296 not depend on
 CONFIG_SMP
In-Reply-To: <1373319489-9467-1-git-send-email-festevam@gmail.com>
References: <1373319489-9467-1-git-send-email-festevam@gmail.com>
Message-ID: <20130709083023.GA2911@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 08, 2013 at 06:38:09PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> imx_v6_v7_defconfig handles both multi-core and single-core SoCs, and it has 
> CONFIG_SMP=y selected by default.
> 
> With such config we cannot select ARM_ERRATA_364296, as it depends on !SMP.
> 
> Let ARM_ERRATA_364296 be undependent on CONFIG_SMP, so that we can select
> this erratum for the ARM1136 SoCs, even if CONFIG_SMP=y is enabled.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

This looks sensible.  The enabled code checks for the specific
affected CPU ID in the CP15 Main ID Register, so it shouldn't get
activated on any other kind of CPU even if the option is enabled.

1136 can't be deployed as SMP, so the patch shouldn't break any existing
configuration.

Strictly speaking, && !SMP may be incorrect, since it is valid (if not
very useful) to build a v6 kernel with SMP and SMP_ON_UP, and run it on
1136 hardware, even if the kernel is non-multiplatform.

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> ---
>  arch/arm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 0ac9be6..ba412e0 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1316,7 +1316,7 @@ config ARM_ERRATA_754327
>  
>  config ARM_ERRATA_364296
>  	bool "ARM errata: Possible cache data corruption with hit-under-miss enabled"
> -	depends on CPU_V6 && !SMP
> +	depends on CPU_V6
>  	help
>  	  This options enables the workaround for the 364296 ARM1136
>  	  r0p2 erratum (possible cache data corruption with
> -- 
> 1.8.1.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
