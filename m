From: johnyoun@synopsys.com (John Youn)
Date: Thu, 25 Aug 2016 14:26:33 -0700
Subject: [RFT PATCH v3 0/3] usb: dwc2: Fix core reset and force mode delays
Message-ID: <cover.1472160194.git.johnyoun@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series tries to account for a delay from the IDDIG debounce
filter when switching modes. This delay is a function of the PHY clock
speed and can range from 5-50 ms. This delay must be taken into
account on core reset and force modes. A full explanation is provided
in the patch commit log and code comments.

Patch 1 is a prerequisite to this fix.

Patch 2 implements the delay for core reset.

Patch 3 implements the delay for set/clear force modes.

Appreciate any testing, especially on RK3188 and RPi platforms.

Patch 1-2 can probably be merged right now as they shouldn't break
anything.

Patch 3 should solve RPi issues, but has problems in RK3188 that need
to be debugged.

v3:
* Added tested-bys for patch 1-2
* Fixed an issue where a function was not returning a value
* Dropped patch 4

v2:
* Broke up the last patch of the original series

Regards,
John

John Youn (3):
  usb: dwc2: gadget: Only initialize device if in device mode
  usb: dwc2: Add delay to core soft reset
  usb: dwc2: Properly account for the force mode delays

 drivers/usb/dwc2/core.c   | 128 ++++++++++++++++++++++++++++++++++++++++------
 drivers/usb/dwc2/core.h   |   1 +
 drivers/usb/dwc2/gadget.c |   7 ++-
 drivers/usb/dwc2/hw.h     |   1 +
 4 files changed, 118 insertions(+), 19 deletions(-)

-- 
2.9.0
