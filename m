From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Thu,  2 Mar 2017 23:11:53 +0800
Subject: [PATCH v2 0/3] Add dual-role OTG support for Allwinner H3
Message-ID: <20170302151156.49295-1-icenowy@aosc.xyz>
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

Patch 1 adds support for auto routing of PHY0. It's currently only enabled
on H3, but it's easy to extend it to other SoCs which feature this
route control.

Patch 2 adds necessary device tree nodes to the H3 DTSI file. Note: The
phy is not bind for OHCI/EHCI0, as OHCI/EHCI drivers will keep the VBUS
on. Only MUSB driver can properly handle a dual-role PHY.

Patch 3 enables USB OTG functionality on Orange Pi One board, which is
the only H3 board I have that have proper OTG function. It's easy to
enable OTG on other boards with their schematics.

Icenowy Zheng (3):
  phy: sun4i-usb: support automatically switch PHY0 route to MUSB/HCI
  ARM: dts: sun8i: add usb_otg and OHCI/EHCI for usbc0 on H3
  ARM: dts: sun8i: enable USB OTG on Orange Pi One

 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts | 22 ++++++++++++-
 arch/arm/boot/dts/sun8i-h3.dtsi             | 32 ++++++++++++++++++
 drivers/phy/phy-sun4i-usb.c                 | 50 +++++++++++++++++++----------
 3 files changed, 86 insertions(+), 18 deletions(-)

-- 
2.11.1
