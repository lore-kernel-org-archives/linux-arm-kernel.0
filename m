From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Mar 2018 13:43:59 +0100
Subject: [PATCH 2/2] ARM: npcm: drop extraneous 'select' statements
In-Reply-To: <CAP6Zq1hzDCRUHJMnnh96u3YOmg_7s6UeqUu=UrK3ynL9s+VX5A@mail.gmail.com>
References: <20180307162430.2664523-1-arnd@arndb.de>
 <20180307162430.2664523-2-arnd@arndb.de>
 <CAP6Zq1ikUJ9jTLbR6ehdRLjkQHxzFa2VSdXN1G2ocMw9RyhGjg@mail.gmail.com>
 <CAP6Zq1hzDCRUHJMnnh96u3YOmg_7s6UeqUu=UrK3ynL9s+VX5A@mail.gmail.com>
Message-ID: <CAK8P3a2xCkSjtFFmwCPKmPzwxLKmjEYrEwVv7YukA-3viYjMVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2018 at 12:43 PM, Tomer Maimon <tmaimon77@gmail.com> wrote:
> Before entering the long mail (sorry about it) just a technical thing
> I think we should add ARM_GIC configuration, It is not implied in ARCH_MULTI_V7.

Yes, you are right.

> Now for the real story :-)
>
> The NPCM7xx is a family of BMC's that include NPCM750, NPCM730 and more
>
> All of the NPCM7xx BMC's have the same basic modules like Cortex-A9,
> WDT, timers, etc - must included shared modules, and there are a
> optional modules that can be added (for example the USB is not in
> NPCM730)
> so the additional optional modules give us the differences between the
> NPCM7xx BMC's
>
> I will like to use the same method that SPEAR using
> (arch/arm/mach-spear/Kconfig)
>
> can we reflacte the NPCM7xx as follow in the Kconfig:
>
> menuconfig ARCH_NPCM
>         bool "Nuvoton NPCM Architecture"
>         depends on ARCH_MULTI_V7
>         select USE_OF
>         select PINCTRL

selecting pinctrl is fine, USE_OF is implied.

> if ARCH_NPCM
>
> config ARCH_NPCM7XX
>         bool "Support for NPCM7xx BMC (Poleg)"
>         depends on ARCH_MULTI_V7
>         select CACHE_L2X0
>         select PINCTRL_NPCM7XX
>         select NPCM7XX_TIMER
>         select ARCH_REQUIRE_GPIOLIB
>         select ARM_GIC
>         select ARM_ERRATA_720789
>         select ARM_ERRATA_754322
>         select ARM_ERRATA_794072
>         select PL310_ERRATA_588369
>         select PL310_ERRATA_727915
>         select MFD_SYSCON
>         help
>           General support for NPCM7xx BMC (Poleg).
>
>           Nuvoton NPCM7xx BMC based on the Cortex A9.

This seems fine.

> config ARCH_NPCM750_NPCM730
>         bool "NPCM750 or NPCM730 BMC support with Device Tree"
>         select HAVE_ARM_TWD if SMP
>         select HAVE_ARM_SCU if SMP
>          select ARM_ERRATA_764369 if SMP
>         help
>           General support for NPCM750 or NPCM730 BMC (Poleg).
>
>           Nuvoton NPCM750 or NPCM730 BMC based on the Cortex A9.
>
> or even better include it in ARCH_NPCM7XX and remove the ARCH_NPCM750
> and ARCH_NPCM730?

Yes, I think that would be best.

> Regarding another matter, defconfig file:
> We would like to consult how to describe the various chips (e.g.
> NPCM750, NPCM730) in the defconfig file.
> One option is to include all modules (as included in NPCM750 chip,
> which is a superset chip) and all the chips.
> The we call it npcm7xx_defconfig (same as spear13xx_deconfig) .
> In this option customers of NPCM730 will need to manually undef
> non-existing modules.
>
> Another option is to create different defconfig files for each chip of
> this NPCM7xx family, e.g. npcm750_defconfig and npcm730_defconfig.
>
> Which approach should be adopt ? We will appreciate your advise.

We don't want one defconfig per chip. Some platform maintainers
don't have any defconfig for their platforms at all, but simply rely
on multi_v7_defconfig for testing, which is fine as well. If you have
an extra defconfig file, make sure to always update both your
own file and the multi_v7_defconfig together when you add a new
driver that should be enabled.

For multi_v7_defconfig, make all non-essential drivers loadable
modules.

        Arnd
