From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 2 Jan 2015 10:50:23 +0100
Subject: [PATCH v2 09/12] ARM: efm32: move into multiplatform
In-Reply-To: <1419895935-22966-10-git-send-email-stefan@agner.ch>
References: <1419895935-22966-1-git-send-email-stefan@agner.ch>
 <1419895935-22966-10-git-send-email-stefan@agner.ch>
Message-ID: <20150102095023.GE28003@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Dec 30, 2014 at 12:32:12AM +0100, Stefan Agner wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Since the multiplatform configuration can support no-MMU kernels now,
> there is nothing stopping us from moving the efm32 platform in there
> as well. This introduces a new ARCH_MULTI_V7M CPU architecture selection
> option, since v7-M is incompatible with v7-A, and we can have either
> of the two enabled for multiplatform, but not both at the same time.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/Kconfig                 | 35 ++++++++++++++++-------------------
>  arch/arm/configs/efm32_defconfig |  2 ++
>  2 files changed, 18 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 95007b9..8fe035b 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -314,7 +314,7 @@ config ARCH_MULTIPLATFORM
>  	select COMMON_CLK
>  	select GENERIC_CLOCKEVENTS
>  	select MIGHT_HAVE_PCI
> -	select MULTI_IRQ_HANDLER
> +	select MULTI_IRQ_HANDLER if !ARCH_MULTI_V7M
>  	select SPARSE_IRQ
>  	select USE_OF
>  
> @@ -400,24 +400,6 @@ config ARCH_EBSA110
>  	  Ethernet interface, two PCMCIA sockets, two serial ports and a
>  	  parallel port.
>  
> -config ARCH_EFM32
> -	bool "Energy Micro efm32"
> -	depends on !MMU
> -	select ARCH_REQUIRE_GPIOLIB
> -	select ARM_NVIC
> -	select AUTO_ZRELADDR
> -	select CLKSRC_OF
> -	select COMMON_CLK
> -	select CPU_V7M
> -	select GENERIC_CLOCKEVENTS
> -	select NO_DMA
> -	select NO_IOPORT_MAP
> -	select SPARSE_IRQ
> -	select USE_OF
> -	help
> -	  Support for Energy Micro's (now Silicon Labs) efm32 Giant Gecko
> -	  processors.
> -
>  config ARCH_EP93XX
>  	bool "EP93xx-based"
>  	select ARCH_HAS_HOLES_MEMORYMODEL
> @@ -778,6 +760,14 @@ menu "Multiple platform selection"
>  
>  comment "CPU Core family selection"
>  
> +config ARCH_MULTI_V7M
> +	bool "ARMv7-M based platforms (Cortex-M)"
> +	depends on !MMU && !(ARCH_MULTI_V4_V5 || ARCH_MULTI_V6_V7)
As ARCH_MULTI_V7M depends on !MMU already ...
> +	select CPU_V7M
> +	select ARM_NVIC
> +	select NO_DMA # for now
> +	select NO_IOPORT_MAP # for now
> +
>  config ARCH_MULTI_V4
>  	bool "ARMv4 based platforms (FA526)"
>  	depends on !ARCH_MULTI_V6_V7 && MMU
> @@ -834,6 +824,13 @@ config ARCH_VIRT
>  	select ARM_PSCI
>  	select HAVE_ARM_ARCH_TIMER
>  
> +config ARCH_EFM32
> +	bool "Energy Micro efm32" if ARCH_MULTI_V7M
> +	depends on !MMU
... you don't need to repeat it here.

Other than that you can have my Ack. I didn't test it though and must
have missed the changes mentioned in the commit log.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
