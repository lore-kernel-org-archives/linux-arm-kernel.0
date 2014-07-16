From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 16 Jul 2014 12:15:56 +0200
Subject: [PATCH 18/19] ARM: SAMSUNG: Remove remaining legacy code
In-Reply-To: <1404496099-26708-19-git-send-email-t.figa@samsung.com>
References: <1404496099-26708-1-git-send-email-t.figa@samsung.com>
 <1404496099-26708-19-git-send-email-t.figa@samsung.com>
Message-ID: <1405505756.4408.24.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-07-04 at 19:48 +0200, Tomasz Figa wrote:
> After refactoring suspend/resume, which was last part with dependencies
> on legacy code, all Kconfig symbols related to Samsung ATAGS support can
> be deselected and more unused code removed. This includes most of s5p-*
> code as well, as s5pv210 was their last user.
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> ---

I noticed another thing now this patch showed up in next-20140716.

>  [...]
> diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
> index f8185b5..1091b0a 100644
> --- a/arch/arm/plat-samsung/Kconfig
> +++ b/arch/arm/plat-samsung/Kconfig
> @@ -6,29 +6,16 @@
>  
>  config PLAT_SAMSUNG
>  	bool
> -	depends on PLAT_S3C24XX || ARCH_S3C64XX || PLAT_S5P || ARCH_EXYNOS
> +	depends on PLAT_S3C24XX || ARCH_S3C64XX || ARCH_EXYNOS || ARCH_S5PV210
>  	default y
>  	select GENERIC_IRQ_CHIP
>  	select NO_IOPORT_MAP
>  	help
>  	  Base platform code for all Samsung SoC based systems
>  
> -config PLAT_S5P
> -	bool
> -	depends on ARCH_S5PV210
> -	default y
> -	select ARCH_REQUIRE_GPIOLIB
> -	select ARM_VIC
> -	select NO_IOPORT_MAP
> -	select PLAT_SAMSUNG
> -	select S3C_GPIO_TRACK
> -	select S5P_GPIO_DRVSTR
> -	help
> -	  Base platform code for Samsung's S5P series SoC.
> -

After this patch that symbol is still referenced in:
drivers/media/platform/Kconfig:159:     depends on VIDEO_DEV && VIDEO_V4L2 && (PLAT_S5P || ARCH_EXYNOS)
drivers/media/platform/Kconfig:169:     depends on VIDEO_DEV && VIDEO_V4L2 && (PLAT_S5P || ARCH_EXYNOS)
drivers/media/platform/Kconfig:177:     depends on VIDEO_DEV && VIDEO_V4L2 && (PLAT_S5P || ARCH_EXYNOS)
drivers/media/platform/exynos4-is/Kconfig:5:    depends on (PLAT_S5P || ARCH_EXYNOS)
drivers/media/platform/s5p-tv/Kconfig:11:       depends on (PLAT_S5P || ARCH_EXYNOS) && PM_RUNTIME
drivers/usb/host/Kconfig:223:       depends on PLAT_S5P || ARCH_EXYNOS
drivers/usb/host/Kconfig:530:   depends on PLAT_S5P || ARCH_EXYNOS

Again, I assume patches to remove these references are pending. But is
that correct?


Paul Bolle
