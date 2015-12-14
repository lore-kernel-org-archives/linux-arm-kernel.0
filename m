From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 14 Dec 2015 15:26:11 +0800
Subject: [PATCH v2 0/3] USB: add generic onboard USB HUB driver
Message-ID: <1450077974-22762-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes for v2:
- Delete platform data support for this driver
- Delete '#define DEBUG'
- Add "clock-frequency" entry for clock setting support
- Set hub_data->clk as NULL if clk is nonexist, it can simply
  operation for optional clocks.
- Delete gpio polarity entry, the polarity can passed by dts,
  and handled by gpio core.
- Delete "hub_" prefix for gpio and its duration property.
- Taking HUB input clock as anonymous clock.
- Change license as "GPL v2".
- Delete header file generic_onboard_hub.h
- Fix the building error found by kbuild test robot

Hi all,

There is a known issue that the USB code can't handle USB HUB's
external pins well, in that case, it may cause some onboard
USB HUBs can't work since their PHY's clock or reset pin needs to
operate.

The user reported this issue at below:
http://www.spinics.net/lists/linux-usb/msg131502.html

In this patch set, I add a generic onboard USB HUB driver to
handle this problem, the external signals will be configured
before usb controller's initialization, it much likes we did
it at board code before.

The user needs to add this generic hub node at dts to support it.

@The udoo users, help to test please.

Peter Chen (3):
  usb: misc: generic_onboard_hub: add generic onboard USB HUB driver
  doc: dt-binding: generic onboard USB HUB
  ARM: dts: imx6qdl-udoo.dtsi: fix onboard USB HUB property

 .../bindings/usb/generic-onboard-hub.txt           |  20 +++
 MAINTAINERS                                        |   7 +
 arch/arm/boot/dts/imx6qdl-udoo.dtsi                |  26 +---
 drivers/usb/misc/Kconfig                           |  10 ++
 drivers/usb/misc/Makefile                          |   1 +
 drivers/usb/misc/generic_onboard_hub.c             | 143 +++++++++++++++++++++
 6 files changed, 188 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/generic-onboard-hub.txt
 create mode 100644 drivers/usb/misc/generic_onboard_hub.c

-- 
1.9.1
