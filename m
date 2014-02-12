From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 12 Feb 2014 18:20:55 +0100
Subject: [PATCH v2 0/7] Audio support for Armada 370 DB
Message-ID: <1392225662-20431-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series of patches enable audio support on the Marvell Armada 370
Development Board. Since both the I2S controller on the SoC side and
the I2C audio codec are already supported by the kernel, the amount of
work is fairly limited.

Changes since v1:

 * Drop patches "sound: codec: add Device Tree binding to cs42l51" and
   " sound: soc: enable Kirkwood driver for mvebu platforms" since
   they have been applied by Mark Brown.

 * Set DAI format directly in the snd_soc_dai_link structure instead
   of separately calling snd_soc_dai_set_fmt(). Suggested by Mark
   Brown.

 * Do not call snd_soc_dapm_enable_pin(), as Mark Brown mentionned
   that DAPM widgets default to enabled. It allowed to entirely remove
   the dai_init operation.

 * Use devm_snd_soc_register_card() instead of
   snd_soc_register_card(), as suggested by Mark Brown.

 * Wrote a Device Tree binding document for the DT binding introduced
   by this driver. Requested by Mark Brown.

 * Use the DT to look up the controller and the codec, as suggested by
   Mark Brown.

 * Add S/PDIF support, which has been successfully tested. I've kept
   it as separate patches (for both the ASoC machine driver, and the
   Device Tree bits), so that it can be reviewed and applied
   separately.

 * Modified the commit title so that they contain "ASoC", as requested
   by Mark Brown.

Patches 1 and 2 are to be reviewed/applied by the ASoC maintainer Mark
Brown, while patches 3 to 7 are to be reviewed/applied by the ARM
mvebu maintainers.

Note that the audio support for Armada 370 also needs a fix to the
CS42L51, which is being discussed with the author of the change that
apparently introduced the problem (see discussion at
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-January/071916.html).

Thanks,

Thomas

Thomas Petazzoni (7):
  sound: ASoC: add ASoC board driver for Armada 370 DB
  sound: ASoC: add S/PDIF support to Armada 370 DB ASoC driver
  ARM: mvebu: add audio I2S controller to Armada 370 Device Tree
  ARM: mvebu: add I2C0 muxing option for Armada 370 SoC
  ARM: mvebu: add audio support to Armada 370 DB
  ARM: mvebu: enable S/PDIF audio in Armada 370 DB Device Tree
  ARM: mvebu: enable audio options in mvebu_defconfig

 .../bindings/sound/armada-370db-audio.txt          |  27 ++++
 arch/arm/boot/dts/armada-370-db.dts                |  56 ++++++++
 arch/arm/boot/dts/armada-370.dtsi                  |  28 ++++
 arch/arm/configs/mvebu_defconfig                   |   5 +
 sound/soc/kirkwood/Kconfig                         |   9 ++
 sound/soc/kirkwood/Makefile                        |   2 +
 sound/soc/kirkwood/armada-370-db.c                 | 148 +++++++++++++++++++++
 7 files changed, 275 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/armada-370db-audio.txt
 create mode 100644 sound/soc/kirkwood/armada-370-db.c

-- 
1.8.3.2
