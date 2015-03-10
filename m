From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 10 Mar 2015 19:59:11 +0800
Subject: [PATCH v5 00/12] mfd: axp20x: add AXP221 PMIC support
Message-ID: <1425988764-23618-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is v5 of the AXP221 series. I've taken over the work from Boris.
This version is based on v4.0-rc1, plus "mfd: AXP20x: Add bindings
documentation" which was posted a few weeks ago. I've worked on this
series for some time, so the changelog might not be completely accurate.

The AXP221 is a member of X-Powers' AXP PMIC family. They share the
same basic functionality and structure. The series adds system poweroff,
power button and regulator support for the AXP221. When Reduced Serial
Bus (RSB) support is introduced, the same code can be reused (except
for the probe interface) for the AXP223, which has the same core and
a different external host interface.

The p2wi controller dts patches have no dependency, and can go in
Maxime's tree.

The regulator bits depend on the mfd patches, which introduce new enums
and register definitions. The regulator dts patches should also be merged
_after_ the regulator bits, as the original axp20x regulator driver did
not check for supported variants. Maybe Lee and Mark can work out a shared
branch, or have Lee take all the driver bits?


Regards
ChenYu


Changes since v4:

  - Rebased onto v4.0-rc1 and axp20x bindings v10

  - Dropped regulator set registration patches

  - Group regmap ranges/tables by AXP variant

  - Fix AXP221 interrupt numbers to match datasheet

  - Handle AXP variants when setting DC-DC regulator work mode

  - Add "switch" type regulator DC1SW, which is a secondary output
    of DCDC1 with a separate on/off switch.

  - Add AXP221 to DT bindings


Boris BREZILLON (4):
  ARM: dts: sun6i: add p2wi controller node to dtsi
  mfd: axp20x: add AXP22x PMIC support
  regulator: axp20x: prepare support for multiple AXP chip families
  regulator: axp20x: add support for AXP22X regulators

Chen-Yu Tsai (8):
  ARM: dts: sun6i: hummingbird: Enable P2WI controller
  mfd: axp20x: update DT bindings with AXP22x compatibles
  ARM: dts: sun6i: hummingbird: Add AXP221 PMIC device node
  mfd: axp20x: Add AXP22x regulator information to DT bindings
  mfd: axp20x: Enable AXP22X regulators
  ARM: dts: sun6i: hummingbird: Add AXP221 regulator nodes
  ARM: dts: sun6i: Add pinmux settings for mmc1 to dtsi
  ARM: dts: sun6i: hummingbird: Enable the onboard WiFi module

 Documentation/devicetree/bindings/mfd/axp20x.txt |  34 +++-
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts      |  91 ++++++++-
 arch/arm/boot/dts/sun6i-a31.dtsi                 |  29 +++
 drivers/mfd/axp20x.c                             | 100 ++++++++++
 drivers/regulator/axp20x-regulator.c             | 239 ++++++++++++++++++-----
 include/linux/mfd/axp20x.h                       |  86 ++++++++
 6 files changed, 526 insertions(+), 53 deletions(-)

-- 
2.1.4
