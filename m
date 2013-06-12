From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 12 Jun 2013 18:53:29 +0200
Subject: [PATCHv5 0/8] Add I2C support for Allwinner SoCs
Message-ID: <1371056017-8166-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset adds support for the I2C controller found on most of the
Allwinner SoCs, especially the already supported A10 and A13, and the
yet to come A31.

This driver leverages the Marvel mv64xxx i2c controller driver, that has
an almost identical logic, with a slightly different register layout.

It has been tested on a A13-Olinuxino and an A10s-Olinuxino.

Thanks,
Maxime

Changes from v4:
  * Don't expose the reg offset structure through the platform data
  * Move the register offset structures to the driver and declare them static
  * Default at marvell's register layout when using platform data, and switch
    between the Allwinner and the Marvell ones only when using DT.
  * Remove the pull-ups in the device tree muxings

Changes from v3:
  * Merged the driver in the Marvell mv64xxx i2c controller

Changes from v2:
  * Slightly modified the switch comments again
  * Removed the of_* calls in favor of platform_get_* functions

Changes from v1:
  * Added comments to the switch statements to clarify when the fall through to
    the next case is made on purpose
  * Use devm_ioremap_resource instead of of_iomap
  * Moved the reset after enabling the clocks
  * Added Emilio Lopez' patch to add the available i2c controllers to the
    cubieboard

Emilio L?pez (1):
  ARM: sun4i: cubieboard: Enable the i2c controllers

Maxime Ripard (7):
  i2c: mv64xxx: Add macros to access parts of registers
  i2c: mv64xxx: make the registers offset configurable
  i2c: mv64xxx: Add Allwinner sun4i compatible
  ARM: sunxi: dt: Add i2c controller nodes to the DTSI
  ARM: sun4i: dt: Add i2c muxing options
  ARM: sun5i: dt: Add i2c muxing options
  ARM: sun5i: olinuxino: Enable the i2c controllers

 arch/arm/boot/dts/sun4i-a10-cubieboard.dts |  12 +++
 arch/arm/boot/dts/sun4i-a10.dtsi           |  48 ++++++++++++
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts  |  18 +++++
 arch/arm/boot/dts/sun5i-a13.dtsi           |  48 ++++++++++++
 drivers/i2c/busses/Kconfig                 |   3 +-
 drivers/i2c/busses/i2c-mv64xxx.c           | 118 +++++++++++++++++++----------
 6 files changed, 206 insertions(+), 41 deletions(-)

-- 
1.8.3
