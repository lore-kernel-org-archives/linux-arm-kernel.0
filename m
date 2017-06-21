From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 21 Jun 2017 19:59:48 +0800
Subject: [PATCH V4 0/7] pinctrl: imx: add imx7ulp pinctrl support
Message-ID: <1498046395-30001-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX 7ULP has three IOMUXC instances: IOMUXC0 for M4 ports,
IOMUXC1 for A7 ports and IOMUXC DDR for DDR interface.

This patch series adds the IOMUXC1 support for A7.
It only supports generic pin config.

ChangeLog:
v3->v4:
 This patch series is a combine of the following patches per
 Maintainer's request.
[PATCH V3 1/2] dt-bindings: pinctrl: add imx7ulp pinctrl binding doc
https://www.spinics.net/lists/arm-kernel/msg582995.html
[PATCH V3 2/2] pinctrl: imx: add imx7ulp driver
https://www.spinics.net/lists/arm-kernel/msg582996.html
[PATCH 0/2] pinctrl: pinctrl-imx: add gpio support for mx7ulp
https://www.spinics.net/lists/arm-kernel/msg580993.html

 Detailed changes as follows:
 * change pad name to IMX7ULP_PAD_X style
 * switch to generic pinmux property
 * remove input/output generic property decodes as the standard
   input/out property name are still under discussing.
   It does not affect the normal GPIO function as imx7ulp pinctrl
   driver supports gpio_set_direction which will set input/output enable
   automatically.
   See: [PATCH V4 7/7] pinctrl: pinctrl-imx7ulp: add gpio_set_direction
   It will be added back later for other pads once the standard property
   is determined.

Dong Aisheng (7):
  dt-bindings: pinctrl: extend the pinmux property to support integers
    array
  dt-bindings: pinctrl: add imx7ulp pinctrl binding doc
  pinctrl: imx: switch to use the generic pinmux property
  pinctrl: imx: add imx7ulp driver
  pinctrl: imx: remove gpio_request_enable and gpio_disable_free
  pinctrl: imx: make imx_pmx_ops.gpio_set_direction platform specific
    callbacks
  pinctrl: pinctrl-imx7ulp: add gpio_set_direction support

 .../bindings/pinctrl/fsl,imx7ulp-pinctrl.txt       |  61 +++
 .../bindings/pinctrl/pinctrl-bindings.txt          |   9 +-
 arch/arm/boot/dts/imx7ulp-pinfunc.h                | 468 +++++++++++++++++++++
 drivers/pinctrl/freescale/Kconfig                  |   7 +
 drivers/pinctrl/freescale/Makefile                 |   1 +
 drivers/pinctrl/freescale/pinctrl-imx.c            | 123 +-----
 drivers/pinctrl/freescale/pinctrl-imx.h            |  20 +
 drivers/pinctrl/freescale/pinctrl-imx7ulp.c        | 364 ++++++++++++++++
 drivers/pinctrl/freescale/pinctrl-vf610.c          |  25 ++
 9 files changed, 958 insertions(+), 120 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx7ulp-pinctrl.txt
 create mode 100644 arch/arm/boot/dts/imx7ulp-pinfunc.h
 create mode 100644 drivers/pinctrl/freescale/pinctrl-imx7ulp.c

-- 
2.7.4
