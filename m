From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 15 Apr 2014 18:06:41 +0200
Subject: [PATCH v2 0/4] Allow OHCI drivers to override hub control operations
Message-ID: <1397578005-3341-1-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The PXA27x OHCI implementation doesn't perform automatic control of port power
supplies for all ports. While the PPS and LSDA bits of the HcRhPortStatus
register are implemented, only a subset of ports have an external power enable
pin controlled by the port status register. Other ports need their power supply
to be controlled manually.

In order to do so I've implemented manual regulator control in the ohci-pxa27x
driver. This requires overriding the default behaviour of the CLEAR_FEATURE
and SET_FEATURE requests for USB_PORT_FEAT_POWER with a custom hub control
operation. In turn this requires calling the currently static ohci_hub_control
function from the ohci-pxa27x driver.

The ohci-at91 and ohci-s3c2410 drivers already implement a similar feature,
and access the ohci_hub_control function by saving the struct hc_driver
hub_control value to a global variable right after calling ohci_init_driver.
This vtable-like implementation could be optimized by exporting the
ohci_hub_control function and calling it directly. As the ohci-pxa27x driver
needs to override hub control operations as well I've decided to export the
function.

For the sake of completeness I've also exported the ehci_hub_control function
and modified the ehci-tegra driver to call it directly.

As a side note regarding the ohci-at91 driver, the "atmel,vbus-gpio" DT
property should really have referenced a regulator instead of a GPIO. Fixing
this in a backward-compatible way would be messy :-(

Please not that I haven't been able to test the third and fourth patches due 
to lack of hardware. I've however tested a similar implementation for OHCI on
an out of tree PXA270 board.

Laurent Pinchart (4):
  USB: OHCI: Export the ohci_hub_control function
  USB: EHCI: Export the ehci_hub_control function
  USB: ohci-pxa27x: Add support for external vbus regulators
  ARM: pxa: zeus: Replace OHCI init/exit functions with a regulator

 arch/arm/mach-pxa/zeus.c        | 89 ++++++++++++++++++++++-------------------
 drivers/usb/host/ehci-hub.c     | 12 +-----
 drivers/usb/host/ehci-tegra.c   |  8 +---
 drivers/usb/host/ehci.h         |  3 ++
 drivers/usb/host/ohci-at91.c    |  6 +--
 drivers/usb/host/ohci-hub.c     |  4 +-
 drivers/usb/host/ohci-pxa27x.c  | 67 +++++++++++++++++++++++++++++++
 drivers/usb/host/ohci-s3c2410.c |  7 +---
 drivers/usb/host/ohci.h         |  2 +
 9 files changed, 128 insertions(+), 70 deletions(-)

-- 
Regards,

Laurent Pinchart
