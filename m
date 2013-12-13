From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 13 Dec 2013 09:23:30 +0800
Subject: [PATCH v6 00/15] Add power management support for mxs phy
Message-ID: <1386897825-6130-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe & Shawn,

The serial adds power management support for MXS PHY, it includes:

- Add three common PHY APIs, .set_wakeup, .notify_suspend, notify_resume.
- Related above API implementation at mxs phy driver
- misc changes and bug fixes for mxs phy to support low power mode and wakeup.

It is based on Greg's usb-next, 3.13-rc1.

Changes for v6:
- Add description for IC bug fixes logic. [9/15]
- Move is_imx6q_phy and is_imx6sl_phy from [9/15] to [14/15] 
- %s/mxs_phy_clock_switch/mxs_phy_clock_switch_delay to reflect
the function meaning more precise [15/15]

Changes for v5:
Add Marc and Michael Grzeschik's commnets
- typo error at [2/15]
- sqhash patches which introducing mxs_phy_disconnect_line and
fixed but at this function. [13/15]
- Introducing flag MXS_PHY_NEED_IP_FIX who stands for the SoCs
who have IC fixes. [2/15, 8/15]
- Delete one patch for low speed connection problem at every rare
situations due to the root cause has still not found.


Peter Chen (15):
  usb: doc: phy-mxs: Add more compatible strings
  usb: phy-mxs: Add platform judgement code
  usb: phy-mxs: Add auto clock and power setting
  usb: doc: phy-mxs: update binding for adding anatop phandle
  ARM: dts: imx6: add anatop phandle for usbphy
  usb: phy-mxs: Add anatop regmap
  usb: phy: add notify suspend and resume callback
  usb: phy-mxs: Add implementation of nofity_suspend and notify_resume
  usb: phy-mxs: Enable IC fixes for related SoCs
  ARM: dts: imx: add mxs phy controller id
  usb: phy-mxs: add controller id
  usb: phy: Add set_wakeup API
  usb: phy-mxs: Add implementation of set_wakeup
  usb: phy-mxs: Add system suspend/resume API
  usb: phy-mxs: Add sync time after controller clear phcd

 Documentation/devicetree/bindings/usb/mxs-phy.txt |    5 +-
 arch/arm/boot/dts/imx23.dtsi                      |    1 +
 arch/arm/boot/dts/imx28.dtsi                      |    2 +
 arch/arm/boot/dts/imx6qdl.dtsi                    |    4 +
 arch/arm/boot/dts/imx6sl.dtsi                     |    4 +
 drivers/usb/phy/phy-mxs-usb.c                     |  360 ++++++++++++++++++++-
 include/linux/usb/phy.h                           |   39 +++
 7 files changed, 400 insertions(+), 15 deletions(-)

-- 
1.7.8
