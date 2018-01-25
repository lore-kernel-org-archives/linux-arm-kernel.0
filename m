From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu, 25 Jan 2018 01:16:33 +0100
Subject: [RFC/RFT usb-next v1 0/6] remove driver-specific "multiple PHY"
 handling
Message-ID: <20180125001639.14681-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(this is the follow-up to my "initialize (multiple) PHYs for a HCD"
series from [0])

Various USB controller drivers parse the "phys" device-tree property and
grab all listed PHYs.
There is a lot of duplicate code around this in the various drivers:
- parse the "phys" property during .probe and save all PHYs in an array
- call phy_init and phy_power_on on all PHYs
- (where supported by the driver) call phy_power_off during .suspend and
  phy_power_on during .resume
- call phy_power_off and phy_exit during .remove

With [0] this functionality was moved to the core HCD driver, meaning
that all USB controller drivers now support this without having to
implement custom code for it.

Thus this series removes this code duplication.

The last two patches are a bit special:
- after patches #1-4 the chipidea driver is the last driver which sets
  the "phy" field of struct usb_hcd. remove this logic as the PHY
  wrapper (which is now part of the core HCD driver) manages the state
  of all PHYs anyways.
- the last patch removes the "phy" field from struct usb_hcd because
  nothing uses it anymore after the previous patches. it also removes
  the parsing and managing of a single PHY with the name "usb" as the
  new PHY wrapper parses all PHYs from the device-tree "phys" property
  anyways (so the PHY wrapper has the same functionality, except that it
  doesn't need the phy-name "usb" and it can manage more than one PHY)

preconditions for testing this series: all patches from [0] need to be
applied.
disclaimer: I don't have any hardware that uses any of the affected
drivers!


[0] http://lists.infradead.org/pipermail/linux-amlogic/2018-January/006274.html

Martin Blumenstingl (6):
  usb: mtu3: remove custom USB PHY handling
  usb: host: xhci-mtk: remove custom USB PHY handling
  usb: host: ehci-platform: remove custom USB PHY handling
  usb: host: ohci-platform: remove custom USB PHY handling
  usb: chipidea: do not set the "phy" field in struct usb_hcd
  usb: core: hcd: remove support for initializing a single PHY

 drivers/usb/chipidea/host.c      |   4 +-
 drivers/usb/core/hcd.c           |  37 --------------
 drivers/usb/host/ehci-platform.c |  55 ++-------------------
 drivers/usb/host/ohci-platform.c |  56 ++--------------------
 drivers/usb/host/xhci-mtk.c      |  98 +------------------------------------
 drivers/usb/mtu3/mtu3_plat.c     | 101 ---------------------------------------
 include/linux/usb/hcd.h          |   1 -
 7 files changed, 12 insertions(+), 340 deletions(-)

-- 
2.16.1
