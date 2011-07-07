From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 7 Jul 2011 11:46:22 -0500
Subject: [PATCH 10/37] ARM: mach-ep93xx: remove mach/memory.h and
	Kconfig	selection of SDRAM bank
In-Reply-To: <1309923021-23487-10-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
	<1309923021-23487-10-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F383D6CEEA@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, July 05, 2011 8:30 PM, Nicolas Pitre wrote:
>
> This all can be selected automatically by default at run time.

How?  It would be nice if you mentioned that this patch makes ARCH_EP93XX
use ARM_PATCH_PHYS_VIRT.  It took a bit of digging for me to figure out
where PHYS_OFFSET was now getting set.

> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> ---
>  arch/arm/Kconfig                           |    2 +
>  arch/arm/mach-ep93xx/Kconfig               |   53 ----------------------------
>  arch/arm/mach-ep93xx/Makefile.boot         |   14 -------
>  arch/arm/mach-ep93xx/include/mach/memory.h |   22 -----------
>  4 files changed, 2 insertions(+), 89 deletions(-)
>  delete mode 100644 arch/arm/mach-ep93xx/include/mach/memory.h
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index c4b6e4a..48b2e88 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -371,6 +371,8 @@ config ARCH_EP93XX
>  	select ARCH_REQUIRE_GPIOLIB
>  	select ARCH_HAS_HOLES_MEMORYMODEL
>  	select ARCH_USES_GETTIMEOFFSET
> +	select NO_MACH_MEMORY_H
> +	select AUTO_ZRELADDR if !ZBOOT_ROM

I would like to see a:

+	select ARM_PATCH_PHYS_VIRT

here.  I realize that the select of NO_MACH_MEMORY_H will cause the selection
but it's a bit hidden.

[snip]

> diff --git a/arch/arm/mach-ep93xx/Makefile.boot b/arch/arm/mach-ep93xx/Makefile.boot
> index 0ad33f1..e69de29 100644
> --- a/arch/arm/mach-ep93xx/Makefile.boot
> +++ b/arch/arm/mach-ep93xx/Makefile.boot
> @@ -1,14 +0,0 @@
> -   zreladdr-$(CONFIG_EP93XX_SDCE3_SYNC_PHYS_OFFSET)	:= 0x00008000
> -params_phys-$(CONFIG_EP93XX_SDCE3_SYNC_PHYS_OFFSET)	:= 0x00000100
> -
> -   zreladdr-$(CONFIG_EP93XX_SDCE0_PHYS_OFFSET)		:= 0xc0008000
> -params_phys-$(CONFIG_EP93XX_SDCE0_PHYS_OFFSET)		:= 0xc0000100
> -
> -   zreladdr-$(CONFIG_EP93XX_SDCE1_PHYS_OFFSET)		:= 0xd0008000
> -params_phys-$(CONFIG_EP93XX_SDCE1_PHYS_OFFSET)		:= 0xd0000100
> -
> -   zreladdr-$(CONFIG_EP93XX_SDCE2_PHYS_OFFSET)		:= 0xe0008000
> -params_phys-$(CONFIG_EP93XX_SDCE2_PHYS_OFFSET)		:= 0xe0000100
> -
> -   zreladdr-$(CONFIG_EP93XX_SDCE3_ASYNC_PHYS_OFFSET)	:= 0xf0008000
> -params_phys-$(CONFIG_EP93XX_SDCE3_ASYNC_PHYS_OFFSET)	:= 0xf0000100

Is Makefile.boot still needed for anything?

Other than those comments.  I have boot tested this on a couple ep93xx
boards and everything looks fine.

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

BTW, scripts/get_maintainer.pl is you friend... It would have been nice to
be CC'ed for the ep93xx specific parts of you patches.  I just happened to
notice them in my inbox yesterday...

Regards,
Hartley
