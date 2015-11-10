From: vigneshr@ti.com (Vignesh R)
Date: Tue, 10 Nov 2015 10:59:54 +0530
Subject: [PATCH v3 0/5] Add memory mapped read support for ti-qspi
Message-ID: <1447133399-25658-1-git-send-email-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Changes since v2:
Remove mmap_lock_mutex.
Optimize enable/disable of mmap mode.

Changes since v1:
Introduce API in SPI core that MTD flash driver can call for mmap read
instead of directly calling spi-master driver callback. This API makes
sure that SPI core msg queue is locked during mmap transfers.
v1: https://lkml.org/lkml/2015/9/4/103


Cover letter:

This patch series adds support for memory mapped read port of ti-qspi.
ti-qspi has a special memory mapped port through which SPI flash
memories can be accessed directly via SoC specific memory region.

First patch adds a method to pass flash specific information like read
opcode, dummy bytes etc and to request mmap read. Second patch
implements mmap read method in ti-qspi driver. Patch 3 adapts m25p80 to
use mmap read method before trying normal SPI transfer. Patch 4 and 5
add memory map region DT entries for DRA7xx and AM43xx SoCs.

This patch series is based on the discussions here:
http://www.spinics.net/lists/linux-spi/msg04796.html

Tested on DRA74 EVM and AM437x-SK.
Read performance increases from ~100kB/s to ~2.5MB/s.

Vignesh R (5):
  spi: introduce mmap read support for spi flash devices
  spi: spi-ti-qspi: add mmap mode read support
  mtd: devices: m25p80: add support for mmap read request
  ARM: dts: DRA7: add entry for qspi mmap region
  ARM: dts: AM4372: add entry for qspi mmap region

 Documentation/devicetree/bindings/spi/ti_qspi.txt | 19 ++++-
 arch/arm/boot/dts/am4372.dtsi                     |  4 +-
 arch/arm/boot/dts/dra7.dtsi                       |  7 +-
 drivers/mtd/devices/m25p80.c                      |  5 ++
 drivers/spi/spi-ti-qspi.c                         | 99 ++++++++++++++++++++++-
 drivers/spi/spi.c                                 | 34 ++++++++
 include/linux/spi/spi.h                           | 20 +++++
 7 files changed, 179 insertions(+), 9 deletions(-)

-- 
2.6.3
