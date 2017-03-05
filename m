From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sun,  5 Mar 2017 21:36:57 +0800
Subject: [PATCH v2 00/12] Add support for the audio codec on Allwinner V3s
Message-ID: <20170305133709.6288-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner V3s features a audio codec with dedicated digital and analog parts,
like the ones on A23/H3, but much simpler (lack of MIC2, LINE IN and MBIAS).

Add support for it.

In order to make the codec usable, DMA support is also added in this series;
the support of Lichee Pi Zero's dock board is also added here, as it's the
only board hackable that come with ports connected to the codec.

Patch 1~3 split out parts that is not available on V3s in the analog codec.

Patch 4/5 adds support for V3s in analog/digital codec.

Patch 6 add the gate bit as a common quirk of sun6i-dma driver, as V3s also
needs it.

Patch 7 really adds support for V3s in DMA engine.

Patch 8 restores the inclusion of CCU headers in the DTSI file of V3s, as
it's removed when merging.

Patch 9/10/11 adds three parts of V3s: DMA engine, codec support and pinmux
of mmc1 (used on Lichee Pi Zero dock).

Patch 12 adds support for Lichee Pi Zero dock, with support of mmc1 and
codec.

Icenowy Zheng (12):
  ASoC: sun8i-codec-analog: split out mic2
  ASoC: sun8i-codec-analog: split out line in
  ASoC: sun8i-codec-analog: split out mbias
  ASoC: sun8i-codec-analog: add support for V3s SoC
  ASoC: sun4i-codec: Add support for V3s codec
  dmaengine: sun6i: make gate bit in sun8i's DMA engines a common quirk
  dmaengine: sun6i: support V3s SoC variant
  ARM: dts: sun8i: restore the inclusion of ccu headers in V3s DTSI
  ARM: dts: sun8i: add DMA engine in V3s DTSI
  ARM: dts: sun8i: add audio codec support into V3s DTSI
  ARM: dts: sun8i: add pinmux for V3s mmc1
  ARM: dts: sun8i: add device tree for Lichee Pi Zero with Dock

 .../devicetree/bindings/dma/sun6i-dma.txt          |   1 +
 .../devicetree/bindings/sound/sun4i-codec.txt      |  11 +-
 .../bindings/sound/sun8i-codec-analog.txt          |   1 +
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts |  67 +++++++
 arch/arm/boot/dts/sun8i-v3s.dtsi                   | 103 ++++++----
 drivers/dma/sun6i-dma.c                            |  22 ++-
 sound/soc/sunxi/sun4i-codec.c                      |  59 ++++++
 sound/soc/sunxi/sun8i-codec-analog.c               | 211 +++++++++++++++++----
 9 files changed, 405 insertions(+), 73 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts

-- 
2.11.1
