From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 21 Nov 2011 15:15:14 -0500 (EST)
Subject: Git pull request: removal, and ioremap optimization
Message-ID: <alpine.LFD.2.02.1111211503250.17904@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, please pull the following:

	git://git.linaro.org/people/nico/linux vmalloc

This patch series removes all instances of mach/vmalloc.h in order to 
have a more unified memory map across all ARM architectures.  To do so, 
the static mappings are moved inside the vmalloc area.  And finally this 
allows for a generic optimization to ioremap where static mappings are 
reused whenever possible, using common code instead of having this 
duplicated in a couple places.

This series provides a net reduction of more than 1200 lines of code.

One regression was discovered on shmobile during testing because that 
platform asks for 158MB of consistent DMA memory while the documented 
maximum is 14MB.  Inspection of the code doesn't tell why this is 
required, and listed maintainers did not respond yet, more than two 
months after repeated inquiries.  So a temporary exception to the 
definition of VMALLOC_END was added for CONFIG_SHMOBILE, accompanied by 
a noisy warning to get those maintainers' attention.

This is based on v3.2-rc2 and was successfully tested on several 
platforms, including OMAP which was the platform that made me withdraw 
this pull request during the last cycle.

Nicolas Pitre (20):
      ARM: mach-dove: remove inclusion of <mach/vmalloc.h>
      ARM: mach-prima2: don't define SIRFSOC_VA in terms of VMALLOC_END
      ARM: plat-mxc: remove inclusion of <mach/vmalloc.h>
      ARM: mach-at91: remove arch specific special handling for ioremap
      ARM: mach-davinci: remove arch specific special handling for ioremap
      ARM: mach-tegra: remove arch specific special handling for ioremap
      ARM: plat-omap: remove arch specific special handling for ioremap
      ARM: mach-bcmring: use proper constant to identify DMA memory area
      ARM: mach-orion5x: remove arch specific special handling for ioremap
      ARM: mach-kirkwood: remove arch specific special handling for ioremap
      ARM: mach-ixp23xx: remove arch specific special handling for ioremap
      ARM: plat-iop: remove arch specific special handling for ioremap
      ARM: sort the meminfo array earlier
      ARM: move initialization of the high_memory variable earlier
      mm: add vm_area_add_early()
      ARM: move iotable mappings within the vmalloc region
      ARM: simplify __iounmap() when dealing with section based mapping
      ARM: add generic ioremap optimization by reusing static mappings
      ARM: big removal of now unused vmalloc.h files
      ARM: move VMALLOC_END down temporarily for shmobile

