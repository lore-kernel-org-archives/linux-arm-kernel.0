From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 20 Jun 2016 10:52:10 +0800
Subject: [PATCH v3 0/8] mfd: ac100: Add support for X-Powers AC100 audio codec
 / RTC combo IC
Message-ID: <1466391138-12862-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series adds support for X-Powers' AC100 audio codec / RTC combo IC.
This chip is found on Allwinner A80 SoC based boards, and is also part
of the AXP813/AXP818 PMIC found with Allwinner A83T SoCs.

The series focuses on the RTC side of the chip. The audio codec will
be done later, once the digital audio interface of the SoC is supported.

Changes since v2:

  - Fix ac100_codec interrupt line in DT binding example.

  - Fix copy-paste errors in RTC set_alarm. Alarm now works.

  - Drop file name from MFD driver.

  - Add / update copyright notices.

  - Change license of RTC driver to GPL v2, matching MFD driver.

  - Fix MFD driver MODULE_LICENSE to match license declaration in header.

Changes since v1:

  - Complete register definitions and regmap regions.

v1 was actually a working version that wasn't updated with the codec
register definitions.


Patch 1 adds bulk write support for regmaps without raw formatting.
This is used in the RTC driver to write out the date and time in one
call.

Patch 2 adds device tree bindings for the AC100.

Patch 3 adds the mfd driver for the AC100.

Patch 4 adds the RTC driver for the AC100.

Patch 5 adds RTC clk output support to the RTC driver.
This is a separate patch as the clk code is over 300 LoC. Having a
separate patch should make it easier for the clk maintainers to review.

Patch 6 adds the AC100 device nodes to the A80 Optimus board dts.

Patch 7 adds the AC100 device nodes to the Cubieboard4 board dts.

Patch 8 fixes the order of device nodes in the A80 Optimus board dts.

Patch 9 fixes the order of device nodes in the Cubieboard4 board dts.

Patch 10 changes the fixed osc_32k clk to a fixed factor clk,
representing the 32k clk input pin on the SoC, and also hooks up the
ac100 rtc clk output to this clk in the board dts files.

I'm hoping we can merge the driver bits (patches 2~5) through the
mfd tree, with acks from the rtc and clk maintainers for patches
4 and 5.


Regards
ChenYu



Chen-Yu Tsai (8):
  regmap: Support bulk writes for devices without raw formatting
  mfd: ac100: Add device tree bindings for X-Powers AC100 codec/RTC
    combo IC
  mfd: ac100: Add driver for X-Powers AC100 audio codec / RTC combo IC
  rtc: ac100: Add RTC driver for X-Powers AC100
  rtc: ac100: Add clk output support
  ARM: dts: sun9i: a80-optimus: Add device node for AC100
  ARM: dts: sun9i: cubieboard4: Add device node for AC100
  ARM: dts: sun9i: Switch to the AC100 RTC clock outputs for osc32k

 Documentation/devicetree/bindings/mfd/ac100.txt |  42 ++
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts     |  26 +
 arch/arm/boot/dts/sun9i-a80-optimus.dts         |  26 +
 arch/arm/boot/dts/sun9i-a80.dtsi                |   9 +-
 drivers/base/regmap/regmap.c                    |  31 +-
 drivers/mfd/Kconfig                             |  10 +
 drivers/mfd/Makefile                            |   2 +
 drivers/mfd/ac100.c                             | 137 +++++
 drivers/rtc/Kconfig                             |  10 +
 drivers/rtc/Makefile                            |   1 +
 drivers/rtc/rtc-ac100.c                         | 684 ++++++++++++++++++++++++
 include/linux/mfd/ac100.h                       | 178 ++++++
 12 files changed, 1147 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/ac100.txt
 create mode 100644 drivers/mfd/ac100.c
 create mode 100644 drivers/rtc/rtc-ac100.c
 create mode 100644 include/linux/mfd/ac100.h

-- 
2.8.1
