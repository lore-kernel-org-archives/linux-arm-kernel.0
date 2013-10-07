From: matt.porter@linaro.org (Matt Porter)
Date: Mon,  7 Oct 2013 06:12:27 -0400
Subject: [PATCH 0/5] USB Device Controller support for BCM281xx
Message-ID: <1381140752-312-1-git-send-email-matt.porter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds USB Device Controller support for the Broadcom
BCM281xx family of parts. BCM281xx contains a DWC2 OTG block and
s3c-hsotg is used to support UDC operation.

Parts 1-2 allows s3c-hsotg to build on non-Samsung platforms and
adds support for a configurable UTMI PHY width. s3c-hsotg is extended
to also support the dwc2 binding as that binding should describe the
hardware independently of there being two different drivers (dwc2 in
staging and s3c-hsotg) for the same device.

Parts 3-4 add a PHY control driver for the Broadcom USB control block
as well as a PHY driver that calls the exported API from the control
driver. This approach is borrowed directly from the phy-omap-control.c
driver.

Patch 5 adds the DT nodes to enable UDC support on both BCM281xx boards
in the kernel.

This series depends on the "Update Kona drivers to use clocks" series
(https://lkml.org/lkml/2013/10/3/645). The dependencies noted for that
series are already queued for 3.13.

Matt Porter (5):
  usb: gadget: s3c-hsotg: enable build for other platforms
  usb: gadget: s3c-hsotg: support configurable UTMI PHY width
  usb: phy: add Broadcom Kona USB control driver
  usb: phy: add Broadcom Kona USB PHY driver
  ARM: dts: add usb udc support to bcm281xx

 Documentation/devicetree/bindings/staging/dwc2.txt |   4 +
 .../devicetree/bindings/usb/bcm-kona-usb-ctrl.txt  |  12 ++
 .../devicetree/bindings/usb/bcm-kona-usb-phy.txt   |  10 ++
 arch/arm/boot/dts/bcm11351-brt.dts                 |  10 ++
 arch/arm/boot/dts/bcm11351.dtsi                    |  21 +++
 arch/arm/boot/dts/bcm28155-ap.dts                  |  12 ++
 drivers/usb/gadget/Kconfig                         |   7 +-
 drivers/usb/gadget/s3c-hsotg.c                     |  20 ++-
 drivers/usb/gadget/s3c-hsotg.h                     |   1 +
 drivers/usb/phy/Kconfig                            |  12 ++
 drivers/usb/phy/Makefile                           |   2 +
 drivers/usb/phy/bcm-kona-usb.h                     |  31 +++++
 drivers/usb/phy/phy-bcm-kona-ctrl.c                | 151 +++++++++++++++++++++
 drivers/usb/phy/phy-bcm-kona-usb2.c                |  99 ++++++++++++++
 14 files changed, 385 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/bcm-kona-usb-ctrl.txt
 create mode 100644 Documentation/devicetree/bindings/usb/bcm-kona-usb-phy.txt
 create mode 100644 drivers/usb/phy/bcm-kona-usb.h
 create mode 100644 drivers/usb/phy/phy-bcm-kona-ctrl.c
 create mode 100644 drivers/usb/phy/phy-bcm-kona-usb2.c

-- 
1.8.4
