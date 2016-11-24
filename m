From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 24 Nov 2016 01:17:10 +0000
Subject: [RFC PATCH 0/5] arm64: Allwinner H5 support
Message-ID: <1479950235-26821-1-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the recently released Allwinner H5 SoC [1] and
the Orange Pi PC 2 board [2].
This exercise is rather easy this time, since the new SoC is very similar
to the existing H3 SoC and can thus share a lot of support.
To express this, the first patch splits the H3 .dtsi to allow reusing
it later. The last two patches add the H5 .dtsi and the .dts for the
first available board featuring this chip, based on that shared base DT.

This is some early version, it's based on a merge of various -for-4.10
branches from Maxime's repository.
I can boot this on the OPi board and MMC and USB seem to work fine.
I haven't tested any other peripherals yet.
Some open issues:
- The naming: Following the Allwinner scheme this should be "sun50i-h5"
(which I use in this series), but it shares so much with the H3 that
"sun8i-h5" wouldn't be wrong either. It gets a bit weird with that shared
.dtsi, which I call sun8i-h3-h5.dtsi for now.
- The clocks and pinctrl look _almost_ similar. I may sound like a broken
record, but our habit of requiring kernel support for those almost identical
SoCs really bites us now. As the MMC got updated, I fear there is _one_
additional pin that we need for the HS400 transfer mode. Also I am afraid
the MMC clock may be slightly different due to the advanced MMC support.
At the moment this is not an issue, as the driver only support DDR50 at
most anyway, so we get away with it now.
I wonder if it's feasible to add those things to the existing H3 clocks
and pinctrl to avoid another set of drivers.
- I just see that I missed those patches that add just the names to the
binding docs. I will send them once we agreed on the naming.

Let me know what you think.

Cheers,
Andre.

[1] http://linux-sunxi.org/images/d/de/Allwinner_H5_Datasheet_V1.0.pdf
[2] http://linux-sunxi.org/Xunlong_Orange_Pi_PC_2

Andre Przywara (5):
  arm: dts: sun8i: split Allwinner H3 .dtsi
  dmaengine: allow sun6i-dma for more SoCs
  arm64: defconfig: sunxi: include options for Allwinner H5 SoC
  arm64: dts: sunxi: add Allwinner H5 .dtsi
  arm64: dts: sunxi: add support for the Orange Pi PC 2 board

 arch/arm/boot/dts/sun8i-h3-h5.dtsi                 | 519 +++++++++++++++++++++
 arch/arm/boot/dts/sun8i-h3.dtsi                    | 465 +-----------------
 arch/arm64/Kconfig.platforms                       |   6 +-
 arch/arm64/boot/dts/allwinner/Makefile             |   1 +
 .../boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts  | 183 ++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi       | 165 +++++++
 arch/arm64/boot/dts/allwinner/sun8i-h3-h5.dtsi     |   1 +
 drivers/dma/Kconfig                                |   2 +-
 8 files changed, 876 insertions(+), 466 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun8i-h3-h5.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
 create mode 120000 arch/arm64/boot/dts/allwinner/sun8i-h3-h5.dtsi

-- 
2.8.2
