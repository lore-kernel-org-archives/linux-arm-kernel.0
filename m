From: johnyoun@synopsys.com (John Youn)
Date: Thu, 01 Sep 2016 14:07:47 -0700
Subject: [RFT PATCH v4 0/3] usb: dwc2: Fix core reset and force mode delays
Message-ID: <cover.1472763969.git.johnyoun@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series accounts for the delay from the IDDIG debounce filter when
switching modes. This delay is a function of the PHY clock speed and
can range from 5-50 ms. This delay must be taken into account on core
reset and force modes. A full explanation is provided in the patch
commit log and code comments.

This revision of the series increases the IDDIG delay to 100 ms. Some
rockchip platforms seem to timeout even with 50 ms so I have doubled
this.

Appreciate any testing on RK3188 and RPi platforms.

v4:
* Increased the IDDIG delay to 110ms.
* Removed tested-by for patch 2 since I have changed the delays.

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

 drivers/usb/dwc2/core.c   | 126 +++++++++++++++++++++++++++++++++++++++-------
 drivers/usb/dwc2/core.h   |   1 +
 drivers/usb/dwc2/gadget.c |   7 ++-
 drivers/usb/dwc2/hw.h     |   1 +
 4 files changed, 116 insertions(+), 19 deletions(-)

-- 
2.9.0
