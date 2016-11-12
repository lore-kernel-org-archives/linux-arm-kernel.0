From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 12 Nov 2016 14:46:38 +0800
Subject: [PATCH 00/10] ASoC: sunxi: Add support for audio codec in A23/H3 SoCs
Message-ID: <20161112064648.26779-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series adds support for the audio codec found in Allwinner A23 and
H3 SoCs. The design and data paths are similar to the audio codec found
in earlier SoCs such as the A31. The analog audio paths are symmetrical
with left/right channels and down-mix selectors for mono differential
output.

What deviates from previous SoCs is that the analog path controls have
been moved to a separate control bus, accessed through a message box
like register interface in the PRCM block. This necessitates writing
a separate component driver for it, which is then tied into the sound
card as an ASoC auxiliary device.

Patches 1 and 2 add the binding and driver for the analog path control
block. This is the more complete version. Previously I provided a not
fully tested version to Mylene Josserand from Free Electrons to use
with the A33. Their version was then trimmed down and switched to 
SOC_DAPM_SINGLE controls. Mine implements all the commonly used paths,
and uses the new stereo SOC_DAPM_DOUBLE controls. I also have a separate
patch for "Phone In" in case anyone wants to test them. It is not included
as my hardware does not use that input.

As for the A33, the analog controls are exactly the same as the A23, so
this driver can be reused, but the PCM and DAI bits are completely
different.

Patch 3 adds the analog path controls block to the sun6i-prcm driver as
a sub-device, for the A23. The H3 currently does not use the PRCM driver.

Patch 4 adds PCM and card support for the A23 codec to the sun4i-codec
driver.

Patch 5 adds a device node for the analog path controls block to the A23
dtsi.

Patch 6 adds a device node for the audio codec, and the phandle for the
analog path controls block to the A23 dtsi.

Patch 7 enables the audio codec for the A23 Q8 tablets. On these tablets
the headphone output is driven in DC coupled, or "direct drive", mode.

Patch 8 adds PCM and card support for the H3 codec to the sun4i-codec
driver.

Patch 9 adds device nodes for the audio codec and analog path controls
block to the H3 dtsi.

Patch 10 enables the audio codec on the Orange Pi PC. The audio output
jack on the board is tied to the line out pins on the SoC.


Please take a look and let me know what you think.

In addition, the sun4i-codec driver is getting pretty large. Maybe we
want to split the different parts into different files?


Regards
ChenYu


Chen-Yu Tsai (10):
  ASoC: sunxi: Add bindings for A23/A33/H3 codec's analog path controls
  ASoC: sunxi: Add support for A23/A33/H3 codec's analog path controls
  mfd: sun6i-prcm: Add codec analog controls sub-device for Allwinner
    A23
  ASoC: sun4i-codec: Add support for A23 codec
  ARM: dts: sun8i: Add codec analog path controls node in PRCM for
    A23/A33
  ARM: dts: sun8i-a23: Add device node for internal audio codec
  ARM: dts: sun8i-a23: q8-tablet: Enable internal audio codec
  ASoC: sun4i-codec: Add support for H3 codec
  ARM: dts: sun8i-h3: Add device nodes for audio codec and its analog
    controls
  ARM: dts: sun8i-h3: orange-pi-pc: Enable audio codec

 .../devicetree/bindings/sound/sun4i-codec.txt      |  14 +-
 .../bindings/sound/sun8i-codec-analog.txt          |  16 +
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               |   4 +
 arch/arm/boot/dts/sun8i-a23-q8-tablet.dts          |  23 +
 arch/arm/boot/dts/sun8i-a23.dtsi                   |  16 +
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         |   8 +
 arch/arm/boot/dts/sun8i-h3.dtsi                    |  19 +
 drivers/mfd/sun6i-prcm.c                           |  17 +
 sound/soc/sunxi/Kconfig                            |   8 +
 sound/soc/sunxi/Makefile                           |   1 +
 sound/soc/sunxi/sun4i-codec.c                      | 179 ++++++
 sound/soc/sunxi/sun8i-codec-analog.c               | 665 +++++++++++++++++++++
 12 files changed, 968 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
 create mode 100644 sound/soc/sunxi/sun8i-codec-analog.c

-- 
2.10.2
