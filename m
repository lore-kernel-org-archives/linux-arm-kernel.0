From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Apr 2015 20:59:05 +0200
Subject: [PATCH 7/9] ARM: Add Kconfig support for bcm2836.
In-Reply-To: <1429639796-2169-8-git-send-email-eric@anholt.net>
References: <1429639796-2169-1-git-send-email-eric@anholt.net>
 <1429639796-2169-8-git-send-email-eric@anholt.net>
Message-ID: <13864545.foFMzEn7Xk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 April 2015 11:09:54 Eric Anholt wrote:
> @@ -116,17 +122,19 @@ config ARCH_BCM283X
>  config ARCH_BCM2835
>         bool "Broadcom BCM2835 family" if ARCH_MULTI_V6
>         select ARCH_BCM283X
> -       select ARCH_REQUIRE_GPIOLIB
> -       select ARM_AMBA
>         select ARM_ERRATA_411920
>         select ARM_TIMER_SP804
> -       select CLKSRC_OF
> -       select PINCTRL
> -       select PINCTRL_BCM2835
>         help
>           This enables support for the Broadcom BCM2835 SoC. This SoC is
>           used in the Raspberry Pi and Roku 2 devices.
>  
> +config ARCH_BCM2836
> +       bool "Broadcom BCM2836 family" if ARCH_MULTI_V7
> +       select ARCH_BCM283X
> +       help
> +         This enables support for the Broadcom BCM2836 SoC. This SoC is
> +         used in the Raspberry Pi 2
> +

The description for the first one says "Broadcom BCM2835 family", and I
guess they are both in the same family. How about leaving the
CONFIG_BCM2835 symbol to mean one of them, and just duplicating the
DEBUG_LL symbols?

You could do something like

config ARCH_BCM2835
        bool "Broadcom BCM2835 family" if ARCH_MULTI_V6 || ARCH_MULTI_V7
        select ARCH_BCM283X
        select ARCH_REQUIRE_GPIOLIB
        select ARM_AMBA
        select ARM_ERRATA_411920 if ARCH_MULTI_V6
        select ARM_TIMER_SP804 if ARCH_MULTI_V6
        select CLKSRC_OF
        select PINCTRL
        select PINCTRL_BCM2835
        help
          This enables support for the Broadcom BCM2835 and BCM2836 SoCs.
	  These SoCs is used in the Raspberry Pi and Roku 2 devices.

That should make it less confusing to the user, because they don't have
to know which specific SoC they are building for, other than enabling
the right architecture level.

	Arnd
