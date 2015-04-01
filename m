From: mw@semihalf.com (Marcin Wojtas)
Date: Wed, 1 Apr 2015 11:02:47 +0200
Subject: [PATCH 0/5] Add standby support for the recent mvebu SoCs
In-Reply-To: <1427724278-12379-1-git-send-email-gregory.clement@free-electrons.com>
References: <1427724278-12379-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <CAPv3WKew5FFsA+ZphXO1hfYcy5hi_SzEBBhyk5QtQ5zn-SAenQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

When I run standby on A385 I get following error:
root at localhost:~# echo standby > /sys/power/state
[  122.889266] PM: System core suspend callback
mvebu_mbus_suspend+0x0/0xf4 failed.

Did you see this issue in your setup?

Best regards,
Marcin

2015-03-30 16:04 GMT+02:00 Gregory CLEMENT <gregory.clement@free-electrons.com>:
> Hi,
>
> Until now only one Armada XP based board supported suspend to
> ram. This suspend to ram mode was unusual because it involved shutting
> down the SoC and relied on a PIC to wake up the system.
>
> However, most of the recent mvebu SoCs can support the standby
> mode. Unlike for the suspend to ram, nothing special have to be done
> for these SoCs. In this mode the SoCs go in idle mode (but they remain
> powered up) and the devices enter in suspend mode. The support itself
> was added in the patch 2.
>
> In order to wake-up the interrupt controller driver have been
> updated. As in standby mode the interrupt controller is not shutdown,
> any interrupt can be a wake-up source. So the MPIC (patch 4) and the
> GIC (patch 3) now used the flags IRQCHIP_SKIP_SET_WAKE and
> IRQCHIP_MASK_ON_SUSPEND.
>
> A wake up source is supposed to work in suspend _and_ in standby mode
> but for the mvebu SoCs, no interrupt can wake up the system. The last
> patch warns the user about it.
>
> The first patch is a clean-up found while working on this series
>
> All the patch are independents either for building or for running.
>
> Thanks,
>
> Gregory
>
>
> Gregory CLEMENT (5):
>   ARM: mvebu: Use __init for the PM initialization functions
>   ARM: mvebu: Add standby support
>   ARM: mvebu: Allow using the GIC for wakeup in standby mode
>   irqchip: armada-370-xp: Allow using wakeup source
>   ARM: mvebu: Warn about the wake-ups sources not taken into account in
>     suspend
>
>  arch/arm/mach-mvebu/board-v7.c      |  7 +++++
>  arch/arm/mach-mvebu/common.h        |  5 ++--
>  arch/arm/mach-mvebu/pm-board.c      | 15 ++++++----
>  arch/arm/mach-mvebu/pm.c            | 57 ++++++++++++++++++++++++++++++++-----
>  drivers/irqchip/irq-armada-370-xp.c |  1 +
>  5 files changed, 70 insertions(+), 15 deletions(-)
>
> --
> 2.1.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
