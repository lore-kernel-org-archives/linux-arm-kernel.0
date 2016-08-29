From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 29 Aug 2016 15:03:33 +0200
Subject: [PATCH v3 0/2] Embedding Position Independent Executables
Message-ID: <20160829130335.12089-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series introduces Position Independent Executables (PIEs) for the
ARM architecture.
The main goal is to avoid having to write low level code in assembly as
this is currently the case for suspend/resume. Multiple platforms will
benefit from this infrastructure: at91, rockchip, am335x.

Russell, do you see any remaining issues with the current approach?

Changes in v3:
 - rebased on v4.8-rc1

Changes in v2:
 - handle big endian
 - handle gcov and ftrace by disabling them before compilling the PIE
 - Get the alignment from the original ELF to ensure the PIE is
   properly aligned in SRAM.
 - stop using fncpy
 - rebased on v4.7-rc1


*** BLURB HERE ***

Alexandre Belloni (2):
  ARM: PIE infrastructure
  ARM: at91: pm: switch to the PIE infrastructure

 arch/arm/Kconfig                 |   2 +
 arch/arm/Makefile                |   1 +
 arch/arm/mach-at91/Kconfig       |   1 +
 arch/arm/mach-at91/Makefile      |   2 +-
 arch/arm/mach-at91/pm.c          |  31 ++--
 arch/arm/mach-at91/pm/.gitignore |   2 +
 arch/arm/mach-at91/pm/Makefile   |   3 +
 arch/arm/mach-at91/pm/atmel_pm.c |  97 +++++++++++
 arch/arm/mach-at91/pm_suspend.S  | 338 ---------------------------------------
 arch/arm/pie/Kconfig             |   8 +
 arch/arm/pie/Makefile            |   1 +
 arch/arm/pie/Makefile.pie        |  86 ++++++++++
 arch/arm/pie/lib/empty.c         |  15 ++
 arch/arm/pie/pie.c               |  97 +++++++++++
 arch/arm/pie/pie.lds.S           |  40 +++++
 include/linux/pie.h              | 146 +++++++++++++++++
 16 files changed, 510 insertions(+), 360 deletions(-)
 create mode 100644 arch/arm/mach-at91/pm/.gitignore
 create mode 100644 arch/arm/mach-at91/pm/Makefile
 create mode 100644 arch/arm/mach-at91/pm/atmel_pm.c
 delete mode 100644 arch/arm/mach-at91/pm_suspend.S
 create mode 100644 arch/arm/pie/Kconfig
 create mode 100644 arch/arm/pie/Makefile
 create mode 100644 arch/arm/pie/Makefile.pie
 create mode 100644 arch/arm/pie/lib/empty.c
 create mode 100644 arch/arm/pie/pie.c
 create mode 100644 arch/arm/pie/pie.lds.S
 create mode 100644 include/linux/pie.h

-- 
2.9.3
