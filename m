From: olof@lixom.net (Olof Johansson)
Date: Mon, 17 Jun 2013 10:03:26 -0700
Subject: [PATCH v10 1/2] ARM: davinci: move private EDMA API to arm/common
In-Reply-To: <1371463571-2578-2-git-send-email-nsekhar@ti.com>
References: <1371463571-2578-1-git-send-email-nsekhar@ti.com>
 <1371463571-2578-2-git-send-email-nsekhar@ti.com>
Message-ID: <20130617170326.GA28497@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 03:36:10PM +0530, Sekhar Nori wrote:
> From: Matt Porter <mporter@ti.com>
> 
> Move mach-davinci/dma.c to common/edma.c so it can be used
> by OMAP (specifically AM33xx) as well.
> 
> Signed-off-by: Matt Porter <mporter@ti.com>
> Acked-by: Chris Ball <cjb@laptop.org> # davinci_mmc.c
> [nsekhar at ti.com: dropped davinci sffsdr changes]
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Acked-by: Olof Johansson <olof@lixom.net>

Tiny nit below, no need to respin just for that.

I suppose we should take this through arm-soc.

> ---
>  arch/arm/Kconfig                                   |    1 +
>  arch/arm/common/Kconfig                            |    3 +
>  arch/arm/common/Makefile                           |    1 +
>  arch/arm/{mach-davinci/dma.c => common/edma.c}     |    2 +-
>  arch/arm/mach-davinci/Makefile                     |    2 +-
>  arch/arm/mach-davinci/board-tnetv107x-evm.c        |    2 +-
>  arch/arm/mach-davinci/davinci.h                    |    2 +-
>  arch/arm/mach-davinci/devices-tnetv107x.c          |    2 +-
>  arch/arm/mach-davinci/devices.c                    |    6 +-
>  arch/arm/mach-davinci/dm355.c                      |    2 +-
>  arch/arm/mach-davinci/dm365.c                      |    2 +-
>  arch/arm/mach-davinci/dm644x.c                     |    2 +-
>  arch/arm/mach-davinci/dm646x.c                     |    2 +-
>  arch/arm/mach-davinci/include/mach/da8xx.h         |    2 +-
>  drivers/dma/edma.c                                 |    2 +-
>  drivers/mmc/host/davinci_mmc.c                     |    1 +
>  include/linux/mfd/davinci_voicecodec.h             |    3 +-
>  .../mach => include/linux/platform_data}/edma.h    |   89 +-------------------
>  include/linux/platform_data/spi-davinci.h          |    2 +-
>  sound/soc/davinci/davinci-evm.c                    |    1 +
>  sound/soc/davinci/davinci-pcm.c                    |    1 +
>  sound/soc/davinci/davinci-pcm.h                    |    2 +-
>  22 files changed, 29 insertions(+), 103 deletions(-)
>  rename arch/arm/{mach-davinci/dma.c => common/edma.c} (99%)
>  rename {arch/arm/mach-davinci/include/mach => include/linux/platform_data}/edma.h (59%)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 49d993c..b1c66a4 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -840,6 +840,7 @@ config ARCH_DAVINCI
>  	select GENERIC_IRQ_CHIP
>  	select HAVE_IDE
>  	select NEED_MACH_GPIO_H
> +	select TI_PRIV_EDMA

What does PRIV here mean? Privileged? Private? I think it can be shortened to
TI_EDMA.

>  	select USE_OF
>  	select ZONE_DMA
>  	help
> diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
> index 9353184..c3a4e9c 100644
> --- a/arch/arm/common/Kconfig
> +++ b/arch/arm/common/Kconfig
> @@ -17,3 +17,6 @@ config SHARP_PARAM
>  
>  config SHARP_SCOOP
>  	bool
> +
> +config TI_PRIV_EDMA
> +	bool
> diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
> index 48434cb..8c60f47 100644
> --- a/arch/arm/common/Makefile
> +++ b/arch/arm/common/Makefile
> @@ -16,3 +16,4 @@ obj-$(CONFIG_ARM_TIMER_SP804)	+= timer-sp.o
>  obj-$(CONFIG_MCPM)		+= mcpm_head.o mcpm_entry.o mcpm_platsmp.o vlock.o
>  AFLAGS_mcpm_head.o		:= -march=armv7-a
>  AFLAGS_vlock.o			:= -march=armv7-a
> +obj-$(CONFIG_TI_PRIV_EDMA)	+= edma.o
