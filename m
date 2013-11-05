From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 5 Nov 2013 09:49:32 +0800
Subject: [PATCH v3 00/11] Add power management support for MXS PHY
Message-ID: <1383616183-10511-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe & Shawn,

The serial adds power management support for MXS PHY, it includes:

- Add three common PHY APIs, .set_wakeup, .notify_suspend, notify_resume.
- Related above API implementation at mxs phy driver
- misc changes for mxs phy to support low power mode and wakeup.

My github tree: https://github.com/hzpeterchen/linux-usb
branch: master
It is based on linux-next-1029.

Changes for v3:
- Using flag bit to indicate SoC features/bugs, so we can remove
platform_device_id.
- Remove 3 unnecessary dts/doc patches due to above change
- Several comment change

Changes for v2:

- Add missing patches which introduce platform judgement code [1/14,2/14]
- re-order the patch sequence, like doc->dts->source file,
the reviewers can know the meaning of dt properties before review source
- Add description of two IC problems exsiting at mxs PHY; change
"high speed" to "HS" and "non-high speed" to "FS/LS" [5/14]
- Change the dt property disconnect-line-without-vbus
that the separator should be "-" not the "_", meanwhile, related source
code has changed.
- Using one local variable to get the function return val to avoid long
condition statement. [13/14]

Peter Chen (11):
  usb: phy-mxs: Add platform judgement code
  usb: phy-mxs: Add auto clock and power setting
  usb: doc: phy-mxs: update binding for adding anatop phandle
  ARM: dts: imx6: add anatop phandle for usbphy
  usb: phy-mxs: Add anatop regmap
  usb: phy: add notify suspend and resume callback
  usb: phy-mxs: Add implementation of nofity_suspend and notify_resume
  usb: phy-mxs: Enable IC fixes for related SoCs
  usb: phy: Add set_wakeup API
  usb: phy-mxs: Add implementation of set_wakeup
  usb: phy-mxs: Add system suspend/resume API

 Documentation/devicetree/bindings/usb/mxs-phy.txt |    2 +
 arch/arm/boot/dts/imx6qdl.dtsi                    |    2 +
 drivers/usb/phy/phy-mxs-usb.c                     |  313 ++++++++++++++++++++-
 include/linux/usb/phy.h                           |   39 +++
 4 files changed, 341 insertions(+), 15 deletions(-)
