From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 20 May 2017 15:50:39 +0200
Subject: [PATCH v4 0/2] Meson GXL USB2 PHY driver
In-Reply-To: <20170417191142.26099-1-martin.blumenstingl@googlemail.com>
References: <20170417191142.26099-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170520135041.25679-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds a driver for the USB2 PHYs found in Amlogic Meson GXL
(and GXM) SoCs.
Devicetree changes are intentionally missing in this series because of
various other problems that need to be resolved before we get USB host
support working.

As usual we unfortunately don't have any documentation available. The
register definitions were taken from the vendor's GPL kernel sources
(see [5] if you are really interested). Translation to human readable
names is done using the "best effort" algorithm.

The USB situation on GXL and GXM is a bit special:
the SoCs include both, a dwc3 and a dwc2 controller. The dwc3 controller
IP only supports host-mode, while the dwc2 controller IP only supports
device mode.
The dwc3 controller has all USB3 ports disabled. GXL has two USB2 ports
enabled on dwc3's internal hub, while GXM has three USB2 ports enabled.
This makes the initialization a bit special: to enable any of the dwc3
controller's USB2 ports *ALL* PHYs have to be initialized (probably due
to the hub's routing logic).
The first USB2 PHY (hardware-wise) also supports OTG mode. The vendor
kernel implements this through the USB3 PHY by re-routing the first
USB2 PHY from the dwc3 controller to the dwc2 controller (which is
disabled by default, but if the USB3 PHY detects that the port should
enter device mode it enables the dwc2 controller).

To get USB host mode working the following steps are needed:
- xhci-plat must be able to manage more than one PHY for a controller,
  this is work-in-progress, see [0]
- there are some DMA handling issues in dwc3 and the rest of the USB
  stack, this is solved by the "sysdev" patches from [1]
- adding all USB related bits to meson-gxl.dtsi - this is work in
  progress but depends on the previous TODOs, see [2] and [3]

This supersedes my previous series "Meson GXL and GXM USB support" [4].


Changes since v3:
- rebased to apply on top of "phy: Group vendor specific phy drivers"
  (the whole series is based on the "fixes" branch in Kishon's
   linux-phy.git, commit a380b78b799b418 "phy: qualcomm: phy-qcom-qmp:
   fix application of sizeof to pointer")
- renamed Kconfig symbol from PHY_MESON_GXL_USB to PHY_MESON_GXL_USB2
  (as there is also a USB3 PHY within the SoC which needs a different
   drivers since it uses completely different registers)

Changes since v2:
- removed PHY mode parsing from phy_meson_gxl_usb2_probe (based on
  of_usb_get_dr_mode_by_phy()) because this will not work with the
  xhci-plat changes anyways. The driver now simply defaults to host
  mode until a consumer uses phy_set_mode().
- fixed a stray newline in drivers/phy/Kconfig b/drivers/phy/Kconfig
  (thanks for spotting this Kishon)
- simplified phy_meson_gxl_usb2_reset() by returning early (thanks
  Kishon for suggesting this improvement)

Changes since v1:
- rebased to the next branch of Kishon's linux-phy tree (currently at
  fe0134d071 "phy: phy-exynos-pcie: make it explicitly non-modular")
- added a missing call to phy_meson_gxl_usb2_power_off in the error
  case in phy_meson_gxl_usb2_power_on - thanks to Hendrik v. Raven for
  spotting this!
- moved the reset logic into a separate function and expose it through
  phy_ops.reset so it can be used by consumers of this PHY.
  phy_meson_gxl_usb2_set_mode still resets the PHY directly because
  this PHY will be configured by xhci-plat (from which we cannot call
  phy_reset() - see the discussion based on v1 of this patch: [6])
- added Rob Herring's ACK to patch #1 (the dt-binding documentation)


[0] https://www.spinics.net/lists/linux-usb/msg151837.html
[1] http://www.mail-archive.com/linux-usb at vger.kernel.org/msg87077.html
[2] https://github.com/xdarklight/linux/commit/e2b83785687fe859ae4bba8da8bb2fb2d7e32bfb
[3] https://github.com/xdarklight/linux/commit/203ab9ea5d1bea0bf066b6738010c8072b821d87
[4] http://lists.infradead.org/pipermail/linux-amlogic/2016-November/001721.html
[5] https://github.com/khadas/linux/blob/76fd19ac41bb774e396ce8009ff665f29c26c535/include/linux/amlogic/usb-gxl.h
[6] http://lists.infradead.org/pipermail/linux-amlogic/2017-March/002777.html

Martin Blumenstingl (2):
  Documentation: dt-bindings: Add documentation for the Meson GXL USB2
    PHY
  phy: meson: add USB2 PHY support for Meson GXL and GXM

 .../devicetree/bindings/phy/meson-gxl-usb2-phy.txt |  17 ++
 drivers/phy/amlogic/Kconfig                        |  13 +
 drivers/phy/amlogic/Makefile                       |   1 +
 drivers/phy/amlogic/phy-meson-gxl-usb2.c           | 273 +++++++++++++++++++++
 4 files changed, 304 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/meson-gxl-usb2-phy.txt
 create mode 100644 drivers/phy/amlogic/phy-meson-gxl-usb2.c

-- 
2.13.0
