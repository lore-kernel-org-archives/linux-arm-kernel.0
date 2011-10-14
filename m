From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Oct 2011 18:29:48 +0200
Subject: [PATCH] ARM: mutually exclude ZBOOT_ROM and AUTO_ZRELADDR
In-Reply-To: <1318607945-6807-1-git-send-email-olof@lixom.net>
References: <20111014071500.GP21648@n2100.arm.linux.org.uk>
	<1318607945-6807-1-git-send-email-olof@lixom.net>
Message-ID: <201110141829.48634.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 October 2011, Olof Johansson wrote:
> This way platforms that want it can select AUTO_ZRELADDR without issues caused by
> someone manually also enabling ZBOOT_ROM.
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 82973b2..2ad58e8 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1814,6 +1814,7 @@ config ZBOOT_ROM_BSS
>  config ZBOOT_ROM
>  	bool "Compressed boot loader in ROM/flash"
>  	depends on ZBOOT_ROM_TEXT != ZBOOT_ROM_BSS
> +	depends on !AUTO_ZRELADDR
>  	help
>  	  Say Y here if you intend to execute your compressed kernel image
>  	  (zImage) directly from ROM or flash.  If unsure, say N.

Unfortunately, you cannot have it both ways:

arnd at ocdc-kvm:~/linux-arm$ make O=obj-tmp CROSS_COMPILE=arm-linux-gnueabi- ARCH=arm  -sj20  menuconfig
arch/arm/Kconfig:1761:error: recursive dependency detected!
arch/arm/Kconfig:1761:  symbol ZBOOT_ROM depends on AUTO_ZRELADDR
arch/arm/Kconfig:1899:  symbol AUTO_ZRELADDR depends on ZBOOT_ROM

	Arnd
