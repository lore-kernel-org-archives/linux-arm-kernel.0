From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 29 Oct 2012 22:11:43 +0100
Subject: [PATCH V2 0/5]  SMP support for Armada XP
Message-ID: <1351545108-18954-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The purpose of this patch set is to add the SMP support for the Armada
XP SoCs. Beside the SMP support itself brought by the last 3 patches,
this patch set also adds the support for the coherency fabric unit and
the power management service unit.

The coherency fabric is responsible for ensuring hardware coherency
between all CPUs and between CPUs and I/O masters. This unit is also
available for Armada 370 and will be used in an incoming patch set
for hardware I/O cache coherency.

The power management service unit is responsible for powering down and
waking up CPUs and other SOC units.

The original code is from Yehuda Yitschak, it was reworked by myself
and reviewed by Yehuda.

This patch set is based on 3.7-rc3 and depends one the framework clock
support (the last version was posted 2 weeks ago:
http://thread.gmane.org/gmane.linux.kernel/1375701). The git branch
called ArmadaXP-SMP-for-3.8-V2 is also available at
https://github.com/MISL-EBU-System-SW/mainline-public.git.

Arnd, Olof, as this code is SoC specific will you be able to pull it
through Jason tree? Or should I push the part added in
arch/arm/mm/proc-v7.S to support PJ4B CPU through Russell tree?

Changelog:
V1 -> V2:
- Rebased on to v3.7-rc3
- Fixed typos found by Alexandre Belloni
- Added clk_prepare_enable() before getting rate clk in
  set_secondary_cpus_clock()
- Add explanation in the binding documentation about the per-CPU
  interrupt registers: the address of the virtual register must be
  used.
- Removed the armada_xp prefix in the coherency.c file to be more
  compliant with the name convention of the other files.
- Coherency_init is now called from armada_370_xp_dt_init() and is no
  more an early_init() call. As the device tree is not available from
  an early_init(), it was useless to call coherency_init() so
  early. The need to be able to call some function very early during
  the boot were already resolved by using the hard code address of the
  register.

Regards,

Yehuda Yitschak (5):
  arm: mvebu: Added support for coherency fabric in mach-mvebu
  arm: mvebu: Added initial support for power managmement service unit
  arm: mvebu: Added IPI support via doorbells
  arm: mm: Added support for PJ4B cpu and init routines
  arm: mvebu: Added SMP support for Armada XP

 .../devicetree/bindings/arm/armada-370-xp-mpic.txt |   12 +-
 .../devicetree/bindings/arm/armada-370-xp-pmsu.txt |   20 ++++
 .../devicetree/bindings/arm/coherency-fabric.txt   |   16 +++
 arch/arm/boot/dts/armada-370-xp.dtsi               |    5 +
 arch/arm/boot/dts/armada-xp.dtsi                   |   12 +-
 arch/arm/configs/mvebu_defconfig                   |    3 +
 arch/arm/mach-mvebu/Kconfig                        |    3 +-
 arch/arm/mach-mvebu/Makefile                       |    4 +-
 arch/arm/mach-mvebu/armada-370-xp.c                |    3 +
 arch/arm/mach-mvebu/armada-370-xp.h                |   10 ++
 arch/arm/mach-mvebu/coherency.c                    |   89 ++++++++++++++
 arch/arm/mach-mvebu/coherency.h                    |   21 ++++
 arch/arm/mach-mvebu/common.h                       |    6 +
 arch/arm/mach-mvebu/headsmp.S                      |   66 +++++++++++
 arch/arm/mach-mvebu/hotplug.c                      |   30 +++++
 arch/arm/mach-mvebu/irq-armada-370-xp.c            |   92 ++++++++++++++-
 arch/arm/mach-mvebu/platsmp.c                      |  124 ++++++++++++++++++++
 arch/arm/mach-mvebu/pmsu.c                         |   78 ++++++++++++
 arch/arm/mach-mvebu/pmsu.h                         |   16 +++
 arch/arm/mm/Kconfig                                |    4 +
 arch/arm/mm/proc-v7.S                              |   46 ++++++++
 21 files changed, 648 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt
 create mode 100644 Documentation/devicetree/bindings/arm/coherency-fabric.txt
 create mode 100644 arch/arm/mach-mvebu/coherency.c
 create mode 100644 arch/arm/mach-mvebu/coherency.h
 create mode 100644 arch/arm/mach-mvebu/headsmp.S
 create mode 100644 arch/arm/mach-mvebu/hotplug.c
 create mode 100644 arch/arm/mach-mvebu/platsmp.c
 create mode 100644 arch/arm/mach-mvebu/pmsu.c
 create mode 100644 arch/arm/mach-mvebu/pmsu.h

-- 
1.7.9.5
