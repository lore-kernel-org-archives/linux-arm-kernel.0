From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 14 Apr 2014 14:25:56 +0200
Subject: [PATCH/RFC 0/3] Allow OHCI drivers to override hub control operations
Message-ID: <1397478359-22541-1-git-send-email-laurent.pinchart@ideasonboard.com>
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

The ohci-s3c2410 driver already implements a similar feature, and accesses the
ohci_hub_control function by saving the struct hc_driver hub_control value to
a global variable right after calling ohci_init_driver. This is a bit of a
hack, and as I need to call that function as well I've decided to export it
instead.

Another option would have been to handle the regulators directly inside the
ohci-hub implementation, but I'm not sure whether it's worth it yet. Comments
(or acks :-)) will be appreciated.

Please not that I haven't been able to test the third patch due to lack of
hardware. I've however tested a similar implementation on an out of tree
PXA270 board.

Laurent Pinchart (3):
  USB: OHCI: Export the ohci_hub_control function
  USB: ohci-pxa27x: Add support for external vbus regulators
  ARM: pxa: zeus: Replace OHCI init/exit functions with a regulator

 arch/arm/mach-pxa/zeus.c        | 89 ++++++++++++++++++++++-------------------
 drivers/usb/host/ohci-hub.c     |  4 +-
 drivers/usb/host/ohci-pxa27x.c  | 67 +++++++++++++++++++++++++++++++
 drivers/usb/host/ohci-s3c2410.c |  7 +---
 drivers/usb/host/ohci.h         |  2 +
 5 files changed, 121 insertions(+), 48 deletions(-)

-- 
Regards,

Laurent Pinchart
