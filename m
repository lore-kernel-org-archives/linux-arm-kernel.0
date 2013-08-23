From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 23 Aug 2013 08:53:05 +0200
Subject: [PATCH 00/12] CPU idle for Armada XP
Message-ID: <1377240797-4047-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch set adds the CPU idle support for Armada XP and prepares
the support for Armada 370. This was based on the work of Nadav
Haklai.

Most of the patches modify the mvebu code in order to prepare the
support for CPU idle, hence the patches 2 to 10 should go to mvebu
subsystem (and then arm-soc).

The first patch should go through ARM subsystem and should be taken
by Russell King.

The 11th patch 'cpuidle: mvebu: Add initial cpu idle support for
Armada 370/XP SoC' is the only one who should go to the cpuidle
subsystem. But of course I would like that Daniel Lezcano or Rafael
J. Wysocki have a look on the whole series.

The last patch should also go to mvebu subsystem (and then arm-soc)
but with an Acked-by from on of the device tree maintainer.

The whole series is also available in the branch CPU-idle-ArmadaXP at
https://github.com/MISL-EBU-System-SW/mainline-public.git

Thanks,

Gregory CLEMENT (12):
  ARM: PJ4B: Add cpu_suspend/cpu_resume hooks for PJ4B
  ARM: mvebu: ll_set_cpu_coherent no more uses the coherency address as
    parameter
  ARM: mvebu: ll_set_cpu_coherent always uses the current CPU
  ARM: mvebu: Remove the unused argument of set_cpu_coherent()
  ARM: mvebu: Makes ll_set_cpu_coherent() more configurable
  ARM: mvebu: Low level functions to disbale cache snooping
  ARM: mvebu: Add a new set of registers for pmsu
  ARM: mvebu: Allow to power down L2 cache controller in idle mode
  ARM: mvebu: Add the PMSU related part of the cpu idle functions
  ARM: mvebu: Set the start address of a CPU in a separate function
  cpuidle: mvebu: Add initial cpu idle support for Armada 370/XP SoC
  ARM: dts: mvebu: Add a new set of registers to the PMSU node

 .../devicetree/bindings/arm/armada-370-xp-pmsu.txt |  12 +-
 arch/arm/boot/dts/armada-xp.dtsi                   |   2 +-
 arch/arm/mach-mvebu/coherency.c                    |  12 +-
 arch/arm/mach-mvebu/coherency.h                    |   2 +-
 arch/arm/mach-mvebu/coherency_ll.S                 |  69 +++++++++--
 arch/arm/mach-mvebu/headsmp.S                      |  15 +--
 arch/arm/mach-mvebu/platsmp.c                      |   2 +-
 arch/arm/mach-mvebu/pmsu.c                         |  99 +++++++++++++++-
 arch/arm/mm/proc-v7.S                              |  64 +++++++++-
 drivers/cpuidle/Kconfig                            |   6 +
 drivers/cpuidle/Makefile                           |   1 +
 drivers/cpuidle/cpuidle-armada-370-xp.c            | 132 +++++++++++++++++++++
 drivers/cpuidle/suspend-armada-370-xp.S            |  91 ++++++++++++++
 include/linux/armada-370-xp-pmsu.h                 |  19 +++
 14 files changed, 484 insertions(+), 42 deletions(-)
 create mode 100644 drivers/cpuidle/cpuidle-armada-370-xp.c
 create mode 100644 drivers/cpuidle/suspend-armada-370-xp.S
 create mode 100644 include/linux/armada-370-xp-pmsu.h

-- 
1.8.1.2
