From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 28 Oct 2014 17:08:38 +0100
Subject: [PATCH 0/6] ASoC/ARM: move Marvell Armada 370 DB to simple-audio-card
Message-ID: <1414512524-24466-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This set of patches moves the Marvell Armada 370 DB audio complex
description from a custom audio machine driver to the
simple-audio-card DT binding.

The first three patches are meant to go through the ASoC tree, the
last three patches are meant to go through the mvebu maintainers tree.

Quick description of the patches:

 - First patch fixes a small issue in the cs42l51 driver following its
   split in two parts.

 - Second patch makes the cs42l51 user-selectable by adding a prompt
   to its Kconfig option.

 - Third patch gets rid of the machine driver.

 - Fourth patch removes some now incorrect pin-muxing selection in the
   Armada 370 DB platform.

 - Fifth patch actually switches to use the simple-audio-card DT
   binding on Armada 370 DB.

 - Sixth patch updates mvebu_v7_defconfig to select the relevant
   options to get audio to work.

Note: obviously, after PATCH 3 is applied, the audio will no longer
work until PATCH 5 is applied. But since those patches will anyway go
through different trees, it is a bit inevitable. And it is not
dramatically important, since audio support on Armada 370 DB is
already broken since the split of the CS42L51 driver.

Thanks,

Thomas

Thomas Petazzoni (6):
  ASoC: cs42l51: re-add of_match_table pointer
  ASoC: cs42l51: make driver user-selectable
  ASoC: kirkwood: get rid of armada-370-db driver
  ARM: mvebu: remove conflicting muxing on Armada 370 DB
  ARM: mvebu: use simple-card DT binding for audio on Armada 370 DB
  ARM: mvebu: update mvebu_v7_defconfig for Armada 370 audio

 arch/arm/boot/dts/armada-370-db.dts |  80 +++++++++++--------
 arch/arm/boot/dts/armada-370.dtsi   |   1 +
 arch/arm/configs/mvebu_v7_defconfig |   4 +-
 sound/soc/codecs/Kconfig            |   2 +-
 sound/soc/codecs/cs42l51-i2c.c      |   7 ++
 sound/soc/codecs/cs42l51.c          |   5 --
 sound/soc/kirkwood/Kconfig          |  13 +---
 sound/soc/kirkwood/Makefile         |   4 -
 sound/soc/kirkwood/armada-370-db.c  | 148 ------------------------------------
 9 files changed, 63 insertions(+), 201 deletions(-)
 delete mode 100644 sound/soc/kirkwood/armada-370-db.c

-- 
2.0.0
