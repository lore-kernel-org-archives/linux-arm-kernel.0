From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 15 Oct 2015 00:32:16 +0800
Subject: [PATCH 0/6] mfd: axp20x: Add support for RSB based AXP223
Message-ID: <1444840342-9233-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series adds support for the Reduced Serial Bus based AXP223 PMIC.
The AXP223 is functionally identical to the AXP221, which we already
support. Only some default values for the regulators are different.
The defaults fit their recommended application, paired with different
SoCs.

Patch 1 adds AXP223 to the list of supported chips in the DT binding.

Patch 2 splits the axp20x mfd driver into 2 parts, a core library, and
an I2C driver.

Patch 3 adds an RSB based driver for the AXP223.

Patch 4 adds support for the AXP223 regulators

Patch 5 adds the NMI interrupt controller to the sun8i dtsi. This is
chained to the GIC, and exposes an external NMI pin for the PMIC.

Patch 6 enables the AXP223 PMIC and its regulators for the Sinlinx
SinA33.

Another patch enabling the PMIC for the A23/A33 Q8 format tablets
is available, but I'll send it after I get the simplefb regulator
support merged. Otherwise the LCD would get powered down. The whole
branch is available at https://github.com/wens/linux/tree/axp223.

This series is a bit messy to merge. RSB support has just been merged
and is queued up for 4.4. It is available at

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git
  
  tags/sunxi-drivers-for-4.4

Patch 4 depends on patch 3 for the new ID, and RSB support, obviously.
And patch 3 depends on patch 2. I suppose with Lee's ack, Mark can
merge the tag above, or wait for 4.4-rc1, then the first 4 patches.


Regards
ChenYu


Chen-Yu Tsai (6):
  mfd: axp20x: Add AXP223 to list of supported PMICs in DT bindings
  mfd: axp20x: Split the driver into core and i2c bits
  mfd: axp20x: Add support for RSB based AXP223 PMIC
  regulator: axp20x: Support new AXP223 PMIC
  ARM: dts: sun8i: Add NMI interrupt controller node
  ARM: dts: sun8i: sinlinx-sina33: Add AXP223 PMIC device and regulator
    nodes

 Documentation/devicetree/bindings/mfd/axp20x.txt |   7 +-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi             |   8 ++
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts   |  79 +++++++++++++-
 drivers/mfd/Kconfig                              |  30 +++++-
 drivers/mfd/Makefile                             |   4 +-
 drivers/mfd/{axp20x.c => axp20x-core.c}          | 107 +++----------------
 drivers/mfd/axp20x-i2c.c                         | 127 +++++++++++++++++++++++
 drivers/mfd/axp20x-rsb.c                         |  93 +++++++++++++++++
 drivers/regulator/axp20x-regulator.c             |   3 +
 include/linux/mfd/axp20x.h                       |  34 +++++-
 10 files changed, 386 insertions(+), 106 deletions(-)
 rename drivers/mfd/{axp20x.c => axp20x-core.c} (87%)
 create mode 100644 drivers/mfd/axp20x-i2c.c
 create mode 100644 drivers/mfd/axp20x-rsb.c

-- 
2.6.1
