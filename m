From: djw@t-chip.com.cn (djw at t-chip.com.cn)
Date: Thu, 31 May 2018 11:27:48 +0800
Subject: [PATCH v3 0/5] Add sdmmc UHS support to ROC-RK3328-CC board.
Message-ID: <1527737273-8387-1-git-send-email-djw@t-chip.com.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Levin Du <djw@t-chip.com.cn>


Hi all, this is an attemp to add sdmmc UHS support to the
ROC-RK3328-CC board.

This patch series adds a new compatible `rockchip,rk3328-gpio-mute` to
the gpio-syscon driver for the access of the GPIO_MUTE pin in rk3328.

A new gpio controller named `gpio_mute` is defined in
rk3328.dtsi and so that all rk3328 boards has access to it.

The ROC-RK3328-CC board use the new gpio <&gpio_mute 0> in
gpio-regulator to control the signal voltage of the sdmmc.
It is essential for UHS support which requires 1.8V signal voltage.

Many thanks to the Linux people!

Changes in v3:
- Change from general gpio-syscon to specific rk3328-gpio-mute
- Use dedicated "rockchip,rk3328-gpio-mute" driver
- Use <&gpio_mute 0> instead of <&gpio_mute 1> to refer to the GPIO_MUTE pin.

Changes in v2:
- Rename gpio_syscon10 to gpio_mute in doc
- Rename gpio_syscon10 to gpio_mute in rk3328.dtsi
- Rename gpio_syscon10 to gpio_mute in rk3328-roc-cc.dts

Changes in v1:
- New: allow fetching syscon from parent node in gpio-syscon driver
- Refactured for general gpio-syscon usage for Rockchip SoCs.
- Add doc rockchip,gpio-syscon.txt
- Split from V0 and add to rk3328.dtsi for general use.
- Split from V0.
- Split into small patches
- Sort dts properties in sdmmc node

Heiko Stuebner (1):
  gpio: syscon: allow fetching syscon from parent node

Levin Du (4):
  gpio: syscon: rockchip: add GPIO_MUTE support for rk3328
  arm64: dts: rockchip: Add GPIO_MUTE pin support to rk3328
  arm64: dts: rockchip: Add io-domain to roc-rk3328-cc
  arm64: dts: rockchip: Add sdmmc UHS support for roc-rk3328-cc

 .../bindings/gpio/rockchip,rk3328-gpio-mute.txt    | 28 ++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts     | 34 ++++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  7 +++++
 drivers/gpio/gpio-syscon.c                         | 33 +++++++++++++++++++++
 4 files changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/rockchip,rk3328-gpio-mute.txt

-- 
2.7.4
