From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Jul 2014 09:28:39 +0200
Subject: [PATCH v8 02/11] power: reset: Add reboot driver for brcmstb
In-Reply-To: <1405976886-27807-3-git-send-email-computersforpeace@gmail.com>
References: <1405976886-27807-1-git-send-email-computersforpeace@gmail.com>
 <1405976886-27807-3-git-send-email-computersforpeace@gmail.com>
Message-ID: <62122849.RXJHvac7Iy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 July 2014 14:07:57 Brian Norris wrote:
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index 0073633e7699..9782e8d80647 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -94,6 +94,7 @@ config ARCH_BRCMSTB
>         select MIGHT_HAVE_PCI
>         select HAVE_SMP
>         select HAVE_ARM_ARCH_TIMER
> +       select POWER_RESET_BRCMSTB
>         help
>           Say Y if you intend to run the kernel on a Broadcom ARM-based STB
>           chipset.
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index bdcf5173e377..fcb9825debe5 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -20,6 +20,16 @@ config POWER_RESET_AXXIA
>  
>           Say Y if you have an Axxia family SoC.
>  
> +config POWER_RESET_BRCMSTB
> +       bool "Broadcom STB reset driver"
> +       depends on POWER_RESET && ARCH_BRCMSTB
> +       help
> +         This driver provides restart support for ARM-based Broadcom STB
> +         boards.
> +
> +         Say Y here if you have an ARM-based Broadcom STB board and you wish
> +         to have restart support.
> +
>  config POWER_RESET_GPIO
>         bool "GPIO power-off driver"
>         depends on OF_GPIO && POWER_RESET
> 

(nitpicking)

You shouldn't have both a user-selectable option and 'select' it from
the platform, because it makes it inherently not selectable, in particular
in the combination with 'depends on ARCH_BRCMSTB'.

One way to solve this would be to change the dependency to

config POWER_RESET_BRCMSTB
	bool "Broadcom STB reset driver"
	depends on POWER_RESET && ARM
	depends on ARCH_BRCMSTB || COMPILE_TEST

which in effect would allow building it on any ARM machine as long as
COMPILE_TEST is set (which normally is not).

The same could be expressed using

config POWER_RESET_BRCMSTB
	bool "Broadcom STB reset driver" if COMPILE_TEST
	depends on POWER_RESET && ARM

My preference in this case however would be to just drop the 'select'
statement and add the driver to the defconfig file.

	Arnd
