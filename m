From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 22 Oct 2012 19:02:42 +0200
Subject: [PATCH 0/5] SMP support for Armada XP
Message-ID: <1350925368-24243-1-git-send-email-gregory.clement@free-electrons.com>
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

This patch set is based on 3.7-rc2 and depends one the framework clock
support (the last version was posted last week:
http://thread.gmane.org/gmane.linux.kernel/1375701). The git branch
called ArmadaXP-SMP-for-3.8 is also available at
https://github.com/MISL-EBU-System-SW/mainline-public.git.

Regards,

Yehuda Yitschak (5):
  arm: mvebu: Added support for coherency fabric in mach-mvebu
  arm: mvebu: Added initial support for power managmement service unit
  arm: mvebu: Added IPI support via doorbells
  arm: mm: Added support for PJ4B cpu and init routines
  arm: mvebu: Added SMP support for Armada XP

 .../devicetree/bindings/arm/armada-370-xp-pmsu.txt |   20 ++++
 .../devicetree/bindings/arm/coherency-fabric.txt   |   16 +++
 arch/arm/boot/dts/armada-370-xp.dtsi               |    5 +
 arch/arm/boot/dts/armada-xp.dtsi                   |   12 +-
 arch/arm/configs/mvebu_defconfig                   |    3 +
 arch/arm/mach-mvebu/Kconfig                        |    3 +-
 arch/arm/mach-mvebu/Makefile                       |    4 +-
 arch/arm/mach-mvebu/armada-370-xp.c                |    1 +
 arch/arm/mach-mvebu/armada-370-xp.h                |   10 ++
 arch/arm/mach-mvebu/coherency.c                    |   92 +++++++++++++++
 arch/arm/mach-mvebu/coherency.h                    |   20 ++++
 arch/arm/mach-mvebu/common.h                       |    6 +
 arch/arm/mach-mvebu/headsmp.S                      |   65 +++++++++++
 arch/arm/mach-mvebu/hotplug.c                      |   30 +++++
 arch/arm/mach-mvebu/irq-armada-370-xp.c            |   92 ++++++++++++++-
 arch/arm/mach-mvebu/platsmp.c                      |  123 ++++++++++++++++++++
 arch/arm/mach-mvebu/pmsu.c                         |   78 +++++++++++++
 arch/arm/mach-mvebu/pmsu.h                         |   16 +++
 arch/arm/mm/Kconfig                                |    4 +
 arch/arm/mm/proc-v7.S                              |   46 ++++++++
 20 files changed, 637 insertions(+), 9 deletions(-)
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
