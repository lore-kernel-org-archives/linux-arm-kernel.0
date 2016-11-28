From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 28 Nov 2016 16:50:24 +0100
Subject: [PATCH net-next v4 0/4] Fix OdroidC2 Gigabit Tx link issue
Message-ID: <1480348229-25672-1-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset fixes an issue with the OdroidC2 board (DWMAC + RTL8211F).
The platform seems to enter LPI on the Rx path too often while performing
relatively high TX transfer. This eventually break the link (both Tx and
Rx), and require to bring the interface down and up again to get the Rx
path working again.

The root cause of this issue is not fully understood yet but disabling EEE
advertisement on the PHY prevent this feature to be negotiated.
With this change, the link is stable and reliable, with the expected
throughput performance.

The patchset adds options in the generic phy driver to disable EEE
advertisement, through device tree. The way it is done is very similar
to the handling of the max-speed property.

Patch 4 is provided here for testing purpose only. Please don't merge
patch 4, this change will go through the amlogic's tree.

Chnages since V3: [3]
 - Fix signess error reported by kbuild test robot (Thx Julia)

Changes since V2: [2]
 - Rename "eee-advert-disable" to "eee-broken-modes" to make the intended
   purpose of this option clear (flag broken configuration, not a
   configuration option)
 - Add DT bindings constants so the DT configuration is more user friendly
 - Submit to net-next instead of net.

Changes since V1: [1]
 - Disable the advertisement of EEE in the generic code instead of the
   realtek driver.

[1] : http://lkml.kernel.org/r/1479220154-25851-1-git-send-email-jbrunet at baylibre.com
[2] : http://lkml.kernel.org/r/1479742524-30222-1-git-send-email-jbrunet at baylibre.com
[3] : http://lkml.kernel.org/r/1480326409-25419-1-git-send-email-jbrunet at baylibre.com

Jerome Brunet (4):
  net: phy: add an option to disable EEE advertisement
  dt-bindings: net: add EEE capability constants
  dt: bindings: add ethernet phy eee-broken-modes option documentation
  ARM64: dts: meson: odroidc2: disable advertisement EEE for GbE.

 Documentation/devicetree/bindings/net/phy.txt      |  2 +
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 14 ++++
 drivers/net/phy/phy.c                              |  3 +
 drivers/net/phy/phy_device.c                       | 80 +++++++++++++++++++---
 include/dt-bindings/net/mdio.h                     | 19 +++++
 include/linux/phy.h                                |  3 +
 6 files changed, 112 insertions(+), 9 deletions(-)
 create mode 100644 include/dt-bindings/net/mdio.h

-- 
2.7.4
