From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 14 Jun 2018 23:35:44 +0800
Subject: [PATCH v3 0/4] allwinner: a64: add SRAM controller / system control
Message-ID: <20180614153548.9644-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series is the remaining A64 syscon changes from the R40 DWMAC
series. The series aligns how the A64 system control exports a regmap
for the sun8i DWMAC driver to access with what we've done for the R40.

Originally the A64 used the generic syscon for this bit of hardware.
But this block also contains mapping bits for the onboard SRAM, used
by various peripherals, and other vendor specific bits we may use in
the future. It is by no means generic. And we already have a device
tree binding and driver for the SRAM part.

The first patch make the SRAM control device export a regmap, exposing
a single EMAC control register, for the DWMAC driver to consume.

The second and third patches rename the A64 compatible string to read
"system control", which is what the block is named in the user manual.

The last patch fixes up the device node, and also adds the lone mappable
SRAM block, which is needed by the Display Engine.

Changes since v2:

  - changed the compatible string from "*-sram-controller" to
    "*-system-control"


ChenYu

Chen-Yu Tsai (2):
  dt-bindings: sram: Rename A64 SRAM controller compatible
  soc: sunxi: sram: Add updated compatible string for A64 system control

Icenowy Zheng (2):
  soc: sunxi: export a regmap for EMAC clock reg on A64
  arm64: dts: allwinner: a64: add SRAM controller device tree node

 .../devicetree/bindings/sram/sunxi-sram.txt   |  3 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 19 +++++-
 drivers/soc/sunxi/sunxi_sram.c                | 61 ++++++++++++++++++-
 3 files changed, 78 insertions(+), 5 deletions(-)

-- 
2.17.1
