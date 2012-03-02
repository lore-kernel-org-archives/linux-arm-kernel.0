From: robherring2@gmail.com (Rob Herring)
Date: Thu,  1 Mar 2012 21:13:12 -0600
Subject: [PATCH v3 00/30] mach/io.h cleanup and removal
Message-ID: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

The last version got bounced from lists with too many CC's, so I've cut
back the CC lists.

This series removes mach/io.h from all but a few platforms. The major change
from the last version is the addition of fixed PCI I/O mapping and coverting
most PCI platforms over. I don't have any platforms with PCI to test on, so
I need people to test. Dove and Kirkwood with 2 buses in particular need
testing.

Changes from last version:
- use pfn rather than phys addr as some platforms have >32-bit addresses
- move pci_map_io (now pci_map_io_pfn) into bios32.c
- omap and davinci mach/io.h fixes
- remove Tegra MMIO_BASE define
- move ep93xx IO_MEM define
- fix some compile breaks

I'd like to merge the first 19 patches for 3.4. The PCI changes need time
to review and test, so they I don't think they will get sorted out in time.

These are the remaining io.h headers and reasons they are still needed:

Non-standard io accessors or mapping:
arch/arm/mach-ebsa110/include/mach/io.h
arch/arm/mach-rpc/include/mach/io.h
arch/arm/mach-s3c2410/include/mach/io.h
arch/arm/mach-ixp4xx/include/mach/io.h

Probably can be fixed, but needs more work on PCI mapping and resources:
arch/arm/mach-mv78xx0/include/mach/io.h
arch/arm/mach-iop32x/include/mach/io.h
arch/arm/mach-iop33x/include/mach/io.h

Propose removing the platform altogether:
arch/arm/mach-ixp2000/include/mach/io.h

See http://www.spinics.net/lists/arm-kernel/msg161977.html

Only needed for !CONFIG_MMU:
arch/arm/mach-footbridge/include/mach/io.h


This is based on at91 and omap io.h clean-up from these 2 trees queued for
3.4:
git://github.com/at91linux/linux-at91 at91-3.4-for_cleanup2
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap iomap

This series is available here:
git://sources.calxeda.com/kernel/linux.git io-cleanup

Rob

Arnd Bergmann (1):
  iop13xx: use more regular PCI I/O space handling

Rob Herring (28):
  usb: ohci-pxa27x: add explicit include of hardware.h
  ARM: provide runtime hook for ioremap/iounmap
  ARM: imx: convert to common runtime ioremap hook
  ARM: msm: use runtime ioremap hook
  ARM: msm: clean-up mach/io.h
  ARM: iop13xx: use runtime ioremap hook
  ARM: iop13xx: move io.h externs to pci.h
  [media] davinci: remove includes of mach/io.h
  ARM: davinci: remove unneeded mach/io.h include
  ARM: orion5x: clean-up mach/io.h
  ARM: tegra: clean-up mach/io.h
  ARM: ep93xx: clean-up mach/io.h
  ARM: at91: add explicit include of hardware.h to uncompressor
  ARM: dove: add explicit include of dove.h to addr-map.c
  ARM: clps711x: remove unneeded include of mach/io.h
  ARM: make mach/io.h include optional
  ARM: remove bunch of now unused mach/io.h files
  ARM: kill off __mem_pci
  ARM: Add fixed PCI i/o mapping
  ARM: tegra: use fixed PCI i/o mapping
  ARM: integrator: use fixed PCI i/o mapping
  ARM: shark: use fixed PCI i/o mapping
  ARM: footbridge: use fixed PCI i/o mapping
  ARM: dove: use fixed PCI i/o mapping
  ARM: kirkwood: use fixed PCI i/o mapping
  ARM: ixp23xx: use fixed PCI i/o mapping
  ARM: iop13xx: use fixed PCI i/o mapping
  ARM: orion5x: use fixed PCI i/o mapping

