From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  3 Nov 2016 15:55:42 +0800
Subject: [PATCH v2 00/14] ASoC: sun4i-codec: Add support for A31 Codec
Message-ID: <20161103075556.29018-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is v2 of my Allwinner A31 audio codec support series. The ASoC DAPM
stereo control patches in v1 were split out and merged already. These
remaining patches depend on them.

The A31's internal codec is similar (in terms of DMA, interface and
control layouts) to the one found in the A10/A13/A20 SoCs. However
it has more external inputs and outputs, the mixer controls are now
stereo (left/right separated), and it also has some audio processing
features (not supported yet).

Changes since v1:

  - Patches 1, 2, 3 and 4 were split out from patch 6.

  - Reworked handling of register offset differences with regmap_field,
    as suggested by Maxime.

  - Added support for an optional (in the driver) reset control (patch 5)

  - Added required reset control for sun6i-a31-codec

  - Added more comments for sun6i registers

  - Added HPCOM (direct drive mode) support

  - Renamed sun6i audio card name to "A31 Audio Codec"

  - Added example for allwinner,sun6i-a31-codec device tree

  - Fixed line out volume control scale

  - Added external amplifier enable GPIO for Hummingbird A31

  - Added patch to enable audio codec on Sinlinx SinA31s

Patch 1 moves some code around to facilitate patch 2. No code was
changed

Patch 2 expands the quirks to handle different register offsets for

    - ADC FIFO controls, using regmap_field's

    - RX/TX FIFO addresses, with offsets stored directly, as these
      are only used to setup DMA and not actually accessed by the
      driver

    - card setup functions, as the newer codecs have a very different
      layout

Patch 3 fixes some of the comments in the register definition section,
so the separation of different functions is clearer.

Patch 4 increases the maximum DMA burst size from 4 to 8. 4 is not
a valid size on later SoCs.

Patch 5 adds driver support for an optional reset control.

Patches 6 through 11 add support for the A31's internal codec, one
feature per patch. Hopefully this makes it easier to review. Some
features, such as PHONE inputs/outputs, audio processing, headset
jack detection and buttons, aren't supported yet.

Patch 12 adds a device node for the codec to the A31 dtsi.

Patch 13 enables the codec for the Hummingbird A31 board.

Patch 14 enables the codec for the Sinlinx SinA31s board.


Please let me know what you think.

Regards
ChenYu


Chen-Yu Tsai (14):
  ASoC: sun4i-codec: Move data structures to add create_card call to
    quirks
  ASoC: sun4i-codec: Expand quirks to handle register offsets and card
    creation
  ASoC: sun4i-codec: Revise comments for register definition macros
  ASoC: sun4i-codec: Increase DMA max burst to 8
  ASoC: sun4i-codec: Add support for optional reset control to quirks
  ASoC: sun4i-codec: Add support for A31 playback through headphone
    output
  ASoC: sun4i-codec: Add support for A31 Line In playback
  ASoC: sun4i-codec: Add support for A31 Line Out playback
  ASoC: sun4i-codec: Add support for A31 analog microphone inputs
  ASoC: sun4i-codec: Add support for A31 ADC capture path
  ASoC: sun4i-codec: Add support for A31 board level audio routing
  ARM: dts: sun6i: Add audio codec device node
  ARM: dts: sun6i: hummingbird: Enable internal audio codec
  ARM: dts: sun6i: sina31s: Enable internal audio codec

 .../devicetree/bindings/sound/sun4i-codec.txt      |  55 +-
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts        |  20 +
 arch/arm/boot/dts/sun6i-a31.dtsi                   |  13 +
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts           |   8 +
 sound/soc/sunxi/sun4i-codec.c                      | 688 ++++++++++++++++++---
 5 files changed, 706 insertions(+), 78 deletions(-)

-- 
2.10.2
