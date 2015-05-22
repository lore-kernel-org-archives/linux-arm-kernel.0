From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 May 2015 09:53:51 +0200
Subject: [PATCH soc] ARM: use ARM_SINGLE_ARMV7M for ARMv7-M platforms
In-Reply-To: <1432161344-1930-1-git-send-email-stefan@agner.ch>
References: <1432161344-1930-1-git-send-email-stefan@agner.ch>
Message-ID: <3824169.vxchxyBt3o@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 May 2015 00:35:44 Stefan Agner wrote:
> Use the new config symbol ARM_SINGLE_ARMV7M which groups config
> symbols used by modern ARMv7-M platforms. This allows supporting
> multiple ARMv7-M platforms in one kernel image. However, a common
> kernel image requires the combined platforms to share the same
> main memory layout to be bootable.
> 
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Since this is essentially only a shift of config symbols, it
> should not change runtime behavior, at least when selecting
> only one platform.
> 
> Uwe, this is essentially the same I had in my patchset, just
> converting the other platforms too. I was bold and added your
> Ack anyway...
> 
> Joachim, Maxime, I test compiled with your defconfigs, compiled
> fine on my machine.
> 
>  arch/arm/Kconfig       | 86 ++++++++++++++++++--------------------------------
>  arch/arm/Kconfig.debug |  5 ++-
>  2 files changed, 32 insertions(+), 59 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 75920ed..9b777e3 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -334,6 +334,7 @@ config ARM_SINGLE_ARMV7M
>  	depends on !MMU
>  	select ARCH_WANT_OPTIONAL_GPIOLIB
>  	select ARM_NVIC
> +	select AUTO_ZRELADDR
>  	select CLKSRC_OF
>  	select COMMON_CLK
>  	select CPU_V7M

I just got a build failure for VF610 because of the lack of AUTO_ZRELADDR,
so this patch should fix that. Good.

>  menu "Multiple platform selection"
> @@ -1006,6 +951,35 @@ source "arch/arm/mach-zx/Kconfig"
>  
>  source "arch/arm/mach-zynq/Kconfig"
>  
> +# ARMv7-M architecture
> +config ARCH_EFM32
> +	bool "Energy Micro efm32"
> +	depends on ARM_SINGLE_ARMV7M
> +	select ARCH_REQUIRE_GPIOLIB
> +	help
> +	  Support for Energy Micro's (now Silicon Labs) efm32 Giant Gecko
> +	  processors.
> +
> +config ARCH_LPC18XX
> +	bool "NXP LPC18xx/LPC43xx"
> +	depends on ARM_SINGLE_ARMV7M
> +	select ARCH_HAS_RESET_CONTROLLER
> +	select ARM_AMBA
> +	select CLKSRC_LPC32XX
> +	select PINCTRL
> +	help
> +	  Support for NXP's LPC18xx Cortex-M3 and LPC43xx Cortex-M4
> +	  high performance microcontrollers.
> +
> +config ARCH_STM32
> +	bool "STMicrolectronics STM32"
> +	depends on ARM_SINGLE_ARMV7M
> +	select ARCH_HAS_RESET_CONTROLLER
> +	select ARMV7M_SYSTICK
> +	select RESET_CONTROLLER
> +	help
> +	  Support for STMicroelectronics STM32 processors.
> +

Should we move those options into the respective subdirectories,
for consistency with the other platforms?

The current top-level Kconfig file is much too large at the moment,
so that would reduce the clutter a bit, but then again, all three
of these currently don't need a Kconfig file for themselves, so
that might be a bit silly as well.

Another option might be to consolidate these three into a single
directory, if someone can come up with a good name. The machine
files are all trivial, so they could even be merged into one as
far as I can tell, we just need slightly different 'select'
statements above.

If we do that, is it possible to merge Vybrid into that as well?
I guess the main question here is how much other infrastructure
(if any) from mach-imx is used on vf610, and if there is some other
way to do that.

	Arnd
