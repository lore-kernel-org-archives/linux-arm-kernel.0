From: dianders@chromium.org (Douglas Anderson)
Date: Fri, 30 Oct 2015 13:17:52 -0700
Subject: [PATCH v2 0/2] Patches to fix remote wakeup on rk3288 dwc2 "host" port
Message-ID: <1446236275-12698-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the rk3288 USB host-only port (the one that's not the OTG-enabled
port) the PHY can get into a bad state when a wakeup is asserted (not
just a wakeup from full system suspend but also a wakeup from
autosuspend).

We can get the PHY out of its bad state by asserting its "port reset",
but unfortunately that seems to assert a reset onto the USB bus so it
could confuse things if we don't actually deenumerate / reenumerate the
device.

We can also get the PHY out of its bad state by fully resetting it using
the reset from the CRU (clock reset unit), which does a more full
reset.  The CRU-based reset appears to actually cause devices on the bus
to be removed and reinserted, which fixes the problem (albeit in a hacky
way).

It's unfortunate that we need to do a full re-enumeration of devices at
wakeup time, but this is better than alternative of letting the bus get
wedged.

I've tested this series atop a bit of a conglomeration of Heiko's github
"somewhat stable" branch (v4.3-rc3-876-g6509232) but with Greg KH's
usb-next merged in.

===

I've posted up a bunch of patches recently but tried to keep them in
separate series where it makes sense.  A summary of known patches:
All patches can be found with: https://patchwork.kernel.org/patch/<ID>/

ACKed (thanks!) and not yet landed:
 7453801  usb: dwc2: host: Fix ahbcfg for rk3066
 7467521  usb: dwc2: host: Fix remote wakeup when not in DWC2_L2

Important, not yet reviewed:
 7421171  [1/2] usb: dwc2: host: Fix missing device insertions

Fixes no known issues, not yet reviewed:
 7421181  [2/2] usb: dwc2: host: Clear interrupts before handling them

Optimization to reduce probe time (may require simple rebase):
 7348131  [1/5] usb: dwc2: Restore GUSBCFG in dwc2_get_hwparams()
 7348221  [2/5] usb: dwc2: reset dwc2 core before dwc2_get_hwparams()
 7348191  [3/5] CHROMIUM: usb: dwc2: Avoid double-reset at boot time
 7348211  [4/5] usb: dwc2: Speed dwc2_get_hwparams() on some host-only ports
 7348201  [5/5] usb: dwc2: reduce dwc2 driver probe time
 7355241  usb: dwc2: Avoid more calls to dwc2_core_reset()

This series:
 usb: dwc2: optionally assert phy "full reset" when waking up
 ARM: dts: rockchip: Point rk3288 dwc2 usb at the full PHY reset

Coming soon:
 RFT: usb: dwc2: bus suspend/resume that's not hibernate

Abandoned for now (can't get wakeup to work on mainline):
 6727091  [REPOST,1/3] USB: Export usb_wakeup_enabled_descendants()
 6727101  [REPOST,2/3] Documentation: dt-bindings: Add snps,need-phy-for-wake for dwc2 USB
 6727121  [REPOST,3/3] USB: dwc2: Don't turn off the usbphy in suspend if wakeup is enabled

Changes in v2:
- Use a full PHY reset for safety; no PHY changes needed for that.
- Cover letter explains outstanding patches

Doug Anderson (2):
  usb: dwc2: optionally assert phy "full reset" when waking up
  ARM: dts: rockchip: Point rk3288 dwc2 usb at the full PHY reset

 Documentation/devicetree/bindings/usb/dwc2.txt |  7 +++++++
 arch/arm/boot/dts/rk3288.dtsi                  |  5 +++++
 drivers/usb/dwc2/core.h                        |  5 +++++
 drivers/usb/dwc2/core_intr.c                   | 14 ++++++++++++++
 drivers/usb/dwc2/platform.c                    | 13 +++++++++++++
 5 files changed, 44 insertions(+)

-- 
2.6.0.rc2.230.g3dd15c0
