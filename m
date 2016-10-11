From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 11 Oct 2016 17:45:58 +0200
Subject: [PATCH v2 0/9] pinctrl: sunxi: Generic bindings rework
Message-ID: <cover.7edc6c25be8a5e2efdda6a82e102dbf7ece6aa64.1476200742.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch set reworks the Allwinner pinctrl driver to support the generic
pin configuration and multiplexing bindings.

In the process, we also covered some lasting issues that were found: we
were ignoring the case where no pull-up was set, and while our binding was
saying that the allwinner,drive and allwinner,pull properties were
optional, the code was not able to deal with the case where they were not
present.

Changes from v1:
  - Realloced the pinctrl_map array
  - Detailed the generic properties we support
  - Directly return the parsing functions return code
  - Called kfree on the pinconfig directly
  - Added Chen-Yu Acked-by
  - Changed the patch 2 commit log as suggested

Maxime Ripard (9):
  pinctrl: sunxi: Rework the pin config building code
  pinctrl: sunxi: Use macros from bindings header file for DT parsing
  pinctrl: sunxi: Handle bias disable
  pinctrl: sunxi: Deal with configless pins
  pinctrl: sunxi: Support generic binding
  dt-bindings: pinctrl: Deprecate sunxi pinctrl bindings
  ARM: sunxi: Remove useless allwinner,drive property
  ARM: sunxi: Remove useless allwinner,pull property
  ARM: sunxi: Convert pinctrl nodes to generic bindings

 Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt |  16 ++++-
 arch/arm/boot/dts/ntc-gr8-evb.dts                                     |  24 ++----
 arch/arm/boot/dts/ntc-gr8.dtsi                                        | 104 +++++++++------------------
 arch/arm/boot/dts/sun4i-a10-a1000.dts                                 |  12 +--
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts                            |   2 +-
 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts                       |  14 +---
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts                            |  14 +---
 arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts                      |  38 +++-------
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts                              |   6 +--
 arch/arm/boot/dts/sun4i-a10-hackberry.dts                             |  12 +--
 arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts                          |  16 +---
 arch/arm/boot/dts/sun4i-a10-inet1.dts                                 |  26 ++-----
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts                             |  14 +---
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts                          |  29 +++-----
 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts                            |  12 +--
 arch/arm/boot/dts/sun4i-a10-marsboard.dts                             |  13 +--
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts                            |   2 +-
 arch/arm/boot/dts/sun4i-a10-mk802.dts                                 |  18 +----
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts                        |  27 ++-----
 arch/arm/boot/dts/sun4i-a10-pcduino.dts                               |  19 +----
 arch/arm/boot/dts/sun4i-a10-pcduino2.dts                              |   6 +--
 arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts                      |  32 +++-----
 arch/arm/boot/dts/sun4i-a10.dtsi                                      | 169 +++++++++++++++-----------------------------
 arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts                          |  18 ++---
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts                          |  29 +++-----
 arch/arm/boot/dts/sun5i-a10s-mk802.dts                                |  19 +----
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts                      |  36 +++------
 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts                         |  20 ++---
 arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts                              |  21 +----
 arch/arm/boot/dts/sun5i-a10s.dtsi                                     |  61 ++++++----------
 arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts                |  23 ++----
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts                              |  22 ++----
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts                       |  40 ++++------
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts                             |  36 +++------
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts                              |  17 +---
 arch/arm/boot/dts/sun5i-a13.dtsi                                      |  24 ++----
 arch/arm/boot/dts/sun5i-r8-chip.dts                                   |  12 +--
 arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi                  |  33 +++------
 arch/arm/boot/dts/sun5i.dtsi                                          |  57 +++++----------
 arch/arm/boot/dts/sun6i-a31-app4-evb1.dts                             |   6 +--
 arch/arm/boot/dts/sun6i-a31-colombus.dts                              |  22 ++----
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts                           |  23 ++----
 arch/arm/boot/dts/sun6i-a31-i7.dts                                    |  19 +----
 arch/arm/boot/dts/sun6i-a31-m9.dts                                    |  19 +----
 arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts                      |  19 +----
 arch/arm/boot/dts/sun6i-a31.dtsi                                      | 136 ++++++++++++++---------------------
 arch/arm/boot/dts/sun6i-a31s-primo81.dts                              |  20 ++---
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts                              |  13 +--
 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts                      |  29 +++-----
 arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts              |   9 +--
 arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi                  |  14 +---
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts                      |  27 ++-----
 arch/arm/boot/dts/sun7i-a20-bananapi.dts                              |  26 ++-----
 arch/arm/boot/dts/sun7i-a20-bananapro.dts                             |  37 +++-------
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts                           |  13 +--
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts                            |  38 +++-------
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts                           |  24 ++----
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts                             |  26 ++-----
 arch/arm/boot/dts/sun7i-a20-itead-ibox.dts                            |   7 +--
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts                             |  30 +++-----
 arch/arm/boot/dts/sun7i-a20-m3.dts                                    |   6 +--
 arch/arm/boot/dts/sun7i-a20-mk808c.dts                                |  12 +--
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts                        |  32 +++-----
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts                        |  27 ++-----
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts                  |   6 +--
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts                       |  33 +++------
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts                       |  28 +++----
 arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts                         |  45 ++++--------
 arch/arm/boot/dts/sun7i-a20-orangepi.dts                              |  38 +++-------
 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts                         |  25 ++----
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts                              |  21 +----
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts                        |  25 ++----
 arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts                      |  13 +--
 arch/arm/boot/dts/sun7i-a20.dtsi                                      | 277 ++++++++++++++++++++++++++----------------------------------------------
 arch/arm/boot/dts/sun8i-a23-a33.dtsi                                  |  95 ++++++++++---------------
 arch/arm/boot/dts/sun8i-a23-evb.dts                                   |   7 +--
 arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts                 |   8 +--
 arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts                 |   8 +--
 arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts                        |   9 +--
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts                             |  18 +----
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts                        |  11 +--
 arch/arm/boot/dts/sun8i-a33.dtsi                                      |   6 +--
 arch/arm/boot/dts/sun8i-a83t.dtsi                                     |  21 +----
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts                       |  18 +----
 arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts                             |  12 +--
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts                             |  26 ++-----
 arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts                          |  18 +----
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts                           |  18 +----
 arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts                       |   4 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts                            |  18 +----
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts                          |  10 +--
 arch/arm/boot/dts/sun8i-h3.dtsi                                       |  92 +++++++++---------------
 arch/arm/boot/dts/sun8i-q8-common.dtsi                                |   9 +--
 arch/arm/boot/dts/sun8i-r16-parrot.dts                                |  36 +++------
 arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi                  |  26 ++-----
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts                           |  15 +---
 arch/arm/boot/dts/sun9i-a80-optimus.dts                               |  33 +++------
 arch/arm/boot/dts/sun9i-a80.dtsi                                      |  54 +++++---------
 arch/arm/boot/dts/sunxi-common-regulators.dtsi                        |  24 ++----
 drivers/pinctrl/sunxi/pinctrl-sunxi.c                                 | 267 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------
 100 files changed, 1307 insertions(+), 1794 deletions(-)

-- 
git-series 0.8.10
