From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 Aug 2013 11:59:07 +0100
Subject: [PATCH] mach-ks8695/Kconfig: Make MACH_KS8695 depends on PCI
In-Reply-To: <1375693624-21548-1-git-send-email-manjunath.goudar@linaro.org>
References: <1375693624-21548-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <20130805105907.GT23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 05, 2013 at 02:37:04PM +0530, Manjunath Goudar wrote:
> From: root <root@si-cspbld63.lge.net>
> 
> This patch adds a Kconfig dependency on MACH_KS8695,MACH_CM* or MACH_IM*
> being available before PCI can be enabled. Without this patch,build system
> can lead to issues. This was discovered during randconfig testing,
> without PCI if any one of MACH_KS8695,MACH_CM* or MACH_IM* being enabled,
> leading to the following error:
> 
> LD      init/built-in.o
> arch/arm/mach-ks8695/built-in.o: In function `og_register_pci':
> arch/arm/mach-ks8695/board-og.c:47:undefined reference to `ks8695_init_pci'
> make: *** [vmlinux] Error 1

This looks wrong.

> diff --git a/arch/arm/mach-ks8695/Kconfig b/arch/arm/mach-ks8695/Kconfig
> index a545976..29d7d9f 100644
> --- a/arch/arm/mach-ks8695/Kconfig
> +++ b/arch/arm/mach-ks8695/Kconfig
> @@ -5,6 +5,7 @@ menu "Kendin/Micrel KS8695 Implementations"
>  config MACH_KS8695
>  	bool "KS8695 development board"
>  	select MIGHT_HAVE_PCI
> +	depends on PCI

So, to be able to select PCI, MIGHT_HAVE_PCI needs to be enabled.  That's
selected by enabling MACH_KS8695, but now you make MACH_KS8695 depend on
PCI.  That sounds to me like a circular dependency.
