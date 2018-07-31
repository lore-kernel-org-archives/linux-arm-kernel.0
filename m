From: djw@t-chip.com.cn (djw at t-chip.com.cn)
Date: Tue, 31 Jul 2018 13:59:18 +0800
Subject: [PATCH v4 0/4] Add sdmmc UHS support to ROC-RK3328-CC board.
Message-ID: <1533016762-5268-1-git-send-email-djw@t-chip.com.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Levin Du <djw@t-chip.com.cn>


Hi all, this is an attemp to add sdmmc UHS support to the
ROC-RK3328-CC board.

This patch series adds a new compatible `rockchip,rk3328-grf-gpio` to
the gpio-syscon driver, which currently only support for the access of
the GPIO_MUTE pin in RK3328. Support for HDMI pins can be added later on
perhaps by writing a standalone driver.

A new GRF GPIO controller named `grf_gpio` is defined in rk3328.dtsi so
that all RK3328 boards has access to it.

The ROC-RK3328-CC board use the new gpio <&grf_gpio 0> in gpio-regulator
to control the signal voltage of the sdmmc. It is essential for UHS
support which requires 1.8V signal voltage.

Many thanks to the Linux people!

Changes in v4:
- Use binding of "rockchip,rk3328-grf-gpio"
- Use <&grf_gpio 0> to refer to the GPIO_MUTE pin.

Changes in v3:
- Change from general gpio-syscon to specific rk3328-gpio-mute
- Use dedicated "rockchip,rk3328-gpio-mute" driver
- Use <&gpio_mute 0> instead of <&gpio_mute 1> to refer to the GPIO_MUTE pin.

Changes in v2:
- Rename gpio_syscon10 to gpio_mute in doc
- Rename gpio_syscon10 to gpio_mute in rk3328.dtsi
- Rename gpio_syscon10 to gpio_mute in rk3328-roc-cc.dts

Changes in v1:
- Refactured for general gpio-syscon usage for Rockchip SoCs.
- Add doc rockchip,gpio-syscon.txt
- Split from V0 and add to rk3328.dtsi for general use.
- Split from V0.
- Split into small patches
- Sort dts properties in sdmmc node

Levin Du (4):
  gpio: syscon: rockchip: add GRF GPIO support for rk3328
  arm64: dts: rockchip: add GRF GPIO controller to rk3328
  arm64: dts: rockchip: add io-domain to roc-rk3328-cc
  arm64: dts: rockchip: add sdmmc UHS support for roc-rk3328-cc

 .../bindings/gpio/rockchip,rk3328-grf-gpio.txt     | 32 ++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts     | 34 ++++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  6 ++++
 drivers/gpio/gpio-syscon.c                         | 31 ++++++++++++++++++++
 4 files changed, 103 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/rockchip,rk3328-grf-gpio.txt

-- 
2.7.4
