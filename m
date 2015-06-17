From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 17 Jun 2015 11:31:16 +0200
Subject: [PATCH 00/15] ARM: shmobile: Remove legacy sh73a0/kzm9g and
 r8a7740/armadillo
Message-ID: <1434533491-21979-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

The KZM-A9-GT and Armadillo-800 EVA boards are now sufficiently
supported by DT-based and board-less SH-Mobile AG5 (sh73a0) and R-Mobile
A1 (r8a7740) multi-platform kernels.

Lacking areas are:
  - USB (it does't work in legacy, neither),
  - HDMI on armadillo (it doesn't work in legacy, neither),
  - Camera on armadillo (we don't care),
  - LCDC:
      - on armadillo, this is supported by the board staging code,
      - on kzm9g, the LCDC is wired to the legacy INTC, which is not
	planned to be supported with DT,
  - DMAC/IPMMU (no DT bindings are planned).

Hence this patch series removes legacy board and SoC code for
sh73a0/kzm9g and r8a7740/armadillo.

It consists of 4 parts:
  - Patches 1-4 remove legacy support for kzm9g (board code, defconfig,
    dtb) and sh73a0,
  - Patches 5-8 remove legacy support for armadillo (board code,
    defconfig, dtb) and r8a7740,
  - Patches 9-11 remove generic shmobile support code (dma-register.h,
    legacy PM Domains, zboot) that became unused by the removal of
    legacy sh73a0/kzm9g and r8a7740/armadillo,
  - Patches 12-15 remove legacy sh73a0 and r8a7740 support in the
    pinctrl drivers.

Dependencies:
  - This is against next-20150617,
  - To keep up with existing LCDC functionality for armadillo-legacy,
    the r8a7740/armadillo part (and later parts) depends on "[PATCH v2
    0/7] staging: board: armadillo800eva: Board staging for
    sh_mobile_lcdc_fb" (https://lkml.org/lkml/2015/6/17/115).
    However, it can be applied as-is now, and board staging can he
    handled in parallel (if at all).

Thanks for applying!

Geert Uytterhoeven (15):
  ARM: shmobile: Remove legacy board code for KZM-A9-GT
  ARM: shmobile: Remove legacy kzm9g_defconfig
  ARM: shmobile: Drop sh73a0-kzm9g.dtb for legacy builds
  ARM: shmobile: Remove legacy SoC code for SH-Mobile AG5
  ARM: shmobile: Remove legacy board code for Armadillo-800 EVA
  ARM: shmobile: Remove legacy armadillo800eva_defconfig
  ARM: shmobile: Drop r8a7740-armadillo800eva.dtb for legacy builds
  ARM: shmobile: Remove legacy SoC code for R-Mobile A1
  ARM: shmobile: Remove unused dma-register.h
  ARM: shmobile: R-Mobile: Remove legacy PM Domain code
  ARM: shmobile: Remove obsolete zboot support
  pinctrl: sh-pfc: sh73a0: Remove obsolete multi-platform check
  pinctrl: sh-pfc: Remove obsolete sh73a0 platform_device_id entry
  pinctrl: sh-pfc: r8a7740: Remove obsolete multi-platform check
  pinctrl: sh-pfc: Remove obsolete r8a7740 platform_device_id entry

 MAINTAINERS                                        |    2 -
 arch/arm/boot/compressed/Makefile                  |    4 -
 arch/arm/boot/compressed/head-shmobile.S           |   71 -
 arch/arm/boot/dts/Makefile                         |    4 +-
 arch/arm/configs/armadillo800eva_defconfig         |  162 ---
 arch/arm/configs/kzm9g_defconfig                   |  154 ---
 arch/arm/mach-shmobile/Kconfig                     |   33 -
 arch/arm/mach-shmobile/Makefile                    |    8 +-
 arch/arm/mach-shmobile/Makefile.boot               |    2 -
 arch/arm/mach-shmobile/board-armadillo800eva.c     | 1365 --------------------
 arch/arm/mach-shmobile/board-kzm9g.c               |  916 -------------
 arch/arm/mach-shmobile/clock-r8a7740.c             |  675 ----------
 arch/arm/mach-shmobile/clock-sh73a0.c              |  752 -----------
 arch/arm/mach-shmobile/dma-register.h              |   84 --
 arch/arm/mach-shmobile/include/mach/head-kzm9g.txt |  410 ------
 arch/arm/mach-shmobile/include/mach/zboot.h        |   19 -
 arch/arm/mach-shmobile/include/mach/zboot_macros.h |  108 --
 arch/arm/mach-shmobile/intc-sh73a0.c               |  337 -----
 arch/arm/mach-shmobile/pm-r8a7740.c                |  129 --
 arch/arm/mach-shmobile/pm-rmobile.c                |   39 -
 arch/arm/mach-shmobile/pm-rmobile.h                |   24 -
 arch/arm/mach-shmobile/pm-sh73a0.c                 |   32 -
 arch/arm/mach-shmobile/r8a7740.h                   |   58 -
 arch/arm/mach-shmobile/setup-r8a7740.c             |  732 +----------
 arch/arm/mach-shmobile/setup-sh73a0.c              |  739 +----------
 arch/arm/mach-shmobile/sh73a0.h                    |   83 --
 arch/arm/mach-shmobile/smp-sh73a0.c                |    8 -
 drivers/pinctrl/sh-pfc/core.c                      |    6 -
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c               |    4 -
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c                |    4 -
 30 files changed, 7 insertions(+), 6957 deletions(-)
 delete mode 100644 arch/arm/boot/compressed/head-shmobile.S
 delete mode 100644 arch/arm/configs/armadillo800eva_defconfig
 delete mode 100644 arch/arm/configs/kzm9g_defconfig
 delete mode 100644 arch/arm/mach-shmobile/board-armadillo800eva.c
 delete mode 100644 arch/arm/mach-shmobile/board-kzm9g.c
 delete mode 100644 arch/arm/mach-shmobile/clock-r8a7740.c
 delete mode 100644 arch/arm/mach-shmobile/clock-sh73a0.c
 delete mode 100644 arch/arm/mach-shmobile/dma-register.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/head-kzm9g.txt
 delete mode 100644 arch/arm/mach-shmobile/include/mach/zboot.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/zboot_macros.h
 delete mode 100644 arch/arm/mach-shmobile/intc-sh73a0.c
 delete mode 100644 arch/arm/mach-shmobile/pm-r8a7740.c
 delete mode 100644 arch/arm/mach-shmobile/pm-sh73a0.c
 delete mode 100644 arch/arm/mach-shmobile/r8a7740.h

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
