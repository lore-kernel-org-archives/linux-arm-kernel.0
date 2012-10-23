From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 23 Oct 2012 21:35:32 +0900
Subject: [PATCH 2/4] ARM: EXYNOS: Kconfig: Sort out dependencies between
 options
In-Reply-To: <1349701345-2681-3-git-send-email-t.figa@samsung.com>
References: <1349701345-2681-1-git-send-email-t.figa@samsung.com>
 <1349701345-2681-3-git-send-email-t.figa@samsung.com>
Message-ID: <01d401cdb11a$e4bcfff0$ae36ffd0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> This patch modifies the dependencies between Exynos-related Kconfig
> options to represent the real dependencies between code units more
> closely.
> 
> Originally it was possible to enable ARCH_EXYNOS{4,5} without any
> SOC_EXYNOS_{4,5}.* enabled, which could end with compilation or link
> errors. Now ARCH_EXYNOS{4,5} is only selected when there is a
> SOC_EXYNOS_{4,5}.* enabled, which requires it.
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-exynos/Kconfig | 15 ++++++---------
>  drivers/devfreq/Kconfig      |  2 +-
>  drivers/mmc/host/sdhci-s3c.c |  2 +-
>  drivers/tty/serial/samsung.c |  3 +--
>  4 files changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index 05dcd07..9f91892 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -12,15 +12,14 @@ if ARCH_EXYNOS
>  menu "SAMSUNG EXYNOS SoCs Support"
> 
>  config ARCH_EXYNOS4
> -	bool "SAMSUNG EXYNOS4"
> -	default y
> +	def_bool n
>  	select HAVE_SMP
>  	select MIGHT_HAVE_CACHE_L2X0
>  	help
>  	  Samsung EXYNOS4 SoCs based systems
> 
>  config ARCH_EXYNOS5
> -	bool "SAMSUNG EXYNOS5"
> +	def_bool n
>  	select HAVE_SMP
>  	help
>  	  Samsung EXYNOS5 (Cortex-A15) SoC based systems
> @@ -30,7 +29,7 @@ comment "EXYNOS SoCs"
>  config SOC_EXYNOS4210
>  	bool "SAMSUNG EXYNOS4210"
>  	default y
> -	depends on ARCH_EXYNOS4
> +	select ARCH_EXYNOS4
>  	select SAMSUNG_DMADEV
>  	select ARM_CPU_SUSPEND if PM
>  	select S5P_PM if PM
> @@ -42,7 +41,7 @@ config SOC_EXYNOS4210
>  config SOC_EXYNOS4212
>  	bool "SAMSUNG EXYNOS4212"
>  	default y
> -	depends on ARCH_EXYNOS4
> +	select ARCH_EXYNOS4
>  	select SAMSUNG_DMADEV
>  	select S5P_PM if PM
>  	select S5P_SLEEP if PM
> @@ -51,6 +50,7 @@ config SOC_EXYNOS4212
> 
>  config SOC_EXYNOS4412
>  	bool "SAMSUNG EXYNOS4412"
> +	select ARCH_EXYNOS4
>  	default y
>  	depends on ARCH_EXYNOS4
>  	select SAMSUNG_DMADEV
> @@ -60,7 +60,7 @@ config SOC_EXYNOS4412
>  config SOC_EXYNOS5250
>  	bool "SAMSUNG EXYNOS5250"
>  	default y
> -	depends on ARCH_EXYNOS5
> +	select ARCH_EXYNOS5
>  	select SAMSUNG_DMADEV
>  	select S5P_PM if PM
>  	select S5P_SLEEP if PM
> @@ -176,8 +176,6 @@ config EXYNOS_SETUP_SPI
> 

Basically, I agree with your approach. Its CONFIG_ARCH_EXYNOSx depends on
selecting own SOC.

BTW, I'm thinking, which one selecting is better to us board? Or SoC?...

>  # machine support
> 
> -if ARCH_EXYNOS4
> -

Well, according to removing above, we can select following exynos4210 boards
on other stuff. Of course, when select board, regarding soc is selected
though. So I'm thinking I said as above.

>  comment "EXYNOS4210 Boards"
> 
>  config MACH_SMDKC210
> @@ -397,7 +395,6 @@ config MACH_SMDK4412
>  	select MACH_SMDK4212
>  	help
>  	  Machine support for Samsung SMDK4412
> -endif
> 
>  comment "Flattened Device Tree based board for EXYNOS SoCs"
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 8545069..c559609 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -67,7 +67,7 @@ comment "DEVFREQ Drivers"
> 
>  config ARM_EXYNOS4_BUS_DEVFREQ
>  	bool "ARM Exynos4210/4212/4412 Memory Bus DEVFREQ Driver"
> -	depends on SOC_EXYNOS4210 || CPU_EXYNOS4212 || CPU_EXYNOS4412
> +	depends on ARCH_EXYNOS4

I don't think so, because it depends on SoC not architecture. In addition,
we don't know ARM_EXYNOS4_BUS_DEVFREQ is available on upcoming exynos4...

>  	select ARCH_HAS_OPP
>  	select DEVFREQ_GOV_SIMPLE_ONDEMAND
>  	help
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index b090415..5e2083b 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -716,7 +716,7 @@ static const struct dev_pm_ops sdhci_s3c_pmops = {
>  #define SDHCI_S3C_PMOPS NULL
>  #endif
> 
> -#if defined(CONFIG_SOC_EXYNOS4210) || defined(CONFIG_SOC_EXYNOS4212)
> +#if defined(CONFIG_ARCH_EXYNOS4)

Same as above.

>  static struct sdhci_s3c_drv_data exynos4_sdhci_drv_data = {
>  	.sdhci_quirks = SDHCI_QUIRK_NONSTANDARD_CLOCK,
>  };
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> index 175ba6e..c689091 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -1594,8 +1594,7 @@ static struct s3c24xx_serial_drv_data
> s5pv210_serial_drv_data = {
>  #define S5PV210_SERIAL_DRV_DATA	(kernel_ulong_t)NULL
>  #endif
> 
> -#if defined(CONFIG_SOC_EXYNOS4210) || defined(CONFIG_SOC_EXYNOS4212) || \
> -	defined(CONFIG_SOC_EXYNOS4412) || defined(CONFIG_SOC_EXYNOS5250)
> +#if defined(CONFIG_ARCH_EXYNOS4) || defined(CONFIG_ARCH_EXYNOS5)

Same as above.

>  static struct s3c24xx_serial_drv_data exynos4210_serial_drv_data = {
>  	.info = &(struct s3c24xx_uart_info) {
>  		.name		= "Samsung Exynos4 UART",
> --
> 1.7.12

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
