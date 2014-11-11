From: hongzhou.yang@mediatek.com (Hongzhou Yang)
Date: Tue, 11 Nov 2014 20:38:52 +0800
Subject: [PATCH v3 0/3] Add Mediatek SoC Pinctrl/GPIO driver for MT8135. 
Message-ID: <1415709535-31515-1-git-send-email-hongzhou.yang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is v3 of add Mediatek SoC Pinctrl/GPIO drvier for MT8135.
It is based on Joe.C' basic device tree support.
See http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/296093.html

This driver include common and MT8135 part, other Mediatek SoCs will share the common part,
and MT8135 part only support MT8135. MT8135 has GPIO controller, it includes 203 pins.

Changes in v3:
  - Rebase on 3.18-rc1.
  - Follow '[RFC] pinctrl: Provide a generic device tree binding for per-pin pin controllers', modify mediatek,pins format,
    add config setting for each pin, the reason is that each pin may have different config.
    The RFC link: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/296491.html
  - Switch to use syscon regmap.
  - Add CLR_ADDR() and SET_ADDR() macros.
  - Add mtk_pconf_set_ies() and mtk_pconf_set_smt() functions to deal with input-enable and input-schmitt-enable.
  - Rename mt_gpio_devdata to mtk_pinctrl_devdata.
  - Rename all mt_prefix to mtk_prefix.
  - Rename mt_pconf_pull_conf() to mtk_pconf_parse_conf, add mtk_pconf_set_pull_select() to deal with pull enable and pull up/down.
    And we will add PIN_CONFIG_DRIVE_STRENGTH to mtk_pconf_parse_conf().

According to Linus' suggestion, make some following changes:
  - Add port_shf, port_mask and port_align members to mtk_pinctrl_devdata struct.
  - Use BIT(x) instead of 1 << (x).
  - Remove mt_pctrl_write_reg() and mt_pctrl_read_reg().
  - Remove mt_gpio_of_xlate().
  - Use .set_mux() instead of .enable().
  - Add some comments.

Hongzhou Yang (3):
  ARM: mediatek: Add Pinctrl/GPIO driver for mt8135.
  dt-bindings: Add pinctrl bindings for mt65xx/mt81xx.
  ARM: dts: mt8135: Add pinctrl/GPIO node for mt8135.

  .../devicetree/bindings/pinctrl/pinctrl-mt65xx.txt |  123 +
  arch/arm/boot/dts/mt8135-pinfunc.h                 | 1304 +++++++++++
  arch/arm/boot/dts/mt8135.dtsi                      |   19 +
  arch/arm/mach-mediatek/Kconfig                     |    1 +
  drivers/pinctrl/Kconfig                            |    1 +
  drivers/pinctrl/Makefile                           |    1 +
  drivers/pinctrl/mediatek/Kconfig                   |   12 +
  drivers/pinctrl/mediatek/Makefile                  |    5 +
  drivers/pinctrl/mediatek/pinctrl-mt8135.c          |   87 +
  drivers/pinctrl/mediatek/pinctrl-mtk-common.c      |  861 +++++++
  drivers/pinctrl/mediatek/pinctrl-mtk-common.h      |  123 +
  drivers/pinctrl/mediatek/pinctrl-mtk-mt8135.h      | 2460 ++++++++++++++++++++
  include/dt-bindings/pinctrl/mt65xx.h               |   23 +
  13 files changed, 5020 insertions(+)
  create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
  create mode 100644 arch/arm/boot/dts/mt8135-pinfunc.h
  create mode 100644 drivers/pinctrl/mediatek/Kconfig
  create mode 100644 drivers/pinctrl/mediatek/Makefile
  create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt8135.c
  create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-common.c
  create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-common.h
  create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt8135.h
  create mode 100644 include/dt-bindings/pinctrl/mt65xx.h

--
1.8.1.1.dirty
