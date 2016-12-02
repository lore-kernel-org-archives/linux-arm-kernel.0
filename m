From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat,  3 Dec 2016 00:47:34 +0100
Subject: [PATCH 0/5] meson-gx: reset RGMII PHYs and configure TX delay
Message-ID: <20161202234739.22929-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This partially fixes the 1000Mbit/s ethernet TX throughput issues (on
networks which are not affected by the EEE problem, as reported here:
[1]).
The actual problem for the TX throughput issues was that the TX delay
was applied twice:
- once "accidentally" by the PHY (this was fixed with [2])
- once by the MAC because there was a hardcoded TX delay (of 2ns),
  this will be configurable with the changes from [0]

These are the dts changes which belong to my other series (in v2
these patches were part of the other series, upon request of the
net maintainers I have split the .dts changes into their own series so
we are able to take both through different trees):
"[PATCH net-next v3 0/2] stmmac: dwmac-meson8b: configurable
RGMII TX delay": [0].
Thus this series depends on the ACK for the binding changes in the
other series!

I based these changes on my other series "[PATCH v2 0/2] GXL and GXM
SCPI improvements": [3]


[0] http://lists.infradead.org/pipermail/linux-amlogic/2016-December/001834.html
[1] http://lists.infradead.org/pipermail/linux-amlogic/2016-November/001607.html
[2] http://lists.infradead.org/pipermail/linux-amlogic/2016-November/001707.html
[3] http://lists.infradead.org/pipermail/linux-amlogic/2016-December/001831.html

Martin Blumenstingl (5):
  ARM64: dts: meson-gx: move the MDIO node to meson-gx
  ARM64: dts: meson-gxbb-odroidc2: add reset for the ethernet PHY
  ARM64: dts: meson-gxbb-p20x: add reset for the ethernet PHY
  ARM64: dts: meson-gxbb-vega-s95: add reset for the ethernet PHY
  ARM64: dts: amlogic: add the ethernet TX delay configuration

 arch/arm64/boot/dts/amlogic/meson-gx.dtsi            |  6 ++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts  | 17 +++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi     | 17 +++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi | 17 +++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts |  2 ++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi           |  6 ------
 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts  |  2 ++
 arch/arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts  |  2 ++
 8 files changed, 63 insertions(+), 6 deletions(-)

-- 
2.10.2
