From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  6 Jan 2015 16:45:06 +0100
Subject: [PATCH 0/4] ARM: mvebu: Enable XHCI on the A385-AP
Message-ID: <1420559110-8043-1-git-send-email-maxime.ripard@free-electrons.com>
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

First, the commit 1290a958d48e ("usb: phy: propagate
__of_usb_find_phy()'s error on failure") introduced in 3.19 broke the
deferred probing for consumer drivers. The first patch attempts at
fixing this while keeping the original intention of the author, and
should probably go in as a fix for 3.19.

Then, since the introduction of the Armada 38x support in 3.16, the
driver was attempting to write into registers while the clock wasn't
enabled yet. This was working because the bootloader left it enabled,
but in the case of a deferred probing, the clock would have been
disabled by the error path of our driver, and this would fail. This
should go in 3.19 as well, and any stable kernel for 3.16+.

The two patches remaining are "regular" patches, and are aimed at
3.20. The last patch depend on my previous serie to introduce support
for the the A385 AP board.

Thanks,
Maxime

Maxime Ripard (4):
  usb: phy: Fix deferred probing
  usb: XHCI: platform: Move the Marvell quirks after the enabling the
    clocks
  usb: xhci: plat: Add USB phy support
  ARM: mvebu: armada-385-ap: Enable USB3 port

 arch/arm/boot/dts/armada-385-ap.dts | 28 ++++++++++++++++++++++++++++
 drivers/usb/host/xhci-plat.c        | 32 ++++++++++++++++++++++----------
 drivers/usb/host/xhci.h             |  2 ++
 drivers/usb/phy/phy.c               |  6 +++---
 4 files changed, 55 insertions(+), 13 deletions(-)

-- 
2.2.1
