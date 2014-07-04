From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 4 Jul 2014 20:37:52 +0530
Subject: [RFC PATCH 0/2] phy: core: better support for multi-phy in phy-core
Message-ID: <1404486474-28312-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In multi-phy PHY providers, each PHY should be modeled as sub-node of PHY
provider. So it makes sense for the controller node to have the phandle for
the sub-node instead of the PHY-provider node in the 'phy' property.

This patch series added support so that the controller node can have the
phandle to the sub-node. So if the phy specifier does not have any other
fields other than the phandle (and the PHY driver uses the default xlate),
phy_get will return the correct PHY.
However if the phy_sepcifier has other fields and the PHY driver provides
its own xlate, the PHY driver can use the *phy->dev.of_node*. (note that
now phy->dev.of_node will have the node pointer of the sub-node).

Kishon Vijay Abraham I (2):
  phy: core: Fix of_phy_provider_lookup to return PHY provider for sub
    node
  phy: core: the node pointer of PHY need not be the same as that of
    PHY provider

 Documentation/phy.txt               |   10 ++++++----
 drivers/phy/phy-bcm-kona-usb2.c     |    2 +-
 drivers/phy/phy-core.c              |   35 +++++++++++++++++++++++++++--------
 drivers/phy/phy-exynos-dp-video.c   |    2 +-
 drivers/phy/phy-exynos-mipi-video.c |    2 +-
 drivers/phy/phy-exynos5-usbdrd.c    |    3 ++-
 drivers/phy/phy-exynos5250-sata.c   |    2 +-
 drivers/phy/phy-mvebu-sata.c        |    2 +-
 drivers/phy/phy-omap-usb2.c         |    2 +-
 drivers/phy/phy-samsung-usb2.c      |    3 ++-
 drivers/phy/phy-sun4i-usb.c         |    2 +-
 drivers/phy/phy-ti-pipe3.c          |    2 +-
 drivers/phy/phy-twl4030-usb.c       |    2 +-
 drivers/phy/phy-xgene.c             |    2 +-
 include/linux/phy/phy.h             |   15 ++++++++++-----
 15 files changed, 57 insertions(+), 29 deletions(-)

-- 
1.7.9.5
