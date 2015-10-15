From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Thu, 15 Oct 2015 23:17:47 +0200
Subject: [PATCH v3 01/10] ARM: cygnus: fix link failures when
 CONFIG_COMMON_CLK_IPROC is disabled
In-Reply-To: <1444938513-10758-2-git-send-email-jonmason@broadcom.com>
References: <1444938513-10758-1-git-send-email-jonmason@broadcom.com>
 <1444938513-10758-2-git-send-email-jonmason@broadcom.com>
Message-ID: <562017FB.3030406@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2015 09:48 PM, Jon Mason wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_CYGNUS is set but CONFIG_COMMON_CLK_IPROC is disabled, the
> following link failures are caused:
> 
> drivers/built-in.o: In function `cygnus_armpll_init':
> :(.init.text+0x1d290): undefined reference to `iproc_armpll_setup'
> drivers/built-in.o: In function `cygnus_genpll_clk_init':
> :(.init.text+0x1d2c4): undefined reference to `iproc_pll_clk_setup'
> drivers/built-in.o: In function `cygnus_lcpll0_clk_init':
> :(.init.text+0x1d304): undefined reference to `iproc_pll_clk_setup'
> drivers/built-in.o: In function `cygnus_mipipll_clk_init':
> :(.init.text+0x1d344): undefined reference to `iproc_pll_clk_setup'
> drivers/built-in.o: In function `cygnus_asiu_init':
> :(.init.text+0x1d370): undefined reference to `iproc_asiu_setup'
> 
> It is fixed it by always selecting COMMON_CLK_IPROC from
> ARCH_BCM_IPROC, and making COMMON_CLK_IPROC a silent option (thus
> preventing it from being erroneously disabled by a user).
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Jon Mason <jonmason@broadcom.com>
> ---
>  arch/arm/mach-bcm/Kconfig | 2 +-
>  drivers/clk/bcm/Kconfig   | 4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index 1319c3c..84bd265 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -14,7 +14,7 @@ config ARCH_BCM_IPROC
>  	select HAVE_ARM_SCU if SMP
>  	select HAVE_ARM_TWD if SMP
>  	select ARM_GLOBAL_TIMER
> -
> +	select COMMON_CLK_IPROC
>  	select CLKSRC_MMIO
>  	select ARCH_REQUIRE_GPIOLIB
>  	select ARM_AMBA
> diff --git a/drivers/clk/bcm/Kconfig b/drivers/clk/bcm/Kconfig
> index 88febf5..46ee475 100644
> --- a/drivers/clk/bcm/Kconfig
> +++ b/drivers/clk/bcm/Kconfig
> @@ -9,10 +9,8 @@ config CLK_BCM_KONA
>  	  in the BCM281xx and BCM21664 families.
>  
>  config COMMON_CLK_IPROC
> -	bool "Broadcom iProc clock support"
> -	depends on ARCH_BCM_IPROC
> +	bool
>  	depends on COMMON_CLK
> -	default ARCH_BCM_IPROC
>  	help
>  	  Enable common clock framework support for Broadcom SoCs
>  	  based on the iProc architecture

A help text is not needed for a silent option.

Hauke
