From: dianders@chromium.org (Douglas Anderson)
Date: Fri, 23 Oct 2015 11:28:07 -0700
Subject: [PATCH 0/4] Patches to fix remote wakeup on rk3288 dwc2 "host" port
Message-ID: <1445624891-31680-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "host1" port (AKA the dwc2 port that isn't the OTG port) on rk3288
has a hardware errata that causes everything to get confused when we get
a remote wakeup.  It appears that the "port reset" bit that's in the USB
phy (located in the rk3288 GRF) fixes things up and appears safe to do.

This series of patches exports the "port reset" from the PHY and then
hooks it up to dwc2 through a quirk.

I've tested this series atop a bit of a conglomeration of Heiko's github
"somewhat stable" branch (v4.3-rc3-876-g6509232) but with Greg KH's
usb-next merged in.

These patches currently conflict with patches that I posted previously
to enable USB wakeup from S3, specifically:
* https://patchwork.kernel.org/patch/6727081/
* https://patchwork.kernel.org/patch/6727121/
...those patches no longer apply anyway, so presumably they need to be
reposted and I can do so later atop these patches.


Douglas Anderson (4):
  phy: rockchip-usb: Support the PHY's "port reset"
  usb: dwc2: optionally assert phy "port reset" when waking up
  ARM: dts: rockchip: Enable the USB phys as reset providers on rk3288
  ARM: dts: rockchip: Point rk3288 dwc2 usb at phy port reset

 .../devicetree/bindings/phy/rockchip-usb-phy.txt   |  6 ++
 Documentation/devicetree/bindings/usb/dwc2.txt     |  7 ++
 arch/arm/boot/dts/rk3288.dtsi                      |  8 +++
 drivers/phy/phy-rockchip-usb.c                     | 74 ++++++++++++++++++++++
 drivers/usb/dwc2/core.h                            |  5 ++
 drivers/usb/dwc2/core_intr.c                       |  7 ++
 drivers/usb/dwc2/platform.c                        | 13 ++++
 7 files changed, 120 insertions(+)

-- 
2.6.0.rc2.230.g3dd15c0
