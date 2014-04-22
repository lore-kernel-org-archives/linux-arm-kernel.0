From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 21 Apr 2014 23:09:00 -0400 (EDT)
Subject: [PATCH v3 06/13] ARM: mcpm: support 4 clusters in HiP04
In-Reply-To: <1397801156-25682-7-git-send-email-haojian.zhuang@linaro.org>
References: <1397801156-25682-1-git-send-email-haojian.zhuang@linaro.org>
 <1397801156-25682-7-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <alpine.LFD.2.11.1404212255520.980@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Apr 2014, Haojian Zhuang wrote:

> Since 16 Cortex-A15 cores are used in HiP04 SoC, enlarge the maximum
> clusters from 2 to 4 if HiP04 SoC is built without CONFIG_BIG_LITTLE.

Why "... if HiP04 SoC is built without CONFIG_BIG_LITTLE" ?
That statement makes no sense.  As mentioned before, if you have a 
multi-platform kernel config with CONFIG_BIG_LITTLE included, there is 
no reason for not supporting quad cluster platforms at the same time.

FYI you might want to have a look at patch #8032 in RMK's patch system 
that removes a build-time MCPM dependency from the b.L switcher.

> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

More comments below.

> ---
>  arch/arm/Kconfig            | 8 ++++++++
>  arch/arm/include/asm/mcpm.h | 5 +++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 9a2214e..f2a25be 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1571,6 +1571,14 @@ config MCPM
>  	  for (multi-)cluster based systems, such as big.LITTLE based
>  	  systems.
>  
> +config MCPM_QUAD_CLUSTER
> +	bool "Enable Quad clusters in MPCM"

s/MPCM/MCPM/

Yet you should not provide any prompt text here.  This is way too 
technical to leave to the user configuring the kernel to decide.  
Instead, the actual platform needing this feature should select this 
config symbol directly.

> +	depends on MCPM
> +	default n

The default is already n, so no need to explicitly default to the 
default's default.

> +	help
> +	  This option enables quad clusters in MCPM. Quad clusters exist
> +	  in HiP04 SoC.

Please refrain from listing SoCs here.

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
> 1.8.3.2
> 
