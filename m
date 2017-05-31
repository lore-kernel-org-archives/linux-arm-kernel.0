From: raviteja.garimella@broadcom.com (Raviteja Garimella)
Date: Wed, 31 May 2017 15:42:00 +0530
Subject: [PATCH v6 0/3] Support for USB DRD Phy driver for NS2 
Message-ID: <1496225523-22035-1-git-send-email-raviteja.garimella@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v6:
=============
Removed spin locks which are not required as the references
to phy_ops in the same driver were removed in v5.

Removed host/device 'notify' routines which are registered
using 'extcon_register_notifier'. The irq handler is sufficient
to deal with the change in extcon events within the same driver.

<clip: as before>
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

Repo: https://github.com/Broadcom/arm64-linux.git
Branch: ns2_drdphy_v6

Raviteja Garimella (3):
  dt-bindings:phy:Add DT bindings documentation for NS2 USB DRD phy
  phy:phy-bcm-ns2-usbdrd:Broadcom USB DRD Phy driver for Northstar2
  arm64: dts: NS2: Add USB DRD PHY device tree node

 .../devicetree/bindings/phy/brcm,ns2-drd-phy.txt   |  30 ++
 arch/arm64/boot/dts/broadcom/ns2.dtsi              |  14 +
 drivers/phy/Kconfig                                |  13 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-bcm-ns2-usbdrd.c                   | 466 +++++++++++++++++++++
 5 files changed, 524 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,ns2-drd-phy.txt
 create mode 100644 drivers/phy/phy-bcm-ns2-usbdrd.c

-- 
2.1.0
