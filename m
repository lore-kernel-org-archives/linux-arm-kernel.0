From: peter.chen@nxp.com (Peter Chen)
Date: Thu, 7 Jul 2016 17:14:46 +0800
Subject: [PATCH 0/6] power: add power sequence library
Message-ID: <1467882892-27589-1-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is a follow-up for my last power sequence framework patch set [1].
According to Rob Herring and Ulf Hansson's comments[2], I use a generic
power sequence library for parsing the power sequence elements on DT,
and implement generic power sequence on library. The host driver
can allocate power sequence instance, and calls pwrseq APIs accordingly.

In future, if there are special power sequence requirements, the special
power sequence library can be created.

This patch set is tested on i.mx6 sabresx evk using a dts change, I use
two hot-plug devices to simulate this use case, the related binding
change is updated at patch[1/6], The udoo board changes were tested
using my last power sequence patch set.[3]

Except for hard-wired MMC and USB devices, I find the USB ULPI PHY also
need to power on itself before it can be found by ULPI bus.

[1] http://www.spinics.net/lists/linux-usb/msg142755.html
[2] http://www.spinics.net/lists/linux-usb/msg143106.html
[3] http://www.spinics.net/lists/linux-usb/msg142815.html

Peter Chen (6):
  binding-doc: power: pwrseq-generic: add binding doc for generic power
    sequence library
  power: add power sequence library
  binding-doc: usb: usb-device: add optional properties for power
    sequence
  usb: core: add power sequence handling for USB devices
  usb: chipidea: host: let the hcd know's parent device node
  ARM: dts: imx6qdl-udoo.dtsi: fix onboard USB HUB property

 .../bindings/power/pwrseq/pwrseq-generic.txt       |  56 +++++++++
 .../devicetree/bindings/usb/usb-device.txt         |  10 ++
 arch/arm/boot/dts/imx6qdl-udoo.dtsi                |  28 +++--
 drivers/power/Kconfig                              |   1 +
 drivers/power/Makefile                             |   1 +
 drivers/power/pwrseq/Kconfig                       |  20 +++
 drivers/power/pwrseq/Makefile                      |   2 +
 drivers/power/pwrseq/core.c                        |  79 ++++++++++++
 drivers/power/pwrseq/pwrseq_generic.c              | 134 +++++++++++++++++++++
 drivers/usb/chipidea/host.c                        |  18 ++-
 drivers/usb/core/Makefile                          |   1 +
 drivers/usb/core/hub.c                             |  12 +-
 drivers/usb/core/hub.h                             |  12 ++
 drivers/usb/core/pwrseq.c                          | 102 ++++++++++++++++
 include/linux/power/pwrseq.h                       |  55 +++++++++
 15 files changed, 511 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
 create mode 100644 drivers/power/pwrseq/Kconfig
 create mode 100644 drivers/power/pwrseq/Makefile
 create mode 100644 drivers/power/pwrseq/core.c
 create mode 100644 drivers/power/pwrseq/pwrseq_generic.c
 create mode 100644 drivers/usb/core/pwrseq.c
 create mode 100644 include/linux/power/pwrseq.h

-- 
1.9.1
