From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 9 May 2014 10:27:17 -0400
Subject: [GIT PULL] ARM: mvebu: SoC changes for v3.16
Message-ID: <20140509142717.GM12708@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

guys,

Here's the bulk of the changes in mvebu-land this cycle.  A lot of new
capability for Armada 375/38x, and a sprinkle of stuff for the other
mvebu SoCs.  These changes have been in -next for almost two weeks, a
couple of bugs were discovered during this period and fixed.

As noted in the tag message, there is an external dependency on the
mvebu/irqchip branch already pulled by tglx.  If you'd like to keep a
copy locally you can pull:

DEP: git://git.infradead.org/linux-mvebu.git tags/irqchip-mvebu-3.16

(I'm hoping the 'DEP:' prevents your script for automagically pulling
the wrong branch ;-) )

I've included the changes to the cpuidle driver in here because they
depend on changes in mvebu/soc, and subsequent changes in mvebu/soc
depend on the changes to the cpuidle driver. Not ideal, but better than
complicated branch deps.

The same goes for the mvebu-bus driver, but there is no assigned
maintainer for drivers/bus, so we usually handle those ourselves.

Please pull.

thx,

Jason.

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-3.16

for you to fetch changes up to 9f0affcf3e21fc56d8bce625bb3d5800b7a7d284:

  ARM: mvebu: Fix pmsu compilation when ARMv6 is selected (2014-05-08 16:55:55 +0000)

----------------------------------------------------------------
mvebu SoC changes for v3.16

 - Armada 375/38x coherency support
 - Armada 375/38x SMP support
 - mvebu PMSU and CPU reset support
 - Armada 370/XP cpuidle support
 - kirkwood remove platform init of audio device
 - small fixes and cleanup for new SoC (375/38x)

Note:
 - due to complex deps, cpuidle changes Acked by appropriate maintainer for
   going though arm-soc tree.

Depends:
 - tags/irqchip-mvebu-3.16 in the mvebu/irqchip branch (tglx already pulled) for:

    d7df84b3ceca irqchip: irq-armada-370-xp: Use cpu notifier to initialize secondary CPUs
    ef37d337e1d3 irqchip: irq-armada-370-xp: Do the set_smp_cross_call() in the driver

----------------------------------------------------------------
Andrew Lunn (3):
      ARM: mvebu: Add a SOC bus device entry
      ARM: Kirkwood: Remove platform driver for codec
      ARM: Kirkwood: t5325: Remove platform device to instantiate audio

Ezequiel Garcia (2):
      ARM: mvebu: Select HAVE_ARM_TWD only if SMP is enabled
      ARM: mvebu: Add thermal quirk for the Armada 375 DB board

Gregory CLEMENT (17):
      ARM: mvebu: extend the PMSU registers
      ARM: mvebu: use a separate function to set the boot address of CPUs
      ARM: mvebu: add function to set the resume boot address for Armada 375
      ARM: mvebu: add SMP support for Armada 375 and Armada 38x
      ARM: mvebu: add workaround for SMP support for Armada 375 stepping Z1
      ARM: mvebu: remove the address parameter for ll_set_cpu_coherent
      ARM: mvebu: ll_set_cpu_coherent always uses the current CPU
      ARM: mvebu: Remove the unused argument of set_cpu_coherent()
      ARM: mvebu: Split low level functions to manipulate HW coherency
      ARM: mvebu: Low level function to disable HW coherency support
      ARM: mvebu: Allow to power down L2 cache controller in idle mode
      ARM: mvebu: Add the PMSU related part of the cpu idle functions
      ARM: mvebu: Register notifier callback for the cpuidle transition
      cpuidle: mvebu: Add initial CPU idle support for Armada 370/XP SoC
      ARM: mvebu: register the cpuidle driver for the Armada XP SoCs
      ARM: mvebu: remove unnecessary ifdef around l2x0_of_init
      ARM: mvebu: fix the name of the parameter used in mvebu_get_soc_id

Jason Cooper (2):
      Merge branch 'mvebu/soc-pmsu' into mvebu/soc
      Merge branch 'mvebu/irqchip' into mvebu/soc

