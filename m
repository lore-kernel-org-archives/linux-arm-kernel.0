From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  3 Feb 2015 06:22:00 +0800
Subject: [PATCH v4 0/5] ARM: sun9i: Add USB host controller support for A80
Message-ID: <1422915725-26492-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is v4 of the sun9i A80 USB host support series.

Changes since v3:

  - Dropped patches merged.

  - Moved reg_usb3_vbus into the optimus board dts

  - Dropped ohci1 from A80 dtsi.

Cover letter from v3:

This series adds USB host controller (EHCI/OHCI) support for the Allwinner
A80 SoC. The A80 has 3 pairs of host controllers and USB PHYs. The PHYs,
unlike in previous SoCs, do not have low level control registers anymore.

As such, this series forgoes the original phy-sun4i-usb driver, and adds
a new, simpler driver for the USB PHYs. It may be possible to merge the
two, but given that work is being done on the OTG front for the earlier
SoCs, it may be better to merge them after support is complete.

EHCI/OHCI0 corresponds to USB1 DP/DM pins; EHCI1 only has HSIC support;
EHCI2/OHCI/2 is USB2 DP/DM externally. External pins labeled USB0 are
for the USB 3.0 OTG controller.

Changes since v2:

  - Split out current USB clock/reset code with a separate patch.

Changes since v1:

  - Rework usb clock/reset driver to only enable ahb gate when child
    clock gates are enabled.

  - Add AHB_INCR16_BURST flag and HSIC specific bits to phy driver.

  - Renumber USB PHYs according to sunxi tradition, usbphy0 for OTG,
    usbphy1 and later for xHCI.

  - Add VBUS regulator for usb3 to sunxi common regulators.

  - Use common regulators for usb vbus regulators.

  - Adapt to label references in board dts file.

  - Use gpio and pinctrl macros in dts.


Patch 1 adds a new generic phy driver for a80 usb phys. This has some
code that is the same as the original phy-sun4i-usb driver, but is simpler.

Patch 2 adds the USB host controller nodes to the a80 dtsi.

Patch 3 enables USB on the A80 Optimus board.

Patch 4 enables sun9i USB PHY in sunxi_defconfig.

Patch 5 enables sun9i USB PHY in multi_v7_defconfig.

Regards,
ChenYu


Chen-Yu Tsai (5):
  phy: Add driver to support individual USB PHYs on sun9i
  ARM: dts: sun9i: Add USB host controller nodes to a80 dtsi
  ARM: dts: sun9i: Enable USB support on A80 Optimus board
  ARM: sunxi_defconfig: Enable CONFIG_PHY_SUN9I_USB
  ARM: multi_v7_defconfig: Enable CONFIG_PHY_SUN9I_USB

 .../devicetree/bindings/phy/sun9i-usb-phy.txt      |  34 +++
 arch/arm/boot/dts/sun9i-a80-optimus.dts            |  65 ++++++
 arch/arm/boot/dts/sun9i-a80.dtsi                   |  55 +++++
 arch/arm/configs/multi_v7_defconfig                |   1 +
 arch/arm/configs/sunxi_defconfig                   |   1 +
 drivers/phy/Kconfig                                |  12 ++
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-sun9i-usb.c                        | 238 +++++++++++++++++++++
 8 files changed, 407 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/sun9i-usb-phy.txt
 create mode 100644 drivers/phy/phy-sun9i-usb.c

-- 
2.1.4
