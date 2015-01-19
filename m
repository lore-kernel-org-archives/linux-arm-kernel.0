From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 19 Jan 2015 14:01:11 +0100
Subject: [PATCH v2 0/3] ARM: mvebu: Enable XHCI on the Armada 385 AP
Message-ID: <1421672474-2945-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This serie enables the Armada 385 AP XHCI controller.

Since the controller uses a GPIO-controlled VBUS, we used the
phy-generic driver, and made the needed additions to the xhci-plat
driver to retrieve a USB phy.

Unfortunately, some glitches were also found along the way, mostly
because of the probe deferring that was introduced by this phy
retrieval.

Since the introduction of the Armada 38x support in 3.16, the driver
was attempting to write into registers while the clock wasn't enabled
yet. This was working because the bootloader left it enabled, but in
the case of a deferred probing, the clock would have been disabled by
the error path of our driver, and this would fail. This should go in
3.19, and any stable kernel for 3.16+.

The two patches remaining are "regular" patches, and are aimed at
3.20. The last patch depend on my previous serie to introduce support
for the the A385 AP board.

Thanks,
Maxime

Changes from v1:
  - Removed the patch 1 that fixes the deferred probing that was
    merged
  - Fixed the error path of the mvebu quirks code to avoid leaking a
    clock reference and the main HCD.
  - Removed the extra PHY field private to the struct xhci, and used
    the usb_phy field in the main HCD instead
  - Fixed the error path of the phy retrieval code in order to avoid
    leaving the phy up if an error was to happen, or the remove
    callback to be called.

Maxime Ripard (3):
  usb: XHCI: platform: Move the Marvell quirks after the enabling the
    clocks
  usb: xhci: plat: Add USB phy support
  ARM: mvebu: armada-385-ap: Enable USB3 port

 arch/arm/boot/dts/armada-385-db-ap.dts | 28 +++++++++++++++++++++++++
 drivers/usb/host/xhci-plat.c           | 38 ++++++++++++++++++++++++----------
 2 files changed, 55 insertions(+), 11 deletions(-)

-- 
2.2.2
