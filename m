From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 10 Nov 2011 09:49:43 +0100
Subject: [PATCH 2/4] arm/imx: fix the references to ARCH_MX3
In-Reply-To: <1320914372-4416-3-git-send-email-shawn.guo@linaro.org>
References: <1320914372-4416-1-git-send-email-shawn.guo@linaro.org>
 <1320914372-4416-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <20111110084943.GW16886@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2011 at 04:39:30PM +0800, Shawn Guo wrote:
> The config symbol ARCH_MX3 has been removed by commit 'a89cf59
> arm/imx: merge i.MX3 and i.MX6', and it should not be referenced
> any more.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-imx/Makefile.boot |   10 +++++++---
>  drivers/dma/Kconfig             |    4 ++--
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/Makefile.boot b/arch/arm/mach-imx/Makefile.boot
> index 22d8588..c349a96 100644
> --- a/arch/arm/mach-imx/Makefile.boot
> +++ b/arch/arm/mach-imx/Makefile.boot
> @@ -14,9 +14,13 @@ zreladdr-$(CONFIG_MACH_MX27)	+= 0xA0008000
>  params_phys-$(CONFIG_MACH_MX27)	:= 0xA0000100
>  initrd_phys-$(CONFIG_MACH_MX27)	:= 0xA0800000
>  
> -zreladdr-$(CONFIG_ARCH_MX3)	+= 0x80008000
> -params_phys-$(CONFIG_ARCH_MX3)	:= 0x80000100
> -initrd_phys-$(CONFIG_ARCH_MX3)	:= 0x80800000
> +zreladdr-$(CONFIG_SOC_IMX31)	+= 0x80008000
> +params_phys-$(CONFIG_SOC_IMX31)	:= 0x80000100
> +initrd_phys-$(CONFIG_SOC_IMX31)	:= 0x80800000
> +
> +zreladdr-$(CONFIG_SOC_IMX35)	+= 0x80008000
> +params_phys-$(CONFIG_SOC_IMX35)	:= 0x80000100
> +initrd_phys-$(CONFIG_SOC_IMX35)	:= 0x80800000
>  
>  zreladdr-$(CONFIG_SOC_IMX6Q)	+= 0x10008000
>  params_phys-$(CONFIG_SOC_IMX6Q)	:= 0x10000100

Can you please replace all CONFIG_ARCH_* in this file instead?

> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index ab8f469..8f7dce1 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -124,7 +124,7 @@ config MV_XOR
>  
>  config MX3_IPU
>  	bool "MX3x Image Processing Unit support"
> -	depends on ARCH_MX3
> +	depends on SOC_IMX31 || SOC_IMX35
>  	select DMA_ENGINE
>  	default y
>  	help
> @@ -216,7 +216,7 @@ config PCH_DMA
>  
>  config IMX_SDMA
>  	tristate "i.MX SDMA support"
> -	depends on ARCH_MX25 || ARCH_MX3 || ARCH_MX5
> +	depends on ARCH_MX25 || SOC_IMX31 || SOC_IMX35 || ARCH_MX5

I already sent a patch to Vinod to remove those individual SoC
dependencies and depend on ARCH_MXC instead.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
