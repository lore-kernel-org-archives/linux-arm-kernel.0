From: raviteja.garimella@broadcom.com (Raviteja Garimella)
Date: Fri,  9 Jun 2017 17:12:59 +0530
Subject: [PATCH v9 0/3] Support for USB DRD PHY driver for NS2 
Message-ID: <1497008582-17974-1-git-send-email-raviteja.garimella@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in V9: 
=============
Rebased on linux-phy next. Driver files and Kconfig/Makefile
changes now in drivers/phy/broadcom.

Changes in v8:
=============
-Renamed phy shutdown routine
-Used devm_request_irq in stead of threaded irq
-Removed devm_unregister calls in probe routine

Changes in v7:
=============
Cleaned up unused variables in phy private data structure that's
missed out in v6.
Setting of phy mode to device/host is removed from phy power on.
routine.

Changes in v6:
=============
Removed spin locks which are not required as the references
to phy_ops in the same driver were removed in v5.

Removed host/device 'notify' routines which are registered
using 'extcon_register_notifier'. The irq handler is sufficient
to deal with the change in extcon events within the same driver.

Changes in v5:
=============
Removed references to phy_ops in the same driver by connect_work
event handler to change the phy modes.

To support dynamically changing the mode of the phy, it does
not require doing a phy reset/programming of PHY PLL. Changes
are made to the connect_work routine to just program the required
register bits to achieve this purpose.

Changes in v4:
=============
Remove references to edev->name in debug prints.

Changes in v3:
=============
Remove unnecessary checks for poweron as suggested in review.

Changes in v2:
=============
1. Initialize file operations .owner field with THIS_MODULE.
2. Remove unnecessary gpio example in DT bindings documentation.
   This is previously acked by Rob Herring <robh@kernel.org>

Introduction for PATCH v1:

This patch adds support for USB Dual Role Device Phy for Broadcom
Northstar2 SoC. Apart from the new phy driver, this patchset contains
changes to Kconfig, Makefile, and Device tree files.

This patchset is tested on Broadcom NS2 BCM958712K reference board.

Raviteja Garimella (3):
  dt-bindings: phy: Add DT bindings documentation for NS2 USB DRD PHY
  phy: phy-bcm-ns2-usbdrd: Broadcom USB DRD PHY driver for Northstar2
  arm64: dts: NS2: Add USB DRD PHY device tree node

 .../devicetree/bindings/phy/brcm,ns2-drd-phy.txt   |  30 ++
 arch/arm64/boot/dts/broadcom/ns2.dtsi              |  14 +
 drivers/phy/broadcom/Kconfig                       |  13 +
 drivers/phy/broadcom/Makefile                      |   1 +
 drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c          | 437 +++++++++++++++++++++
 5 files changed, 495 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,ns2-drd-phy.txt
 create mode 100644 drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c

-- 
2.1.0
