From: garlic.tseng@mediatek.com (Garlic Tseng)
Date: Mon, 13 Jun 2016 15:26:37 +0800
Subject: [alsa-devel] [PATCH v4 0/9] ASoC: Mediatek: Add support for MT2701 SOC
Message-ID: <1465802806-19197-1-git-send-email-garlic.tseng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for submitting new version in a short time.
I find some comment style error and fix it.
please ignore v3 and directly review v4.

This patch adds basic support for Mediatek AFE for MT2701 SoC.
The patch is based on broonie tree "for-next" branch.

Change since v3:

* fix comments style.

Change since v2:

* fix comments style.
* replace EXPORT_SYMBOL with EXPORT_SYMBOL_GPL
* reduce debug message
* move mutex lock for irq-allocated to AFE struct
* remove func mtk_simple_isr and call snd_pcm_period_elapsed directly
* mt2701 driver probe will fail if clock initial error
* fix dapm on/off switch control naming

Change since v1:

implement common private structure, fe dai and platform driver.
let mt8173 and mt2701 use the common structure.


Garlic Tseng (9):
  ASoC: mediatek: Refine mt8173 driver and change config option
  ASoC: mediatek: implement mediatek common structure
  ASoC: mediatek: let mt8173 use mediatek common structure
  ASoC: mediatek: add documents for mt2701
  ASoC: mediatek: add structure define and clock control for 2701
  ASoC: mediatek: add mt2701 platform driver implementation.
  ASoC: bt-sco: extend rate and add a general compatible string
  ASoC: mediatek: add BT implementation
  ASoC: mediatek: Add mt2701-cs42448 driver and config option.

 Documentation/devicetree/bindings/sound/bt-sco.txt |    2 +-
 .../devicetree/bindings/sound/mt2701-afe-pcm.txt   |  150 ++
 .../devicetree/bindings/sound/mt2701-cs42448.txt   |   43 +
 sound/soc/codecs/bt-sco.c                          |    5 +-
 sound/soc/mediatek/Kconfig                         |   44 +-
 sound/soc/mediatek/Makefile                        |   11 +-
 sound/soc/mediatek/common/Makefile                 |   17 +
 sound/soc/mediatek/common/mtk-afe-fe-dai.c         |  379 +++++
 sound/soc/mediatek/common/mtk-afe-fe-dai.h         |   45 +
 .../soc/mediatek/common/mtk-afe-platform-driver.c  |   90 ++
 .../soc/mediatek/common/mtk-afe-platform-driver.h  |   23 +
 sound/soc/mediatek/common/mtk-base-afe.h           |  104 ++
 sound/soc/mediatek/mt2701/Makefile                 |   19 +
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c  |  464 ++++++
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h  |   38 +
 sound/soc/mediatek/mt2701/mt2701-afe-common.h      |  181 +++
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c         | 1698 ++++++++++++++++++++
 sound/soc/mediatek/mt2701/mt2701-cs42448.c         |  422 +++++
 sound/soc/mediatek/mt2701/mt2701-reg.h             |  186 +++
 sound/soc/mediatek/mt8173/Makefile                 |    7 +
 sound/soc/mediatek/mt8173/mt8173-afe-common.h      |   73 +
 .../{mtk-afe-pcm.c => mt8173/mt8173-afe-pcm.c}     |  921 +++++------
 sound/soc/mediatek/{ => mt8173}/mt8173-max98090.c  |    2 +-
 .../mediatek/{ => mt8173}/mt8173-rt5650-rt5514.c   |    2 +-
 .../mediatek/{ => mt8173}/mt8173-rt5650-rt5676.c   |    4 +-
 sound/soc/mediatek/{ => mt8173}/mt8173-rt5650.c    |    2 +-
 sound/soc/mediatek/mtk-afe-common.h                |  101 --
 27 files changed, 4399 insertions(+), 634 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mt2701-cs42448.txt
 create mode 100644 sound/soc/mediatek/common/Makefile
 create mode 100644 sound/soc/mediatek/common/mtk-afe-fe-dai.c
 create mode 100644 sound/soc/mediatek/common/mtk-afe-fe-dai.h
 create mode 100644 sound/soc/mediatek/common/mtk-afe-platform-driver.c
 create mode 100644 sound/soc/mediatek/common/mtk-afe-platform-driver.h
 create mode 100644 sound/soc/mediatek/common/mtk-base-afe.h
 create mode 100644 sound/soc/mediatek/mt2701/Makefile
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-afe-common.h
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-cs42448.c
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-reg.h
 create mode 100644 sound/soc/mediatek/mt8173/Makefile
 create mode 100644 sound/soc/mediatek/mt8173/mt8173-afe-common.h
 rename sound/soc/mediatek/{mtk-afe-pcm.c => mt8173/mt8173-afe-pcm.c} (51%)
 rename sound/soc/mediatek/{ => mt8173}/mt8173-max98090.c (99%)
 rename sound/soc/mediatek/{ => mt8173}/mt8173-rt5650-rt5514.c (99%)
 rename sound/soc/mediatek/{ => mt8173}/mt8173-rt5650-rt5676.c (99%)
 rename sound/soc/mediatek/{ => mt8173}/mt8173-rt5650.c (99%)
 delete mode 100644 sound/soc/mediatek/mtk-afe-common.h

-- 
1.9.1
