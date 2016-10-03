From: wens@csie.org (Chen-Yu Tsai)
Date: Mon,  3 Oct 2016 19:07:52 +0800
Subject: [PATCH 00/12] ASoC: sun4i-codec: Add support for A31 Codec
Message-ID: <20161003110804.28235-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series adds support for stereo mixer controls in DAPM and uses them
to add support for Allwinner A31's internal codec. This series is for
4.10. I'm sending them out now, so if there are any issues we can discuss
them at ELCE next week.

The A31's internal codec is similar (in terms of DMA, interface and
control layouts) to the one found in the A10/A13/A20 SoCs. However
it has more external inputs and outputs, the mixer controls are now
stereo (left/right separated), and it also has some audio processing
features (not supported).

To fully support DAPM but also provide a sane interface to userspace,
the first 4 patches attempt to implement stereo support to DAPM controls.
Otherwise we end up with a bunch of mono controls labeled "X Left" and
"X Right".

Patches 5 through 10 add support for the A31's internal codec, one
feature per patch. Hopefully this makes it easier to review. Some
features, such as PHONE inputs/outputs, audio processing, headset
jack detection and buttons, aren't supported yet.

Patch 11 adds a device node for the codec to the A31 dtsi.

Patch 12 enables the codec for the Hummingbird A31 board.


Regards
ChenYu

Chen-Yu Tsai (12):
  ASoC: dapm: Support second register for DAPM control updates
  ASoC: dapm: Implement stereo mixer control support
  ASoC: dapm: Introduce DAPM_DOUBLE dual channel control type
  ASoC: dapm: Introduce DAPM_DOUBLE_R dual channel dual register control
    type
  ASoC: sun4i-codec: Add support for A31 playback through headphone
    output
  ASoC: sun4i-codec: Add support for A31 Line In playback
  ASoC: sun4i-codec: Add support for A31 Line Out playback
  ASoC: sun4i-codec: Add support for A31 analog microphone inputs
  ASoC: sun4i-codec: Add support for A31 ADC capture path
  ASoC: sun4i-codec: Add support for A31 board level audio routing
  ARM: dts: sun6i: Add audio codec device node
  ARM: dts: sun6i: hummingbird: Enable internal audio codec

 .../devicetree/bindings/sound/sun4i-codec.txt      |  41 +-
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts        |  12 +
 arch/arm/boot/dts/sun6i-a31.dtsi                   |  12 +
 include/sound/soc-dapm.h                           |  14 +
 sound/soc/codecs/adau17x1.c                        |   2 +-
 sound/soc/codecs/tlv320aic3x.c                     |   2 +-
 sound/soc/codecs/wm9712.c                          |   2 +-
 sound/soc/codecs/wm9713.c                          |   2 +-
 sound/soc/soc-dapm.c                               | 116 ++--
 sound/soc/sunxi/sun4i-codec.c                      | 599 ++++++++++++++++++---
 10 files changed, 699 insertions(+), 103 deletions(-)

-- 
2.9.3
