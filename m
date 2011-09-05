From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 05 Sep 2011 14:17:08 +0900
Subject: [PATCH v2 6/6] ARM: EXYNOS4: Limit usage of pl330 device instance
	to non-dt build
In-Reply-To: <1314867882-11755-7-git-send-email-thomas.abraham@linaro.org>
References: <1314867882-11755-1-git-send-email-thomas.abraham@linaro.org>
	<1314867882-11755-2-git-send-email-thomas.abraham@linaro.org>
	<1314867882-11755-3-git-send-email-thomas.abraham@linaro.org>
	<1314867882-11755-4-git-send-email-thomas.abraham@linaro.org>
	<1314867882-11755-5-git-send-email-thomas.abraham@linaro.org>
	<1314867882-11755-6-git-send-email-thomas.abraham@linaro.org>
	<1314867882-11755-7-git-send-email-thomas.abraham@linaro.org>
Message-ID: <001901cc6b8b$0f450730$2dcf1590$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Thomas Abraham [mailto:thomas.abraham at linaro.org]
> Sent: Thursday, September 01, 2011 6:05 PM
> To: devicetree-discuss at lists.ozlabs.org
> Cc: grant.likely at secretlab.ca; linux-arm-kernel at lists.infradead.org;
linux-samsung-
> soc at vger.kernel.org; kgene.kim at samsung.com; robherring2 at gmail.com;
> vinod.koul at intel.com; patches at linaro.org; jassisinghbrar at gmail.com;
> boojin.kim at samsung.com
> Subject: [PATCH v2 6/6] ARM: EXYNOS4: Limit usage of pl330 device instance
to
> non-dt build
> 
> The pl330 device instances and associated platform data is required only
> for non-device-tree builds. With device tree, all of this information is
> obtained from the device tree.
> 
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  arch/arm/mach-exynos4/Kconfig  |    7 +++++++
>  arch/arm/mach-exynos4/Makefile |    3 ++-
>  2 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
> index d4d401c..3edbf37 100644
> --- a/arch/arm/mach-exynos4/Kconfig
> +++ b/arch/arm/mach-exynos4/Kconfig
> @@ -21,6 +21,13 @@ config EXYNOS4_MCT
>  	help
>  	  Use MCT (Multi Core Timer) as kernel timers
> 
> +config EXYNOS4_DEV_DMA
> +	bool
> +	default y if !OF
> +	help
> +	  Compile in amba device definitions for DMA controller if OF
> +	  is not enabled.
> +
>  config EXYNOS4_DEV_AHCI
>  	bool
>  	help
> diff --git a/arch/arm/mach-exynos4/Makefile
b/arch/arm/mach-exynos4/Makefile
> index d2bf5bf..a2f33dc 100644
> --- a/arch/arm/mach-exynos4/Makefile
> +++ b/arch/arm/mach-exynos4/Makefile
> @@ -13,7 +13,8 @@ obj-				:=
>  # Core support for EXYNOS4 system
> 
>  obj-$(CONFIG_CPU_EXYNOS4210)	+= cpu.o init.o clock.o irq-combiner.o
> -obj-$(CONFIG_CPU_EXYNOS4210)	+= setup-i2c0.o irq-eint.o dma.o
> pmu.o
> +obj-$(CONFIG_CPU_EXYNOS4210)	+= setup-i2c0.o irq-eint.o pmu.o
> +obj-$(CONFIG_EXYNOS4_DEV_DMA)	+= dma.o

Do we need _really_ EXYNOS4_DEV_DMA here?
How about to use like following?

+obj-$(!CONFIG_OF)		+= dma.o

If any problems, let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


>  obj-$(CONFIG_PM)		+= pm.o sleep.o
>  obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
> 
> --
> 1.6.6.rc2
