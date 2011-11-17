From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Nov 2011 15:36:24 +0000
Subject: [PATCH 4/5] ARM: vexpress: Initial RS1 memory map support
In-Reply-To: <1321036026-23411-5-git-send-email-pawel.moll@arm.com>
References: <1321036026-23411-1-git-send-email-pawel.moll@arm.com>
 <1321036026-23411-5-git-send-email-pawel.moll@arm.com>
Message-ID: <20111117153624.GR9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2011 at 06:27:05PM +0000, Pawel Moll wrote:
> diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
> index 4c11e90..d1b0f35 100644
> --- a/arch/arm/mach-vexpress/Kconfig
> +++ b/arch/arm/mach-vexpress/Kconfig
> @@ -1,6 +1,14 @@
>  menu "Versatile Express platform type"
>  	depends on ARCH_VEXPRESS
>  
> +config ARCH_VEXPRESS_LEGACY
> +	bool
> +	select AUTO_ZRELADDR
> +	select ARM_PATCH_PHYS_VIRT
> +
> +config ARCH_VEXPRESS_RS1
> +	bool
> +
>  config ARCH_VEXPRESS_CA9X4
>  	bool "Versatile Express Cortex-A9x4 tile"
>  	select CPU_V7
> @@ -8,6 +16,7 @@ config ARCH_VEXPRESS_CA9X4
>  	select ARM_ERRATA_720789
>  	select ARM_ERRATA_751472
>  	select ARM_ERRATA_753970
> +	select ARCH_VEXPRESS_LEGACY

This doesn't make sense.  Why should CA9x4 be forced to use the P2V stuff
and the AUTO_ZRELADDR stuff?  Hint: it works fine today without.

>  
>  config ARCH_VEXPRESS_DT
>  	bool
> diff --git a/arch/arm/mach-vexpress/Makefile.boot b/arch/arm/mach-vexpress/Makefile.boot
> index 8630b3d..3278615 100644
> --- a/arch/arm/mach-vexpress/Makefile.boot
> +++ b/arch/arm/mach-vexpress/Makefile.boot
> @@ -1,3 +1,3 @@
> -   zreladdr-y	+= 0x60008000
> -params_phys-y	:= 0x60000100
> -initrd_phys-y	:= 0x60800000
> +   zreladdr-y	+= 0x80008000
> +params_phys-y	:= 0x80000100
> +initrd_phys-y	:= 0x80800000

So is this the reason - you don't want to turn this into a config, so you
want to force all the automatic zreladdr stuff on?  You do know that this
will probably cause uboot to load the uImage at 0x80008000 instead of
0x60008000, and therefore we'll lose half the RAM on this board?