Tony Lindgren (1):
  ARM: OMAP: Remove remaining includes for mach/io.h

 arch/arm/Kconfig                                   |   12 +++
 arch/arm/include/asm/io.h                          |   62 +++++++------
 arch/arm/include/asm/mach/pci.h                    |   18 ++++
 arch/arm/kernel/bios32.c                           |   23 +++++
 arch/arm/mach-at91/include/mach/io.h               |   31 -------
 arch/arm/mach-at91/include/mach/uncompress.h       |    1 +
 arch/arm/mach-bcmring/include/mach/io.h            |   33 -------
 arch/arm/mach-clps711x/include/mach/io.h           |   36 --------
 arch/arm/mach-clps711x/include/mach/uncompress.h   |    1 -
 arch/arm/mach-cns3xxx/include/mach/io.h            |   17 ----
 arch/arm/mach-davinci/include/mach/entry-macro.S   |    1 -
 arch/arm/mach-davinci/include/mach/io.h            |   24 -----
 arch/arm/mach-dove/addr-map.c                      |    1 +
 arch/arm/mach-dove/common.c                        |   15 +--
 arch/arm/mach-dove/include/mach/dove.h             |    8 +-
 arch/arm/mach-dove/include/mach/io.h               |   20 ----
 arch/arm/mach-dove/pcie.c                          |    9 +--
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h    |    9 ++
 arch/arm/mach-ep93xx/include/mach/io.h             |   22 -----
 arch/arm/mach-exynos/include/mach/io.h             |   26 ------
 arch/arm/mach-footbridge/common.c                  |   12 +--
 .../arm/mach-footbridge/include/mach/debug-macro.S |    3 +-
 arch/arm/mach-footbridge/include/mach/io.h         |   25 +-----
 arch/arm/mach-gemini/include/mach/io.h             |   18 ----
 arch/arm/mach-h720x/include/mach/io.h              |   22 -----
 arch/arm/mach-highbank/include/mach/io.h           |    7 --
 arch/arm/mach-imx/mm-imx3.c                        |    4 +-
 arch/arm/mach-integrator/include/mach/io.h         |   34 -------
 arch/arm/mach-integrator/include/mach/platform.h   |    4 +
 arch/arm/mach-integrator/integrator_ap.c           |   11 +--
 arch/arm/mach-iop13xx/include/mach/io.h            |   41 ---------
 arch/arm/mach-iop13xx/include/mach/iop13xx.h       |   15 +---
 arch/arm/mach-iop13xx/io.c                         |   37 ++------
 arch/arm/mach-iop13xx/iq81340mc.c                  |    1 +
 arch/arm/mach-iop13xx/iq81340sc.c                  |    1 +
 arch/arm/mach-iop13xx/pci.c                        |   12 ++--
 arch/arm/mach-iop13xx/pci.h                        |    6 ++
 arch/arm/mach-iop13xx/setup.c                      |   17 ++--
 arch/arm/mach-iop32x/include/mach/io.h             |    1 -
 arch/arm/mach-iop33x/include/mach/io.h             |    1 -
 arch/arm/mach-ixp2000/include/mach/io.h            |    1 -
 arch/arm/mach-ixp23xx/core.c                       |    7 +-
 arch/arm/mach-ixp23xx/include/mach/io.h            |   23 -----
 arch/arm/mach-ixp23xx/include/mach/ixp23xx.h       |   20 ++---
 arch/arm/mach-ixp23xx/pci.c                        |    2 +-
 arch/arm/mach-ixp4xx/include/mach/io.h             |    6 +-
 arch/arm/mach-kirkwood/common.c                    |   21 ++---
 arch/arm/mach-kirkwood/include/mach/io.h           |   26 ------
 arch/arm/mach-kirkwood/include/mach/kirkwood.h     |    8 +-
 arch/arm/mach-kirkwood/pcie.c                      |    8 +-
 arch/arm/mach-ks8695/include/mach/io.h             |   19 ----
 arch/arm/mach-lpc32xx/include/mach/io.h            |   27 ------
 arch/arm/mach-mmp/include/mach/io.h                |   21 -----
 arch/arm/mach-msm/board-halibut.c                  |    6 ++
 arch/arm/mach-msm/board-trout.c                    |    6 ++
 arch/arm/mach-msm/include/mach/io.h                |   36 --------
 arch/arm/mach-msm/include/mach/msm_iomap-7x00.h    |    6 ++
 arch/arm/mach-msm/include/mach/msm_iomap-7x30.h    |    4 +
 arch/arm/mach-msm/include/mach/msm_iomap-8960.h    |    4 +
 arch/arm/mach-msm/include/mach/msm_iomap-8x50.h    |    4 +
 arch/arm/mach-msm/include/mach/msm_iomap-8x60.h    |    4 +
 arch/arm/mach-msm/io.c                             |    1 -
 arch/arm/mach-mv78xx0/include/mach/io.h            |    2 -
 arch/arm/mach-mxs/include/mach/io.h                |   22 -----
 arch/arm/mach-netx/include/mach/io.h               |   28 ------
 arch/arm/mach-nomadik/include/mach/io.h            |   22 -----
 arch/arm/mach-omap1/include/mach/entry-macro.S     |    1 -
 arch/arm/mach-omap1/include/mach/io.h              |   46 ----------
 arch/arm/mach-omap1/sram.S                         |    1 -
 arch/arm/mach-omap2/include/mach/io.h              |   49 ----------
 arch/arm/mach-orion5x/common.c                     |   16 ++--
 arch/arm/mach-orion5x/common.h                     |    9 ++
 arch/arm/mach-orion5x/include/mach/io.h            |   33 -------
 arch/arm/mach-orion5x/pci.c                        |    1 +
 arch/arm/mach-orion5x/tsx09-common.c               |    1 +
 arch/arm/mach-picoxcell/include/mach/io.h          |   22 -----
 arch/arm/mach-pnx4008/include/mach/io.h            |   21 -----
 arch/arm/mach-prima2/include/mach/io.h             |   16 ----
 arch/arm/mach-pxa/include/mach/io.h                |   20 ----
 arch/arm/mach-realview/include/mach/io.h           |   28 ------
 arch/arm/mach-rpc/include/mach/io.h                |    5 -
 arch/arm/mach-s3c2410/include/mach/io.h            |    5 -
 arch/arm/mach-s3c64xx/include/mach/io.h            |   18 ----
 arch/arm/mach-s5p64x0/include/mach/io.h            |   25 -----
 arch/arm/mach-s5pc100/include/mach/io.h            |   18 ----
 arch/arm/mach-s5pv210/include/mach/io.h            |   26 ------
 arch/arm/mach-sa1100/include/mach/io.h             |   20 ----
 arch/arm/mach-shark/core.c                         |   14 +---
 arch/arm/mach-shark/include/mach/debug-macro.S     |    7 +-
 arch/arm/mach-shark/include/mach/entry-macro.S     |    3 +-
 arch/arm/mach-shark/include/mach/io.h              |   20 ----
 arch/arm/mach-shmobile/include/mach/io.h           |    9 --
 arch/arm/mach-spear3xx/include/mach/io.h           |   19 ----
 arch/arm/mach-spear6xx/include/mach/io.h           |   20 ----
 arch/arm/mach-tegra/include/mach/debug-macro.S     |    1 -
 arch/arm/mach-tegra/include/mach/io.h              |   95 --------------------
 arch/arm/mach-tegra/include/mach/iomap.h           |   51 +++++++++++
 arch/arm/mach-tegra/io.c                           |    3 +
 arch/arm/mach-tegra/pcie.c                         |   41 +--------
 arch/arm/mach-u300/include/mach/io.h               |   20 ----
 arch/arm/mach-ux500/include/mach/io.h              |   22 -----
 arch/arm/mach-versatile/include/mach/io.h          |   28 ------
 arch/arm/mach-vexpress/include/mach/io.h           |   26 ------
 arch/arm/mach-vt8500/include/mach/io.h             |   26 ------
 arch/arm/mach-w90x900/include/mach/io.h            |   30 ------
 arch/arm/mach-zynq/include/mach/io.h               |   33 -------
 arch/arm/mm/ioremap.c                              |    6 ++
 arch/arm/plat-mxc/include/mach/hardware.h          |    3 +
 arch/arm/plat-mxc/include/mach/io.h                |   39 --------
 arch/arm/plat-omap/include/plat/sdrc.h             |    1 -
 arch/arm/plat-spear/include/plat/io.h              |   22 -----
 drivers/media/video/davinci/vpbe_osd.c             |    1 -
 drivers/media/video/davinci/vpbe_venc.c            |    1 -
 drivers/usb/host/ohci-pxa27x.c                     |    1 +
 drivers/video/omap2/vrfb.c                         |    1 -
 115 files changed, 315 insertions(+), 1584 deletions(-)
 delete mode 100644 arch/arm/mach-at91/include/mach/io.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/io.h
 delete mode 100644 arch/arm/mach-clps711x/include/mach/io.h
 delete mode 100644 arch/arm/mach-cns3xxx/include/mach/io.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/io.h
 delete mode 100644 arch/arm/mach-dove/include/mach/io.h
 delete mode 100644 arch/arm/mach-ep93xx/include/mach/io.h
 delete mode 100644 arch/arm/mach-exynos/include/mach/io.h
 delete mode 100644 arch/arm/mach-gemini/include/mach/io.h
 delete mode 100644 arch/arm/mach-h720x/include/mach/io.h
 delete mode 100644 arch/arm/mach-highbank/include/mach/io.h
 delete mode 100644 arch/arm/mach-integrator/include/mach/io.h
 delete mode 100644 arch/arm/mach-iop13xx/include/mach/io.h
 create mode 100644 arch/arm/mach-iop13xx/pci.h
 delete mode 100644 arch/arm/mach-ixp23xx/include/mach/io.h
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/io.h
 delete mode 100644 arch/arm/mach-ks8695/include/mach/io.h
 delete mode 100644 arch/arm/mach-lpc32xx/include/mach/io.h
 delete mode 100644 arch/arm/mach-mmp/include/mach/io.h
 delete mode 100644 arch/arm/mach-msm/include/mach/io.h
 delete mode 100644 arch/arm/mach-mxs/include/mach/io.h
 delete mode 100644 arch/arm/mach-netx/include/mach/io.h
 delete mode 100644 arch/arm/mach-nomadik/include/mach/io.h
 delete mode 100644 arch/arm/mach-omap1/include/mach/io.h
 delete mode 100644 arch/arm/mach-omap2/include/mach/io.h
 delete mode 100644 arch/arm/mach-orion5x/include/mach/io.h
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/io.h
 delete mode 100644 arch/arm/mach-pnx4008/include/mach/io.h
 delete mode 100644 arch/arm/mach-prima2/include/mach/io.h
 delete mode 100644 arch/arm/mach-pxa/include/mach/io.h
 delete mode 100644 arch/arm/mach-realview/include/mach/io.h
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/io.h
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/io.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/io.h
 delete mode 100644 arch/arm/mach-s5pv210/include/mach/io.h
 delete mode 100644 arch/arm/mach-sa1100/include/mach/io.h
 delete mode 100644 arch/arm/mach-shark/include/mach/io.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/io.h
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/io.h
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/io.h
 delete mode 100644 arch/arm/mach-tegra/include/mach/io.h
 delete mode 100644 arch/arm/mach-u300/include/mach/io.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/io.h
 delete mode 100644 arch/arm/mach-versatile/include/mach/io.h
 delete mode 100644 arch/arm/mach-vexpress/include/mach/io.h
 delete mode 100644 arch/arm/mach-vt8500/include/mach/io.h
 delete mode 100644 arch/arm/mach-w90x900/include/mach/io.h
 delete mode 100644 arch/arm/mach-zynq/include/mach/io.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/io.h
 delete mode 100644 arch/arm/plat-spear/include/plat/io.h

-- 
1.7.5.4
