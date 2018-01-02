From: ryder.lee@mediatek.com (Ryder Lee)
Date: Tue, 2 Jan 2018 19:47:09 +0800
Subject: [PATCH 00/12] mediatek: rework audio subsystem driver
Message-ID: <cover.1514881870.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch series mainly adds a common driver [5][6] for the top block of
the MediaTek audio subsystem, which includes clock part and audio components.
This is a minimal driver that manages shared resources like shared registers,
and expose a regmap to its sub-nodes. It was tested on the bananapi-r2 and
the MT2701 EVB.

Also, this driver can be reused by other subsystems (e.g. MMSYS, ETHSYS) in
future patch.

Patch[1]-[4]: rework for audio enable/disable sequences and update some part of
			  code to make them more generic.
Patch[7]~[12]: modify both drivers, audio and clock to adapt the new subsystem.

Ryder Lee (12):
  ASoC: mediatek: fix error handling in mt2701_afe_pcm_dev_probe()
  ASoC: mediatek: rework clock functions for MT2701
  ASoC: mediatek: cleanup audio driver for MT2701
  ASoC: mediatek: update clock related properties of MT2701 AFE
  mfd: mtk-audsys: add MediaTek audio subsystem driver
  mfd: add DT bindings for MedaiTek audio subsystem
  ASoC: mediatek: modify MT2701 AFE driver to adapt subsystem wrapper
  ASoC: mediatek: modify documentation to adapt subsystem wrapper
  clk: mediatek: move part of mtk_clk_register_gates() to the new
    function
  clk: mediatek: switch to use dev_get_regmap() for MT7622 audsys
  clk: mediatek: add audsys support for MT2701
  dt-bindings: clock: mediatek: update audsys bindings to adapt the
    wrapper

 .../bindings/arm/mediatek/mediatek,audsys.txt      |  19 +-
 .../devicetree/bindings/mfd/mtk-audsys.txt         | 109 +++++
 .../devicetree/bindings/sound/mt2701-afe-pcm.txt   | 257 +++++-----
 drivers/clk/mediatek/Kconfig                       |   6 +
 drivers/clk/mediatek/Makefile                      |   1 +
 drivers/clk/mediatek/clk-mt2701-aud.c              | 180 +++++++
 drivers/clk/mediatek/clk-mt7622-aud.c              |  11 +-
 drivers/clk/mediatek/clk-mtk.c                     |  26 +-
 drivers/clk/mediatek/clk-mtk.h                     |   4 +
 drivers/mfd/Kconfig                                |   9 +
 drivers/mfd/Makefile                               |   2 +
 drivers/mfd/mtk-audsys.c                           | 138 ++++++
 include/dt-bindings/clock/mt7622-clk.h             |   3 +-
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c  | 526 +++++++--------------
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h  |  15 +-
 sound/soc/mediatek/mt2701/mt2701-afe-common.h      |  84 +---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c         | 212 +++------
 sound/soc/mediatek/mt2701/mt2701-reg.h             |  42 +-
 18 files changed, 860 insertions(+), 784 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/mtk-audsys.txt
 create mode 100644 drivers/clk/mediatek/clk-mt2701-aud.c
 create mode 100644 drivers/mfd/mtk-audsys.c

-- 
1.9.1
