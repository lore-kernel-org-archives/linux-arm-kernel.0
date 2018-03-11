From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 11 Mar 2018 14:52:57 +0100
Subject: [PATCH 00/10] Switch Versatile and RealView to DRM
Message-ID: <20180311135307.6271-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM Versatile and RealView platforms have enough support
merged for v4.17/next that we can fully switch them all over to
using the DRM PL111 driver instead of the old fbdev driver.

Integrator and Versatile Express will follow.

The device trees are augmented with the proper VGA bridges
instead of "panels" that were never correct, the maximum
memory bandwidth is augmented and these platforms can now
in many cases support 1024x768 in 16bpp instead of only
640x480 with 32bpp.

If the board has the IB1 or IB2 daughterboard
mounted, the daughterboard display will take precedence
over the VGA connector. The IB1 daughterboard which connects
a number of various displays does not need any separate device
tree: it will be autodetected.

For the Versatile CP with the IB2 daughterboard we need to
add a new device tree, as it has a system controller we need
to access and a few other features we may want to make use of
in the future. (It already has proper device tree bindings
in place.)

This has been tested on:

- RealView PM11MPCore
- RealView PB1176
- Versatile AB with and without the IB2 daughterboard
- All applicable QEMU models: RealView EB, RealView PBA8,
  RealView PBX-A9 and Versatile AB.

I'm planning to send this as two pull requests: one for the
DTS changes and one for the defconfig changes.

Linus Walleij (10):
  ARM: dts: Augment VGA connector bridge on PB11MPcore
  ARM: dts: Augment VGA connector bridge on PB1176
  ARM: dts: Augment VGA connector bridge on Realview EB
  ARM: dts: Augment VGA connector bridge on Realview PBX
  ARM: dts: Add Versatile IB2 device tree
  ARM: dts: Augment panel setting for Versatile
  ARM: defconfig: Update RealView defconfig
  ARM: defconfig: Switch RealView boards to use P111 DRM
  ARM: defconfig: Update Versatile defconfig
  ARM: defconfig: Configure Versatile boards to use PL111 DRM

 arch/arm/boot/dts/Makefile                |  1 +
 arch/arm/boot/dts/arm-realview-eb.dtsi    | 64 +++++++++++++++---------
 arch/arm/boot/dts/arm-realview-pb1176.dts | 66 ++++++++++++++----------
 arch/arm/boot/dts/arm-realview-pb11mp.dts | 78 +++++++++++++++++++----------
 arch/arm/boot/dts/arm-realview-pbx.dtsi   | 82 ++++++++++++++++++++----------
 arch/arm/boot/dts/versatile-ab-ib2.dts    | 26 ++++++++++
 arch/arm/boot/dts/versatile-ab.dts        | 83 ++++++++++++++++++++++++++++++-
 arch/arm/configs/realview_defconfig       | 21 ++++----
 arch/arm/configs/versatile_defconfig      | 18 ++++---
 9 files changed, 317 insertions(+), 122 deletions(-)
 create mode 100644 arch/arm/boot/dts/versatile-ab-ib2.dts

-- 
2.14.3
