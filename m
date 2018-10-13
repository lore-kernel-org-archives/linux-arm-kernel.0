From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sat, 13 Oct 2018 09:53:20 -0700
Subject: [PATCH v2 0/9] Add support for audiocodec in Allwinner A64
Message-ID: <20181013165329.13363-1-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds Allwinner A64 audiocodec support into sun4i-i2s,
sun8i-codec drivers, introduces new sun50i-codec-analog driver and enables
sound on Pine64, SoPine boards and Pinebook.

I2S for audiocodec in A64 is different from other 3 I2S modules but
similar to one in A10, digital part of codec is compatible with A33 and
analog controls part is completely different from other SoCs - it shares
only few bits in few registers, so adding support for it into existing
sun8i-codec-analog would mean duplicating all the widgets, controls and
some routes and making it hard to read. Therefore it makes sense to
introduce new driver.

v2: - Use simple-amplifier for speaker amp on Pinebook
    - Rename sun50i-a64-i2s to sun50i-a64-codec-i2s to preserve compatible
      string for other 3 I2S modules in A64 in case if there's any
      incompatibility with H3

Marcus Cooper (1):
  ASoC: sun4i-i2s: Add compatibility with A64 codec I2S

Vasily Khoruzhick (8):
  ASoC: sun8i-codec: Don't hardcode BCLK / LRCK ratio
  ASoC: sun8i-codec-analog: split regmap code into separate driver
  ASoC: dt-binding: Add bindings for Allwinner A64 codec's analog path
    controls
  ASoC: sunxi: Add new driver for Allwinner A64 codec's analog path
    controls
  ASoC: sunxi: allow the sun8i-codec driver to be built on ARM64
  arm64: dts: allwinner: a64: add nodes necessary for analog sound
    support
  arm64: dts: allwinner: a64: enable sound on Pine64 and SoPine
  arm64: dts: allwinner: a64: enable sound on Pinebook

 .../devicetree/bindings/sound/sun4i-i2s.txt   |   2 +
 .../bindings/sound/sun50i-codec-analog.txt    |  12 +
 .../boot/dts/allwinner/sun50i-a64-pine64.dts  |  30 ++
 .../dts/allwinner/sun50i-a64-pinebook.dts     |  42 ++
 .../allwinner/sun50i-a64-sopine-baseboard.dts |  30 ++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  58 +++
 sound/soc/sunxi/Kconfig                       |  17 +-
 sound/soc/sunxi/Makefile                      |   2 +
 sound/soc/sunxi/sun4i-i2s.c                   |  21 +
 sound/soc/sunxi/sun50i-codec-analog.c         | 444 ++++++++++++++++++
 sound/soc/sunxi/sun8i-codec-analog.c          |  79 +---
 sound/soc/sunxi/sun8i-codec.c                 |  35 +-
 sound/soc/sunxi/sunxi-adda-pr-regmap.c        | 102 ++++
 sound/soc/sunxi/sunxi-adda-pr-regmap.h        |   7 +
 14 files changed, 798 insertions(+), 83 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt
 create mode 100644 sound/soc/sunxi/sun50i-codec-analog.c
 create mode 100644 sound/soc/sunxi/sunxi-adda-pr-regmap.c
 create mode 100644 sound/soc/sunxi/sunxi-adda-pr-regmap.h

-- 
2.19.0
