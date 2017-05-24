From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 24 May 2017 18:05:58 +0800
Subject: [PATCH v3 0/9] Add support for the audio codec on Allwinner V3s
Message-ID: <20170524100607.29790-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner V3s features a audio codec with dedicated digital and analog parts,
like the ones on A23/H3, but much simpler (lack of MIC2, LINE IN and MBIAS).

Add support for it.

In order to make the codec usable, DMA support is also added in this series.

Patch 1 split out MBIAS in analog codec driver.

Patch 2 prepared a set of objects that have MIC2 and LINEIN stripped out
for V3s.

Patch 3/4 adds support for V3s in analog/digital codec.

Patch 5 add the gate bit as a common quirk of sun6i-dma driver, as V3s also
needs it.

Patch 6 really adds support for V3s in DMA engine.

Patch 7/8/9 adds three parts of device tree: DMA engine, codec support
and enable the codec for Lichee Pi Zero dock.

Icenowy Zheng (9):
  ASoC: sun8i-codec-analog: split out mbias
  ASoC: sun8i-codec-analog: prepare a mixer control/widget/route set for
    V3s
  ASoC: sun8i-codec-analog: add support for V3s SoC
  ASoC: sun4i-codec: Add support for V3s codec
  dmaengine: sun6i: make gate bit in sun8i's DMA engines a common quirk
  dmaengine: sun6i: support V3s SoC variant
  ARM: dts: sun8i: add DMA engine in V3s DTSI
  ARM: dts: sun8i: add audio codec support into V3s DTSI
  ARM: sun8i: v3s: enable audio on Lichee Pi Zero Dock board

 .../devicetree/bindings/dma/sun6i-dma.txt          |   1 +
 .../devicetree/bindings/sound/sun4i-codec.txt      |  11 +-
 .../bindings/sound/sun8i-codec-analog.txt          |   1 +
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts |   9 ++
 arch/arm/boot/dts/sun8i-v3s.dtsi                   |  28 ++++
 drivers/dma/sun6i-dma.c                            |  25 +++-
 sound/soc/sunxi/sun4i-codec.c                      |  63 +++++++++
 sound/soc/sunxi/sun8i-codec-analog.c               | 141 ++++++++++++++++++++-
 8 files changed, 266 insertions(+), 13 deletions(-)

-- 
2.12.2
