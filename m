From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue,  3 Apr 2018 15:29:13 +0200
Subject: [PATCH 0/7] sunxi: Add DT representation for the MBUS controller
Message-ID: <cover.54a07919b9d7fe8d7c90e9f4929648013e641cff.1522761929.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

We've had for quite some time to hack around in our drivers to take into
account the fact that our DMA accesses are not done through the parent
node, but through another bus with a different mapping than the CPU for the
RAM (0 instead of 0x40000000 for most SoCs).

After some discussion after the submission of a camera device suffering of
the same hacks, I've decided to put together a serie that introduce a
property called dma-parent that allows to express the DMA relationship
between a master and its bus, even if they are not direct parents in the DT.

Let me know what you think,
Maxime

Maxime Ripard (7):
  dt-bindings: Add a dma-parent property
  dt-bindings: bus: Add binding for the Allwinner MBUS controller
  of: address: Add parent pointer to the __of_translate_address args
  of: address: Add support for the dma-parent property
  drm/sun4i: Rely on dma-parent for our RAM offset
  clk: sunxi-ng: sun5i: Export the MBUS clock
  ARM: dts: sun5i: Add the MBUS controller

 Documentation/devicetree/bindings/sunxi-mbus.txt | 35 ++++++++++++++-
 Documentation/devicetree/booting-without-of.txt  | 10 ++++-
 arch/arm/boot/dts/sun5i.dtsi                     | 11 ++++-
 drivers/clk/sunxi-ng/ccu-sun5i.h                 |  4 +--
 drivers/gpu/drm/sun4i/sun4i_backend.c            | 28 ++++++++---
 drivers/of/address.c                             | 43 +++++++++++++----
 include/dt-bindings/clock/sun5i-ccu.h            |  2 +-
 7 files changed, 111 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sunxi-mbus.txt

base-commit: 4a3928c6f8a53fa1aed28ccba227742486e8ddcb
-- 
git-series 0.9.1
