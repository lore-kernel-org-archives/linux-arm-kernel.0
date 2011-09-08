From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  8 Sep 2011 18:00:09 +0100
Subject: [RFC PATCH 0/3] Per SoC descriptor
Message-ID: <1315501212-1820-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is my first stab at an idea that has floated around for a while,
which is to have a per-soc descriptor containing most of the SoC
specific operations, which should clear the path a bit more towards
the single zImage holy grail. It's as far as possible from being
perfect, but I thought I'd share it as early as possible and see what
people think of it.

This first patch series introduces the arm_soc_desc structure, adds
per-soc SMP and CPU hotplug operations, and converts both RealView and
VExpress to this new scheme.

There's a number of things I'm happy with yet in that patch series:
- the per-soc descriptor init is ugly
- all descriptors are kept around forever

I plan to address those in the future (if this patch series has any!).

It's been tested on VExpress (A5 and A15) and RealView EB-11MP.

Marc Zyngier (3):
  ARM: SoC: Introduce per SoC descriptor
  ARM: SoC: Add per SoC SMP and CPU hotplug operations
  ARM: SoC: convert VExpress/RealView to SoC descriptor

 arch/arm/include/asm/mach/arch.h               |    2 +
 arch/arm/include/asm/soc.h                     |   38 +++++++++++++++++++
 arch/arm/kernel/setup.c                        |    5 ++
 arch/arm/kernel/smp.c                          |   48 ++++++++++++++++++++++++
 arch/arm/mach-realview/core.c                  |   19 +++++++++
 arch/arm/mach-realview/core.h                  |    9 ++++
 arch/arm/mach-realview/hotplug.c               |    6 +-
 arch/arm/mach-realview/platsmp.c               |    4 +-
 arch/arm/mach-realview/realview_eb.c           |    1 +
 arch/arm/mach-realview/realview_pb1176.c       |    1 +
 arch/arm/mach-realview/realview_pb11mp.c       |    1 +
 arch/arm/mach-realview/realview_pba8.c         |    1 +
 arch/arm/mach-realview/realview_pbx.c          |    1 +
 arch/arm/mach-vexpress/core.h                  |    6 +++
 arch/arm/mach-vexpress/hotplug.c               |    6 +-
 arch/arm/mach-vexpress/platsmp.c               |    4 +-
 arch/arm/mach-vexpress/v2m.c                   |   20 ++++++++++
 arch/arm/plat-versatile/include/plat/platsmp.h |   13 ++++++
 arch/arm/plat-versatile/platsmp.c              |    4 +-
 19 files changed, 177 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/include/asm/soc.h
 create mode 100644 arch/arm/plat-versatile/include/plat/platsmp.h
