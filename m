From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue,  4 Apr 2017 17:50:55 +0800
Subject: [PATCH v4 0/5] Add support for the R_CCU on Allwinner H3/A64 SoCs
Message-ID: <20170404095100.18649-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner SoCs after sun6i-a31 nearly all have a R_CCU in PRCM part.
(V3s and R40 do not have it, as they have even no PRCM)

This patch adds support for the ones on H3/A64.

Some clock/reset values are reserved for easier extending the support to
A31/A23, but for this I think some changes to the PRCM MFD should be made,
see [1] (Although this is only a sketch).

The r_pio device node is also added for A64, as the driver is already
merged, and its depends (r_ccu) is now met.

[1] https://github.com/wens/linux/commits/sunxi-ng-prcm

Icenowy Zheng (5):
  dt-bindings: update device tree binding for Allwinner PRCM CCUs
  clk: sunxi-ng: add support for PRCM CCUs
  arm64: allwinner: a64: add r_ccu node
  ARM: sunxi: h3/h5: switch apb0-related clocks to r_ccu
  arm64: allwinner: a64: add R_PIO pinctrl node

 .../devicetree/bindings/clock/sunxi-ccu.txt        |  17 +-
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 |  45 ++---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      |  29 +++
 drivers/clk/sunxi-ng/Kconfig                       |   6 +
 drivers/clk/sunxi-ng/Makefile                      |   1 +
 drivers/clk/sunxi-ng/ccu-sun8i-r.c                 | 213 +++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun8i-r.h                 |  27 +++
 include/dt-bindings/clock/sun8i-r-ccu.h            |  59 ++++++
 include/dt-bindings/reset/sun8i-r-ccu.h            |  53 +++++
 9 files changed, 418 insertions(+), 32 deletions(-)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-r.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-r.h
 create mode 100644 include/dt-bindings/clock/sun8i-r-ccu.h
 create mode 100644 include/dt-bindings/reset/sun8i-r-ccu.h

-- 
2.12.2
