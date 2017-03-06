From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue,  7 Mar 2017 06:34:44 +0800
Subject: [PATCH v3 0/5] Add dual-role OTG support for Allwinner H3
Message-ID: <20170306223449.21404-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner H3 have a its USB PHY0 routed to two USB controllers: one is
a MUSB controller, which can work in peripheral mode, but works badly in
host mode (several hardware will fail on the MUSB controller, even connect
one MUSB controller in peripheral mode to another one in host mode cannot
work); the other is a pair of EHCI/OHCI controller, which can work only
in host mode, but have better compatibillity. The route is controlled in
a register, which we have set it to HCI only when we do not know about
it well.

Add support to route to the best controller according to current USB mode
(host/peripheral).

Note: Currently even if hardware only support hostmode, we should still
enable the MUSB controller, as it controls the USB mode. (Some this kind
of hardware can also work in peripheral mode by settings in the sysfs
node of MUSB, then connect it to another host via a USB Type-A to Type-A
cable.)

Patch 1 changes the device tree binding to include the "pmu0" for HCI pair.

Patch 2 adds support for auto routing of PHY0. It's currently only enabled
on H3, but it's easy to extend it to other SoCs which feature this
route control.

Patch 3 adds necessary device tree nodes to the H3 DTSI file. Note: The
phy is not bind for OHCI/EHCI0, as OHCI/EHCI drivers will keep the VBUS
on. Only MUSB driver can properly handle a dual-role PHY.

Patch 4 enables USB OTG functionality on Orange Pi One board, which is
the only H3 board I have that have proper OTG function. It's easy to
enable OTG on other boards with their schematics.

Patch 5 enables USB OTG functionality on Orange Pi Zero board, as the
board cannot output power on Vbus, I only enabled peripheral mode by
default.

The USB PHY on V3s/A64 SoCs also feature this capability, and it will
be soon enabled on these SoCs after this patchset is merged.

Icenowy Zheng (5):
  dt: bindings: add pmu0 regs for USB PHYs on Allwinner H3/V3s/A64
  phy: sun4i-usb: support automatically switch PHY0 route to MUSB/HCI
  ARM: dts: sun8i: h3: add usb_otg and OHCI/EHCI for usbc0 on H3
  ARM: dts: sun8i: h3: enable USB OTG on Orange Pi One
  ARM: dts: sun8i: h2+: enable USB OTG for Orange Pi Zero board

 .../devicetree/bindings/phy/sun4i-usb-phy.txt      |  1 +
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts  | 14 ++++++
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts        | 22 +++++++++-
 arch/arm/boot/dts/sun8i-h3.dtsi                    | 32 ++++++++++++++
 drivers/phy/phy-sun4i-usb.c                        | 50 ++++++++++++++--------
 5 files changed, 101 insertions(+), 18 deletions(-)

-- 
2.11.1
