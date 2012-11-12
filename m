From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 12 Nov 2012 21:49:35 +0100
Subject: [PATCH V2 0/5]  SMP support for Armada XP
In-Reply-To: <1351545108-18954-1-git-send-email-gregory.clement@free-electrons.com>
References: <1351545108-18954-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <50A160DF.7030305@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 10/29/2012 10:11 PM, Gregory CLEMENT wrote:
[...]

> Arnd, Olof, as this code is SoC specific will you be able to pull it
> through Jason tree? Or should I push the part added in
> arch/arm/mm/proc-v7.S to support PJ4B CPU through Russell tree?

Before sending a new series with the fixes related to Will comments, I
would like to know if I need to split the patches in order to send some
parts to Russell or if you (Arnd and Olof) will be able to take the whole
series (through Jason Cooper's git tree of course).

> 
> Changelog:
> V1 -> V2:
> - Rebased on to v3.7-rc3
> - Fixed typos found by Alexandre Belloni
> - Added clk_prepare_enable() before getting rate clk in
>   set_secondary_cpus_clock()
> - Add explanation in the binding documentation about the per-CPU
>   interrupt registers: the address of the virtual register must be
>   used.
> - Removed the armada_xp prefix in the coherency.c file to be more
>   compliant with the name convention of the other files.
> - Coherency_init is now called from armada_370_xp_dt_init() and is no
>   more an early_init() call. As the device tree is not available from
>   an early_init(), it was useless to call coherency_init() so
>   early. The need to be able to call some function very early during
>   the boot were already resolved by using the hard code address of the
>   register.
> 
> Regards,
> 
> Yehuda Yitschak (5):
>   arm: mvebu: Added support for coherency fabric in mach-mvebu
>   arm: mvebu: Added initial support for power managmement service unit
>   arm: mvebu: Added IPI support via doorbells
>   arm: mm: Added support for PJ4B cpu and init routines
>   arm: mvebu: Added SMP support for Armada XP
> 
>  .../devicetree/bindings/arm/armada-370-xp-mpic.txt |   12 +-
>  .../devicetree/bindings/arm/armada-370-xp-pmsu.txt |   20 ++++
>  .../devicetree/bindings/arm/coherency-fabric.txt   |   16 +++
>  arch/arm/boot/dts/armada-370-xp.dtsi               |    5 +
>  arch/arm/boot/dts/armada-xp.dtsi                   |   12 +-
>  arch/arm/configs/mvebu_defconfig                   |    3 +
>  arch/arm/mach-mvebu/Kconfig                        |    3 +-
>  arch/arm/mach-mvebu/Makefile                       |    4 +-
>  arch/arm/mach-mvebu/armada-370-xp.c                |    3 +
>  arch/arm/mach-mvebu/armada-370-xp.h                |   10 ++
>  arch/arm/mach-mvebu/coherency.c                    |   89 ++++++++++++++
>  arch/arm/mach-mvebu/coherency.h                    |   21 ++++
>  arch/arm/mach-mvebu/common.h                       |    6 +
>  arch/arm/mach-mvebu/headsmp.S                      |   66 +++++++++++
>  arch/arm/mach-mvebu/hotplug.c                      |   30 +++++
>  arch/arm/mach-mvebu/irq-armada-370-xp.c            |   92 ++++++++++++++-
>  arch/arm/mach-mvebu/platsmp.c                      |  124 ++++++++++++++++++++
>  arch/arm/mach-mvebu/pmsu.c                         |   78 ++++++++++++
>  arch/arm/mach-mvebu/pmsu.h                         |   16 +++
>  arch/arm/mm/Kconfig                                |    4 +
>  arch/arm/mm/proc-v7.S                              |   46 ++++++++
>  21 files changed, 648 insertions(+), 12 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/coherency-fabric.txt
>  create mode 100644 arch/arm/mach-mvebu/coherency.c
>  create mode 100644 arch/arm/mach-mvebu/coherency.h
>  create mode 100644 arch/arm/mach-mvebu/headsmp.S
>  create mode 100644 arch/arm/mach-mvebu/hotplug.c
>  create mode 100644 arch/arm/mach-mvebu/platsmp.c
>  create mode 100644 arch/arm/mach-mvebu/pmsu.c
>  create mode 100644 arch/arm/mach-mvebu/pmsu.h
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
