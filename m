From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 9 Dec 2013 14:30:49 +0800
Subject: [PATCH v5 00/15] Add power management support for mxs phy
Message-ID: <1386570664-6713-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe & Shawn,

The serial adds power management support for MXS PHY, it includes:

- Add three common PHY APIs, .set_wakeup, .notify_suspend, notify_resume.
- Related above API implementation at mxs phy driver
- misc changes and bug fixes for mxs phy to support low power mode and wakeup.

It is based on Greg's usb-next, 3.13-rc1.

Changes for v5:
Add Marc and Michael Grzeschik's commnets
- typo error at [2/15]
- sqhash patches which introducing mxs_phy_disconnect_line and
fixed but at this function. [13/15]
- Introducing flag MXS_PHY_NEED_IP_FIX who stands for the SoCs
who have IC fixes. [2/15, 8/15]
- Delete one patch for low speed connection problem at every rare
situations due to the root cause has still not found.

Changes for v4:
- Using MXS_PHY_HAS_ANATOP to indicate which platform has anatop module
- Using mxs_phy_data to instead of mxs_phy_platform_flag
- Create is_xxx_phy() MACRO
- Add imx6sl support, and pass the test [5/17]
- Add one additional binding doc for compatible string [1/17]
- Introduce controller id to access un-regulator register region
[14/17] [15/17]
- Add waiting stable time before phy clock switches to AHB clock
(from 32K) [13/17]
- Fix one problem that only using the 1st controller register
at mxs_phy_disconnect_line [16/17]
- Fix one problem for low speed connection at very rare cases [17/17]
- Some typos


Changes for v3:
- Using flag bit to indicate SoC features/bugs, so we can remove
platform_device_id.
- Remove 3 unnecessary dts/doc patches due to above change
- Several comment change

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
 drivers/usb/phy/phy-mxs-usb.c                     |  355 ++++++++++++++++++++-
 include/linux/usb/phy.h                           |   39 +++
 7 files changed, 395 insertions(+), 15 deletions(-)

-- 
1.7.8
