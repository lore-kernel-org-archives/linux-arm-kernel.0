From: peter.chen@nxp.com (Peter Chen)
Date: Thu, 3 Mar 2016 18:01:13 +0800
Subject: [PATCH 0/3] Add power sequence for hard-wired USB devices
Message-ID: <1456999276-6315-1-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I have a patch for adding device tree support for USB device [1] some
days ago, this is a follow-up to support the USB devices which need
to do some power sequence like enabling USB PHY clock, toggling reset
gpio, etc, before this device can work normal. I have seen some use
cases for it.

In the 1st patch, the USB HUB driver will iterate all its sub devices
described at dts, and do power on sequence if there is a phandle "usb-pwrseq"
for it. The user can add its specific clock and reset pin in its dts to
support this feature.

In the 2nd patch, there is a workaround for chipidea driver to let the
hcd know its device node.

In the 3rd patch, it is a user case for this problem.
@Maciej @Fabio, would you kind to test it at udoo boards, and supply
the related vid/pid for this HUB?
@troy, would you kind add your dts for it at nitrogen6x board?

[1] http://www.spinics.net/lists/linux-usb/msg136698.html

Peter Chen (3):
  usb: core: add power sequence for USB devices
  usb: chipidea: host: let the hcd know's parent device node
  ARM: dts: imx6qdl-udoo.dtsi: fix onboard USB HUB property

 .../devicetree/bindings/usb/usb-device.txt         |  41 +++++-
 arch/arm/boot/dts/imx6qdl-udoo.dtsi                |  35 ++---
 drivers/usb/chipidea/host.c                        |  18 ++-
 drivers/usb/core/Makefile                          |   2 +-
 drivers/usb/core/hub.c                             |  32 +++++
 drivers/usb/core/pwrseq.c                          | 149 +++++++++++++++++++++
 include/linux/usb/of.h                             |  10 ++
 7 files changed, 260 insertions(+), 27 deletions(-)
 create mode 100644 drivers/usb/core/pwrseq.c

-- 
1.9.1
