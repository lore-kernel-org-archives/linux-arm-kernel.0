From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 7 May 2014 12:59:00 -0400 (EDT)
Subject: [PATCH v5 06/14] ARM: mcpm: support 4 clusters
In-Reply-To: <1399473888-12947-7-git-send-email-haojian.zhuang@linaro.org>
References: <1399473888-12947-1-git-send-email-haojian.zhuang@linaro.org>
 <1399473888-12947-7-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <alpine.LFD.2.11.1405071256280.980@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 7 May 2014, Haojian Zhuang wrote:

> Add the CONFIG_MCPM_QUAD_CLUSTER configuration to enlarge cluster number
> from 2 to 4.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  arch/arm/Kconfig            | 9 +++++++++
>  arch/arm/include/asm/mcpm.h | 5 +++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 0e52a2c..624829f 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1575,6 +1575,15 @@ config MCPM
>  	  for (multi-)cluster based systems, such as big.LITTLE based
>  	  systems.
>  
> +config MCPM_QUAD_CLUSTER
> +	bool "Enable Quad clusters in MCPM"

Please remove the prompt string, keeping only the bool alone.  This 
config option shouldn't be visible to users.  After that you may add:

Reviewed-by: Nicolas Pitre <nico@linaro.org>


> +	depends on MCPM
> +	help
> +	  To avoid wasting resources unnecessarily, MCPM only supports up
> +	  to 2 clusters by default.
> +	  Platforms with 3 or 4 clusters that use MCPM must select this
> +	  option to allow the additional clusters to be managed.
> +
>  config BIG_LITTLE
>  	bool "big.LITTLE support (Experimental)"
>  	depends on CPU_V7 && SMP
> diff --git a/arch/arm/include/asm/mcpm.h b/arch/arm/include/asm/mcpm.h
> index 608516e..fc8d70d 100644
> --- a/arch/arm/include/asm/mcpm.h
> +++ b/arch/arm/include/asm/mcpm.h
> @@ -20,7 +20,12 @@
>   * to consider dynamic allocation.
>   */
>  #define MAX_CPUS_PER_CLUSTER	4
> +
> +#ifdef CONFIG_MCPM_QUAD_CLUSTER
> +#define MAX_NR_CLUSTERS		4
> +#else
>  #define MAX_NR_CLUSTERS		2
> +#endif
>  
>  #ifndef __ASSEMBLY__
>  
> -- 
> 1.9.1
> 
