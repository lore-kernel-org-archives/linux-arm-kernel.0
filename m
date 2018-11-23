From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 23 Nov 2018 12:22:14 +0100
Subject: [PATCH 0/3] Bring suspend to RAM support to xHCI MVEBU driver
Message-ID: <20181123112217.4878-1-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

As part of an effort to bring suspend to RAM support to Armada 3700
SoCs (main target: ESPRESSObin), this series handles the work around
the USB3 host IP.

First, a change in the core adds support for the new PHY framework by
following the phy_set_mode()/phy_power_on() sequence (patch 1). The
second change needed is to update the xHCI MVEBU driver (patch 2) with
the XHCI_RESET_ON_RESUME quirk that will do most of the
reconfiguration work when resuming.

Then, because of the asynchronous suspend feature implemented lately
the driver was blocking during the S2RAM operation, probably due to a
register access while the clock was not enabled. A first patch has
been written for that, adding a new quirk to ignore the asynchronous
setting [1] which has become useless once clock links with consumer
have been contributed [2] (series not merged yet).

Finally, the ESPRESSObin device tree is updated (patch 3) to reference
the PHY. xHCI bindings already document the PHY so no update is needed
on this regard.

[1] http://code.bulix.org/s2ccd4-511198
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/614527.html

Thanks,
Miqu?l


Miquel Raynal (2):
  usb: core: comply to PHY framework
  ARM64: dts: marvell: armada-3720-espressobin: declare USB3 PHY

Ofer Heifetz (1):
  usb: host: xhci: mvebu: add reset on resume quirk

 .../dts/marvell/armada-3720-espressobin.dts   |  1 +
 drivers/usb/core/hcd.c                        |  5 ++++
 drivers/usb/core/phy.c                        | 28 +++++++++++++++++++
 drivers/usb/core/phy.h                        |  2 ++
 drivers/usb/host/Kconfig                      |  2 +-
 drivers/usb/host/xhci-mvebu.c                 | 11 ++++++++
 drivers/usb/host/xhci-mvebu.h                 |  6 ++++
 drivers/usb/host/xhci-plat.c                  |  7 +++++
 8 files changed, 61 insertions(+), 1 deletion(-)

-- 
2.19.1
