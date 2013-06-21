From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 21 Jun 2013 15:46:01 +0530
Subject: [PATCH v12 05/11] edma: config: Enable config options for EDMA
In-Reply-To: <1371762407-24544-6-git-send-email-joelagnel@ti.com>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
 <1371762407-24544-6-git-send-email-joelagnel@ti.com>
Message-ID: <51C427E1.2000800@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/21/2013 2:36 AM, Joel A Fernandes wrote:
> From: Joel A Fernandes <agnel.joel@gmail.com>
> 
> Build TI_EDMA by default for ARCH_DAVINCI and ARCH_OMAP2PLUS
> 
> Signed-off-by: Joel A Fernandes <joelagnel@ti.com>

You should sign-off with author e-mail address.

> ---
>  arch/arm/Kconfig            |    1 +
>  arch/arm/mach-omap2/Kconfig |    1 +
>  drivers/dma/Kconfig         |    2 +-
>  3 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index b1c66a4..7d58cd9 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -841,6 +841,7 @@ config ARCH_DAVINCI
>  	select HAVE_IDE
>  	select NEED_MACH_GPIO_H
>  	select TI_PRIV_EDMA
> +	select DMADEVICES

It is generally a bad idea to force select on something that can be
enabled using menuconfig. Unless used carefully, select causes "unmet
direct dependency" warnings which folks are already fighting hard to
fix. This leads to what Russell referred in the past as "select madness" [1]

In this particular case, it is perfectly okay to have a DaVinci platform
without DMA engine support. Drivers figure out they don't have DMA
support and switch to PIO mode.

Add this in defconfig if its useful for most folks using the platform,
but don't force it for everyone through select.

>  	select USE_OF
>  	select ZONE_DMA
>  	help
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index f91b07f..c02f083 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -17,6 +17,7 @@ config ARCH_OMAP2PLUS
>  	select PROC_DEVICETREE if PROC_FS
>  	select SOC_BUS
>  	select SPARSE_IRQ
> +	select DMADEVICES
>  	select TI_PRIV_EDMA
>  	select USE_OF
>  	help
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 3215a3c..b2d6f15 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -216,7 +216,7 @@ config TI_EDMA
>  	depends on ARCH_DAVINCI || ARCH_OMAP
>  	select DMA_ENGINE
>  	select DMA_VIRTUAL_CHANNELS
> -	default n
> +	default y

Can't see why DMA support should default to y.

Thanks,
Sekhar

[1] http://lkml.org/lkml/2013/3/4/114
