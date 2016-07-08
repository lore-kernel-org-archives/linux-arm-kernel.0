From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  8 Jul 2016 22:33:35 +0800
Subject: [PATCH v5 0/7] mfd: ac100: Add support for X-Powers AC100 audio codec
 / RTC combo IC
Message-ID: <1467988422-17934-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series adds support for X-Powers' AC100 audio codec / RTC combo IC.
This chip is found on Allwinner A80 SoC based boards, and is also part
of the AXP813/AXP818 PMIC found with Allwinner A83T SoCs.

The series focuses on the RTC side of the chip. The audio codec will
be done later, once the digital audio interface of the SoC is supported.

Changes since v4:

  - Style changes to DT bindings.
  - Added commit message to DT bindings commit.

Changes since v3:

  - bulk write support for regmaps without raw formatting patch merged
    and thus dropped from series.

  - sun9i device node re-ordering patches merged and thus dropped from
    series.

  - Fixed device node name and added labels to device tree binding example.

  - Moved 4M_adda clock to codec side, and added clock bindings to codec
    node.

  - Rename RTC clock output related prefixes from clk32k to clkout.

  - Rename default clock output names to cko{1,2,3}-rtc.

  - Move struct tm to/from RTC conversion offsets inline with reg[]
    assignments

  - Drop separate mutex and use rtc->ops_lock in interrupt handler.

  - Use platform_get_irq instead of of_get_irq.

  - Add struct of_device_id and .of_match_table to RTC driver.

Changes since v2:

  - Fix ac100_codec interrupt line in DT binding example.

  - Fix copy-paste errors in RTC set_alarm. Alarm now works.

  - Drop file name from MFD driver.

  - Add / update copyright notices.

  - Change license of RTC driver to GPL v2, matching MFD driver.

  - Fix MFD driver MODULE_LICENSE to match license declaration in header.

Changes since v1:

  - Complete register definitions and regmap regions.

Patch 1 adds device tree bindings for the AC100.

Patch 2 adds the mfd driver for the AC100.

Patch 3 adds the RTC driver for the AC100.

Patch 4 adds RTC clk output support to the RTC driver.
This is a separate patch as the clk code is over 300 LoC. Having a
separate patch should make it easier for the clk maintainers to review.

Patch 5 adds the AC100 device nodes to the A80 Optimus board dts.

Patch 6 adds the AC100 device nodes to the Cubieboard4 board dts.

Patch 7 changes the fixed osc_32k clk to a fixed factor clk,
representing the 32k clk input pin on the SoC, and also hooks up the
ac100 rtc clk output to this clk in the board dts files.

I'm hoping we can merge the driver bits (patches 1~4) through the
mfd tree, with acks from the rtc maintainers for patches 3 and 4.


Regards
ChenYu


Chen-Yu Tsai (7):
  mfd: ac100: Add device tree bindings for X-Powers AC100 codec/RTC
    combo IC
  mfd: ac100: Add driver for X-Powers AC100 audio codec / RTC combo IC
  rtc: ac100: Add RTC driver for X-Powers AC100
  rtc: ac100: Add clk output support
  ARM: dts: sun9i: a80-optimus: Add device node for AC100
  ARM: dts: sun9i: cubieboard4: Add device node for AC100
  ARM: dts: sun9i: Switch to the AC100 RTC clock outputs for osc32k

 Documentation/devicetree/bindings/mfd/ac100.txt |  54 ++
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts     |  29 ++
 arch/arm/boot/dts/sun9i-a80-optimus.dts         |  29 ++
 arch/arm/boot/dts/sun9i-a80.dtsi                |   9 +-
 drivers/mfd/Kconfig                             |  10 +
 drivers/mfd/Makefile                            |   2 +
 drivers/mfd/ac100.c                             | 137 ++++++
 drivers/rtc/Kconfig                             |  10 +
 drivers/rtc/Makefile                            |   1 +
 drivers/rtc/rtc-ac100.c                         | 627 ++++++++++++++++++++++++
 include/linux/mfd/ac100.h                       | 178 +++++++
 11 files changed, 1080 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/ac100.txt
 create mode 100644 drivers/mfd/ac100.c
 create mode 100644 drivers/rtc/rtc-ac100.c
 create mode 100644 include/linux/mfd/ac100.h

-- 
2.8.1
