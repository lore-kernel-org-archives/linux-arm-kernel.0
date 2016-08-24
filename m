From: johnyoun@synopsys.com (John Youn)
Date: Wed, 24 Aug 2016 16:19:51 -0700
Subject: [RFT PATCH v2 0/4] usb: dwc2: Fix core reset and force mode delays
Message-ID: <cover.1471991702.git.johnyoun@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patch series addresses the core reset and force mode
delay problems seen on some platforms.

It is basically the same as this series of patches sent earlier this
year:

http://marc.info/?l=linux-usb&m=145921907525708&w=2

Except the first patch is omitted (already upstream) and the last
patch is broken up into two patches.

This series is trying to account for a variable delay from the IDDIG
debounce filter when switching modes. This delay is a function of the
PHY clock speed and can range from 5-50 ms. This delay must be taken
into account on core reset and force modes. A full explanation is
provided in the patch commit log and code comments.

Patch 1 is a prerequisite to this fix.

Patch 2 implements the delay for core reset.

Patch 3 implements the delay for set/clear force modes.

Patch 4 makes further optimizations to remove unnecessary calls to
reset and force mode and avoid extra delays in the driver.

RK3188 platforms:

Michael Niewoehner reported problems with the previous set of patches
that I suspect have to do with the last patch of this series.

On Raspberry PI platforms:

Stefan Wahren reported problems that should be solved by patches 1-3
of this series.

Appreciate testing on these and any other platforms.

Patch 1-2 can probably be merged right now as they shouldn't break
anything.

Patch 3 should solve the RPI problems and shouldn't have any issues on
rk3188 either.

Patch 4 likely will have the same issue as with rk3188 and will need
to be investigated at a later time.

Regards,
John

John Youn (4):
  usb: dwc2: gadget: Only initialize device if in device mode
  usb: dwc2: Add delay to core soft reset
  usb: dwc2: Properly account for the force mode delays
  usb: dwc2: Force mode optimizations

 drivers/usb/dwc2/core.c     | 195 ++++++++++++++++++++++++++++----------------
 drivers/usb/dwc2/core.h     |   2 +-
 drivers/usb/dwc2/gadget.c   |   7 +-
 drivers/usb/dwc2/hcd.c      |   6 +-
 drivers/usb/dwc2/hw.h       |   1 +
 drivers/usb/dwc2/platform.c |   9 +-
 6 files changed, 143 insertions(+), 77 deletions(-)

-- 
2.9.0
