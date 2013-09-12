From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 12 Sep 2013 15:39:22 +0100
Subject: [PATCH 0/4] Add smp support for Allwinner A20 and phy arch
 count timer
In-Reply-To: <1378968687-8200-1-git-send-email-cinifr@gmail.com>
References: <1378968687-8200-1-git-send-email-cinifr@gmail.com>
Message-ID: <20130912143922.GC22013@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 12, 2013 at 07:51:23AM +0100, Fan Rong wrote:
> The patchs add smp support for Allwinner A20. It add cpuregister node
> in dts forsmp configure. The patchs also add a options for phy count
> timer to replace vir count timer as ARM arch timer clocksource. About
> ARM arch timer: 1. Current kernel use vir count timer, vir count timer
> can be accessed in any cpu mode for kernel, but it need bootloader set
> vir count offset rigister zero at first. 2. Phy count timer can be
> accessed in most cpu mode for kernel except NS-PL1 mode when register
> CNTHCTL.PL1PCTEN is set to zero. To ensure to use phy count timer,
> bootloader should set register CNTHCTL.PL1PCTEN is 1 at first. At all,
> to ensure kernel can use arch timer, bootload should set some generic
> timer register(cntvoff or cnthctl) at first. the kernel should select
> which count timer by reading current kernel running mode. 

Sorry, but I find the above text difficult to understand. It jumps
between several issues and isn't well formatted.

You seem to be suggesting a kernel change (using CNTPCT), but also
bootloader changes (setting CNTHCTL.PL1PCTEN) to make this possible at
all. If the bootloader needs to be modified, why can it not be modified
to set CNTVOFF (or to boot the kernel in Hyp where it can set it
itself)?

I'm not sure what you mean by selecting which timer to use be reading
the current running mode. We currently decide to use CNTVCT if booted in
PL1, or CNTPCT if booted in Hyp. I assume this isn't the mode you're
referring to?

Thanks,
Mark.

> 
> Fan Rong (4):
>   Add smp support for Allwinner A20(sunxi 7i).
>   Add cpuconfig nodes in dts for smp configure.
>   Add physical count arch timer support for clocksource in ARMv7.
>   Add arch count timer node in dts for Allwinner A20(sunxi 7i).
> 
>  arch/arm/boot/dts/sun7i-a20.dtsi     |   18 +-
>  arch/arm/include/asm/arch_timer.h    |   11 ++
>  arch/arm/mach-sunxi/Makefile         |    2 +
>  arch/arm/mach-sunxi/headsmp.S        |   12 ++
>  arch/arm/mach-sunxi/platform.h       |  346 ++++++++++++++++++++++++++++++++++
>  arch/arm/mach-sunxi/platsmp.c        |  166 ++++++++++++++++
>  arch/arm/mach-sunxi/sunxi.c          |    4 +
>  drivers/clocksource/Kconfig          |    8 +
>  drivers/clocksource/arm_arch_timer.c |   10 +-
>  9 files changed, 574 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/mach-sunxi/headsmp.S
>  create mode 100644 arch/arm/mach-sunxi/platform.h
>  create mode 100644 arch/arm/mach-sunxi/platsmp.c
> 
> -- 
> 1.7.9.5
> 
> 
