From: ryder.lee@mediatek.com (Ryder Lee)
Date: Thu, 4 Jan 2018 15:44:02 +0800
Subject: [PATCH v1 0/6] add "simple-mfd" support for MediaTek audio subsystem
Message-ID: <cover.1515038387.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The reason for this series is that MediaTek audio hardware block expose more than
a single functionality, but register those in different kernel subsystems.
Same issue could also be found in MMSYS: https://lkml.org/lkml/2017/11/14/669

Hence use "simple-mfd" to handle this kind of situation, that will make sure all
children are registered - and we don't need to write an MFD driver specially.
It was tested on the bananapi-r2 and the MT2701/MT7622 EVB.

[1]~[3]: modify the current audio driver accordingly.
[5][6]: add clock driver for MT2701 and add missing data for MT7622.

changes since v1:
 - To avoid writing an MFD driver, we add "simple-mfd" in the audsys binding.
 - Move three top clocks to audio driver [1] as we remove mfd/mtk-audsys.c in v1.

Ryder Lee (6):
  ASoC: mediatek: add some core clocks for MT2701 AFE
  ASoC: mediatek: modify MT2701 AFE driver to adapt mfd device
  ASoC: mediatek: update MT2701 AFE documentation to adapt mfd device
  dt-bindings: clock: mediatek: add "simple-mfd" in audsys documentation
  clk: mediatek: update missing clock data for MT7622 audsys
  clk: mediatek: add audsys support for MT2701

 .../bindings/arm/mediatek/mediatek,audsys.txt      |  21 ++-
 .../devicetree/bindings/sound/mt2701-afe-pcm.txt   | 171 +++++++++++---------
 drivers/clk/mediatek/Kconfig                       |   6 +
 drivers/clk/mediatek/Makefile                      |   1 +
 drivers/clk/mediatek/clk-mt2701-aud.c              | 174 +++++++++++++++++++++
 drivers/clk/mediatek/clk-mt7622-aud.c              |   3 +-
 include/dt-bindings/clock/mt7622-clk.h             |   3 +-
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c  |  30 +++-
 sound/soc/mediatek/mt2701/mt2701-afe-common.h      |   3 +
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c         |  45 +++---
 sound/soc/mediatek/mt2701/mt2701-reg.h             |   1 -
 11 files changed, 345 insertions(+), 113 deletions(-)
 create mode 100644 drivers/clk/mediatek/clk-mt2701-aud.c

-- 
1.9.1
