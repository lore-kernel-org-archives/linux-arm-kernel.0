From: avorontsov@mvista.com (Anton Vorontsov)
Date: Tue, 30 Nov 2010 20:16:26 +0300
Subject: [PATCH v4 0/8] SMP support for CNS3xxx + some SMP SCU cleanups
Message-ID: <20101130171626.GA6165@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

This is a reincarnation of my old series that was posted some time
ago, i.e. http://www.spinics.net/lists/arm-kernel/msg94291.html

The main change is that boot protocol routines were split into
its own file, i.e. smp_scu_boot.c. And now there are all platforms
converted to the common SCU routines (where possible).

Russell suggested to get rid of the holding pen thing, I believe
this is doable, but for now I don't want to change code behaviour.
Just consolidate it as much as possible.

For convenience, the patches are available in GIT repository (based
on Russell's devel tree):

  git://git.infradead.org/users/cbou/linux-cns3xxx.git smp

Diffstat looks quite good, I think. Especially, considering that
the series contains SMP addition for a platform, :-)

 arch/arm/Kconfig                                   |    2 +-
 arch/arm/include/asm/smp_scu.h                     |    9 +
 arch/arm/kernel/Makefile                           |    2 +-
 arch/arm/kernel/smp_scu_boot.c                     |  149 ++++++++++++++++++
 .../headsmp.S => kernel/smp_scu_head.S}            |   11 +-
 arch/arm/mach-cns3xxx/Kconfig                      |    1 +
 arch/arm/mach-cns3xxx/Makefile                     |    1 +
 arch/arm/mach-cns3xxx/include/mach/smp.h           |   28 ++++
 arch/arm/mach-cns3xxx/platsmp.c                    |   69 +++++++++
 arch/arm/mach-omap2/omap-smp.c                     |   64 +--------
 arch/arm/mach-realview/Makefile                    |    2 +-
 arch/arm/mach-realview/hotplug.c                   |    5 +-
 arch/arm/mach-realview/platsmp.c                   |  161 ++------------------
 arch/arm/mach-s5pv310/Makefile                     |    2 +-
 arch/arm/mach-s5pv310/headsmp.S                    |   41 -----
 arch/arm/mach-s5pv310/hotplug.c                    |    5 +-
 arch/arm/mach-s5pv310/platsmp.c                    |  125 +---------------
 arch/arm/mach-tegra/platsmp.c                      |   36 +----
 arch/arm/mach-ux500/Makefile                       |    2 +-
 arch/arm/mach-ux500/headsmp.S                      |   38 -----
 arch/arm/mach-ux500/hotplug.c                      |    5 +-
 arch/arm/mach-ux500/include/mach/smp.h             |    3 -
 arch/arm/mach-ux500/platsmp.c                      |  115 +-------------
 arch/arm/mach-vexpress/Makefile                    |    2 +-
 arch/arm/mach-vexpress/headsmp.S                   |   39 -----
 arch/arm/mach-vexpress/platsmp.c                   |  150 ++-----------------
 26 files changed, 318 insertions(+), 749 deletions(-)
 create mode 100644 arch/arm/kernel/smp_scu_boot.c
 rename arch/arm/{mach-realview/headsmp.S => kernel/smp_scu_head.S} (81%)
 create mode 100644 arch/arm/mach-cns3xxx/include/mach/smp.h
 create mode 100644 arch/arm/mach-cns3xxx/platsmp.c
 delete mode 100644 arch/arm/mach-s5pv310/headsmp.S
 delete mode 100644 arch/arm/mach-ux500/headsmp.S
 delete mode 100644 arch/arm/mach-vexpress/headsmp.S
