From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Thu,  2 Feb 2017 10:24:14 +0100
Subject: [PATCH v4 0/8] Add sun8i A33 audio driver
Message-ID: <20170202092422.5588-1-mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

This a V4 of my Allwinner A33 (sun8i) audio codec driver.

Tested on "for-next" branch of ASoC repository with some patches
to apply before this series:
https://patchwork.kernel.org/patch/9447631/
https://patchwork.kernel.org/patch/9423999/
and one of my previous patch (from V2):
https://patchwork.kernel.org/patch/9521121/

Changes since V3:
	- Rebased my patches under Mark Brown's repo on "for-next" branch.
	- Removed the .owner from sun8i-codec driver, reported by KBuild robot
	- Updated patch 05/08 according to Rob Herring's review.

Changes since V2:
	- Removed patches from v2 already merged:
	commit ebad64d193779 ("ASoC: sun4i-i2s: Increase DMA max burst to 8")
	commit 603a0c8af9cb2 ("clk: sunxi-ng: a33: Add CLK_SET_RATE_PARENT to ac-dig")
	- Removed "reset-names" from sun4i-i2s driver
	- Fixed the build warning from sun8i-codec
	- Fixed some various topics such as subject line
	for dt bindings patch, renamed the simple-card
	and disabled the simple-card.

Changes since V1:
	- Remove the analog codec driver as a better version has been
	committed by Chen-Yu Tsai and is already merged.
	- Remove the audio-card as simple-card can be used
	- The DMA maxburst is set to 8 in the sun4i-i2s instead of
	adding the maxburst of 4 in Sun6i dma engine.
	- Create a new compatible for sun4i-i2s to handle the reset
	line.
	- Fix various problems in sun8i-codec driver according to V1's
	reviews
	- Add the pm_runtime hooks in sun8i-codec driver to prepare/
	unprepare clocks.
	- Update the DTS according to Chen-Yu's analog codec driver.
	- Rename sun8i-codec's clocks to "bus" and "mod"
	- The first "delay" issue from V1 is fixed by using a delay
	when enabling the headphone amplifier to let the amplifier
	being up.

Patches 1 and 2 add a new compatible "allwinner,sun6i-a31-i2s"
to handle the reset line for sun4i-i2s driver. It uses a quirk to
use a version with or without reset lines.

Patch 3 adds the sun8i codec driver which represents the digital part
of the A33 codec. It supports only playback features.

Path 4 fixes the previous issue of a "first time delay" in V1 (see cover
letter). Do not hesitate if you have comments on this patch.

Patches 5 adds the dt-bindings documentation for new audio driver
added in this serie (sun8i-codec).

Patch 6 adds the cpu DAI, codec and audio nodes to sun8i-a33 device tree.

Patches 7 and 8 enable the audio on Parrot and Sinlinx's boards.

The DAI for this A33 codec is the same than for A20: "sun4i-i2s".
Currently, the sun8i-a33 codec driver handles only the playback feature.
The other ones (such as capture) and all other interfaces except
headphone are not supported. I will send a patch to handle the
capture with microphones in next few weeks.

Examples of amixer commands:
	amixer set 'Headphone' 75%
	amixer set 'Headphone' on
	amixer set 'DAC' on
	amixer set 'Right DAC Mixer RSlot 0' on
	amixer set 'Left DAC Mixer LSlot 0' on

It was tested on Parrot and Sinlinx boards.

Let me know if you have any comments on this serie.

Thank you in advance,
Best regards,

Myl?ne Josserand (8):
  ASoC: sun4i-i2s: Update binding documentation to include A31
  ASoC: sun4i-i2s: Add quirks to handle a31 compatible
  ASoC: Add sun8i digital audio codec
  ASoC: sun8i-codec-analog: Add amplifier event to fix first delay
  ASoC: codecs: Add sun8i-a33 binding documentation
  ARM: dts: sun8i: Add audio codec, dai and card for A33
  ARM: dts: sun8i: parrot: Enable audio nodes
  ARM: dts: sun8i: sinlinx: Enable audio nodes

 .../devicetree/bindings/sound/sun4i-i2s.txt        |   5 +
 .../devicetree/bindings/sound/sun8i-a33-codec.txt  |  63 +++
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |  12 +
 arch/arm/boot/dts/sun8i-a33.dtsi                   |  45 ++
 arch/arm/boot/dts/sun8i-r16-parrot.dts             |  12 +
 sound/soc/sunxi/Kconfig                            |  11 +
 sound/soc/sunxi/Makefile                           |   1 +
 sound/soc/sunxi/sun4i-i2s.c                        |  57 ++-
 sound/soc/sunxi/sun8i-codec-analog.c               |  30 +-
 sound/soc/sunxi/sun8i-codec.c                      | 498 +++++++++++++++++++++
 10 files changed, 730 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/sun8i-a33-codec.txt
 create mode 100644 sound/soc/sunxi/sun8i-codec.c

-- 
2.11.0