Rob Herring (3):
      ARM: versatile: remove overlapping map_desc entry
      ARM: realview: fix map_desc alignment
      ARM: realview-eb11mp: fix map_desc alignment

 Documentation/arm/memory.txt                    |   11 +-
 arch/arm/include/asm/pgtable.h                  |   13 +-
 arch/arm/kernel/setup.c                         |    8 +
 arch/arm/mach-at91/include/mach/io.h            |    8 -
 arch/arm/mach-at91/include/mach/vmalloc.h       |   28 ---
 arch/arm/mach-at91/setup.c                      |   18 --
 arch/arm/mach-bcmring/dma.c                     |    2 +-
 arch/arm/mach-bcmring/include/mach/vmalloc.h    |   25 ---
 arch/arm/mach-clps711x/include/mach/vmalloc.h   |   20 --
 arch/arm/mach-cns3xxx/include/mach/vmalloc.h    |   11 --
 arch/arm/mach-davinci/Makefile                  |    2 +-
 arch/arm/mach-davinci/include/mach/io.h         |    8 -
 arch/arm/mach-davinci/include/mach/vmalloc.h    |   14 --
 arch/arm/mach-davinci/io.c                      |   48 -----
 arch/arm/mach-dove/include/mach/dove.h          |    2 -
 arch/arm/mach-dove/include/mach/vmalloc.h       |    5 -
 arch/arm/mach-ebsa110/include/mach/vmalloc.h    |   10 -
 arch/arm/mach-ep93xx/include/mach/vmalloc.h     |    5 -
 arch/arm/mach-exynos/include/mach/vmalloc.h     |   22 ---
 arch/arm/mach-footbridge/include/mach/vmalloc.h |   10 -
 arch/arm/mach-gemini/include/mach/vmalloc.h     |   10 -
 arch/arm/mach-h720x/include/mach/vmalloc.h      |   10 -
 arch/arm/mach-highbank/include/mach/vmalloc.h   |    1 -
 arch/arm/mach-integrator/include/mach/vmalloc.h |   20 --
 arch/arm/mach-iop13xx/include/mach/vmalloc.h    |    4 -
 arch/arm/mach-iop32x/include/mach/io.h          |    7 -
 arch/arm/mach-iop32x/include/mach/vmalloc.h     |    5 -
 arch/arm/mach-iop33x/include/mach/io.h          |    7 -
 arch/arm/mach-iop33x/include/mach/vmalloc.h     |    5 -
 arch/arm/mach-ixp2000/include/mach/vmalloc.h    |   20 --
 arch/arm/mach-ixp23xx/include/mach/io.h         |   29 ---
 arch/arm/mach-ixp23xx/include/mach/vmalloc.h    |   10 -
 arch/arm/mach-ixp4xx/include/mach/vmalloc.h     |    5 -
 arch/arm/mach-kirkwood/include/mach/io.h        |   25 ---
 arch/arm/mach-kirkwood/include/mach/vmalloc.h   |    5 -
 arch/arm/mach-ks8695/include/mach/vmalloc.h     |   19 --
 arch/arm/mach-lpc32xx/include/mach/vmalloc.h    |   24 ---
 arch/arm/mach-mmp/include/mach/vmalloc.h        |    5 -
 arch/arm/mach-msm/include/mach/vmalloc.h        |   22 ---
 arch/arm/mach-mv78xx0/include/mach/vmalloc.h    |    5 -
 arch/arm/mach-mxs/include/mach/vmalloc.h        |   22 ---
 arch/arm/mach-netx/include/mach/vmalloc.h       |   19 --
 arch/arm/mach-nomadik/include/mach/vmalloc.h    |    2 -
 arch/arm/mach-omap1/include/mach/vmalloc.h      |   20 --
 arch/arm/mach-omap1/io.c                        |    1 -
 arch/arm/mach-omap2/include/mach/vmalloc.h      |   20 --
 arch/arm/mach-omap2/io.c                        |    1 -
 arch/arm/mach-orion5x/include/mach/io.h         |   25 ---
 arch/arm/mach-orion5x/include/mach/vmalloc.h    |    5 -
 arch/arm/mach-picoxcell/include/mach/vmalloc.h  |   14 --
 arch/arm/mach-pnx4008/include/mach/vmalloc.h    |   20 --
 arch/arm/mach-prima2/include/mach/map.h         |    6 +-
 arch/arm/mach-prima2/include/mach/vmalloc.h     |   16 --
 arch/arm/mach-pxa/include/mach/vmalloc.h        |   11 --
 arch/arm/mach-realview/include/mach/vmalloc.h   |   21 ---
 arch/arm/mach-realview/realview_eb.c            |    4 +-
 arch/arm/mach-realview/realview_pbx.c           |    4 +-
 arch/arm/mach-rpc/include/mach/vmalloc.h        |   10 -
 arch/arm/mach-s3c2410/include/mach/vmalloc.h    |   20 --
 arch/arm/mach-s3c64xx/include/mach/vmalloc.h    |   20 --
 arch/arm/mach-s5p64x0/include/mach/vmalloc.h    |   20 --
 arch/arm/mach-s5pc100/include/mach/vmalloc.h    |   17 --
 arch/arm/mach-s5pv210/include/mach/vmalloc.h    |   22 ---
 arch/arm/mach-sa1100/include/mach/vmalloc.h     |    4 -
 arch/arm/mach-shark/include/mach/vmalloc.h      |    4 -
 arch/arm/mach-shmobile/include/mach/vmalloc.h   |    7 -
 arch/arm/mach-spear3xx/include/mach/vmalloc.h   |   19 --
 arch/arm/mach-spear6xx/include/mach/vmalloc.h   |   19 --
 arch/arm/mach-tegra/include/mach/io.h           |    6 -
 arch/arm/mach-tegra/include/mach/vmalloc.h      |   28 ---
 arch/arm/mach-tegra/io.c                        |   21 ---
 arch/arm/mach-u300/include/mach/vmalloc.h       |   12 --
 arch/arm/mach-ux500/include/mach/vmalloc.h      |   18 --
 arch/arm/mach-versatile/core.c                  |    5 -
 arch/arm/mach-versatile/include/mach/vmalloc.h  |   21 ---
 arch/arm/mach-vexpress/include/mach/vmalloc.h   |   21 ---
 arch/arm/mach-vt8500/include/mach/vmalloc.h     |   20 --
 arch/arm/mach-w90x900/include/mach/vmalloc.h    |   23 ---
 arch/arm/mach-zynq/include/mach/vmalloc.h       |   20 --
 arch/arm/mm/init.c                              |   40 +----
 arch/arm/mm/ioremap.c                           |   82 ++++++---
 arch/arm/mm/mm.h                                |   14 ++
 arch/arm/mm/mmu.c                               |   50 ++++--
 arch/arm/mm/nommu.c                             |    2 +
 arch/arm/plat-iop/Makefile                      |    2 -
 arch/arm/plat-iop/io.c                          |   59 ------
 arch/arm/plat-mxc/include/mach/mx1.h            |    2 -
 arch/arm/plat-mxc/include/mach/vmalloc.h        |   22 ---
 arch/arm/plat-omap/Makefile                     |    2 +-
 arch/arm/plat-omap/common.c                     |    7 +
 arch/arm/plat-omap/include/plat/io.h            |    8 -
 arch/arm/plat-omap/io.c                         |  159 -----------------
 arch/arm/plat-spear/include/plat/vmalloc.h      |   19 --
 arch/arm/plat-tcc/include/mach/vmalloc.h        |   10 -
 include/linux/vmalloc.h                         |    1 +
 mm/vmalloc.c                                    |   29 +++-
 96 files changed, 177 insertions(+), 1407 deletions(-)