Thomas Petazzoni (22):
      ARM: mvebu: prepare coherency code to support more SOCs
      ARM: mvebu: add a coherency_available() call
      bus: mvebu: pass the coherency availability information at init time
      ARM: mvebu: ARM: mvebu: use of_find_matching_node_and_match() in coherency.c
      ARM: mvebu: enable the ARM SCU on Armada 375 and Armada 38x
      ARM: mvebu: add Armada 375 support to the coherency code
      ARM: mvebu: implement Armada 375 coherency workaround
      ARM: mvebu: add Armada 38x support to the coherency code
      ARM: mvebu: introduce CPU reset code
      ARM: mvebu: start using the CPU reset driver
      ARM: mvebu: improve PMSU driver to request its resource
      ARM: mvebu: move Armada XP specific SMP initialization to platsmp.c
      ARM: mvebu: use CPU_METHOD_OF_DECLARE for SMP on Armada XP
      ARM: mvebu: add Armada 38x compatible string to pmsu
      ARM: mvebu: refine which files are build in mach-mvebu
      ARM: mvebu: fix thermal quirk SoC revision check
      ARM: mvebu: initialize mvebu-soc-id earlier
      ARM: mvebu: add Armada 375 A0 revision definition
      ARM: mvebu: conditionalize Armada 375 SMP workaround
      ARM: mvebu: conditionalize Armada 375 coherency workaround

Vincent Stehl? (1):
      ARM: mvebu: Fix pmsu compilation when ARMv6 is selected

 .../devicetree/bindings/arm/armada-370-xp-pmsu.txt |  19 +-
 .../devicetree/bindings/arm/armada-cpu-reset.txt   |  14 ++
 .../devicetree/bindings/arm/coherency-fabric.txt   |  32 ++-
 Documentation/devicetree/bindings/arm/cpus.txt     |   3 +
 arch/arm/mach-kirkwood/board-dt.c                  |   2 +-
 arch/arm/mach-mvebu/Kconfig                        |  14 +-
 arch/arm/mach-mvebu/Makefile                       |  13 +-
 arch/arm/mach-mvebu/armada-370-xp.h                |   2 -
 arch/arm/mach-mvebu/board-t5325.c                  |  41 ---
 arch/arm/mach-mvebu/board-v7.c                     |  82 +++++-
 arch/arm/mach-mvebu/board.h                        |   6 -
 arch/arm/mach-mvebu/coherency.c                    | 280 ++++++++++++++++++---
 arch/arm/mach-mvebu/coherency.h                    |   3 +-
 arch/arm/mach-mvebu/coherency_ll.S                 | 122 +++++++--
 arch/arm/mach-mvebu/common.h                       |   3 +
 arch/arm/mach-mvebu/cpu-reset.c                    | 103 ++++++++
 arch/arm/mach-mvebu/dove.c                         |   2 +-
 arch/arm/mach-mvebu/headsmp-a9.S                   |  34 +++
 arch/arm/mach-mvebu/headsmp.S                      |  15 +-
 arch/arm/mach-mvebu/kirkwood.c                     |   5 +-
 arch/arm/mach-mvebu/mvebu-soc-id.c                 |  32 ++-
 arch/arm/mach-mvebu/mvebu-soc-id.h                 |   4 +
 arch/arm/mach-mvebu/platsmp-a9.c                   | 102 ++++++++
 arch/arm/mach-mvebu/platsmp.c                      |  23 +-
 arch/arm/mach-mvebu/pmsu.c                         | 273 ++++++++++++++++++--
 arch/arm/mach-mvebu/system-controller.c            |  15 +-
 drivers/bus/mvebu-mbus.c                           |  11 +-
 drivers/cpuidle/Kconfig.arm                        |   5 +
 drivers/cpuidle/Makefile                           |   1 +
 drivers/cpuidle/cpuidle-armada-370-xp.c            |  93 +++++++
 include/linux/mbus.h                               |   2 +-
 33 files changed, 1178 insertions(+), 206 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/armada-cpu-reset.txt
 delete mode 100644 arch/arm/mach-mvebu/board-t5325.c
 create mode 100644 arch/arm/mach-mvebu/cpu-reset.c
 create mode 100644 arch/arm/mach-mvebu/headsmp-a9.S
 create mode 100644 arch/arm/mach-mvebu/platsmp-a9.c
 create mode 100644 drivers/cpuidle/cpuidle-armada-370-xp.c
