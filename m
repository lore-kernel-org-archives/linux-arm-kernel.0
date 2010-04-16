From: r.herring@freescale.com (Rob Herring)
Date: Fri, 16 Apr 2010 14:35:14 -0500
Subject: [RFC PATCH 0/10] Initial MX53 support
Message-ID: <1271446524-26450-1-git-send-email-r.herring@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

This patch series adds support for the i.MX53 chip. MX53 is a derivative of MX51
with a few new features.

A major change from MX51 is the support for 2GB of RAM. This has resulted in all the
peripheral addresses changing. Fortunately the AIPS and SPBA buses are just
shifted down by 0x20000000, but the module offsets within the buses are the same
as MX51. Rather than create new defines of every peripheral register base, I
fix-up the addresses at runtime for MX53. I am interested in comments on this
approach.

With the runtime physoffset patches, both MX51 and MX53 can boot with a single
image.

Regards,
Rob

Rob Herring (10):
      mx51: convert static mappings in clock code
      mx51: convert AIPS bus setup to ioremap
      mx51: convert iomux and wdog to ioremap
      mx51: remove unused static mappings
      mx51: change MX51 specific config from ARCH_MX5 to ARCH_MX51
      mx5: rename mx51_map_io to mx5_map_io
      mx5: rename clock-mx51.c to clock.c
      imx: Add MX53 core support
      mx5: determine cpu type at runtime
      mx5: Add MX53 EVK board support

 arch/arm/mach-mx5/Kconfig                    |   14 +-
 arch/arm/mach-mx5/Makefile                   |    3 +-
 arch/arm/mach-mx5/Makefile.boot              |    9 +-
 arch/arm/mach-mx5/board-mx51_babbage.c       |    2 +-
 arch/arm/mach-mx5/board-mx53_evk.c           |   88 +++
 arch/arm/mach-mx5/clock-mx51.c               |  826 ------------------------
 arch/arm/mach-mx5/clock.c                    |  879 ++++++++++++++++++++++++++
 arch/arm/mach-mx5/cpu.c                      |   29 +-
 arch/arm/mach-mx5/crm_regs.h                 |  100 ---
 arch/arm/mach-mx5/mm.c                       |   47 +-
 arch/arm/plat-mxc/devices.c                  |   13 +
 arch/arm/plat-mxc/include/mach/common.h      |    6 +-
 arch/arm/plat-mxc/include/mach/debug-macro.S |   11 +-
 arch/arm/plat-mxc/include/mach/iomux-mx53.h  |   47 ++
 arch/arm/plat-mxc/include/mach/irqs.h        |    4 +-
 arch/arm/plat-mxc/include/mach/memory.h      |    5 +-
 arch/arm/plat-mxc/include/mach/mx51.h        |   44 +-
 arch/arm/plat-mxc/include/mach/mxc.h         |   15 +-
 18 files changed, 1149 insertions(+), 993 deletions(-)
