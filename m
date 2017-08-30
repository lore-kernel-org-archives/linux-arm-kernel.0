From: stefan.bruens@rwth-aachen.de (=?UTF-8?q?Stefan=20Br=C3=BCns?=)
Date: Thu, 31 Aug 2017 01:36:06 +0200
Subject: [PATCH 0/3] dmaengine: Fix DMA on current allwinner SoCs,
 add A64 support
Message-ID: <20170830233609.13855-1-stefan.bruens@rwth-aachen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The latest generation of allwinner SoCs (e.g. H3, H5, A64) have some significant
differences to older SoC generations (e.g. A23):

- different register location for the clock autogating register (offset 0x28 vs 0x20)
- different field offset for the src/dest burst length fields in the channel
  configuration register
- additional burst lengths and widths

This is the second change to the implementation of the DMA controller (first change
being the addition of the clock autogating register in the A23). To differentiate
between the different generations, the patch adds an enum value to the OF config
data.

The A83t uses the same register layout as the A23, so this series also fixes the missing
clock gating setting for the A83t.

The A64 is register compatible to the H3, but supports less channels and has a different
set of endpoints. Add a new compatible string to the device tree and the driver.

Stefan Br?ns (3):
  dmaengine: sun6i: Correct DMA support on H3
  arm64: allwinner: a64: Add device node for DMA controller
  dmaengine: sun6i: Add support for Allwinner A64

 .../devicetree/bindings/dma/sun6i-dma.txt          |   1 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      |  13 ++
 drivers/dma/sun6i-dma.c                            | 135 +++++++++++++++------
 3 files changed, 109 insertions(+), 40 deletions(-)

-- 
2.14.1
