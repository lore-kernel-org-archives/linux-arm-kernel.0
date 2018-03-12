From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Mar 2018 14:37:32 +0100
Subject: [PATCH 1/2] ARM: npcm: add CONFIG_ARCH_MULTI_V7 dependency
In-Reply-To: <CAP6Zq1jEAg2OrmnHzJdk9UBjPkDctu5oGHYyJ+QLBzN+E31sPw@mail.gmail.com>
References: <20180307162430.2664523-1-arnd@arndb.de>
 <CAFd5g45h3wAZtx-4oJb_uLbtDTzSsD6eLM5G0VF=3BBHNmW8YQ@mail.gmail.com>
 <CAP6Zq1jEAg2OrmnHzJdk9UBjPkDctu5oGHYyJ+QLBzN+E31sPw@mail.gmail.com>
Message-ID: <CAK8P3a2=0ZUqyhmKVa4u_VvOg4rtd6vUWdpRojfsoP3OSvGyeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2018 at 2:28 PM, Tomer Maimon <tmaimon77@gmail.com> wrote:
> Hi Brendan,
>
> According to the last mail I have with Arnd can you modify the Kconfig
> as follow:
>
> +menuconfig ARCH_NPCM
> +       bool "Nuvoton NPCM Architecture"
> +       depends on ARCH_MULTI_V7
> +       select PINCTRL
> +
> +if ARCH_NPCM
> +
> +config ARCH_NPCM7XX
> +       bool "Support for NPCM7xx BMC (Poleg)"
> +       depends on ARCH_MULTI_V7
> +       select PINCTRL_NPCM7XX
> +       select NPCM7XX_TIMER
> +       select ARCH_REQUIRE_GPIOLIB
> +       select CACHE_L2X0
> +       select ARM_GIC
> +       select HAVE_ARM_TWD if SMP
> +       select HAVE_ARM_SCU if SMP
> +       select ARM_ERRATA_764369 if SMP
> +       select ARM_ERRATA_720789
> +       select ARM_ERRATA_754322
> +       select ARM_ERRATA_794072
> +       select PL310_ERRATA_588369
> +       select PL310_ERRATA_727915
> +       select MFD_SYSCON
> +       help
> +         General support for NPCM7xx BMC (Poleg).
> +
> +         Nuvoton NPCM7xx BMC based on the Cortex A9.
> +
> +endif

One more change is needed to avoid a link error without CONFIG_SMP:

diff --git a/arch/arm/mach-npcm/Makefile b/arch/arm/mach-npcm/Makefile
index c7a1316d27c1..34d51f9f207c 100644
--- a/arch/arm/mach-npcm/Makefile
+++ b/arch/arm/mach-npcm/Makefile
@@ -1,3 +1,4 @@
 AFLAGS_headsmp.o               += -march=armv7-a

-obj-$(CONFIG_ARCH_NPCM750)     += npcm7xx.o platsmp.o headsmp.o
+obj-$(CONFIG_ARCH_NPCM750)     += npcm7xx.o
+obj-$(CONFIG_SMP)              += platsmp.o headsmp.o

Can one of you send me a pull request or the full patch series on top
of the version I have in arm-soc?

      Arnd
