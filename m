From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 20 Mar 2012 22:30:53 -0400 (EDT)
Subject: [PATCH 1/2] ARM: dma-mapping: convert
 ARCH_HAS_DMA_SET_COHERENT_MASK to kconfig symbol
In-Reply-To: <1332296149-28110-1-git-send-email-robherring2@gmail.com>
References: <4F68CD9C.3090001@windriver.com>
 <1332296149-28110-1-git-send-email-robherring2@gmail.com>
Message-ID: <alpine.LFD.2.02.1203202230230.24151@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Mar 2012, Rob Herring wrote:

> From: Rob Herring <rob.herring@calxeda.com>
> 
> The only users of ARCH_HAS_DMA_SET_COHERENT_MASK are 2 ARM platforms:
> ixp4xx and pxa cm_x2xx. We've been getting lucky that the define is
> implicitly included before dma-mapping.h, but the removal of io.h broke
> things (c334bc1 ARM: make mach/io.h include optional). Since memory.h
> is the correct place, but no longer exists, convert the define to a
> kconfig entry.
> 
> Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Imre Kaloz <kaloz@openwrt.org>
> Cc: Krzysztof Halasa <khc@pm.waw.pl>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/Kconfig                             |    4 ++++
>  arch/arm/mach-ixp4xx/include/mach/hardware.h |    2 --
>  arch/arm/mach-pxa/Kconfig                    |    1 +
>  arch/arm/mach-pxa/include/mach/hardware.h    |    4 ----
>  include/linux/dma-mapping.h                  |    2 +-
>  5 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 31a2ddc..d3999a5 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -180,6 +180,9 @@ config ZONE_DMA
>  config NEED_DMA_MAP_STATE
>         def_bool y
>  
> +config ARCH_HAS_DMA_SET_COHERENT_MASK
> +	bool
> +
>  config GENERIC_ISA_DMA
>  	bool
>  
> @@ -547,6 +550,7 @@ config ARCH_IXP2000
>  config ARCH_IXP4XX
>  	bool "IXP4xx-based"
>  	depends on MMU
> +	select ARCH_HAS_DMA_SET_COHERENT_MASK
>  	select CLKSRC_MMIO
>  	select CPU_XSCALE
>  	select GENERIC_GPIO
> diff --git a/arch/arm/mach-ixp4xx/include/mach/hardware.h b/arch/arm/mach-ixp4xx/include/mach/hardware.h
> index c30e7e9..034bb2a 100644
> --- a/arch/arm/mach-ixp4xx/include/mach/hardware.h
> +++ b/arch/arm/mach-ixp4xx/include/mach/hardware.h
> @@ -23,8 +23,6 @@
>  #define PCIBIOS_MAX_MEM		0x4BFFFFFF
>  #endif
>  
> -#define ARCH_HAS_DMA_SET_COHERENT_MASK
> -
>  /* Register locations and bits */
>  #include "ixp4xx-regs.h"
>  
> diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
> index 61d3c72..109ccd2 100644
> --- a/arch/arm/mach-pxa/Kconfig
> +++ b/arch/arm/mach-pxa/Kconfig
> @@ -108,6 +108,7 @@ config CSB726_CSB701
>  
>  config MACH_ARMCORE
>  	bool "CompuLab CM-X255/CM-X270 modules"
> +	select ARCH_HAS_DMA_SET_COHERENT_MASK if PCI
>  	select PXA27x
>  	select IWMMXT
>  	select PXA25x
> diff --git a/arch/arm/mach-pxa/include/mach/hardware.h b/arch/arm/mach-pxa/include/mach/hardware.h
> index 8184669..54b64ea 100644
> --- a/arch/arm/mach-pxa/include/mach/hardware.h
> +++ b/arch/arm/mach-pxa/include/mach/hardware.h
> @@ -337,8 +337,4 @@ extern unsigned int get_memclk_frequency_10khz(void);
>  extern unsigned long get_clock_tick_rate(void);
>  #endif
>  
> -#if defined(CONFIG_MACH_ARMCORE) && defined(CONFIG_PCI)
> -#define ARCH_HAS_DMA_SET_COHERENT_MASK
> -#endif
> -
>  #endif  /* _ASM_ARCH_HARDWARE_H */
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index e13117c..5a736af 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -77,7 +77,7 @@ static inline u64 dma_get_mask(struct device *dev)
>  	return DMA_BIT_MASK(32);
>  }
>  
> -#ifdef ARCH_HAS_DMA_SET_COHERENT_MASK
> +#ifdef CONFIG_ARCH_HAS_DMA_SET_COHERENT_MASK
>  int dma_set_coherent_mask(struct device *dev, u64 mask);
>  #else
>  static inline int dma_set_coherent_mask(struct device *dev, u64 mask)
> -- 
> 1.7.5.4
> 
