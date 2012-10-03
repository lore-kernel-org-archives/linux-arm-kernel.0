From: mporter@ti.com (Matt Porter)
Date: Wed,  3 Oct 2012 10:55:27 -0400
Subject: [PATCH v3 0/6] uio_pruss cleanup and platform support
Message-ID: <1349276133-26408-1-git-send-email-mporter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v2:
	- Dropped AM33xx/OMAP support from series.
	- Changed the DA850 L3 RAM gen_pool support to be based
	  on a previous Davinci SRAM series from Subhasish Ghosh
	  and Ben Gardiner.
	
Changes since v1:
	- Replaced uio_pruss private SRAM API use with genalloc
	- Added DA850 platform device and clock support
	- Added DA850 L3 RAM gen_pool support
	- Split out DT binding

This series enables uio_pruss on DA850 and removes use of the
private SRAM API by the driver. The driver previously was not
enabled by any platform and the private SRAM API was accessing
an invalid SRAM bank.

Ben Gardiner (2):
  ARM: davinci: sram: ioremap the davinci_soc_info specified sram
    regions
  ARM: davinci: da850-dm646x: remove the SRAM_VIRT iotable entry

Matt Porter (3):
  ARM: davinci: add platform hook to fetch the SRAM pool
  ARM: davinci: Add support for PRUSS on DA850
  uio: uio_pruss: replace private SRAM API with genalloc

Subhasish Ghosh (1):
  ARM: davinci: da850: changed SRAM allocator to shared ram.

 arch/arm/mach-davinci/board-da850-evm.c     |   12 +++++
 arch/arm/mach-davinci/da850.c               |   17 +++----
 arch/arm/mach-davinci/devices-da8xx.c       |   66 +++++++++++++++++++++++++++
 arch/arm/mach-davinci/dm355.c               |    6 ---
 arch/arm/mach-davinci/dm365.c               |    6 ---
 arch/arm/mach-davinci/dm644x.c              |    6 ---
 arch/arm/mach-davinci/dm646x.c              |    6 ---
 arch/arm/mach-davinci/include/mach/common.h |    2 -
 arch/arm/mach-davinci/include/mach/da8xx.h  |    3 ++
 arch/arm/mach-davinci/include/mach/sram.h   |    3 ++
 arch/arm/mach-davinci/sram.c                |   22 +++++++--
 drivers/uio/Kconfig                         |    1 +
 drivers/uio/uio_pruss.c                     |   24 +++++++---
 include/linux/platform_data/uio_pruss.h     |    3 +-
 14 files changed, 132 insertions(+), 45 deletions(-)

-- 
1.7.9.5
