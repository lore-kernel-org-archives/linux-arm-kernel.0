From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 31 May 2014 20:12:21 +0200
Subject: [PATCH RFC] ARM: clps711x: Partial multiplatform support
In-Reply-To: <1401559206-23767-1-git-send-email-shc_work@mail.ru>
References: <1401559206-23767-1-git-send-email-shc_work@mail.ru>
Message-ID: <13452733.Lg1kBhJLHP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 31 May 2014 22:00:06 Alexander Shiyan wrote:
> This patch provide initial partial multiplatform support for CLPS711X CPUs.
> Not intended for apply, just for comments at now.

It's great to see you are this close now!
 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 899afa4..aced2fb 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -385,15 +385,9 @@ config ARCH_AT91
>  	  This enables support for systems based on Atmel
>  	  AT91RM9200 and AT91SAM9* processors.
>  
> -config ARCH_CLPS711X
> +config CLPS711X_SINGLE
>  	bool "Cirrus Logic CLPS711x/EP721x/EP731x-based"
> -	select ARCH_REQUIRE_GPIOLIB
> -	select AUTO_ZRELADDR
> -	select CLKSRC_MMIO
> -	select COMMON_CLK
> -	select CPU_ARM720T
> -	select GENERIC_CLOCKEVENTS
> -	select MFD_SYSCON
> +	select ARCH_CLPS711X
>  	help
>  	  Support for Cirrus Logic 711x/721x/731x based boards.
>  
> diff --git a/arch/arm/mach-clps711x/Kconfig b/arch/arm/mach-clps711x/Kconfig
> index f711498..1802562 100644
> --- a/arch/arm/mach-clps711x/Kconfig
> +++ b/arch/arm/mach-clps711x/Kconfig
> @@ -1,15 +1,34 @@
> +config ARCH_CLPS711X
> +	bool
> +	depends on CLPS711X_SINGLE || CLPS711X_MULTI
> +	select ARCH_REQUIRE_GPIOLIB
> +	select AUTO_ZRELADDR
> +	select CLKSRC_MMIO
> +	select COMMON_CLK
> +	select CPU_ARM720T
> +	select GENERIC_CLOCKEVENTS
> +	select MFD_SYSCON
> +
> +config CLPS711X_MULTI
> +	bool "Cirrus Logic CLPS711X" if ARCH_MULTI_V4T
> +	select ARCH_CLPS711X
> +	help
> +	  Support for Cirrus Logic CLPS711X-based family of processors.

The split between single and multi is just intended to be temporary,
while the framebuffer driver is being sorted out, right?

In general, I'd be happier skipping that stage and going to multiplatform
for all of clps711x when it's ready, but we can also do it like this
if  there is a good reason and you have a clear schedule for when to
remove the _SINGLE part.

One technicality: this change breaks all defconfig files and user
.configs. You can avoid that if you keep the name ARCH_CLPS711X for
either the single- or the multiplatform case and name the common
option ARCH_CLPS711X_COMMON.

	Arnd
